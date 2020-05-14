# install.packages("pastecs")
# library(pastecs)
# library(networkD3)
# library(magrittr)
# library(jsonlite)
# library(lubridate)
# library("dplyr")
# library(raster)
# library(conflicted)
# conflict_prefer("select", "dplyr")
# conflict_prefer("filter", "dplyr")
# library(networkD3)
# library(magrittr)
# library(jsonlite)
# library(ggplot2)


###see repeters
################ adding sequence information to the dataset
datarepet <- data2[order(data2$idauteur, data2$date_review),]

################### create dataset
#select the data
#keep nationality over 1000 comments
nationality <- table(datarepet$country)
nationality <- as.data.frame(nationality)
nationality <- nationality[nationality$Freq <1000,]
nationality <- nationality$Var1
for (i in 1:length(nationality))
{
  datarepet <- datarepet[!datarepet$country==nationality[i], ]
}

rm(nationality)

#keep year with lots of users and comments
year <- c(2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012)
for (i in 1:length(year))
{
  datarepet <- datarepet[!datarepet$year==year[i], ]
}

rm(year)

datarepet <- datarepet[order(datarepet$idauteur, datarepet$date_review),]

#select nationality, age, sewe etc
# datarepet <- datarepet[datarepet$country=="France",]

#nb of user per year
nbuser <- datarepet %>% group_by(year)  %>% summarize(n=n_distinct(idauteur))
nbuser <- nbuser[order(nbuser$year),]

#keep people who come back at least two different year
datarepet <- datarepet %>% group_by(idauteur) %>% mutate(nbyear = n_distinct(year))
datarepet <- datarepet[!datarepet$nbyear==1,]

#seperate visit by year 2013 2014 2017 2018 2015 2016 2019
datarepet2013 <- datarepet[datarepet$year==2013,]
datarepet2013 <- select(datarepet2013, name_3=name_3, idauteur=idauteur)
datarepet2013 <- unique(datarepet2013)

datarepet2014 <- datarepet[datarepet$year==2014,]
datarepet2014 <- select(datarepet2014, name_3=name_3, idauteur=idauteur)
datarepet2014 <- unique(datarepet2014)

datarepet2015 <- datarepet[datarepet$year==2015,]
datarepet2015 <- select(datarepet2015, name_3=name_3, idauteur=idauteur)
datarepet2015 <- unique(datarepet2015)

datarepet2016 <- datarepet[datarepet$year==2016,]
datarepet2016 <- select(datarepet2016, name_3=name_3, idauteur=idauteur)
datarepet2016 <- unique(datarepet2016)

datarepet2017 <- datarepet[datarepet$year==2017,]
datarepet2017 <- select(datarepet2017, name_3=name_3, idauteur=idauteur)
datarepet2017 <- unique(datarepet2017)

datarepet2018 <- datarepet[datarepet$year==2018,]
datarepet2018 <- select(datarepet2018, name_3=name_3, idauteur=idauteur)
datarepet2018 <- unique(datarepet2018)

datarepet2019 <- datarepet[datarepet$year==2019,]
datarepet2019 <- select(datarepet2019, name_3=name_3, idauteur=idauteur)
datarepet2019 <- unique(datarepet2019)

# stats about dataset
stat <- datarepet2019 %>% group_by(idauteur) %>% mutate(count = n())
stat <- select(stat, idauteur, count)
stat <- unique(stat)
stat <- stat.desc(stat$count)
stat <- as.data.frame(stat)
stat[1,1] #nbre of idauteur
stat[7,1] #nbre of tuple name3-idauteur
stat[4,1] #min number of tuple per idauteur
stat[5,1] #max number of tuple per idauteur
stat[9,1] #mean number of tuple per idauteur
stat[13,1] #std number of tuple per idauteur

rm(stat)

#create all join possible CHANGER POUR PRENDRE EN COMPTE TOUTES LES ZONES ET FAIRE LE FLOT DES REPETERS INTERZONES
repet1314 <- merge(datarepet2013, datarepet2014, by=c("idauteur"), sort = FALSE)
repet1315 <- merge(datarepet2013, datarepet2015, by=c("idauteur"), sort = FALSE)
repet1316 <- merge(datarepet2013, datarepet2016, by=c("idauteur"), sort = FALSE)
repet1317 <- merge(datarepet2013, datarepet2017, by=c("idauteur"), sort = FALSE)
repet1318 <- merge(datarepet2013, datarepet2018, by=c("idauteur"), sort = FALSE)
repet1319 <- merge(datarepet2013, datarepet2019, by=c("idauteur"), sort = FALSE)
repet1415 <- merge(datarepet2014, datarepet2015, by=c("idauteur"), sort = FALSE)
repet1416 <- merge(datarepet2014, datarepet2016, by=c("idauteur"), sort = FALSE)
repet1417 <- merge(datarepet2014, datarepet2017, by=c("idauteur"), sort = FALSE)
repet1418 <- merge(datarepet2014, datarepet2018, by=c("idauteur"), sort = FALSE)
repet1419 <- merge(datarepet2014, datarepet2019, by=c("idauteur"), sort = FALSE)
repet1516 <- merge(datarepet2015, datarepet2016, by=c("idauteur"), sort = FALSE)
repet1517 <- merge(datarepet2015, datarepet2017, by=c("idauteur"), sort = FALSE)
repet1518 <- merge(datarepet2015, datarepet2018, by=c("idauteur"), sort = FALSE)
repet1519 <- merge(datarepet2015, datarepet2019, by=c("idauteur"), sort = FALSE)
repet1617 <- merge(datarepet2016, datarepet2017, by=c("idauteur"), sort = FALSE)
repet1618 <- merge(datarepet2016, datarepet2018, by=c("idauteur"), sort = FALSE)
repet1619 <- merge(datarepet2016, datarepet2019, by=c("idauteur"), sort = FALSE)
repet1718 <- merge(datarepet2017, datarepet2018, by=c("idauteur"), sort = FALSE)
repet1719 <- merge(datarepet2017, datarepet2019, by=c("idauteur"), sort = FALSE)
repet1819 <- merge(datarepet2018, datarepet2019, by=c("idauteur"), sort = FALSE)

# stats about dataset
stat <- select(repet1617, idauteur, name_3.y) 
stat <- unique(stat)
stat <-  stat   %>% group_by(idauteur) %>% mutate(count = n())
stat <- select(stat, idauteur, count)
stat <- unique(stat)
stat <- stat.desc(stat$count)
stat <- as.data.frame(stat)
stat[1,1] #nbre of idauteur
stat[7,1] #nbre of tuple name3-idauteur
stat[4,1] #min number of tuple per idauteur
stat[5,1] #max number of tuple per idauteur
stat[9,1] #mean number of tuple per idauteur
stat[13,1] #std number of tuple per idauteur

rm(stat)

#count nb of repeters for each zones : visit x year 1 and visit y year 2 and percent of comment
repetnb <- data.frame(year=character(), percent=numeric())

repet1314nb <- repet1314 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1314nb <- merge(repet1314nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1314nb <- merge(repet1314nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1314nb <- select(repet1314nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1314nb <- repet1314nb[order(repet1314nb$namex, repet1314nb$namey),]
repet1314nb <- mutate(repet1314nb, year="13-14")
repetnb <- add_row(repetnb, year="13-14", percent =  n_distinct(repet1314$idauteur)/nbuser$n[1]) 

repet1315nb <- repet1315 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1315nb <- merge(repet1315nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1315nb <- merge(repet1315nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1315nb <- select(repet1315nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1315nb <- repet1315nb[order(repet1315nb$namex, repet1315nb$namey),]
repet1315nb <- mutate(repet1315nb, year="13-15")
repetnb <- add_row(repetnb, year="13-15", percent =  n_distinct(repet1315$idauteur)/nbuser$n[1]) 

repet1316nb <- repet1316 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1316nb <- merge(repet1316nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1316nb <- merge(repet1316nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1316nb <- select(repet1316nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1316nb <- repet1316nb[order(repet1316nb$namex, repet1316nb$namey),]
repet1316nb <- mutate(repet1316nb, year="13-16")
repetnb <- add_row(repetnb, year="13-16", percent =  n_distinct(repet1316$idauteur)/nbuser$n[1]) 

repet1317nb <- repet1317 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1317nb <- merge(repet1317nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1317nb <- merge(repet1317nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1317nb <- select(repet1317nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1317nb <- repet1317nb[order(repet1317nb$namex, repet1317nb$namey),]
repet1317nb <- mutate(repet1317nb, year="13-17")
repetnb <- add_row(repetnb, year="13-17", percent =  n_distinct(repet1317$idauteur)/nbuser$n[1]) 

repet1318nb <- repet1318 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1318nb <- merge(repet1318nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1318nb <- merge(repet1318nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1318nb <- select(repet1318nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1318nb <- repet1318nb[order(repet1318nb$namex, repet1318nb$namey),]
repet1318nb <- mutate(repet1318nb, year="13-18")
repetnb <- add_row(repetnb, year="13-18", percent =  n_distinct(repet1318$idauteur)/nbuser$n[1]) 

repet1319nb <- repet1319 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1319nb <- merge(repet1319nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1319nb <- merge(repet1319nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1319nb <- select(repet1319nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1319nb <- repet1319nb[order(repet1319nb$namex, repet1319nb$namey),]
repet1319nb <- mutate(repet1319nb, year="13-19")
repetnb <- add_row(repetnb, year="13-19", percent =  n_distinct(repet1319$idauteur)/nbuser$n[1]) 

repet1415nb <- repet1415 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1415nb <- merge(repet1415nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1415nb <- merge(repet1415nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1415nb <- select(repet1415nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1415nb <- repet1415nb[order(repet1415nb$namex, repet1415nb$namey),]
repet1415nb <- mutate(repet1415nb, year="14-15")
repetnb <- add_row(repetnb, year="14-15", percent =  n_distinct(repet1415$idauteur)/nbuser$n[2]) 

repet1416nb <- repet1416 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1416nb <- merge(repet1416nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1416nb <- merge(repet1416nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1416nb <- select(repet1416nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1416nb <- repet1416nb[order(repet1416nb$namex, repet1416nb$namey),]
repet1416nb <- mutate(repet1416nb, year="14-16")
repetnb <- add_row(repetnb, year="14-16", percent =  n_distinct(repet1416$idauteur)/nbuser$n[2]) 

repet1417nb <- repet1417 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1417nb <- merge(repet1417nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1417nb <- merge(repet1417nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1417nb <- select(repet1417nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1417nb <- repet1417nb[order(repet1417nb$namex, repet1417nb$namey),]
repet1417nb <- mutate(repet1417nb, year="14-17")
repetnb <- add_row(repetnb, year="14-17", percent =  n_distinct(repet1417$idauteur)/nbuser$n[2]) 

repet1418nb <- repet1418 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1418nb <- merge(repet1418nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1418nb <- merge(repet1418nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1418nb <- select(repet1418nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1418nb <- repet1418nb[order(repet1418nb$namex, repet1418nb$namey),]
repet1418nb <- mutate(repet1418nb, year="14-18")
repetnb <- add_row(repetnb, year="14-18", percent =  n_distinct(repet1418$idauteur)/nbuser$n[2]) 

repet1419nb <- repet1419 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1419nb <- merge(repet1419nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1419nb <- merge(repet1419nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1419nb <- select(repet1419nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1419nb <- repet1419nb[order(repet1419nb$namex, repet1419nb$namey),]
repet1419nb <- mutate(repet1419nb, year="14-19")
repetnb <- add_row(repetnb, year="14-19", percent =  n_distinct(repet1419$idauteur)/nbuser$n[2]) 

repet1516nb <- repet1516 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1516nb <- merge(repet1516nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1516nb <- merge(repet1516nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1516nb <- select(repet1516nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1516nb <- repet1516nb[order(repet1516nb$namex, repet1516nb$namey),]
repet1516nb <- mutate(repet1516nb, year="15-16")
repetnb <- add_row(repetnb, year="15-16", percent =  n_distinct(repet1516$idauteur)/nbuser$n[3]) 

repet1517nb <- repet1517 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1517nb <- merge(repet1517nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1517nb <- merge(repet1517nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1517nb <- select(repet1517nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1517nb <- repet1517nb[order(repet1517nb$namex, repet1517nb$namey),]
repet1517nb <- mutate(repet1517nb, year="15-17")
repetnb <- add_row(repetnb, year="15-17", percent =  n_distinct(repet1517$idauteur)/nbuser$n[3]) 

repet1518nb <- repet1518 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1518nb <- merge(repet1518nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1518nb <- merge(repet1518nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1518nb <- select(repet1518nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1518nb <- repet1518nb[order(repet1518nb$namex, repet1518nb$namey),]
repet1518nb <- mutate(repet1518nb, year="15-18")
repetnb <- add_row(repetnb, year="15-18", percent =  n_distinct(repet1518$idauteur)/nbuser$n[3]) 

repet1519nb <- repet1519 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1519nb <- merge(repet1519nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1519nb <- merge(repet1519nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1519nb <- select(repet1519nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1519nb <- repet1519nb[order(repet1519nb$namex, repet1519nb$namey),]
repet1519nb <- mutate(repet1519nb, year="15-19")
repetnb <- add_row(repetnb, year="15-19", percent =  n_distinct(repet1519$idauteur)/nbuser$n[3]) 

repet1617nb <- repet1617 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1617nb <- merge(repet1617nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1617nb <- merge(repet1617nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1617nb <- select(repet1617nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1617nb <- repet1617nb[order(repet1617nb$namex, repet1617nb$namey),]
repet1617nb <- mutate(repet1617nb, year="16-17")
repetnb <- add_row(repetnb, year="16-17", percent = n_distinct(repet1617$idauteur)/nbuser$n[4]) 

repet1618nb <- repet1618 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1618nb <- merge(repet1618nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1618nb <- merge(repet1618nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1618nb <- select(repet1618nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1618nb <- repet1618nb[order(repet1618nb$namex, repet1618nb$namey),]
repet1618nb <- mutate(repet1618nb, year="16-18")
repetnb <- add_row(repetnb, year="16-18", percent = n_distinct(repet1618$idauteur)/nbuser$n[4]) 

repet1619nb <- repet1619 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1619nb <- merge(repet1619nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1619nb <- merge(repet1619nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1619nb <- select(repet1619nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1619nb <- repet1619nb[order(repet1619nb$namex, repet1619nb$namey),]
repet1619nb <- mutate(repet1619nb, year="16-19")
repetnb <- add_row(repetnb, year="16-19", percent = n_distinct(repet1619$idauteur)/nbuser$n[4]) 

repet1718nb <- repet1718 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1718nb <- merge(repet1718nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1718nb <- merge(repet1718nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1718nb <- select(repet1718nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1718nb <- repet1718nb[order(repet1718nb$namex, repet1718nb$namey),]
repet1718nb <- mutate(repet1718nb, year="17-18")
repetnb <- add_row(repetnb, year="17-18", percent = n_distinct(repet1718$idauteur)/nbuser$n[5]) 

repet1719nb <- repet1719 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1719nb <- merge(repet1719nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1719nb <- merge(repet1719nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1719nb <- select(repet1719nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1719nb <- repet1719nb[order(repet1719nb$namex, repet1719nb$namey),]
repet1719nb <- mutate(repet1719nb, year="17-19")
repetnb <- add_row(repetnb, year="17-19", percent = n_distinct(repet1719$idauteur)/nbuser$n[5]) 

repet1819nb <- repet1819 %>% group_by(name_3.x, name_3.y) %>% summarize(n=n_distinct(idauteur))
repet1819nb <- merge(repet1819nb, networkdatanodes, by.x="name_3.x", by.y="name")
repet1819nb <- merge(repet1819nb, networkdatanodes, by.x="name_3.y", by.y="name")
repet1819nb <- select(repet1819nb, namex = name_3.x, namey = name_3.y, x = id.x, y = id.y, value  = n)
repet1819nb <- repet1819nb[order(repet1819nb$namex, repet1819nb$namey),]
repet1819nb <- mutate(repet1819nb, year="18-19")
repetnb <- add_row(repetnb, year="18-19", percent = n_distinct(repet1819$idauteur) /nbuser$n[6]) 

# stats about dataset
stat <- repet1719nb
stat <- stat.desc(stat$value)
stat <- as.data.frame(stat)
stat[1,1] #nbre of tuple source-destination
stat[4,1] #min number of users per name3
stat[5,1] #max number of users per name3
stat[9,1] #mean number of users per name3
stat[13,1] #std number of users per name3

rm(stat)


#nb of user who come ba
barplot(repetnb$percent,
        main = "Percent of repeters",
        xlab = "Percent",
        ylab = "Years",
        names.arg = repetnb$year,
        col = "darkred",
        horiz = TRUE,
        las =2)

#see one dataset with heatmap 
test <- repet1314nb

test$namex <- gsub('Ã¨', 'è', test$namex)
test$namex <- gsub('Ã¢', 'â', test$namex)
test$namex <- gsub('Ã©', 'é', test$namex)

test$namey <- gsub('Ã¨', 'è', test$namey )
test$namey <- gsub('Ã¢', 'â', test$namey )
test$namey <- gsub('Ã©', 'é', test$namey )

ggplot(test, aes(namey, namex, fill= value)) + 
  geom_tile() + xlab("New comment's place") + ylab("Previous comment's place") + labs(fill = "nb of comments") +
  theme(axis.text.x = element_text(angle=90))

#see in percent
testsum <- aggregate(test$value, by=list(namex=test$namex), FUN=sum)
test <- merge(test, testsum, by="namex")

test <- mutate(test, percent=0)
test$percent <- test$value / test$x.y

ggplot(test, aes(namey, namex, fill= percent)) + 
  geom_tile() + 
  geom_tile() + xlab("New comment's place") + ylab("Previous comment's place") + labs(fill = "% row's") +
  theme(axis.text.x = element_text(angle=90))


rm(test)
rm(testsum)
