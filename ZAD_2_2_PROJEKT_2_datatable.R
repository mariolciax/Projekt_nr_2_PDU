df_table_2 <- function(){
  options(stringsAsFactors=FALSE) 
  Tags <- data.table(read.csv("~/R/travel_stackexchange_com/Tags.csv") )
  Posts <- data.table(read.csv("~/R/travel_stackexchange_com/Posts.csv"))
  Users <- data.table(read.csv("~/R/travel_stackexchange_com/Users.csv"))
  library(data.table)
  join1 <- Tags[Posts, on = "WikiPostId == Id", nomatch = 0 ]
  join2 <- join1[Users, on = "OwnerUserId == AccountId", nomatch = 0]
  wyborkolumn <- join2[, list(TagName, Count, OwnerUserId, Age, Location, DisplayName)]
  bezwyjatku <- wyborkolumn[OwnerUserId != -1 ]
  final4 <- bezwyjatku[order(-Count)]
  final4
}

df_table_2

DT[order(-V3)]

bez_wyjatku <- wybor_kolumn %>%
  filter( OwnerUserId != -1)

final3 <- group_by(bez_wyjatku, Count)

ans <- Tags[order(Count, -desc)]
rad.table()
x[z, on = "X1 == Z1"]




df_table_1 <- function(){
  library("data.table")
  options(stringsAsFactors=FALSE) 
  Posts <- data.table(read.csv("~/R/travel_stackexchange_com/Posts.csv"))
  
  pomocnicza <- Posts[PostTypeId == 1]
  pomocnicza1<- pomocnicza[FavoriteCount >= 25]
  pomocnicza2<- pomocnicza1[ViewCount >= 1000]
  
  ostateczna4 <- pomocnicza2[, list(Title, Score, ViewCount, FavoriteCount)]
  
}

