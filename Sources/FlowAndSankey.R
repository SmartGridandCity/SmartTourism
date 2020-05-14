# install.packages('networkD3', type = "source")
# install.packages("jsonlite")
# library(networkD3)
# library(magrittr)
# library(jsonlite)

########## choose the GID and others parameters to compute flow

#choose the GID level
flow2 <- flow %>% group_by(ifromname2, jfromname3) %>% mutate(count = n())

#choose the nationality : 
# "Belgium" "France" "United States" "Netherlands" "United Kingdom" "Germany" "Australia" "Switzerland" "Italy" "Russia" "Spain" "Canada" "Brazil"
temp <- select(datause2, idauteur, country)
temp$seq <- NULL
temp <- unique(temp)
flow2 <- left_join(flow2, temp, by.x="idauteur", by.y="idauteur", sort = FALSE)
flow2 <- filter(flow2, country=='Brazil')

length(unique(flow2$idauteur))
nrow(flow2)

rm(temp)

# #choose the sex : male, female
# temp <- select(datause2, idauteur, sex)
# temp$seq <- NULL
# temp <- subset(temp, temp$sex!="")
# temp <- unique(temp)
# flow2 <- left_join(flow2, temp, by.x="idauteur", by.y="idauteur", sort = FALSE)
# flow2 <- filter(flow2, sex=='female')
# 
# rm(temp)
# 
# #choose the age category 1, 2, 3, 4, 5, 6
# temp <- select(datause2, idauteur, age)
# temp$seq <- NULL
# temp <- subset(temp, temp$age!="")
# temp <- subset(temp, !is.na(temp$age))
# temp <- unique(temp)
# flow2 <- left_join(flow2, temp, by.x="idauteur", by.y="idauteur", sort = FALSE)
# flow2 <- filter(flow2, age==1)
# 
# rm(temp)

#form the dataset
flow2 <- select(flow2, ifromname3, jfromname3, count)
names(flow2)[names(flow2) == "ifromname3"] <- "ifromname"
names(flow2)[names(flow2) == "jfromname3"] <- "jfromname"
flow2 <- unique(flow2)

#form the network data
networkData <- data.frame(source=flow2$ifromname, target=flow2$jfromname, value=flow2$count)
sourceid <- data.frame(name=unique(flow2$ifromname))
sourceid2 <- data.frame(name=unique(flow2$jfromname))
networkdatanodes <- bind_rows(sourceid, sourceid2)
networkdatanodes <- as.data.frame(unique(networkdatanodes))
networkdatanodes <- networkdatanodes %>% mutate(id = row_number())
networkData <- merge(networkData, networkdatanodes, by.x="source", by.y="name", sort = FALSE)
networkData <- merge(networkData, networkdatanodes, by.x="target", by.y="name", sort = FALSE)
networkdatanodes <- mutate(networkdatanodes, group=1, size=15)

# #simple graphe with the data
# networkData2 <- data.frame(source=flow2$ifromname3, target=flow2$jfromname3)
# simpleNetwork(networkData2, zoom= TRUE, linkDistance = 300, charge = -50, fontSize = 7, fontFamily = "serif",
#               linkColour = "#666", nodeColour = "#3182bd", opacity = 1)
# 
# simpleNetwork(networkData2) %>%
#   saveNetwork(file = 'Netw.html')
# 
# rm(networkData2)

#graph with weighted
networkData2 <- data.frame(source=flow2$ifromname, target=flow2$jfromname, value=flow2$count)
sourceid <- data.frame(name=unique(networkData2$source))
sourceid2 <- data.frame(name=unique(networkData2$target))
networkdatanodes2 <- bind_rows(sourceid, sourceid2)
networkdatanodes2 <- as.data.frame(unique(networkdatanodes2))
networkdatanodes2 <- networkdatanodes2 %>% mutate(id = row_number())
networkData2 <- merge(networkData2, networkdatanodes2, by.x="source", by.y="name", sort = FALSE)
networkData2 <- merge(networkData2, networkdatanodes2, by.x="target", by.y="name", sort = FALSE)
networkdatanodes2 <- mutate(networkdatanodes2, group=1, size=15)
networkData2 <- data.frame(source= networkData2$id.x, target=  networkData2$id.y, value= networkData2$value)
networkdatanodes2 <- data.frame(id= networkdatanodes2$id,name = networkdatanodes2$name, group = networkdatanodes2$group, size = networkdatanodes2$size)
networkData2$source = networkData2$source -1 #zero-indexed value
networkData2$target = networkData2$target -1
networkdatanodes2$id = networkdatanodes2$id -1

networkdatanodes2 <- toJSON(networkdatanodes2, pretty = TRUE)
networkData2 <- toJSON(networkData2, pretty = TRUE)
networkdatanodes2 <- jsonlite::fromJSON(networkdatanodes2)
networkData2 <- jsonlite::fromJSON(networkData2)

forceNetwork(Links = networkData2, Nodes= networkdatanodes2, Source = "source",
             Target = "target", Value = "value", NodeID = "name", linkDistance = 300, charge = -50,
             Group = "group", opacity = 0.4, zoom = TRUE)  %>%
  saveNetwork(file = 'NetFORCEname3Brazil.html')

rm(networkData2)
rm(networkdatanodes2)
rm(sourceid)
rm(sourceid2)

#sankeynetwork with separated source and target
networkData2 <- data.frame(source=flow2$ifromname, target=flow2$jfromname, value=flow2$count)
networkData2$target <- paste0(networkData2$target, "_t")
sourceid <- data.frame(name=unique(networkData2$source))
sourceid2 <- data.frame(name=unique(networkData2$target))
networkdatanodes2 <- bind_rows(sourceid, sourceid2)
networkdatanodes2 <- as.data.frame(unique(networkdatanodes2))
networkdatanodes2 <- networkdatanodes2 %>% mutate(id = row_number())
networkData2 <- merge(networkData2, networkdatanodes2, by.x="source", by.y="name", sort = FALSE)
networkData2 <- merge(networkData2, networkdatanodes2, by.x="target", by.y="name", sort = FALSE)
networkdatanodes2 <- mutate(networkdatanodes2, group=1, size=15)
networkData2 <- data.frame(source= networkData2$id.x, target=  networkData2$id.y, value= networkData2$value)
networkdatanodes2 <- data.frame(id= networkdatanodes2$id,name = networkdatanodes2$name, group = networkdatanodes2$group, size = networkdatanodes2$size)
networkData2$source = networkData2$source -1 #zero-indexed value
networkData2$target = networkData2$target -1
networkdatanodes2$id = networkdatanodes2$id -1

networkdatanodes2 <- toJSON(networkdatanodes2, pretty = TRUE)
networkData2 <- toJSON(networkData2, pretty = TRUE)
networkdatanodes2 <- jsonlite::fromJSON(networkdatanodes2)
networkData2 <- jsonlite::fromJSON(networkData2)

sankeyNetwork(Links = networkData2, Nodes = networkdatanodes2, Source = 'source',
              Target = 'target', Value = 'value', NodeID = 'name',
              units = 'Users', fontSize = 12, nodeWidth = 30)  %>% saveNetwork(file = 'NetSANKEYname3Brazil.html')

rm(networkData2)
rm(networkdatanodes2)
rm(sourceid)
rm(sourceid2)

