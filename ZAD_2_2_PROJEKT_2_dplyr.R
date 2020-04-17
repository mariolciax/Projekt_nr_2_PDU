df_dplyr_2 <- function(){
  options(stringsAsFactors=FALSE) 
  Tags <- read.csv("~/R/travel_stackexchange_com/Tags.csv") 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")
  library("dplyr")
  library("magrittr")
  
  inner <- inner_join(Tags, Posts, by = c("WikiPostId"= "Id")) 
  as.data.frame(inner)
  inner2<- inner_join(inner, Users, by = c("OwnerUserId"="AccountId"))
  wybor_kolumn <-inner2 %>% 
    select(TagName, Count, OwnerUserId, Age, Location, DisplayName)
  bez_wyjatku <- wybor_kolumn %>%
    filter( OwnerUserId != -1)
  final3 <- group_by(bez_wyjatku, Count)
  final3
}



select(inner2, TagName, Count, OwnerUserId, Age, Location, DispalyName)

   
   
??inner_join
?n

msleep %>% 
  group_by(order) %>%


df_dplyr_2 <- function(){
  options(stringsAsFactors=FALSE) 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  library("dplyr")
  pomocnicza3 <- filter(Posts,  PostTypeId == 1, FavoriteCount >= 25, ViewCount >= 1000)
  ostateczna3 <- select(pomocnicza3, Title, Score, ViewCount, FavoriteCount)
  ostateczna3 
}
df_dplyr_1()
