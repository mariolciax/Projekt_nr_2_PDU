options(stringsAsFactors=FALSE) 
PostLinks <- read.csv("~/R/travel_stackexchange_com/PostLinks.csv")
Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")

library(dplyr)
PostLinks %>%
  group_by(PostId) %>%
  mutate(Count=n())
