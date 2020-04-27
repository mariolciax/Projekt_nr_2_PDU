options(stringsAsFactors=FALSE) 
PostLinks <- read.csv("~/R/travel_stackexchange_com/PostLinks.csv")
Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
library(sqldf)
koncowa22 <- sqldf("SELECT Posts.Title, RelatedTab.NumLinks 
              FROM (SELECT RelatedPostId AS PostId, 
              COUNT(*) AS NumLinks 
              FROM PostLinks GROUP BY RelatedPostId) AS RelatedTab 
              JOIN Posts ON RelatedTab.PostId=Posts.Id 
              WHERE Posts.PostTypeId=1 ORDER BY NumLinks DESC ")

as.data.frame(koncowa22)
