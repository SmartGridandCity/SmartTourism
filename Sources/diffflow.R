library(scales)

######## analyse difference between global and a selected dataset
#global
flow2 <- flow
flow2 <- flow2 %>% group_by(ifromname3, jfromname3) %>% mutate(count = n())

flow2 <- select(flow2, ifromname3, jfromname3, count)
names(flow2)[names(flow2) == "ifromname3"] <- "ifromname"
names(flow2)[names(flow2) == "jfromname3"] <- "jfromname"
flow2 <- unique(flow2)

flow2$ifromname <- gsub('Ã¨', 'è', flow2$ifromname)
flow2$ifromname <- gsub('Ã¢', 'â', flow2$ifromname)
flow2$ifromname <- gsub('Ã©', 'é', flow2$ifromname)
flow2$jfromname <- gsub('Ã¨', 'è', flow2$jfromname)
flow2$jfromname <- gsub('Ã¢', 'â', flow2$jfromname)
flow2$jfromname <- gsub('Ã©', 'é', flow2$jfromname)

networkData <- data.frame(iname=flow2$ifromname, jname=flow2$jfromname, fij=flow2$count)
networkData <- networkData %>% group_by(iname) %>% mutate(sum = sum(fij))
networkData$fij <- networkData$fij / networkData$sum

#selected
flowtest <- flow

#selection for the flow (sex, age)
# flow2 <- filter(flow2, sex=='male')
# flow2 <- filter(flow2, age==1)

### AGE AND SEX GIVE NO CHANGE / GLOBAL

# "Belgium" "France" "United States" "Netherlands" "United Kingdom" "Germany" "Australia" "Switzerland" "Italy" "Russia" "Spain" "Canada" "Brazil"
temp <- select(datause2, idauteur, country)
temp$seq <- NULL
temp <- unique(temp)
flowtest <- left_join(flowtest, temp, by.x="idauteur", by.y="idauteur", sort = FALSE)
flowtest <- filter(flowtest, country=='Belgium')

flowtest <- flowtest %>% group_by(ifromname3, jfromname3) %>% mutate(count = n())

#create the dataset
flowtest <- select(flowtest, ifromname3, jfromname3, count)
names(flowtest)[names(flowtest) == "ifromname3"] <- "ifromname"
names(flowtest)[names(flowtest) == "jfromname3"] <- "jfromname"
flowtest <- unique(flowtest)

#change encoding problem
flowtest$ifromname <- gsub('Ã¨', 'è', flowtest$ifromname)
flowtest$ifromname <- gsub('Ã¢', 'â', flowtest$ifromname)
flowtest$ifromname <- gsub('Ã©', 'é', flowtest$ifromname)
flowtest$jfromname <- gsub('Ã¨', 'è', flowtest$jfromname)
flowtest$jfromname <- gsub('Ã¢', 'â', flowtest$jfromname)
flowtest$jfromname <- gsub('Ã©', 'é', flowtest$jfromname)

#create network data
networkDatatest <- data.frame(iname=flowtest$ifromname, jname=flowtest$jfromname, fij=flowtest$count)
networkDatatest <- networkDatatest %>% group_by(iname) %>% mutate(sum = sum(fij))
networkDatatest$fij <- networkDatatest$fij / networkDatatest$sum

#compare the flows
flowcomp <- merge(networkData, networkDatatest, by=c("iname", "jname"), all=TRUE)
flowcomp <- mutate(flowcomp, fij=0)
flowcomp[is.na(flowcomp)] <- 0
flowcomp$fij <- flowcomp$fij.y - flowcomp$fij.x
ggplot(flowcomp, aes(jname, iname, fill= fij)) + 
  geom_tile() + xlab("Destination") + ylab("Source") + labs(fill = "% of difference") +
  theme(axis.text.x = element_text(angle=90))

rm(flowcomp)
rm(networkDatatest)
rm(flowtest)
rm(networkData)
rm(flow2)