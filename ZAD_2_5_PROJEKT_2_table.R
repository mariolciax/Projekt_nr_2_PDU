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

status[N == NA, N := 0]
DT[V2 < 4, V2 := 0L]
DT