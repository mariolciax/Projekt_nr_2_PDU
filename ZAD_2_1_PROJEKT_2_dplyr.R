library("dplyr")
options(stringsAsFactors=FALSE) 
Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
head(Posts)

pomocnicza3 <- filter(Posts,  PostTypeId == 1, FavoriteCount >= 25, ViewCount >= 1000)
ostateczna3 <- select(pomocnicza3, Title, Score, ViewCount, FavoriteCount)
ostateczna3 

df_dplyr_1 <- function(){
  options(stringsAsFactors=FALSE) 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  library("dplyr")
  pomocnicza3 <- filter(Posts,  PostTypeId == 1, FavoriteCount >= 25, ViewCount >= 1000)
  ostateczna3 <- select(pomocnicza3, Title, Score, ViewCount, FavoriteCount)
  ostateczna3 
}
df_dplyr_1()
