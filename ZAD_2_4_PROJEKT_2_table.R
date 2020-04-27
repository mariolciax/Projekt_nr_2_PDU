
library(data.table)
options(stringsAsFactors=FALSE) 
Users <- data.table(read.csv("~/R/travel_stackexchange_com/Users.csv"))
Badges <- data.table(read.csv("~/R/travel_stackexchange_com/Badges.csv"))

bezwyjatku <- Badges[Class == 1 ]
pogrupowana<- bezwyjatku[, .N, by = Name]
wybrane <- pogrupowana[N >=2 & N<= 10 ]
samoName <- wybrane[, list(Name)]
poloczona <- Badges[Name %chin% samoName$Name]
ValuableBadges <- poloczona[Class == 1]
join_2<- Users[ValuableBadges, on = "Id == UserId", nomatch = 0]
finish4 <- unique(join_2, by = c("Id", "DisplayName","Reputation","Age","Location"))
finish4 <- finish4[ , list(Id, DisplayName, Reputation, Age, Location)]

