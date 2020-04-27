df_dplyr_4 <- function(df1=Badges, df2=Users, ...){
  options(stringsAsFactors=FALSE) 
  Badges <- read.csv("~/R/travel_stackexchange_com/Badges.csv")
  Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")
  library(dplyr)
  bez_wyjatku <- Badges %>%
    filter( Class == 1)
  pogrupowana<- bez_wyjatku %>%
        group_by(Name)%>%
        tally()
  bez_pewnych_danych <- pogrupowana %>%
        filter( n >= 2 ) %>%
        filter (n <= 10) %>%
        select(Name)
  poloczona <- filter(Badges, Name %in% bez_pewnych_danych$Name)
  
  ValuableBadges <- poloczona %>%
                  filter(Class == 1)
  inner_1 <- inner_join(Users, ValuableBadges, by = c("Id"= "UserId")) 
  finishh<- inner_1 %>%
            select(Id, DisplayName, Reputation, Age, Location)
  finish3 <- distinct(finishh)
  
}
df_dplyr_4()
