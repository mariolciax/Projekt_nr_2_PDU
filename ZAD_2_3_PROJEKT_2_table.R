options(stringsAsFactors=FALSE) 
PostLinks <- read.csv("~/R/travel_stackexchange_com/PostLinks.csv")
head(PostLinks)
Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
head(Posts)
library(data.table)

nowa <- setDT(PostLinks)[, Count:=.N, PostId]
nowa
