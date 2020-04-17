
df_base_2 <- function(){
  options(stringsAsFactors=FALSE) 
  Tags <- read.csv("~/R/travel_stackexchange_com/Tags.csv") 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")
  
  join_1 <- merge(Tags, Posts, all.x = FALSE, all.y = FALSE, by.y="Id", by.x = "WikiPostId")
  join_2 <- merge(join_1, Users, all.x = FALSE, all.y = FALSE, by.x ="OwnerUserId", by.y="AccountId")
  bez_pewnych_danych <- join_2[join_2$OwnerUserId != -1, ,drop=FALSE]
  posortowana <- bez_pewnych_danych[with(bez_pewnych_danych, order(-Count)), ]
  #minus robi DESC
  wybrane_kolumny <- c("TagName", "Count", "OwnerUserId", "Age", "Location", "DisplayName")
  final2 <- posortowana[ , wybrane_kolumny, drop=FALSE]
}




df_base_1 <- function(df1, df2, df3,...){
  options(stringsAsFactors=FALSE) 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  wybrane_kolumny <- c("Title","Score",  "ViewCount", "FavoriteCount")
  pierwsza_czesc <- Posts[Posts$PostTypeId == 1 & Posts$FavoriteCount >= 25 & Posts$ViewCount >= 1000, ,drop = FALSE ]
  as.data.frame(pierwsza_czesc)
  ostateczna <- na.omit(pierwsza_czesc[ , wybrane_kolumny, drop = FALSE ], cols=wybrane_kolumny)
  ostateczna
}
df_base_1(Posts)




