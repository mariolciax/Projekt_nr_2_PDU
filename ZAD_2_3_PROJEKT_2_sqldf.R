options(stringsAsFactors=FALSE) 
PostLinks <- read.csv("~/R/travel_stackexchange_com/PostLinks.csv")
Posts <- read.csv("~/R/travel_stackexchange_com/Posts.csv")
head(Posts)
df_sql_3 <- function(df1=PostLinks, df2= Posts){

  library(sqldf)
  RelatedTab1 <- sqldf("SELECT COUNT (*) AS NumLinks, RelatedPostId
        FROM PostLinks
        GROUP BY RelatedPostId")
  
  RelatedTab <- sqldf("select 'RelatedPostId' as PostId, NumLinks from RelatedTab1")
  laczona <- sqldf("select * from RelatedTab 
                  inner join Posts on RelatedTab.PostId ==Posts.Id ")
  
  bez_danych <- sqldf("select * from laczona where PostTypeId = 1")
  
  wybor_kol_ <- sqldf("select Title, NumLinks from bez_danych")
  koncowa1 <- sqldf("SELECT * FROM wybor_kol_ ORDER BY NumLinks DESC")
  koncowa1
  
}




library(sqldf)
sqldf("select * from data
       left join (select ID, count(ID) as count from data group by ID)
       using (ID)")
head(PostLinks)


#wybor <- sqldf(‘select count(*) total from PostLinks where Num group by survived’)

#colnames(PostLinks)[which(names(PostLinks) == "RelatedPostId")] <- "PostId"
