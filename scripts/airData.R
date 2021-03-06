# carga de librerias
if (!require("RSQLite")) install.packages("RSQLite")
library(RSQLite)

# connect to the sqlite file
sqlite <- dbDriver("SQLite")
con <- dbConnect(sqlite,"airqualityCyL.db")
alltables <- dbListTables(con)

# creacion de data frames
dfHistoricos <- dbGetQuery(con,'select * from historico')
dfEstaciones <- dbGetQuery(con,'select * from estacion')

# cierre de bbdd
dbDisconnect(con)

# cambio tipos de datos en dfHistoricos
dfHistoricos$date <- as.Date(dfHistoricos$date)
dfHistoricos$province <- as.factor(dfHistoricos$province)
dfHistoricos[,2] <- as.numeric(dfHistoricos[,2])
dfHistoricos[,3:10] <- sapply(dfHistoricos[,3:10], as.integer)
dfHistoricos$province <- NULL
dfHistoricos$station <- as.factor(dfHistoricos$station)

# cambio tipos de datos en dfEstaciones

dfEstaciones$operative <- as.factor(dfEstaciones$operative)
dfEstaciones$province <- as.factor(dfEstaciones$province)
dfEstaciones$height <- as.integer(dfEstaciones$height)

#enriquecemos el dataframe con datos de las estaciones

mydata <- merge(dfHistoricos,dfEstaciones,by="station")
mydata$date <- paste(mydata$date, ' ', "00:00:00")
mydata$date <- format(as.Date(mydata$date), '%d/%m/%Y %H:%M:%S')
mydata$ws <- as.integer(0)
mydata$wd <- as.integer(0)
mydata <- mydata[,c(2,18:19,3:11,1,12:15,17)]
mydata$site <- paste(mydata$station, ' - ', mydata$province)
mydata <- mydata[with(mydata, order(site, date)), ]

# Debe cambiarse al subirse al servidor!!!!
write.csv(mydata, file = "AirCyL/mydata.csv", row.names = FALSE)

# Eliminacion de datos auxiliares
rm(dfEstaciones, dfHistoricos, alltables, con, sqlite, mydata)
detach("package:RSQLite", unload=TRUE)
