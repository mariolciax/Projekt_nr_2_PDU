library(data.table)
options(stringsAsFactors=FALSE) 
PostLinks <- data.table(read.csv("~/R/travel_stackexchange_com/PostLinks.csv"))
#head(PostLinks)
Posts <- data.table(read.csv("~/R/travel_stackexchange_com/Posts.csv"))
#head(Posts)
library(data.table)

RelatedTab <- PostLinks[, .N, by = RelatedPostId]

setnames(RelatedTab, old = "N", new = "NumLinks")

###RelatedTab[, , by = "RelatedPostId"]

setnames(RelatedTab, old = "RelatedPostId", new = "PostId")
join__2<- RelatedTab[Posts, on = "PostId == Id", nomatch = 0]

bezwyjatku <- join__2[PostTypeId == 1 ]
wyborkolumn <- bezwyjatku[, list(Title, NumLinks)]
koncowa4 <- wyborkolumn[order(-NumLinks)]
koncowa4









RelatedTab <- aggregate(x = PostLinks$RelatedPostId, by= PostLinks["RelatedPostId"], FUN=length)
colnames(RelatedTab)[which(names(RelatedTab) == "x")] <- "NumLinks"
colnames(RelatedTab)[which(names(RelatedTab) == "RelatedPostId")] <- "PostId"

join <- merge(RelatedTab, Posts, all.x = FALSE, all.y = FALSE, by.y="Id", by.x = "PostId")

bezpewnychdanych <- join[join$PostTypeId == 1, ,drop=FALSE]
head(bezpewnychdanych)
posort <- bezpewnychdanych[with(bezpewnychdanych, order(-NumLinks)), ]
wybrane_kol <- c("Title", "NumLinks")
koncowa2 <- posort[ , wybrane_kol, drop=FALSE]
koncowa2






nowa <- setDT(PostLinks)[, Count:=.N, PostId]
nowa
