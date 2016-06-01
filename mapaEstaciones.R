# preparamos el mapa de estaciones. Pediente para Shiny el filtro de actividad (si o no)

if (!require("ggmap")) install.packages("ggmap")
library(ggmap)
map <- get_map(location = 'Valladolid', scale=1, zoom = 7, source="google", maptype = "terrain")
mapPoints <- ggmap(map) + geom_point(aes(x = longitude, y = latitude), data = mydata, color="blue", size=2, alpha = .5)
mapPoints

# datos para mapas de google maps

library(plyr)
library(lubridate)
o3Measurements <- mydata[,c(1,7,13,17,16)]
o3Measurements$date <- gsub("/", "-", o3Measurements$date)
o3Measurements$date <- dmy_hms(o3Measurements$date)
o3Measurements <- cutData(o3Measurements, type = "season")

annual <- ddply(o3Measurements, .(station), numcolwise(mean), na.rm = TRUE)
means <- ddply(o3Measurements, .(station, season), numcolwise(mean), na.rm = TRUE)
peaks <- ddply(o3Measurements, .(station, season), numcolwise(max), na.rm = TRUE)

GoogleMapsPlot(annual, lat="latitude", long = "longitude", pollutant = "o3", maptype= "roadmap", col = "jet")

GoogleMapsPlot(means, lat="latitude", long = "longitude", pollutant = "o3", type= "season", maptype= "roadmap", col = "jet")

GoogleMapsPlot(peaks, lat="latitude", long = "longitude", pollutant = "o3", type= "season", maptype= "roadmap", col = "jet")
