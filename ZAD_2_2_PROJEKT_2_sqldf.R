options(stringsAsFactors=FALSE) 

Tags <- read.csv("~/R/travel_stackexchange_com/Tags.csv") 

Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")

Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")

library(sqldf)
g <- head(Tags)
dokladny_wybor_posts <- sqldf("select * from Posts where OwnerUserId != -1")

wybor_kol_tags <- sqldf("select TagName, Count, WikiPostId from Tags")
wybor_kol_posts <- sqldf("select OwnerUserId, Id from Posts")
wybor_kol_users <- sqldf("select Age, Location, DisplayName, AccountId from Users")


###merge(Tags, Posts, all.x=FALSE, all.y = FALSE, by.x="Id", by.y ="WikiPostId")


df_sql_2 <- function(){
  options(stringsAsFactors=FALSE) 
  Tags <- read.csv("~/R/travel_stackexchange_com/Tags.csv") 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")
  library(sqldf)
  wybor_kol_tags <- sqldf("select TagName, Count, WikiPostId from Tags")
  wybor_kol_posts <- sqldf("select OwnerUserId, Id from Posts")
  wybor_kol_users <- sqldf("select Age, Location, DisplayName, AccountId from Users")
  join_1 <- sqldf("select * from wybor_kol_tags inner join wybor_kol_posts on wybor_kol_tags.WikiPostId=wybor_kol_posts.Id ")
  join_2 <- sqldf("select * from join_1 inner join wybor_kol_users on wybor_kol_users.AccountId=join_1.OwnerUserId ")
  wybor <- sqldf("select TagName, Count, OwnerUserId, Age, Location, DisplayName from join_2")
  dokladny_wybor <- sqldf("select * from wybor where OwnerUserId != -1")
  final <- sqldf("SELECT * FROM dokladny_wybor ORDER BY Count DESC")
  final
}
df_sql_2()

