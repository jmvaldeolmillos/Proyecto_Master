# configuación de directorio de trabajo
workingDirectory <- setwd("~/Documents/Repos/Proyecto_Master")

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

# cambio tipos de datos en dfEstaciones

dfEstaciones$Operativa <- as.factor(dfEstaciones$Operativa)
dfEstaciones$Provincia <- as.factor(dfEstaciones$Provincia)
dfEstaciones$Altura <- as.integer(dfEstaciones$Altura)

# preparamos el mapa de estaciones. Pediente para Shiny el filtro de actividad (si o no)
library(ggmap)
map <- get_map(location = 'Valladolid', scale=1, zoom = 7, source="google", maptype = "terrain")
mapPoints <- ggmap(map) + geom_point(aes(x = Longitud, y = Latitud), data = dfEstaciones, color="blue", size=2, alpha = .5)
mapPoints
