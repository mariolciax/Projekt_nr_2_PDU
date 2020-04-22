
options(stringsAsFactors=FALSE) 
library(sqldf)
Badges <- read.csv("~/R/travel_stackexchange_com/Badges.csv")
Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")

finish <- sqldf("SELECT DISTINCT Users.Id, Users.DisplayName, Users.Reputation, Users.Age, Users.Location 
                FROM ( SELECT Name, UserID FROM Badges WHERE Name IN 
                ( SELECT Name FROM Badges WHERE Class=1 
                GROUP BY Name HAVING COUNT(*) BETWEEN 2 AND 10 ) AND Class=1 ) AS ValuableBadges 
                JOIN Users ON ValuableBadges.UserId=Users.Id ")
finish