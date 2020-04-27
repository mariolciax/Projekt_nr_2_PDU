options(stringsAsFactors=FALSE) 
Votes <- read.csv("~/R/travel_stackexchange_com/Votes.csv")
wybrana <- Votes[Votes$VoteTypeId == 2, , drop = FALSE ]
UpVotesTab <- aggregate(x = wybrana$PostId, by = wybrana["PostId"], FUN=length)
colnames(UpVotesTab)[which(names(UpVotesTab) == "x")] <- "UpVotes"
wybrana2 <- Votes[Votes$VoteTypeId == 3, , drop = FALSE ]
DownVotesTab <- aggregate(x = wybrana2$PostId, by = wybrana2["PostId"], FUN=length)
colnames(DownVotesTab)[which(names(DownVotesTab) == "x")] <- "DownVotes"
left_join <- merge(UpVotesTab, DownVotesTab, all.x=TRUE, all.y = FALSE, by.x="PostId", by.y = "PostId")
left_join$DownVotes<- ifelse(isNull(left_join$DownVotes), 0, left_join$DownVotes)
left_join[is.na(left_join)] <- 0
wynikowa2 <- left_join
