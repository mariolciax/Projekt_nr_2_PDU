options(stringsAsFactors=FALSE) 
Badges <- read.csv("~/R/travel_stackexchange_com/Badges.csv")
Users <- read.csv("~/R/travel_stackexchange_com/Users.csv")
kol <- c("Name", "UserId", "Class")
df1 <- Badges[,kol, drop=FALSE]
wybor_klasy <- na.omit(df1[df1$Class == 1, ,drop=FALSE])

pogrupowana <- (wybor_klasy[1], wybor_klasy["Name"], length)
pogrupowana$Count <- with(pogrupowana, ave(seq_along(Class), Class, FUN=length))
bezpewnychdanych <- pogrupowana[pogrupowana$Count >= 2 & pogrupowana$Count <= 10, ,drop=FALSE]

df1 <- wybor_class[,c("Name", "UserId")]
join <- merge(ValuableBadges, Users, all.x = FALSE, all.y = FALSE, by.x="UserId", by.y = "Id")
