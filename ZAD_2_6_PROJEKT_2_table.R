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

