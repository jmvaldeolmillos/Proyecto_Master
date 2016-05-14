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

# preparamos el mapa de estaciones. Pediente para Shiny el filtro de actividad (si o no)
if (!require("ggmap")) install.packages("ggmap")
library(ggmap)
map <- get_map(location = 'Valladolid', scale=1, zoom = 7, source="google", maptype = "terrain")
mapPoints <- ggmap(map) + geom_point(aes(x = longitud, y = latitud), data = dfEstaciones, color="blue", size=2, alpha = .5)
mapPoints

# Gráfica de no2
hist(dfHistoricos$no2, main = "Histogram of nitrogen dioxide", xlab = "Nitrogen dioxide (ppb)")

# Gráfica de co
hist(dfHistoricos$co, main = "Histogram of nitrogen dioxide", xlab = "Nitrogen dioxide (ppb)")

# Gráfica de no
hist(dfHistoricos$no, main = "Histogram of nitrogen oxide", xlab = "Nitrogen oxide (ppb)")

# Gráfica de ozone
hist(dfHistoricos$ozone, main = "Histogram of Ozone", xlab = "Ozone")

# Gráfica de so2
hist(dfHistoricos$so2, main = "Histogram of nitrogen dioxide", xlab = "Nitrogen dioxide (ppb)")

# Gráfica de pm10
hist(dfHistoricos$pm10, main = "Histogram of PM10", xlab = "PM10")

# Gráfica de pm25
hist(dfHistoricos$pm25, main = "Histogram of PM25", xlab = "PM25")


## Creacion de las GRAFICAS para SHINY con openair.
# Actualmente no se poseen datos sobre velocidad y direccion del viento. Se han solicitado.

if (!require("openair")) install.packages("openair", dependencies = TRUE)
library(openair)


dat <- dfHistoricos
dat$ws <- as.integer(NA)
dat$wd <- as.integer(NA)

# Empezamos ploteando los principales componentes de estudio
polarPlot(dat, pollutant = "so2")
polarPlot(dat, pollutant = "no")
polarPlot(dat, pollutant = "no2")
summaryPlot(dat)

