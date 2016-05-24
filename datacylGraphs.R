if (!require("openair")) install.packages("openair", dependencies = TRUE)
library(openair)

#enriquecemos el dataframe con datos de las estaciones
mydata <- merge(dfHistoricos,dfEstaciones,by="estacion")

mydata$date <- paste(mydata$date, ' ', "00:00:00")
mydata$date <- format(as.Date(mydata$date), '%d/%m/%Y %H:%M:%S')
mydata$ws <- as.integer(0)
mydata$wd <- as.integer(0)
mydata <- mydata[,c(2,18:19,3:11,1,12,13)]
mydata$site <- paste(mydata$estacion, ' - ', mydata$provincia)
mydata <- mydata[with(mydata, order(site, date)), ]

# Empezamos ploteando los principales componentes de estudio y con los que vamos a jugar...

# summaryPlot. Ok mirar a ver si se puede seleccionar site o mejor provincia.
summaryPlot(mydata = mydata[,c(1,4:8,12,16)], clip = TRUE)
# seleccionando provincia...
summaryPlot(mydata = subset(mydata, provincia == "VALLADOLID")[,c(1,5,6,7)], clip = TRUE)

# calendarPlot también OK Seleccionar año, pollutant y si se puede, site o mejor provincia.
calendarPlot(mydata, pollutant = "o3", year=2003)

# timePlot. Seleccionar mes, año y si se puede site o mejor provincia.
timePlot(selectByDate(mydata, year = 2004, month = 03),
         pollutant = c("co", "nox", "no2", "o3", "pm10", "so2"), type = 'site')

# SmoothTrend OK. seleccionar pollutant. Y provincia
smoothTrend(mydata, pollutant = "o3", ylab = "concentration (ppb)",
            main = "monthly mean o3")
# timeVariation OK. Seleccionar Provincia y en vez de por horas, como sale abajo.
timeVariation(mydata, pollutant = c("nox", "co", "no2", "o3"), normalise = TRUE)

# scatterPlot. controlar eje x e y, año y provincia.
scatterPlot(mydata, x = "nox", y = "no2", method = "hexbin", col= "jet")
scatterPlot(selectByDate(mydata, year = 2003), x = "nox", y = "no2",
            method = "density", col = "jet")
# otro ejemplo por estacion de año. 
scatterPlot(mydata, x = "nox", y = "no2", z = "o3", type = c("season", "weekend"),
            limits = c(0, 30))
# selección de año, mes, provincia y ejes x,y,z.
scatterPlot(selectByDate(mydata, year=2003, month = 8), x = "date", y = "so2", z = "no")

# linearRelation se puede seleccionar x,y y provincia.
linearRelation(mydata, x = "nox", y = "so2")
linearRelation(mydata, x = "nox", y = "o3", period = "month")
linearRelation(mydata, x = "nox", y = "o3", period = "year")

# Mirar trendLevel para ver si se puede sacar algo.
trendLevel(mydata, pollutant = "o3",
           border = "white", statistic = "max",
           breaks = c(0, 50, 100, 500),
           labels = c("low", "medium", "high"),
           cols = c("forestgreen", "yellow", "red"))

# Si hay tiempo se puede trabajar los mapas para que saquen algo más que la posición. Pero solo si hay tiempo...