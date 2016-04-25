# configuación de directorio de trabajo
setwd("~/Documents/Repos/Proyecto_Master")

# carga de librerias
library(RSQLite)

# connect to the sqlite file
sqlite <- dbDriver("SQLite")
con <- dbConnect(sqlite,"airqualityCyl.db")
alltables <- dbListTables(con)

# creacion de data frames
dfHistoricos <- dbGetQuery(con,'select * from historico')
dfEstaciones <- dbGetQuery(con,'select * from estacion')

# cierre de bbdd
dbDisconnect(con)

# cambio tipos de datos en dfHistoricos
dfHistoricos$Dia <- as.Date(dfHistoricos$Dia)
dfHistoricos$Provincia <- as.factor(dfHistoricos$Provincia)
dfHistoricos[,2] <- as.numeric(dfHistoricos[,2])
dfHistoricos[,3:10] <- sapply(dfHistoricos[,3:10], as.integer)
str(dfHistoricos)

# cambio tipos de datos en dfEstaciones

dfEstaciones$Operativa <- as.factor(dfEstaciones$Operativa)
dfEstaciones$Provincia <- as.factor(dfEstaciones$Provincia)
dfEstaciones$Altura <- as.integer(dfEstaciones$Altura)

str(dfEstaciones)