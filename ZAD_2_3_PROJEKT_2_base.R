
options(stringsAsFactors=FALSE) 
PostLinks <- read.csv("~/R/travel_stackexchange_com/PostLinks.csv")
Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
colnames(PostLinks)[which(names(PostLinks) == "PostId")] <- "RelatedPostId"
colnames(PostLinks)[4] <- "RelatedPostId"
head(PostLinks)
PostLinks$Count <- with(PostLinks, ave(seq_along(RelatedPostId),RelatedPostId, FUN=length))
#zmiana PostLinks
head(PostLinks)
colnames(PostLinks)[which(names(PostLinks) == "Count")] <- "NumLinks"
posort <- PostLinks[with(PostLinks, order(-RelatedPostId)), ]
wybrane_kolumny <- c("T", "Count", "OwnerUserId", "Age", "Location", "DisplayName")
final2 <- posortowana[ , wybrane_kolumny, drop=FALSE]