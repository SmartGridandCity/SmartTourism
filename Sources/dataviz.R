# writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', con = "~/.Renviron")
# install.packages("dplyr")
# install.packages('raster')
# install.packages('conflicted')
# 
# library(lubridate)
# library("dplyr")
# library(raster)
# library(conflicted)
# conflict_prefer("select", "dplyr")
# conflict_prefer("filter", "dplyr")

datatourismIleDeFrance2 <- read.csv("C:/Users/Rhaada/Documents/datatourismIleDeFrance2.csv", sep=";")
data <- select(datatourismIleDeFrance2, id, nom, rating, nbAvisRecupere, latitude, longitude,
               activiteType, name_0, name_1, name_2, name_3, name_4, name_5,
               type_1, type_2, type_3, type_4, type_5, idauteur, date_review,
               location, country, sexe, age)
# rm(datatourismIleDeFrance2)

#remove empty row
data <- subset(data, data$idauteur!="")
data <- subset(data, data$date_review!="0000-00-00")
data <- subset(data, data$country!="")
data <- subset(data, data$country!="-")

################## dataviz for 1 comment
#see nationality of people with only 1 comment
comment1 <- data
comment1 <- comment1 %>% 
  group_by(idauteur) %>% 
  filter(n() == 1)

#subset by nationality
nationality1 <- table(comment1$country)
nationality1 <- as.data.frame(nationality1)
nationality1 <- subset(nationality1, Freq>0)
nationality1 <- mutate(nationality1, nbuser=-1)
sum <- sum(nationality1$Freq)
for(i in 1:nrow(nationality1))
{
  nationality1$nbuser[i] <- nationality1$Freq[i]
  nationality1$Freq[i] <- nationality1$Freq[i]/sum
}

nationality1 <- nationality1[order(nationality1$Freq),]
write.csv(x = nationality1, file = "nationality1review.csv")

rm(nationality1)
rm(comment1)
rm(sum)
rm(i)

################# dataviz of nationality for 2 comments
#keep sequence =2
comment2 <- data
comment2 <- comment2 %>% 
  group_by(idauteur) %>% 
  filter(n() == 2)

#subset by nationality (comment)
nationality2 <- table(comment2$country)
nationality2 <- as.data.frame(nationality2)
nationality2 <- subset(nationality2, Freq>0)
nationality2 <- mutate(nationality2, nbuser=-1)
sum <- sum(nationality$Freq)
for(i in 1:nrow(nationality2))
{
  nationality2$nbuser[i] <- nationality2$Freq[i]/2
  nationality2$Freq[i] <- nationality2$Freq[i]/sum
}

nationality2 <- nationality2[order(nationality2$Freq),]
write.csv(x = nationality2, file = "nationality2review.csv")

rm(nationality2)
rm(comment2)
rm(sum)
rm(i)

################# dataviz of nationality for 2 comments
#keep sequence >2
data2 <- data
data2 <- data2 %>% 
  group_by(idauteur) %>% 
  filter(n() > 2)



#cleaning typeof each column
data2$longitude <- gsub(",", "\\.", data2$longitude)
data2$latitude <- gsub(",", "\\.", data2$latitude)
data2$longitude <- as.numeric(data2$longitude)
data2$latitude <- as.numeric(data2$latitude)

data2$date_review <- as.Date(data2$date_review)
data2$idauteur <- as.integer(data2$idauteur)
data2$country <- as.character(data2$country)
data2$sexe <- as.character(data2$sexe)
data2$age <- as.numeric(data2$age)
data2$name_0 <- as.character(data2$name_0)
data2$name_1 <- as.character(data2$name_1)
data2$name_2 <- as.character(data2$name_2)
data2$name_3 <- as.character(data2$name_3)
data2$name_4 <- as.character(data2$name_4)
data2$name_5 <- as.character(data2$name_5)

data2 <- mutate(data2, year=year(date_review))

#subset comment by year/nationality
test <- select(data2, idauteur, country, year)
nationality <- aggregate(test$idauteur, list(test$year, test$country), length)
sum <- as.numeric(nrow(data2))

#nb of user for each year/nationality
nbuser <- select(data2, idauteur, country, year)
nbuser <- aggregate(nbuser$idauteur, list(nbuser$year, nbuser$country), function(x) length(unique(x)))

#nb of comment per user
test <- select(data2, idauteur, country, year)
test <- test %>% group_by(year, idauteur) %>% mutate(count = n())
test <- unique(test)
test2 <- aggregate.data.frame(test$count, list(test$year, test$country), function(x) c(min(x), max(x), mean(x)))
test2 <- mutate(test2, min=test2$x[,1], max=test2$x[,2], mean=test2$x[,3])
test2 <- select(test2, Group.1, Group.2, min, max, mean)

#build stats about the dataset
stat <- merge(nationality, nbuser, by.x=c("Group.1", "Group.2"), by.y=c("Group.1", "Group.2"))
stat <- merge(stat, test2, by.x=c("Group.1", "Group.2"), by.y=c("Group.1", "Group.2"))
names(stat)[names(stat) == "Group.1"] <- "year"
names(stat)[names(stat) == "Group.2"] <- "country"
names(stat)[names(stat) == "x.x"] <- "nbcomment"
names(stat)[names(stat) == "x.y"] <- "nbuser"
stat <- mutate(stat, perccomment = -1, percuser = -1)

for(i in 1:nrow(stat))
{
  stat$perccomment[i] <- stat$nbcomment[i] / sum
  stat$percuser[i] <- stat$nbuser[i]  / sum2
}

write.csv(x = stat, file = "nationalitySUP2review.csv")

rm(test)
rm(test2)
rm(nationality)
rm(nbuser)
rm(i)


#comment/user per year or per country
nationality <- table(data2$country)
nationality <- as.data.frame(nationality)
nationality <- mutate(nationality, perc=nationality$Freq/sum)
write.csv(x = nationality, file = "nationalitySUP2nationality.csv")

year <- table(data2$year)
year <- as.data.frame(year)
year <- mutate(year, perc=year$Freq/sum)
write.csv(x = year, file = "nationalitySUP2year.csv")


################ adding sequence information to the dataset
datause <- data2[order(data2$idauteur, data2$date_review),]


################### create dataset
#select the data
#keep nationality over 1000 comments
nationality <- nationality[nationality$Freq <1000,]
nationality <- nationality$Var1
for (i in 1:length(nationality))
{
  datause <- datause[!datause$country==nationality[i], ]
}

#keep year with lots of users and comments
year <- c(2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012)
for (i in 1:length(year))
{
  datause <- datause[!datause$year==year[i], ]
}

rm(nationality)
rm(year)

datause <- datause %>% 
  group_by(idauteur) %>% 
  filter(n() > 2)
datause <- datause[order(datause$idauteur, datause$date_review),]
datause <- datause %>% mutate(timestamp = row_number()) #add timestamp for each user
datause <- transform(datause, seq=as.numeric(factor(idauteur))) #add idseq for each user
datause <- mutate(datause, dategap=NA)

datause$timestamp <- as.integer(datause$timestamp)
datause$seq <- as.integer(datause$seq)
datause$dategap <- as.integer(datause$dategap)

## prendre le date_review et retirer le premier element
for(i in 1:nrow(datause))
{
  if(datause$timestamp[i]!=1)
  {
    datause$dategap[i] <- datause$date_review[i]-datause$date_review[i-1]
  }
}


############## keep relevent sequence
# dataviz of time between two comment
#define a threshold of time between two comments
x <- datause$dategap
h <- hist(x, breaks="Scott", plot=FALSE)
plot(h$mids, h$density, log="y", type='h', xlab= "Wh", ylab = "Density")
q <- quantile(x, probs = seq(0, 1, by= 0.01), na.rm = TRUE) # centile
plot(q,type='l')
s <- summary(x)
s
cut <- 7 #choice of max dategap

#redefine the sequence with a threshold at 'cut'
changeseq <- as.numeric(max(datause$seq))+1
changestamp <- 1
for(i in 1:nrow(datause))
{
  if(!is.na(datause$dategap[i]) && datause$dategap[i] > cut)
  {
    datause$seq[i] <- changeseq
    datause$timestamp[i] <- changestamp
    datause$dategap[i] <- NA
    
    ida <- datause$idauteur[i]
    i <- i+1
    changestamp <- changestamp+1
    
    while (datause$idauteur[i]==ida && !is.na(datause$dategap[i]) && datause$dategap[i]<= cut)
    {
      datause$seq[i] <- changeseq
      datause$timestamp[i] <- changestamp
      i <- i+1
      changestamp <- changestamp+1
    }
    
    changeseq <- changeseq+1
    changestamp <- 1
  }
}

write.csv(x = datause, file = "sequencesdata.csv")

rm(cut)
rm(changeseq)
rm(changestamp)

# remove new seq with nb of comment <2
datause2 <- datause %>% 
  group_by(seq) %>% 
  filter(n() > 2)


##############prepare flow matrix
nbrow <- as.numeric(nrow(datause2) - nrow(datause2[datause2$timestamp==1, ]))
flow <- data.frame(i=rep(NA,nbrow),
                   j=rep(NA,nbrow),
                   ifromname1=rep(NA,nbrow),
                   ifromname2=rep(NA,nbrow),
                   ifromname3=rep(NA,nbrow),
                   ifromname4=rep(NA,nbrow),
                   ifromname5=rep(NA,nbrow),
                   jfromname1=rep(NA,nbrow),
                   jfromname2=rep(NA,nbrow),
                   jfromname3=rep(NA,nbrow),
                   jfromname4=rep(NA,nbrow),
                   jfromname5=rep(NA,nbrow),
                   idauteur= rep(NA,nbrow),
                   idsequence= rep(NA,nbrow),
                   ecartdate = rep(NA,nbrow),
                   timestamp = rep(NA,nbrow),
                   sexe = rep(NA,nbrow),
                   age = rep(NA,nbrow),
                   stringsAsFactors = FALSE)


j <- 1 #browse flow data frame
for(i in 2:nrow(datause2))
{
  if(datause2$timestamp[i]>1)
  {
    flow$i[j] <- datause2$id[i-1]
    flow$j[j] <- datause2$id[i]
    flow$ifromname1[j] <- datause2$name_1[i-1]
    flow$ifromname2[j]<- datause2$name_2[i-1]
    flow$ifromname3[j] <- datause2$name_3[i-1]
    flow$ifromname4[j] <- datause2$name_4[i-1]
    flow$ifromname5[j] <- datause2$name_5[i-1]
    flow$jfromname1[j] <- datause2$name_1[i]
    flow$jfromname2[j] <- datause2$name_2[i]
    flow$jfromname3[j] <- datause2$name_3[i]
    flow$jfromname4[j] <- datause2$name_4[i]
    flow$jfromname5[j] <- datause2$name_5[i]
    flow$idauteur[j]<- datause2$idauteur[i]
    flow$idsequence[j]<- datause2$seq[i]
    flow$ecartdate[j]<- datause2$dategap[i]
    flow$timestamp[j]<- datause2$timestamp[i]
    flow$sexe[j] <- datause2$sexe[i]
    flow$age[j]<- datause2$age[i]
    j <- j+1
  }
}

write.csv(x = flow, file = "Touristflot.csv")

