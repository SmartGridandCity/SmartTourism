# install.packages("RcppQuantuccia")
# library(RcppQuantuccia)
# library(lubridate)
# library("dplyr")
# library("plyr")
# library(tidyr)
# library(raster)
# library(conflicted)
# library(tidyverse)
# conflict_prefer("select", "dplyr")
# conflict_prefer("filter", "dplyr")
# conflict_prefer("mutate", "dplyr")
# conflict_prefer("count", "dplyr")

## from a dataset, build histogramm per country choosing age, sex, month of year, type of day
##############################
#see nationality per month of visiting
basics <- datause
basics <- mutate(basics, month=NA)
basics$month <- month(basics$date_review)
basics <- basics[order(basics$month),]

basics <- basics %>% group_by(country, month) %>% mutate(count = n_distinct(idauteur))
basics <- select(basics, country, month, count)
basics <- unique(basics)

ggplot(basics, aes(fill=country, y=count, x=month)) +
  geom_bar(position="stack", stat="identity") +
  theme(axis.text.x = element_text(angle=90)) +
  xlab("Month") + ylab("Number of users") + labs(fill = "Country")

#see percent by month for each nationality
# "Belgium" "France" "United States" "Netherlands" "United Kingdom" "Germany" "Australia" "Switzerland" "Italy" "Russia" "Spain" "Canada" "Brazil"
basics <- basics %>% group_by(country) %>% mutate(sum = sum(count))
basics <- mutate(basics, perc=NA)
basics$perc <- basics$count/basics$sum

ggplot(basics, aes(fill=country, y=perc, x=month)) +
  geom_bar(position="stack", stat="identity") +
  theme(axis.text.x = element_text(angle=90)) +
  xlab("Month") + ylab("Number of users") + labs(fill = "Country")

rm(sum)
rm(basics)

####################################
#see nationality per month and if week-end or not
basics <- datause
basics <- mutate(basics, month=NA)
basics$month <- month(basics$date_review)
basics <- mutate(basics, we=NA)
basics$we <- isWeekend(basics$date_review)
basics <- basics %>% group_by(country, month, we) %>% mutate(count = n_distinct(idauteur))
basics <- select(basics, country, month, we, count)
basics <- unique(basics)
basics$we <- as.character(basics$we)

ggplot(basics, aes(fill=country, x = month, y = count)) + geom_bar(stat = "identity") + xlab("Month (we or not)") + ylab("Number of users") + labs(fill = "Country")+
  facet_wrap(~we)

#see nationality per month for users that only came during week-end
basics2 <- datause
basics2 <- mutate(basics2, month=NA)
basics2$month <- month(basics2$date_review)
basics2 <- mutate(basics2, we=NA)
basics2$we <- isWeekend(basics2$date_review)
semaine <- basics2[basics2$we == FALSE,]
semaine <- unique(semaine$idauteur)
basics2 <- subset(basics2, !(idauteur %in% semaine))

basics2 <- basics2 %>% group_by(country, month) %>% mutate(count = n_distinct(idauteur))
basics2 <- select(basics2, country, month, count)
basics2 <- unique(basics2)

ggplot(basics2, aes(fill=country, y=count, x=month)) +
  geom_bar(position="stack", stat="identity") +
  theme(axis.text.x = element_text(angle=90)) +
  xlab("Month") + ylab("Number of users (only we)") + labs(fill = "Country")

basics3 <- datause
basics3 <- mutate(basics3, month=NA)
basics3$month <- month(basics3$date_review)
basics3 <- basics3[order(basics3$month),]

basics3 <- basics3 %>% group_by(country, month) %>% mutate(count = n_distinct(idauteur))
basics3 <- select(basics3, country, month, count)
basics3 <- unique(basics3)
basics2 <- inner_join(basics2, basics3, by=c("country", "month"))
basics2 <- mutate(basics2, perc=NA)
basics2$perc <- basics2$count.x/basics2$count.y

ggplot(basics2, aes(fill=country, y=perc, x=month)) +
  geom_bar(position="stack", stat="identity") +
  theme(axis.text.x = element_text(angle=90)) +
  xlab("Month") + ylab("Perc of users (only we/total)") + labs(fill = "Country")

rm(basics)
rm(basics2)
rm(basics3)
