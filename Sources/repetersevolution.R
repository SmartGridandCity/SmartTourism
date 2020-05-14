#country of repeter for two consecutive years
#repet1314 repet1415 repet1516 repet1617 repet1718 repet1819
test <- repet1819
origin <- select(datarepet, idauteur=idauteur, country=country)
origin <- unique(origin)

test <- merge(test, origin, by="idauteur")
test <- test %>% group_by(name_3.y, country) %>% mutate(nbuser = n_distinct(idauteur))
test <- select(test, destination=name_3.y, country=country, nbuser = nbuser)
test <- unique(test)

test$destination <- gsub('Ã¨', 'è', test$destination)
test$destination <- gsub('Ã¢', 'â', test$destination)
test$destination <- gsub('Ã©', 'é', test$destination)

ggplot(test, aes(fill=country, y=nbuser, x=destination)) +
  geom_bar(position="stack", stat="identity") +
  theme(axis.text.x = element_text(angle=90)) +
  xlab("New destination") + ylab("Number of users") + labs(fill = "Country") 

rm(origin)
rm(test)

#evolution of percent between two consecutive year > come three years
#repet1314 repet1415 repet1516 repet1617 repet1718 repet1819
test <- merge(repet1718, repet1819, by="idauteur")
origin <- select(datarepet, idauteur=idauteur, country=country)
origin <- unique(origin)

test <- merge(test, origin, by="idauteur")
test <- test %>% group_by(name_3.y.y, country) %>% mutate(nbuser = n_distinct(idauteur))
test <- select(test, destination=name_3.y.y, country=country, nbuser = nbuser)
test <- unique(test)

test$destination <- gsub('Ã¨', 'è', test$destination)
test$destination <- gsub('Ã¢', 'â', test$destination)
test$destination <- gsub('Ã©', 'é', test$destination)

ggplot(test, aes(fill=country, y=nbuser, x=destination)) +
  geom_bar(position="stack", stat="identity") +
  theme(axis.text.x = element_text(angle=90)) +
  xlab("New destination") + ylab("Number of users") + labs(fill = "Country") 

rm(origin)
rm(test)

#evolution of percent between three consecutive year > come three years
#repet1314 repet1415 repet1516 repet1617 repet1718 repet1819
test <- merge(repet1617, repet1718, by="idauteur")
test <- select(test, idauteur=idauteur)
test <- unique(test)
test <- merge(test, repet1819, by="idauteur")
origin <- select(datarepet, idauteur=idauteur, country=country)
origin <- unique(origin)

test <- merge(test, origin, by="idauteur")
test <- test %>% group_by(name_3.y, country) %>% mutate(nbuser = n_distinct(idauteur))
test <- select(test, destination=name_3.y, country=country, nbuser = nbuser)
test <- unique(test)

test$destination <- gsub('Ã¨', 'è', test$destination)
test$destination <- gsub('Ã¢', 'â', test$destination)
test$destination <- gsub('Ã©', 'é', test$destination)

ggplot(test, aes(fill=country, y=nbuser, x=destination)) +
  geom_bar(position="stack", stat="identity") +
  theme(axis.text.x = element_text(angle=90)) +
  xlab("New destination") + ylab("Number of users") + labs(fill = "Country") 

rm(origin)
rm(test)

#FAIRE DES GENS QUI REVIENNENT DANS LA MEME ANNEE GRADE A IDAUTEUR ET IDSEQ
sameyear <- datause %>% group_by(idauteur, year) %>% summarize(n=n_distinct(seq))

# write.csv(x = flow, file = "REPETTouristflot.csv")