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
