options(stringsAsFactors=FALSE) 
PostLinks <- read.csv("~/R/travel_stackexchange_com/PostLinks.csv")
Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
head(PostLinks)
head(Posts)

colnames(PostLinks)[which(names(PostLinks) == "RelatedPostId")] <- "PostId"

library(sqldf)
sqldf("select * from data
       left join (select ID, count(ID) as count from data group by ID)
       using (ID)")
head(PostLinks)


wybor <- sqldf(‘select count(*) total from PostLinks where Num group by survived’)