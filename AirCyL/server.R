#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
if (!require("openair")) install.packages("openair", dependencies = TRUE)
library(openair)
if (!require("ggmap")) install.packages("ggmap")
library(ggmap)
if (!require("plyr")) install.packages("plyr")
library(plyr)
if (!require("lubridate")) install.packages("lubridate")
library(lubridate)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
      
      # Expression that generates a histogram. The expression is
      # wrapped in a call to renderPlot to indicate that:
      #
      #  1) It is "reactive" and therefore should re-execute automatically
      #     when inputs change
      #  2) Its output type is a plot
      
      # Genéricos
      output$distPlotGenerico <- renderPlot({
            
            # draw the histogram with the specified number of bins
            summaryPlot(mydata[,c(1,4:8,12,16)], clip = TRUE)
      })
      output$distPlotProvincia <- renderPlot({
            nProvincia <- input$nProvincia
            
            # draw the Graphic
            if (input$nProvincia != "TODAS")
                  summaryPlot(subset(mydata, province == nProvincia)[,c(1,5,6,7)])
            else
                  summaryPlot(mydata[,c(1,5,6,7)])
      })
      output$distPlotCalendar <- renderPlot({
            
            nProvincia <- input$n2Provincia
            nAnio <- input$n2Anio
            nPollutant <- input$n2Pollutant
            
            #  draw the Graphic
            if (input$n2Provincia != "TODAS")
                  calendarPlot(subset(mydata, province == nProvincia), pollutant = nPollutant, year = nAnio)
            else
                  calendarPlot(mydata, pollutant = nPollutant, year = nAnio)
      })
      output$distMapsSituation <- renderPlot({
            nProvincia <- input$n9Provincia
            nActividad <- input$n9Actividad
            nZoom <- as.integer(input$n9Zoom)
            nSize <- as.integer(input$n9Size)
            nAlpha <- as.numeric(input$n9Alpha)
            
            # draw the Graphic
            if (input$n9Provincia != "TODAS")
                  if(nActividad != "Todas") {
                        map <- get_map(location = "Valladolid", scale=1, zoom = nZoom, source="google", maptype = "terrain")
                        mapPoints <- ggmap(map) + geom_point(aes(x = longitude, y = latitude), 
                                                             data = subset(mydata, province == nProvincia && operative == nActividad), color="blue", size=nSize, alpha = nAlpha)
                  }
            else {
                  map <- get_map(location = "Valladolid", scale=1, zoom = nZoom, source="google", maptype = "terrain")
                  mapPoints <- ggmap(map) + geom_point(aes(x = longitude, y = latitude), 
                                                       data = subset(mydata, province == nProvincia), color="blue", size=nSize, alpha = nAlpha)
            }
            else {
                  if(nActividad != "Todas") {
                        map <- get_map(location = "Valladolid", scale=1, zoom = nZoom, source="google", maptype = "terrain")
                        mapPoints <- ggmap(map) + geom_point(aes(x = longitude, y = latitude), 
                                                             data = subset(mydata, operative == nActividad), color="blue", size=nSize, alpha = nAlpha)
                  }
                  else {
                        map <- get_map(location = "Valladolid", scale=1, zoom = nZoom, source="google", maptype = "terrain")
                        mapPoints <- ggmap(map) + geom_point(aes(x = longitude, y = latitude), 
                                                             data = mydata, color="blue", size=nSize, alpha = nAlpha)    
                  }
            }
            mapPoints
      })
      output$distTimePlot <- renderPlot({
            nProvincia <- input$n3Provincia
            nAnio <- as.integer(input$n3Anio)
            # draw the Graphic
            if (input$n3Provincia != "TODAS")
                  timePlot(selectByDate(subset(mydata, province == nProvincia), year = nAnio),
                           pollutant = c("nox", "no2", "o3"), type = 'site')            
            else
                  timePlot(selectByDate(mydata, year = nAnio),
                           pollutant = c("nox", "no2", "o3"), type = 'site')
      })
      output$distTimeVariation <- renderPlot({
            nProvincia <- input$n5Provincia
            # draw the Graphic
            if (input$n5Provincia != "TODAS")
                  timeVariation(subset(mydata, province == nProvincia), pollutant = c("nox", "co", "no2", "o3"), normalise = TRUE)
            else
                  timeVariation(mydata, pollutant = c("nox", "co", "no2", "o3"), normalise = TRUE)
      })
      output$distScatterPlot <- renderPlot({
            nEjeX <- input$n6EjeX
            nEjeY <- input$n6EjeY
            nMethod <- input$n6Method
            nAnio <- input$n6Anio
            nProvincia <- input$n6Provincia
            # draw the Graphic
            if (input$n6EjeX != input$n6EjeY)
                  if (input$n6Provincia != "TODAS")
                        scatterPlot(selectByDate(subset(mydata, province == nProvincia), year = nAnio), x = nEjeX, y = nEjeY,
                                    method = nMethod, col = "jet")
                  else
                        scatterPlot(selectByDate(mydata, year = nAnio), x = nEjeX, y = nEjeY,
                                    method = nMethod, col = "jet")
            else
                  stop("Los valores del Eje X e Y no pueden ser iguales. Seleccionar Componentes diferentes.")
      })
      output$distLinealRelationSum <- renderPlot({
            nEjeX <- input$n7EjeX
            nEjeY <- input$n7EjeY
            nProvincia <- input$n7Provincia
            # draw the Graphic
            if (input$n7EjeX != input$n7EjeY)
                  if (input$n7Provincia != "TODAS")
                        linearRelation(subset(mydata, province == nProvincia), x = nEjeX, y = nEjeY)      
                                    
                  else
                        linearRelation(mydata, x = nEjeX, y = nEjeY)      
            
            else
                  stop("Los valores del Eje X e Y no pueden ser iguales. Seleccionar Componentes diferentes.")
      })
      
      # Predicciones sobre componentes, comportamiento y estacionalidad
      output$distTrendLevel <- renderPlot({
            nProvincia <- input$n8Provincia
            # draw the Graphic
            if (input$n8Provincia != "TODAS")
                  trendLevel(subset(mydata, province == nProvincia), x="nox", y="no2", 
                             pollutant = "o3", border="white", n.levels=10, statistic = "mean", limits = c(0,100))
            else
                  trendLevel(mydata, x="nox", y="no2", 
                             pollutant = "o3", border="white", n.levels=10, statistic = "mean", limits = c(0,100)) 
            })
      output$distSmoothTrend <- renderPlot({
            nProvincia <- input$n4Provincia
            nPollutant <- input$n4Pollutant
            # draw the Graphic
            if (input$n4Provincia != "TODAS")
                  smoothTrend(subset(mydata, province == nProvincia), pollutant = nPollutant, 
                              ylab = "concentration (ppb)",main = paste("Media mensual", nPollutant))            
            else
                  smoothTrend(mydata, pollutant = nPollutant, 
                              ylab = "concentration (ppb)",main = paste("Media mensual", nPollutant))      
      })   
      output$distTheilSend <- renderPlot({
            nProvincia <- input$n10Provincia
            nPollutant <- grep(input$n10Pollutant, colnames(mydata))
            
            Measurements <- mydata[,c(1,nPollutant,15)]
            Measurements$date <- gsub("/", "-", Measurements$date)
            Measurements$date <- dmy_hms(Measurements$date)
            Measurements <- cutData(Measurements, type = "season")
            if (input$n10Provincia != "TODAS")
                  Measurements<- subset(Measurements, province == nProvincia)  
            
            # draw the Graphic
            TheilSen(Measurements, pollutant = input$n10Pollutant, ylab = paste(input$n10Pollutant,"unidades en ppb"), deseason = TRUE)
      })
      
      # Madas y Gráficos
      output$distPlotAnnual<- renderPlot({
            GMapsMeasurements <- clean_data_vis(input$n11Pollutant)
            annual <- ddply(GMapsMeasurements, .(station), numcolwise(mean), na.rm = TRUE)
            
            # draw the Graphic
            GoogleMapsPlot(annual, lat="latitude", long = "longitude", pollutant = input$n11Pollutant, maptype= "roadmap", col = "jet")
      })
      output$distPlotMeans<- renderPlot({
            GMapsMeasurements <- clean_data_vis(input$n11Pollutant)
            means <- ddply(GMapsMeasurements, .(station, season), numcolwise(mean), na.rm = TRUE)
            
            # draw the Graphic
            GoogleMapsPlot(means, lat="latitude", long = "longitude", pollutant = input$n11Pollutant, type= "season", maptype= "roadmap", col = "jet")
      })
      output$distPlotPeaks<- renderPlot({
            GMapsMeasurements <- clean_data_vis(input$n11Pollutant)
            peaks <- ddply(GMapsMeasurements, .(station, season), numcolwise(max), na.rm = TRUE)
            
            # draw the Graphic
            GoogleMapsPlot(peaks, lat="latitude", long = "longitude", pollutant = input$n11Pollutant, type= "season", maptype= "roadmap", col = "jet")
      })
})
