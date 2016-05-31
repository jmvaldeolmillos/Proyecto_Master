# configuación de directorio de trabajo
workingDirectory <- setwd("~/Documents/Repos/Proyecto_Master")

# carga de librerias
if (!require("RSQLite")) install.packages("RSQLite")
library(RSQLite)
if (!require("stringi")) install.packages("stringi", dependencies = TRUE)

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

#enriquecemos el dataframe con datos de las estaciones

mydata <- merge(dfHistoricos,dfEstaciones,by="estacion")
mydata$date <- paste(mydata$date, ' ', "00:00:00")
mydata$date <- format(as.Date(mydata$date), '%d/%m/%Y %H:%M:%S')
mydata$ws <- as.integer(0)
mydata$wd <- as.integer(0)
mydata <- mydata[,c(2,18:19,3:11,1,12,13)]
mydata$site <- paste(mydata$estacion, ' - ', mydata$provincia)
mydata <- mydata[with(mydata, order(site, date)), ]

# Generamos las variables para app

lPollutant <- c("CO"="co", "NO" = "nox", "NO2" = "no2", "O3" = "o3", "SO2" = "so2", "PM10" = "pm10", "PM25" = "pm25")
lAnio <- sort((unique(substr(mydata$date, 7,10))))
lProvincia <- c("Avila" = "AVILA", "Burgos" = "BURGOS", "Leon" = "LEON", "Palencia" = "PALENCIA", "Salamanca" = "SALAMANCA",
                "Segovia" = "SEGOVIA", "Soria" = "SORIA", "Valladolid" = "VALLADOLID", "Zamora" = "ZAMORA", "Todas" = "TODAS")
lSite <- unique(mydata$site)
lMonth <- sort((unique(substr(mydata$date, 4,5))))
rm(dfEstaciones, dfHistoricos, alltables, con, sqlite)
