# Carga de librerias necesarias
# rm(list = ls())
if (!require("plyr")) install.packages("plyr")
library(plyr)
if (!require("lubridate")) install.packages("lubridate")
library(lubridate)
if (!require("ggmap")) install.packages("ggmap")
library(ggmap)

# Carga del fichero principal que ajusta el dataframe base
source("airData.R")

# Funcion de manipulado para generación de graficos
clean_data_vis <- function(componente) {
      nPollutant <- grep(componente, colnames(mydata))
      clean_data <- mydata[,c(1,nPollutant,13,17,16)]
      clean_data$date <- gsub("/", "-", clean_data$date)
      clean_data$date <- dmy_hms(clean_data$date)
      clean_data <- cutData(clean_data, type = "season")
      return(clean_data)
}

# Creación de listas
lPollutant <- c("CO"="co", "NO" = "nox", "NO2" = "no2", "O3" = "o3", "SO2" = "so2", "PM10" = "pm10", "PM25" = "pm25")
lAnio <- sort((unique(substr(mydata$date, 7,10))))
lProvincia <- c("Todas" = "TODAS","Avila" = "AVILA", "Burgos" = "BURGOS", "Leon" = "LEON", "Palencia" = "PALENCIA", "Salamanca" = "SALAMANCA",
                "Segovia" = "SEGOVIA", "Soria" = "SORIA", "Valladolid" = "VALLADOLID", "Zamora" = "ZAMORA")
lSite <- unique(mydata$site)
lMonth <- sort((unique(substr(mydata$date, 4,5))))