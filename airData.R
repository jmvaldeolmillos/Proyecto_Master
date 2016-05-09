# configuación de directorio de trabajo
workingDirectory <- setwd("~/Repos/Proyecto_Master")

# carga de librerias
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
dfHistoricos$Dia <- as.Date(dfHistoricos$Dia)
dfHistoricos$Provincia <- as.factor(dfHistoricos$Provincia)
dfHistoricos[,2] <- as.numeric(dfHistoricos[,2])
dfHistoricos[,3:10] <- sapply(dfHistoricos[,3:10], as.integer)
dfHistoricos$Provincia <- NULL
dfHistoricos$Estacion <- as.factor(dfHistoricos$Estacion)

# cambio tipos de datos en dfEstaciones

dfEstaciones$Operativa <- as.factor(dfEstaciones$Operativa)
dfEstaciones$Provincia <- as.factor(dfEstaciones$Provincia)
dfEstaciones$Altura <- as.integer(dfEstaciones$Altura)

# preparamos el mapa de estaciones. Pediente para Shiny el filtro de actividad (si o no)
library(ggmap)
map <- get_map(location = 'Valladolid', scale=1, zoom = 7, source="google", maptype = "terrain")
mapPoints <- ggmap(map) + geom_point(aes(x = Longitud, y = Latitud), data = dfEstaciones, color="blue", size=2, alpha = .5)
mapPoints

# Gráfica de NO2
hist(dfHistoricos$NO2, main = "Histogram of nitrogen dioxide", xlab = "Nitrogen dioxide (ppb)")

# Gráfica de CO
hist(dfHistoricos$CO, main = "Histogram of nitrogen dioxide", xlab = "Nitrogen dioxide (ppb)")

# Gráfica de NO
hist(dfHistoricos$NO, main = "Histogram of nitrogen oxide", xlab = "Nitrogen oxide (ppb)")

# Gráfica de Ozone
hist(dfHistoricos$Ozono, main = "Histogram of Ozone", xlab = "Ozone")

# Gráfica de NO2
hist(dfHistoricos$NO2, main = "Histogram of nitrogen dioxide", xlab = "Nitrogen dioxide (ppb)")

# Gráfica de PM10
hist(dfHistoricos$PM10, main = "Histogram of PM10", xlab = "PM10")

# Gráfica de PM25
hist(dfHistoricos$PM25, main = "Histogram of PM25", xlab = "PM25")
