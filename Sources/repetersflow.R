library(lubridate)
library(tidyverse)

#diff flow between repeters and nono-repeteres
#repeters on year 2016-2017 with nationality
test <- datarepet
test<- test[test$year==2017,]
test <- mutate(test, month=NA)
test$month <- month(test$date_review)
test<- merge(test, repet1617, by.x=c("idauteur", "name_3"), by.y=c("idauteur", "name_3.y"))
test <- test %>% group_by(name_3, month, country) %>% mutate(count = n_distinct(idauteur))
test <- select(test, country, month, name_3, count)
test <- unique(test)

basics <- data2
basics <- mutate(basics, month=NA)
basics$month <- month(basics$date_review)
basics<- basics[basics$year==2017,]
basics <- basics %>% group_by(name_3, month, country) %>% mutate(count = n_distinct(idauteur))
basics <- select(basics, country, month, name_3, count)
basics <- unique(basics)

test <- merge(test, basics, by=c("name_3", "month", "country"))
test <- mutate(test, perc=NA)
test$perc <- test$count.x / test$count.y

test$name_3 <- gsub('Ã¨', 'è', test$name_3)
test$name_3 <- gsub('Ã¢', 'â', test$name_3)
test$name_3 <- gsub('Ã©', 'é', test$name_3)

ggplot(test, aes(fill=country, y=perc, x=month)) +
  geom_bar(position="stack", stat="identity") +
  theme(axis.text.x = element_text(angle=90)) +
  xlab("Month") + ylab("Percent of tourists") + labs(fill = "Country") + facet_wrap(~name_3)  
