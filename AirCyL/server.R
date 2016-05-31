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
# require("airData.R")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
      
      # Expression that generates a histogram. The expression is
      # wrapped in a call to renderPlot to indicate that:
      #
      #  1) It is "reactive" and therefore should re-execute automatically
      #     when inputs change
      #  2) Its output type is a plot
      
      output$distPlotGenerico <- renderPlot({
            
            # draw the histogram with the specified number of bins
            summaryPlot(mydata[,c(1,4:8,12,16)], clip = TRUE)
      })
      output$distPlotProvincia <- renderPlot({
            nProvincia <- input$nProvincia
            
            # draw the Graphic
            summaryPlot(subset(mydata, provincia == nProvincia)[,c(1,5,6,7)], clip = TRUE)
      })
      output$distPlotCalendar <- renderPlot({
            
            nProvincia <- input$n2Provincia
            nAnio <- input$n2Anio
            nPollutant <- input$n2Pollutant
            
            #  draw the Graphic
            if (input$n2Provincia != "TODAS")
                  calendarPlot(subset(mydata, provincia == nProvincia), pollutant = nPollutant, year = nAnio)
            else
                  calendarPlot(mydata, pollutant = nPollutant, year = nAnio)
      })
      output$distTimePlot <- renderPlot({
            nMonth <- input$n3Month
            nAnio <- input$n3Anio
            nProvincia <- input$n3Provincia
            # draw the Graphic
            if (input$n3Provincia != "TODAS")
                  timePlot(subset(mydata, provincia == nProvincia), year = nAnio, month = nMonth,
                           pollutant = c("nox", "no2", "o3", "so2"), type = 'site')            
            else
                  timePlot(mydata, year = nAnio, month = nMonth,
                           pollutant = c("nox", "no2", "o3", "so2"), type = 'site')
      })
      output$distSmoothTrend <- renderPlot({
            nProvincia <- input$n4Provincia
            nPollutant <- input$n4Pollutant
            # draw the Graphic
            if (input$n4Provincia != "TODAS")
                  smoothTrend(subset(mydata, provincia == nProvincia), pollutant = nPollutant, 
                              ylab = "concentration (ppb)",main = paste("Media mensual", nPollutant))            
            else
            smoothTrend(mydata, pollutant = nPollutant, 
                        ylab = "concentration (ppb)",main = paste("Media mensual", nPollutant))      
      })
      output$distTimeVariation <- renderPlot({
            nProvincia <- input$n5Provincia
            # draw the Graphic
            if (input$n5Provincia != "TODAS")
                  timeVariation(subset(mydata, provincia == nProvincia), pollutant = c("nox", "co", "no2", "o3"), normalise = TRUE)
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
            scatterPlot(selectByDate(subset(mydata, provincia == nProvincia), year = nAnio), x = nEjeX, y = nEjeY,
                        method = nMethod, col = "jet")
      })
      output$distLinealRelationSum <- renderPlot({
            nEjeX <- input$n7EjeX
            nEjeY <- input$n7EjeY
            nProvincia <- input$n7Provincia
            # draw the Graphic
            linearRelation(subset(mydata, provincia == nProvincia), x = nEjeX, y = nEjeY)      
      })
      output$distTrendLevel <- renderPlot({
            nProvincia <- input$n8Provincia
            nPollutant <- input$n8Pollutant
            # draw the Graphic
            trendLevel(subset(mydata, provincia == nProvincia), pollutant = nPollutant,
                       border = "white", statistic = "max",
                       breaks = c(0, 50, 100, 500),
                       labels = c("low", "medium", "high"),
                       cols = c("forestgreen", "yellow", "red"))      
            })
})
