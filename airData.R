# configuación de directorio de trabajo
workingDirectory <- setwd("~/Documents/Repos/Proyecto_Master")

# carga de librerias
if (!require("RSQLite")) install.packages("RSQLite")
library(RSQLite)

# connect to the sqlite file
sqlite <- dbDriver("SQLite")
con <- dbConnect(sqlite,paste0(workingDirectory,"/airqualityCyL.db"))
alltables <- dbListTables(con)

# creacion de data frames
dfHistoricos <- dbGetQuery(con,'select * from historico')
dfEstaciones <- dbGetQuery(con,'select * from estacion')

# cierre de bbdd
dbDisconnect(con)

# cambio tipos de datos en dfHistoricos
dfHistoricos$date <- as.Date(dfHistoricos$date)
dfHistoricos$provincia <- as.factor(dfHistoricos$provincia)
dfHistoricos[,2] <- as.numeric(dfHistoricos[,2])
dfHistoricos[,3:10] <- sapply(dfHistoricos[,3:10], as.integer)
dfHistoricos$provincia <- NULL
dfHistoricos$estacion <- as.factor(dfHistoricos$estacion)

# cambio tipos de datos en dfEstaciones

dfEstaciones$operativa <- as.factor(dfEstaciones$operativa)
dfEstaciones$provincia <- as.factor(dfEstaciones$provincia)
dfEstaciones$altura <- as.integer(dfEstaciones$altura)