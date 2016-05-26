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

#enriquecemos el dataframe con datos de las estaciones
mydata <- merge(dfHistoricos,dfEstaciones,by="estacion")

mydata$date <- paste(mydata$date, ' ', "00:00:00")
mydata$date <- format(as.Date(mydata$date), '%d/%m/%Y %H:%M:%S')
mydata$ws <- as.integer(0)
mydata$wd <- as.integer(0)
mydata <- mydata[,c(2,18:19,3:11,1,12,13)]
mydata$site <- paste(mydata$estacion, ' - ', mydata$provincia)
mydata <- mydata[with(mydata, order(site, date)), ]


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
            summaryPlot(mydata = mydata[,c(1,4:8,12,16)], clip = TRUE)
      })
      output$distPlotProvincia <- renderPlot({
            nProvincia <- input$nProvincia
            
            # draw the histogram with the specified number of bins
            summaryPlot(mydata = subset(mydata, provincia == nProvincia)[,c(1,5,6,7)], clip = TRUE)
      })
      output$distPlotCalendar <- renderPlot({
            nProvincia <- input$nProvinciaC
            nAnio <- input$nAnioC
            nPollutant <- input$nPollutantC
            # draw the histogram with the specified number of bins
            calendarPlot(mydata = subset(mydata, provincia == nProvincia), pollutant = nPollutant, year = nAnio) })
})
