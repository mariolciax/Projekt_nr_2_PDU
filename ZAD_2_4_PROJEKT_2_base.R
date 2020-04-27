options(stringsAsFactors=FALSE) 
Badges <- read.csv("~/R/travel_stackexchange_com/Badges.csv")
Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")
wybor_klasy <- Badges[Badges$Class == 1, ,drop=FALSE]
pogrupowana <- aggregate(x = wybor_klasy$Name, by = wybor_klasy["Name"], FUN=length)
bezpewnychdanych <- pogrupowana[pogrupowana$x >= 2 & pogrupowana$x <= 10, ,drop=FALSE]
samo_Name <- bezpewnychdanych[ , "Name", drop=FALSE]
#pierwsza <- samo_Name[[1]]
#nowa_podramka <- Badges[Badges$Name == pierwsza[1]|Badges$Name == pierwsza[2] 
              #  |Badges$Name == pierwsza[3]|Badges$Name == pierwsza[4], , drop=FALSE]
nowa_podramka <- Badges[Badges$Name %in% samo_Name$Name,]
ValuableBadges <- (nowa_podramka[nowa_podramka$Class == 1, ,drop=FALSE])
ValuableBadges <- ValuableBadges[,c("Name", "UserId")]
join <- merge( Users, ValuableBadges, all.x = FALSE, all.y = FALSE, by.x="Id", by.y = "UserId")
wyb_kol <- c("Id", "DisplayName", "Reputation", "Age", "Location")
finish2<- unique( join[ , wyb_kol ] )



----------------------------------
  
  
  

options(stringsAsFactors=FALSE) 
Badges <- read.csv("~/R/travel_stackexchange_com/Badges.csv")
Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")


wybor_klasy <- Badges[Badges$Class == 1, ,drop=FALSE]

wybor_klasy$Count <- with(wybor_klasy, ave(seq_along(Name), Name, FUN=length))








##kol <- c("Name", "UserId", "Class")
###df1 <- Badges[,kol, drop=FALSE]
ValuableBadges <- merge(samoName, Badges)
##wybor_klasy <- na.omit(Badges[Badges$Class == 1, ,drop=FALSE])
#wybor_klasy$Count <- with(wybor_klasy, ave(seq_along(Name), Name, FUN=length))