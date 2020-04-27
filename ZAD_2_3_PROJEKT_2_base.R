
  options(stringsAsFactors=FALSE) 
  PostLinks <- read.csv("~/R/travel_stackexchange_com/PostLinks.csv")
  Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
  head(Posts)
  
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
df_base_3()




#colnames(PostLinks)[which(names(PostLinks) == "PostId")] <- "RelatedPostId"

##colnames(PostLinks)[4] <- "RelatedPostId"

#PostLinks$Count <- with(PostLinks, ave(seq_along(RelatedPostId), RelatedPostId, FUN=length))
#zliczenie

#colnames(PostLinks)[which(names(PostLinks) == "Count")] <- "NumLinks"
#zmiania nazwy kolumny

#RelatedTad <- PostLinks[with(PostLinks, order(-RelatedPostId)), ]

kolumny <- c("Title", "NumLinks")
finalowa2 <- posortowana[ , kolumny, drop=FALSE]
