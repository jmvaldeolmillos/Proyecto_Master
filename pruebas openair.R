dat <- read.csv("OpenAir_example_data_long.csv", header = T)

# carga la fecha como Factor, debemos pasarla a date
dat$date <- as.POSIXct(strptime(dat$date, format="%d/%m/%Y %H:%M", tz = "Etc/GMT-1"))

library(openair)

# Empezamos a trabajar los plots
polarPlot(dat, pollutant = "so2")
polarPlot(dat, pollutant = "nox")
polarPlot(dat, pollutant = "pm10")

# Mostramos el ratio entre so2 y nox
dat2 <- transform(dat, ratio= so2/nox)
polarPlot(dat2, pollutant = "ratio")

# Gráfico que muestra un resumen de los datos.
summaryPlot(dat)

# Rosa para mostrar la polucion. No se pueden usar, pues faltaría la dirección del viento.
pollutionRose(dat, pollutant = "nox")
pollutionRose(dat, pollutant = "nox", type="so2", layout = c(4,1))

polarFreq(dat)
polarFreq(dat, pollutant = "so2", type="year")
polarFreq(dat, pollutant = "nox", ws.int = 30, statistic = "weighted.mean", offset = 80, trans = F, col = "heat")

# Tanto los polares como los ROSE no se van a poder usar, pues no tenemos ni dirección ni velocidad del viento.

timePlot(selectByDate(dat, year = 2003), pollutant = c("nox", "o3"))
timePlot(selectByDate(dat, year = 2003, month = "abr"), pollutant = c("nox", "o3"))
calendarPlot(dat, pollutant = "o3", year=2003)

TheilSen(dat, pollutant = "o3", ylab = "ozone (ppb)", deseason = T)
