### Praca projektowa nr 2
### Rozwiązanie zadan
### Mariola Bartosik 305952 MAT


## ------------------------ Zadanie 01 ----------------------------

## ---- sqldf ----
df_sql_1 <- function(df1 = Posts, ...){
  library("sqldf")
  options(stringsAsFactors=FALSE) 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  sqldf("SELECT Title, Score, ViewCount, FavoriteCount 
      FROM Posts 
      WHERE PostTypeId=1 AND FavoriteCount >= 25 AND ViewCount>=10000")
}

## ---- bazowy ----

df_base_1 <- function(df1 = Posts,...){
  options(stringsAsFactors=FALSE) 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  wybrane_kolumny <- c("Title","Score",  "ViewCount", "FavoriteCount")
  pierwsza_czesc <- Posts[Posts$PostTypeId == 1 & Posts$FavoriteCount >= 25 & Posts$ViewCount >= 10000, ,drop = FALSE ]
  
  ostateczna <- na.omit(pierwsza_czesc[ , wybrane_kolumny, drop = FALSE ], cols=wybrane_kolumny)
  ostateczna
}


## ---- dplyr ----
df_dplyr_1 <- function(df1 = Posts, ...){
  options(stringsAsFactors=FALSE) 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  library("dplyr")
  pomocnicza3 <- filter(Posts,  PostTypeId == 1, FavoriteCount >= 25, ViewCount >= 10000)
  ostateczna3 <- select(pomocnicza3, Title, Score, ViewCount, FavoriteCount)
  ostateczna3 
}


## ---- data.table ----

df_table_1 <- function(df1 = Posts, ...){
  library("data.table")
  options(stringsAsFactors=FALSE) 
  Posts <- data.table(read.csv("~/R/travel_stackexchange_com/Posts.csv"))
  
  pomocnicza <- Posts[PostTypeId == 1]
  pomocnicza1<- pomocnicza[FavoriteCount >= 25]
  pomocnicza2<- pomocnicza1[ViewCount >= 10000]
  
  ostateczna4 <- pomocnicza2[, list(Title, Score, ViewCount, FavoriteCount)]
  ostateczna4
  
}


## ------------------------ Zadanie 02 ----------------------------

## ---- sqldf ----
df_sql_2 <- function(df1 = Tags, df2 = Posts, df3 = Users){
  options(stringsAsFactors=FALSE) 
  Tags <- read.csv("~/R/travel_stackexchange_com/Tags.csv") 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")
  library(sqldf)
  sqldf("SELECT Tags.TagName, Tags.Count, Posts.OwnerUserId, 
    Users.Age, Users.Location, Users.DisplayName 
    FROM Tags JOIN Posts ON Posts.Id=Tags.WikiPostId 
    JOIN Users ON Users.AccountId=Posts.OwnerUserId 
    WHERE OwnerUserId != -1 ORDER BY Count DESC")
}
  
  

## ---- bazowy ----
df_base_2 <- function(df1 = Tags, df2 = Posts, df3 = Users){
    options(stringsAsFactors=FALSE) 
    Tags <- read.csv("~/R/travel_stackexchange_com/Tags.csv") 
    Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
    Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")
    
    join_1 <- merge(Tags, Posts, all.x = FALSE, all.y = FALSE, by.y="Id", by.x = "WikiPostId")
    join_2 <- merge(join_1, Users, all.x = FALSE, all.y = FALSE, by.x ="OwnerUserId", by.y="AccountId")
    bez_pewnych_danych <- join_2[join_2$OwnerUserId != -1, ,drop=FALSE]
    posortowana <- bez_pewnych_danych[with(bez_pewnych_danych, order(-Count)), ]
    wybrane_kolumny <- c("TagName", "Count", "OwnerUserId", "Age", "Location", "DisplayName")
    final2 <- (posortowana[ , wybrane_kolumny, drop=FALSE])
}
  


## ---- dplyr ----
df_dplyr_2 <- function(df1 = Tags, df2 = Posts, df3 = Users){
  options(stringsAsFactors=FALSE) 
  Tags <- read.csv("~/R/travel_stackexchange_com/Tags.csv") 
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")
  library("dplyr")
  inner <- inner_join(Tags, Posts, by = c("WikiPostId" = "Id")) 
  inner2<- inner_join(inner, Users, by = c("OwnerUserId"="AccountId"))
  wybor_kolumn <- inner2 %>% 
    select(TagName, Count, OwnerUserId, Age, Location, DisplayName)
  bez_wyjatku <- wybor_kolumn %>%
    filter( OwnerUserId != -1)
  final3 <-  arrange(bez_wyjatku, desc(Count))
  final3
}


## ---- data.table ----
df_table_2 <- function(df1 = Tags, df2 = Posts, df3 = Users){
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


## ------------------------ Zadanie 03 ----------------------------

## ---- sqldf ----
df_sql_3 <- function(df1 = PostLinks, df2 = Posts, ...){ 
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
}


## ---- bazowy ----
  df_base_3 <- function(df1 = PostLinks, df2 = Posts, ...){  
    RelatedTab <- aggregate(x = PostLinks$RelatedPostId, by = PostLinks["RelatedPostId"], FUN=length)
    colnames(RelatedTab)[which(names(RelatedTab) == "x")] <- "NumLinks"
    colnames(RelatedTab)[which(names(RelatedTab) == "RelatedPostId")] <- "PostId"
    
    join <- merge(RelatedTab, Posts, all.x = FALSE, all.y = FALSE, by.x="PostId", by.y = "Id")
    
    bezpewnychdanych <- join[join$PostTypeId == 1, ,drop=FALSE]
    head(bezpewnychdanych)
    posort <- bezpewnychdanych[with(bezpewnychdanych, order(-NumLinks)), ]
    wybrane_kol <- c("Title", "NumLinks")
    koncowa2 <- posort[ , wybrane_kol, drop=FALSE]
    koncowa2
}


## ---- dplyr ----
df_dplyr_3 <- function(df1 = PostLinks, df2 = Posts, ...){  
  options(stringsAsFactors=FALSE) 
  PostLinks <- read.csv("~/R/travel_stackexchange_com/PostLinks.csv")
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  library(dplyr)
  RelatedTab <- count(PostLinks, RelatedPostId)
  RelatedTab <- rename(RelatedTab, NumLinks = n)
  k<- RelatedTab %>%
    group_by(RelatedPostId)%>%
    tally()
  RelatedTab <- rename(RelatedTab, PostId = RelatedPostId)
  inner__1 <- inner_join(RelatedTab, Posts, by = c("PostId"= "Id")) 
  bez_wyjatku <- inner__1 %>%
    filter( PostTypeId == 1)
  bez_wyjatku <- arrange(bez_wyjatku, desc(NumLinks))
  koncowa3 <-bez_wyjatku %>% 
    select(Title, NumLinks)
}


## ---- data.table ----
df_table_3 <- function(df1 = Postlinks, df2 = Posts){
  library(data.table)
  options(stringsAsFactors=FALSE) 
  PostLinks <- data.table(read.csv("~/R/travel_stackexchange_com/PostLinks.csv"))
  Posts <- data.table(read.csv("~/R/travel_stackexchange_com/Posts.csv"))
  RelatedTab <- PostLinks[, .N, by = RelatedPostId]
  setnames(RelatedTab, old = "N", new = "NumLinks")
  setnames(RelatedTab, old = "RelatedPostId", new = "PostId")
  join__2<- RelatedTab[Posts, on = "PostId == Id", nomatch = 0]
  bezwyjatku <- join__2[PostTypeId == 1 ]
  wyborkolumn <- bezwyjatku[, list(Title, NumLinks)]
  koncowa4 <- wyborkolumn[order(-NumLinks)]
  koncowa4
  
}


## ------------------------ Zadanie 04 ----------------------------

## ---- sqldf ----
df_sql_4 <- function(df1=Badges, df2=Users, ...){
  options(stringsAsFactors=FALSE) 
  library(sqldf)
  Badges <- read.csv("~/R/travel_stackexchange_com/Badges.csv")
  Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")
  
  finish <- sqldf("SELECT DISTINCT Users.Id, Users.DisplayName, Users.Reputation, Users.Age, Users.Location 
                  FROM ( SELECT Name, UserID FROM Badges WHERE Name IN 
                  ( SELECT Name FROM Badges WHERE Class=1 
                  GROUP BY Name HAVING COUNT(*) BETWEEN 2 AND 10 ) AND Class=1 ) AS ValuableBadges 
                  JOIN Users ON ValuableBadges.UserId=Users.Id ")
  finish
}

## ---- bazowy ----
df_base_4 <- function(df1=Badges, df2=Users, ...){
  options(stringsAsFactors=FALSE) 
  Badges <- read.csv("~/R/travel_stackexchange_com/Badges.csv")
  Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")
  wybor_klasy <- Badges[Badges$Class == 1, ,drop=FALSE]
  pogrupowana <- aggregate(x = wybor_klasy$Name, by = wybor_klasy["Name"], FUN=length)
  bezpewnychdanych <- pogrupowana[pogrupowana$x >= 2 & pogrupowana$x <= 10, ,drop=FALSE]
  samo_Name <- bezpewnychdanych[ , "Name", drop=FALSE]
  nowa_podramka <- Badges[Badges$Name %in% samo_Name$Name,]
  ValuableBadges <- (nowa_podramka[nowa_podramka$Class == 1, ,drop=FALSE])
  ValuableBadges <- ValuableBadges[,c("Name", "UserId")]
  join <- merge( Users, ValuableBadges, all.x = FALSE, all.y = FALSE, by.x="Id", by.y = "UserId")
  wyb_kol <- c("Id", "DisplayName", "Reputation", "Age", "Location")
  finish2<- unique( join[ , wyb_kol ] )
}


## ---- dplyr ----
df_dplyr_4 <- function(df1=Badges, df2=Users, ...){
  options(stringsAsFactors=FALSE) 
  Badges <- read.csv("~/R/travel_stackexchange_com/Badges.csv")
  Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")
  library(dplyr)
  bez_wyjatku <- Badges %>%
    filter( Class == 1)
  pogrupowana<- bez_wyjatku %>%
    group_by(Name)%>%
    tally()
  bez_pewnych_danych <- pogrupowana %>%
    filter( n >= 2 ) %>%
    filter (n <= 10) %>%
    select(Name)
  poloczona <- filter(Badges, Name %in% bez_pewnych_danych$Name)
  
  ValuableBadges <- poloczona %>%
    filter(Class == 1)
  inner_1 <- inner_join(Users, ValuableBadges, by = c("Id"= "UserId")) 
  finishh<- inner_1 %>%
    select(Id, DisplayName, Reputation, Age, Location)
  finish3 <- distinct(finishh)
}


## ---- data.table ----
df_table_4 <- function(df1=Badges, df2=Users, ...){
  library(data.table)
  options(stringsAsFactors=FALSE) 
  Users <- data.table(read.csv("~/R/travel_stackexchange_com/Users.csv"))
  Badges <- data.table(read.csv("~/R/travel_stackexchange_com/Badges.csv"))
  
  bezwyjatku <- Badges[Class == 1 ]
  pogrupowana<- bezwyjatku[, .N, by = Name]
  wybrane <- pogrupowana[N >=2 & N<= 10 ]
  samoName <- wybrane[, list(Name)]
  poloczona <- Badges[Name %chin% samoName$Name]
  ValuableBadges <- poloczona[Class == 1]
  join_2<- Users[ValuableBadges, on = "Id == UserId", nomatch = 0]
  finish4 <- unique(join_2, by = c("Id", "DisplayName","Reputation","Age","Location"))
  finish4 <- finish4[ , list(Id, DisplayName, Reputation, Age, Location)]
}




## ------------------------ Zadanie 05 ----------------------------

## ---- sqldf ----
df_sql_5 <- function(df1 = Votes, ...){
  options(stringsAsFactors=FALSE) 
  Votes <- read.csv("~/R/travel_stackexchange_com/Votes.csv")
  library(sqldf)
  wynikowa1 <- sqldf("SELECT UpVotesTab.PostId, UpVotesTab.UpVotes, 
                  IFNULL(DownVotesTab.DownVotes, 0) 
                  AS DownVotes FROM ( SELECT PostId, COUNT(*) AS UpVotes 
                                      FROM Votes 
                                      WHERE VoteTypeId=2 GROUP BY PostId ) 
                  AS UpVotesTab 
                  LEFT JOIN ( SELECT PostId, COUNT(*) AS DownVotes 
                              FROM Votes WHERE VoteTypeId=3 GROUP BY PostId ) 
                  AS DownVotesTab ON UpVotesTab.PostId=DownVotesTab.PostId")
  
}


## ---- bazowy ----
df_base_5 <- function(df1 = Votes, ...){
    options(stringsAsFactors=FALSE) 
    Votes <- read.csv("~/R/travel_stackexchange_com/Votes.csv")
    wybrana <- Votes[Votes$VoteTypeId == 2, , drop = FALSE ]
    UpVotesTab <- aggregate(x = wybrana$PostId, by = wybrana["PostId"], FUN=length)
    colnames(UpVotesTab)[which(names(UpVotesTab) == "x")] <- "UpVotes"
    wybrana2 <- Votes[Votes$VoteTypeId == 3, , drop = FALSE ]
    DownVotesTab <- aggregate(x = wybrana2$PostId, by = wybrana2["PostId"], FUN=length)
    colnames(DownVotesTab)[which(names(DownVotesTab) == "x")] <- "DownVotes"
    left_join <- merge(UpVotesTab, DownVotesTab, all.x=TRUE, all.y = FALSE, by.x="PostId", by.y = "PostId")
    #left_join$DownVotes<- ifelse(isNull(left_join$DownVotes), 0, left_join$DownVotes)
    
    left_join[is.na(left_join)] <- 0
    wynikowa2 <- left_join
}


## ---- dplyr ----
df_dplyr_5 <- function(df1 = Votes, ...){
  options(stringsAsFactors=FALSE) 
  Votes <- read.csv("~/R/travel_stackexchange_com/Votes.csv")
  library(dplyr)
  UpVotesTab <- Votes %>%
    filter(VoteTypeId == 2) %>%
    group_by(PostId) %>%
    tally() 
  UpVotesTab <- rename(UpVotesTab, UpVotes = n)
  DownVotesTab <- Votes %>%
    filter(VoteTypeId == 3) %>%
    group_by(PostId) %>%
    tally() 
  DownVotesTab <- rename(DownVotesTab, DownVotes = n)
  loczenie <- left_join(UpVotesTab, DownVotesTab, by = c("PostId" = "PostId"))
  wynikowa3<- loczenie %>% 
    mutate(DownVotes = coalesce(DownVotes, 0L))
}


## ---- data.table ----
df_table_5 <- function(df1 = Votes, ...){
  options(stringsAsFactors=FALSE) 
  library(data.table)
  Votes <- data.table(read.csv("~/R/travel_stackexchange_com/Votes.csv"))
  bezwyjatku <- Votes[VoteTypeId == 2 ]
  UpVotesTab <- bezwyjatku[, .N, by = PostId]
  setnames(UpVotesTab, old = "N", new = "UpVotes")
  
  bezwyjatku2 <- Votes[VoteTypeId == 3 ]
  DownVotesTab <- bezwyjatku2[, .N, by = PostId]
  setnames(DownVotesTab, old = "N", new = "DownVotes")
  
  left_join <- DownVotesTab[UpVotesTab, on = "PostId == PostId"]
  wynikowa4 <- left_join[, list(PostId, UpVotes, DownVotes)]
  
  wynikowa4 <- wynikowa4[is.na(DownVotes), DownVotes := 0L]
  wynikowa4
}

## ------------------------ Zadanie 06 ----------------------------

## ---- sqldf ----
df_sql_6 <- function(df1 = Votes, ...){
  options(stringsAsFactors=FALSE) 
  Votes <- read.csv("~/R/travel_stackexchange_com/Votes.csv")
  library(sqldf)
  rozwiazanie1<- sqldf("SELECT PostId, UpVotes-DownVotes AS Votes
          FROM ( SELECT UpVotesTab.PostId, UpVotesTab.UpVotes, 
          IFNULL(DownVotesTab.DownVotes, 0) AS DownVotes 
          FROM ( SELECT PostId, COUNT(*) AS UpVotes FROM Votes WHERE VoteTypeId=2 
          GROUP BY PostId ) AS UpVotesTab
          LEFT JOIN ( SELECT PostId, COUNT(*) AS DownVotes
          FROM Votes WHERE VoteTypeId=3 GROUP BY PostId ) AS DownVotesTab 
          ON UpVotesTab.PostId=DownVotesTab.PostId
          UNION
          SELECT DownVotesTab.PostId, IFNULL(UpVotesTab.UpVotes, 0) AS UpVotes, 
          DownVotesTab.DownVotes FROM ( SELECT PostId, COUNT(*) AS DownVotes 
          FROM Votes WHERE VoteTypeId=3 GROUP BY PostId ) AS DownVotesTab 
          LEFT JOIN ( SELECT PostId, COUNT(*) AS UpVotes 
          FROM Votes WHERE VoteTypeId=2 GROUP BY PostId ) AS UpVotesTab 
          ON DownVotesTab.PostId=UpVotesTab.PostId
          )")
  
}


## ---- bazowy ----
df_base_6 <- function(df1 = Votes, ...){
  options(stringsAsFactors=FALSE) 
  Votes <- read.csv("~/R/travel_stackexchange_com/Votes.csv")
  wybrana <- Votes[Votes$VoteTypeId == 2, , drop = FALSE ]
  UpVotesTab <- aggregate(x = wybrana$PostId, by = wybrana["PostId"], FUN=length)
  colnames(UpVotesTab)[which(names(UpVotesTab) == "x")] <- "UpVotes"
  wybrana2 <- Votes[Votes$VoteTypeId == 3, , drop = FALSE ]
  DownVotesTab <- aggregate(x = wybrana2$PostId, by = wybrana2["PostId"], FUN=length)
  colnames(DownVotesTab)[which(names(DownVotesTab) == "x")] <- "DownVotes"
  left_join <- merge(UpVotesTab, DownVotesTab, all.x=TRUE, all.y = FALSE, by.x="PostId", by.y = "PostId")
  left_join2 <- merge(DownVotesTab, UpVotesTab, all.x=TRUE, all.y = FALSE, by.x="PostId", by.y = "PostId")
  left_join[is.na(left_join)] <- 0
  posrednia1 <- left_join
  left_join2[is.na(left_join2)] <- 0
  posrednia2 <- left_join2
  posrednia0 <-union(posrednia1, posrednia2)
  rozwiazanie2 <- as.data.frame(posrednia0$UpVotes-posrednia0$DownVotes)
  rozwiazanie2 <- cbind(posrednia0$PostId, rozwiazanie2)
  colnames(rozwiazanie2)[which(names(rozwiazanie2) == "posrednia0$PostId")] <- "PostId"
  colnames(rozwiazanie2)[2] <- "Votes"
  rozwiazanie2
 
}


## ---- dplyr ----
df_dplyr_6 <- function(df1 = Votes, ...){
  options(stringsAsFactors=FALSE) 
  Votes <- read.csv("~/R/travel_stackexchange_com/Votes.csv")
  library(dplyr)
  UpVotesTab <- Votes %>%
    filter(VoteTypeId == 2) %>%
    group_by(PostId) %>%
    tally() 
  UpVotesTab <- rename(UpVotesTab, UpVotes = n)
  DownVotesTab <- Votes %>%
    filter(VoteTypeId == 3) %>%
    group_by(PostId) %>%
    tally() 
  DownVotesTab <- rename(DownVotesTab, DownVotes = n)
  loczenie <- left_join(UpVotesTab, DownVotesTab, by = c("PostId" = "PostId"))
  loczenie2 <-left_join(DownVotesTab, UpVotesTab, by = c("PostId" = "PostId"))
  #DF <- mutate(loczenie, DownVotes = base::replace(DownVotes, DownVotes = NA, 0L))
  posrednia1<- loczenie %>% 
    mutate(DownVotes = coalesce(DownVotes, 0L))
  posrednia2<- loczenie2 %>%
    mutate(UpVotes = coalesce(UpVotes, 0L))
  posrednia <- dplyr::union(posrednia1, posrednia2)
  samo_PostId <- select(posrednia, PostId)
  rozwiazanie_ <- transmute(posrednia, UpVotes - DownVotes)
  rozwiazanie3 <-rename(rozwiazanie_, Votes = ("UpVotes - DownVotes") )
  rozwiazanie3 <-  bind_cols(samo_PostId, rozwiazanie3)
  rozwiazanie3
}


## ---- data.table ---- 
df_table_6 <- function(df1 = Votes, ...){
  options(stringsAsFactors=FALSE) 
  library(data.table)
  Votes <- data.table(read.csv("~/R/travel_stackexchange_com/Votes.csv"))
  bezwyjatku <- Votes[VoteTypeId == 2 ]
  UpVotesTab <- bezwyjatku[, .N, by = PostId]
  setnames(UpVotesTab, old = "N", new = "UpVotes")
  bezwyjatku2 <- Votes[VoteTypeId == 3 ]
  DownVotesTab <- bezwyjatku2[, .N, by = PostId]
  setnames(DownVotesTab, old = "N", new = "DownVotes")
  left_join1 <- DownVotesTab[UpVotesTab, on = "PostId == PostId"]
  posrednia1 <- left_join1[, list(PostId, UpVotes, DownVotes)]
  posrednia1 <- posrednia1[is.na(DownVotes), DownVotes := 0L]
  left_join2 <- UpVotesTab[DownVotesTab, on = "PostId == PostId"]
  posrednia2 <- left_join2[,list(PostId, UpVotes, DownVotes)]
  posrednia2 <- posrednia2[is.na(UpVotes), UpVotes := 0L]
  union <- funion(posrednia1, posrednia2)
  samo_PostId<- union[,1]
  rozwiazanie4 <- union[, .(UpVotes-DownVotes)]
  rozwiazanie4 <- base::cbind(samo_PostId, rozwiazanie4)
  roozwiazania4 <- setnames(rozwiazanie4, old = "V1", new = "Votes")
  roozwiazania4
}

