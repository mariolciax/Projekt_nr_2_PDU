options(stringsAsFactors=FALSE) 
PostLinks <- read.csv("~/R/travel_stackexchange_com/PostLinks.csv")
Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")

library(dplyr)
RelatedTab <- count(PostLinks, RelatedPostId)
RelatedTab <- rename(RelatedTab, NumLinks = n)
RelatedTab %>%
  group_by(RelatedPostId)
RelatedTab <- rename(RelatedTab, PostId = RelatedPostId)

inner__1 <- inner_join(RelatedTab, Posts, by = c("PostId"= "Id")) 


bez_wyjatku <- inner__1 %>%
    filter( PostTypeId == 1)

bez_wyjatku <- arrange(bez_wyjatku, desc(NumLinks))

koncowa3 <-bez_wyjatku %>% 
  select(Title, NumLinks)

