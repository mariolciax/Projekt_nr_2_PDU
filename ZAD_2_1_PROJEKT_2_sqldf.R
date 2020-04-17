options(stringsAsFactors=FALSE) 
Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
library(sqldf)

sqldf("select * from Posts where  PostTypeId = 1 and FavoriteCount >= 25 and ViewCount >= 1000")
sqldf("select * from Posts where  FavoriteCount >= 25")
sqldf("select * from Posts where  ViewCount >= 1000")
sqldf("select Title, Score, ViewCount, FavoriteCount from Posts ")

library(sqldf)
df1 <- as.data.frame(df1)
sqldf("select * from Posts ")
pomocnicza <- (sqldf("select * from Posts where  PostTypeId = 1 and FavoriteCount >= 25 and ViewCount >= 1000"))
ostateczna <- na.omit(sqldf("select Title, Score, ViewCount, FavoriteCount from pomocnicza "))






df_sqldf <-function(df1, df2, df3,...){
  library(sqldf)
  df1 <- as.data.frame(df1)
  sqldf("select * from df1 ")
  pomocnicza <- (sqldf("select * from Posts where  PostTypeId = 1 and FavoriteCount >= 25 and ViewCount >= 1000"))
  na.omit(sqldf("select Title, Score, ViewCount, FavoriteCount from pomocnicza "))
  
}
df_sqldf(Posts)
