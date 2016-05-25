#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
      
      # Application title
      titlePanel("AIRCYL - Gráficas Calidad del Aire en Castilla y León"),
      
      # Sidebar with a slider input for the number of bins
      sidebarLayout(
            sidebarPanel(
                  selectInput("nProvincia",
                              "Selección de Provincia:",
                              c("Avila"="AVILA", "Burgos" = "BURGOS", "Leon" = "LEON", "Palencia" = "PALENCIA",
                                "Salamanca" = "SALAMANCA", "Segovia" = "SEGOVIA", "Soria" = "SORIA", 
                                "Valladolid" = "VALLADOLID", "Zamora" = "ZAMORA"))
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
                  plotOutput("distPlotGenerico"),
                  plotOutput("distPlotProvincia")
            )
      )
))
