options(stringsAsFactors=FALSE) 
Votes <- read.csv("~/R/travel_stackexchange_com/Votes.csv")
wybrana <- Votes[Votes$VoteTypeId == 2, , drop = FALSE ]
UpVotesTab <- aggregate(x = wybrana$PostId, by = wybrana["PostId"], FUN=length)
colnames(UpVotesTab)[which(names(UpVotesTab) == "x")] <- "UpVotes"
wybrana2 <- Votes[Votes$VoteTypeId == 3, , drop = FALSE ]
DownVotesTab <- aggregate(x = wybrana2$PostId, by = wybrana2["PostId"], FUN=length)
colnames(DownVotesTab)[which(names(DownVotesTab) == "x")] <- "DownVotes"
left_join <- merge(UpVotesTab, DownVotesTab, all.x=TRUE, all.y = FALSE, by.x="PostId", by.y = "PostId")
left_join2 <- merge(DownVotesTab, UpVotesTab, all.x=TRUE, all.y = FALSE, by.x="PostId", by.y = "PostId")
left_join[is.na(left_join)] <- 0
posrednia1 <- left_join

left_join2[is.na(left_join2)] <- 0
posrednia2 <- left_join2
posrednia0 <-union(posrednia1, posrednia2)
rozwiazanie2 <- as.data.frame(posrednia0$UpVotes-posrednia0$DownVotes)
rozwiazanie2 <- cbind(posrednia0$PostId, rozwiazanie2)
colnames(rozwiazanie2)[which(names(rozwiazanie2) == "posrednia0$PostId")] <- "PostId"
colnames(rozwiazanie2)[2] <- "Votes"
rozwiazanie2
#¿eby nie ca³a tabelka by³a zamieniona NA tylko jedna kolumna
