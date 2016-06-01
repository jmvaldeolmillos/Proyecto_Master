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
dfHistoricos$province <- as.factor(dfHistoricos$province)
dfHistoricos[,2] <- as.numeric(dfHistoricos[,2])
dfHistoricos[,3:10] <- sapply(dfHistoricos[,3:10], as.integer)
dfHistoricos$province <- NULL
dfHistoricos$station <- as.factor(dfHistoricos$station)

# cambio tipos de datos en dfEstaciones

dfEstaciones$operative <- as.factor(dfEstaciones$operative)
dfEstaciones$province <- as.factor(dfEstaciones$province)
dfEstaciones$hight <- as.integer(dfEstaciones$hight)

#enriquecemos el dataframe con datos de las estaciones

mydata <- merge(dfHistoricos,dfEstaciones,by="station")
mydata$date <- paste(mydata$date, ' ', "00:00:00")
mydata$date <- format(as.Date(mydata$date), '%d/%m/%Y %H:%M:%S')
mydata$ws <- as.integer(0)
mydata$wd <- as.integer(0)
mydata <- mydata[,c(2,18:19,3:11,1,12:15,17)]
mydata$site <- paste(mydata$station, ' - ', mydata$province)
mydata <- mydata[with(mydata, order(site, date)), ]

# Generamos las variables para app

lPollutant <- c("CO"="co", "NO" = "nox", "NO2" = "no2", "O3" = "o3", "SO2" = "so2", "PM10" = "pm10", "PM25" = "pm25")
lAnio <- sort((unique(substr(mydata$date, 7,10))))
lProvincia <- c("Todas" = "TODAS","Avila" = "AVILA", "Burgos" = "BURGOS", "Leon" = "LEON", "Palencia" = "PALENCIA", "Salamanca" = "SALAMANCA",
                "Segovia" = "SEGOVIA", "Soria" = "SORIA", "Valladolid" = "VALLADOLID", "Zamora" = "ZAMORA")
lSite <- unique(mydata$site)
lMonth <- sort((unique(substr(mydata$date, 4,5))))
rm(dfEstaciones, dfHistoricos, alltables, con, sqlite)

# Preparamos la parte de gráficos

if (!require("plyr")) install.packages("plyr")
library(plyr)
if (!require("lubridate")) install.packages("lubridate")
library(lubridate)

o3Measurements <- mydata[,c(1,7,13,17,16)]
o3Measurements$date <- gsub("/", "-", o3Measurements$date)
o3Measurements$date <- dmy_hms(o3Measurements$date)
o3Measurements <- cutData(o3Measurements, type = "season")
annual <- ddply(o3Measurements, .(station), numcolwise(mean), na.rm = TRUE)
means <- ddply(o3Measurements, .(station, season), numcolwise(mean), na.rm = TRUE)
peaks <- ddply(o3Measurements, .(station, season), numcolwise(max), na.rm = TRUE)