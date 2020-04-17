
df_table_1 <- function(){
  library("data.table")
  options(stringsAsFactors=FALSE) 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  as.data.table(Posts)
  ans <- Posts[Posts$PostTypeId == 1 & Posts$FavoriteCount >= 25 & Posts$ViewCount >= 1000,]
  ostateczna4 <- na.omit(ans[, c("Title", "Score", "ViewCount", "FavoriteCount")])

}