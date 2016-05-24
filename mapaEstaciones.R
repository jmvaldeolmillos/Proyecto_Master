# preparamos el mapa de estaciones. Pediente para Shiny el filtro de actividad (si o no)
if (!require("ggmap")) install.packages("ggmap")
library(ggmap)
map <- get_map(location = 'Valladolid', scale=1, zoom = 7, source="google", maptype = "terrain")
mapPoints <- ggmap(map) + geom_point(aes(x = longitud, y = latitud), data = dfEstaciones, color="blue", size=2, alpha = .5)
mapPoints