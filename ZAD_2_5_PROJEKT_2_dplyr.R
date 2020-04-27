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
#DF <- mutate(loczenie, DownVotes = base::replace(DownVotes, DownVotes = NA, 0L))
wynikowa3<- loczenie %>% 
        mutate(DownVotes = coalesce(DownVotes, 0L))
