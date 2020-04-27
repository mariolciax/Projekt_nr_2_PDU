options(stringsAsFactors=FALSE) 
Votes <- read.csv("~/R/travel_stackexchange_com/Votes.csv")
library(sqldf)
rozwiazanie1<- sqldf("SELECT PostId, UpVotes-DownVotes AS Votes
          FROM ( SELECT UpVotesTab.PostId, UpVotesTab.UpVotes, 
          IFNULL(DownVotesTab.DownVotes, 0) AS DownVotes 
          FROM ( SELECT PostId, COUNT(*) AS UpVotes FROM Votes WHERE VoteTypeId=2 
          GROUP BY PostId ) AS UpVotesTab
          LEFT JOIN ( SELECT PostId, COUNT(*) AS DownVotes
          FROM Votes WHERE VoteTypeId=3 GROUP BY PostId ) AS DownVotesTab 
          ON UpVotesTab.PostId=DownVotesTab.PostId
          UNION
          SELECT DownVotesTab.PostId, IFNULL(UpVotesTab.UpVotes, 0) AS UpVotes, 
          DownVotesTab.DownVotes FROM ( SELECT PostId, COUNT(*) AS DownVotes 
          FROM Votes WHERE VoteTypeId=3 GROUP BY PostId ) AS DownVotesTab 
          LEFT JOIN ( SELECT PostId, COUNT(*) AS UpVotes 
          FROM Votes WHERE VoteTypeId=2 GROUP BY PostId ) AS UpVotesTab 
          ON DownVotesTab.PostId=UpVotesTab.PostId
          )")
                                                 