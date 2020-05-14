# install.packages("flows")
# library(flows)
# library(raster)
# library("dplyr")
# library(raster)
# library(conflicted)
# conflict_prefer("select", "dplyr")
# conflict_prefer("filter", "dplyr")

##### build the dataset
flow2 <- flow

#selection for the flow (sex, age)
# flow2 <- filter(flow2, sex=='male')
# flow2 <- filter(flow2, age==1)

### AGE AND SEX GIVE NO CHANGE / GLOBAL

# "Belgium" "France" "United States" "Netherlands" "United Kingdom" "Germany" "Australia"
#"Switzerland" "Italy" "Russia" "Spain" "Canada" "Brazil"
temp <- select(datause2, idauteur, country)
temp$seq <- NULL
temp <- unique(temp)
flow2 <- left_join(flow2, temp, by.x="idauteur", by.y="idauteur", sort = FALSE)
flow2 <- filter(flow2, country=='United States')
length(unique(flow2$idauteur))
nrow(flow2)

flow2 <- flow2 %>% group_by(ifromname3, jfromname3) %>% mutate(count = n())

#create the dataset
flow2 <- select(flow2, ifromname3, jfromname3, count)
names(flow2)[names(flow2) == "ifromname3"] <- "ifromname"
names(flow2)[names(flow2) == "jfromname3"] <- "jfromname"
flow2 <- unique(flow2)

france<-getData('GADM', country='FRA', level=3)
hautsdefrance <- subset(france, NAME_1=="Hauts-de-France")

HdF <- data.frame(GID= hautsdefrance$GID_3, name = hautsdefrance$NAME_3)

#change encoding problem
flow2$ifromname <- gsub('Ã¨', 'è', flow2$ifromname)
flow2$ifromname <- gsub('Ã¢', 'â', flow2$ifromname)
flow2$ifromname <- gsub('Ã©', 'é', flow2$ifromname)
flow2$jfromname <- gsub('Ã¨', 'è', flow2$jfromname)
flow2$jfromname <- gsub('Ã¢', 'â', flow2$jfromname)
flow2$jfromname <- gsub('Ã©', 'é', flow2$jfromname)

#create network data
networkData <- data.frame(iname=flow2$ifromname, jname=flow2$jfromname, fij=flow2$count)
sourceid <- data.frame(name=unique(flow2$ifromname))
sourceid2 <- data.frame(name=unique(flow2$jfromname))
networkdatanodes <- bind_rows(sourceid, sourceid2)
networkdatanodes <- as.data.frame(unique(networkdatanodes))
networkdatanodes <- networkdatanodes %>% mutate(id = row_number())
networkData <- merge(networkData, networkdatanodes, by.x="iname", by.y="name", sort = FALSE)
networkData <- merge(networkData, networkdatanodes, by.x="jname", by.y="name", sort = FALSE)
HdF <- left_join(HdF, networkdatanodes, by="name", sort = FALSE)
names(networkData)[names(networkData) == "id.x"] <- "i"
names(networkData)[names(networkData) == "id.y"] <- "j"

for(i in 1:nrow(HdF))
{
  if(is.na(HdF$id[i]))
  {
    HdF$id[i] <- max(HdF$id, na.rm = TRUE)+1
  }
}

hautsdefrance$GID_3 <- HdF$id


#stat on data
myflows <- prepflows(mat = networkData, i = "i", j = "j", fij = "fij")
statflow <- statmat(mat = myflows, output = "none", verbose = TRUE)
statmat(mat = myflows, output = "all", verbose = FALSE)

# commuters
diag(myflows) <- 0
flowSel1 <- firstflows(mat = myflows, method = "xfirst", k = as.numeric(statflow$median))
flowSel2 <- domflows(mat = myflows, w = colSums(myflows), k = 1)
flowSel <- myflows * flowSel1 * flowSel2
inflows <- data.frame(id = colnames(myflows), w = colSums(myflows))

# Plot dominant flows map
opar <- par(mar = c(0,0,2,0))
sp::plot(hautsdefrance, col = "#cceae7", border = NA)
plotMapDomFlows(mat = flowSel, spdf = hautsdefrance, spdfid = "GID_3", w = inflows, wid = "id",
                wvar = "w", wcex = 0.05, add = TRUE,
                legend.flows.pos = "topright",
                legend.flows.title = "Nb. of commuters")
title("Dominant Flows of Commuters")

myflows <- prepflows(mat = networkData, i = "i", j = "j", fij = "fij")
myflows <- myflows/rowSums(myflows)*100

# write.csv(x = myflows, file = "MarkovFranceAGE1.csv")
# write.table(HdF, "MarkovFranceAGE1.csv", col.names=FALSE, sep=",", append=TRUE)

rm(flowSel)
rm(opar)
rm(myflows)
rm(flowSel1)
rm(flowSel2)
rm(statflow)
rm(france)
rm(hautsdefrance)
rm(HdF)
rm(inflows)
rm(sourceid)
rm(sourceid2)
