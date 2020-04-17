options(stringsAsFactors=FALSE) 
Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
head(Posts)
as.data.frame(Posts)
wybrane_kolumny <- c("Title","Score",  "ViewCount", "FavoriteCount")
pierwsza_czesc <- Posts[Posts$PostTypeId == 1 & Posts$FavoriteCount >= 25 & Posts$ViewCount >= 1000, ,drop = FALSE ]
as.data.frame(pierwsza_czesc)
pierwsza_czesc[ , c("Title","Score",  "ViewCount", "FavoriteCount"), drop = FALSE ]
as.data.frame(pierwsza_czesc)
ostateczna2 <- na.omit(pierwsza_czesc[ , wybrane_kolumny, drop = FALSE ], cols=wybrane_kolumny)
ostateczna2






df_base_1 <- function(df1, df2, df3,...){
  options(stringsAsFactors=FALSE) 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  wybrane_kolumny <- c("Title","Score",  "ViewCount", "FavoriteCount")
  pierwsza_czesc <- df1[df1$PostTypeId == 1 & df1$FavoriteCount >= 25 & df1$ViewCount >= 1000, ,drop = FALSE ]
  as.data.frame(pierwsza_czesc)
  na.omit(pierwsza_czesc[ , wybrane_kolumny, drop = FALSE ], cols=wybrane_kolumny)
  
}
df_base_1(Posts)




#subset(Posts, Posts$PostTypeId ==1 & Posts$FavoriteCount >= 25 & Posts$ViewCount >= 1000)
#Posts[Posts$ViewCount >= 1000]

