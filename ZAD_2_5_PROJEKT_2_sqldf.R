library(sqldf)
wynikowa1 <- sqldf("SELECT UpVotesTab.PostId, UpVotesTab.UpVotes, 
                  IFNULL(DownVotesTab.DownVotes, 0) 
                  AS DownVotes FROM ( SELECT PostId, COUNT(*) AS UpVotes 
                                      FROM Votes 
                                      WHERE VoteTypeId=2 GROUP BY PostId ) 
                  AS UpVotesTab 
                  LEFT JOIN ( SELECT PostId, COUNT(*) AS DownVotes 
                              FROM Votes WHERE VoteTypeId=3 GROUP BY PostId ) 
                  AS DownVotesTab ON UpVotesTab.PostId=DownVotesTab.PostId")
