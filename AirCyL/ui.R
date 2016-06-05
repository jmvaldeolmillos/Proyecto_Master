#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shinydashboard)
      sidebar <- dashboardSidebar(
            sidebarMenu(
                  menuItem("Maps Situation", tabName = "mapssituation", icon = icon("map")),
                  menuItem("Summary Plot", tabName = "summaryplot", icon = icon("dashboard")),
                  menuItem("Calendar Plot", tabName = "calendarplot", icon = icon("calendar")),
                  menuItem("Time Plot", tabName = "timeplot", icon = icon("line-chart")),
                  menuItem("Time Variation", tabName = "timevariation", icon = icon("line-chart")),
                  menuItem("Scatter Plot", tabName = "scatterplot", icon = icon("signal")),
                  menuItem("Lineal Relation", tabName = "linealrelation", icon = icon("line-chart")),
                  menuItem("Trend Level", tabName = "trendlevel", icon = icon("signal")),
                  menuItem("Smooth Trend", tabName = "smoothtrend", icon = icon("area-chart")),
                  menuItem("Theil Send", tabName = "theilsend", icon = icon("signal")),
                  menuItem("Pollution Maps", tabName = "pollutantmaps", icon = icon("map"))
            )
      )
      
      body <- dashboardBody(
            tabItems(
                  tabItem(tabName = "summaryplot",
                          h2("Valores de calidad del aire generales y por provincia"),
                          
                          fluidRow(
                                box(width=12, title = "Datos genericos", status = "primary", 
                                    solidHeader = TRUE, collapsible = TRUE, plotOutput("distPlotGenerico"))
                          ),
                          fluidRow(
                                box(width=6, selectInput("nProvincia","Selección de Provincia:", lProvincia))
                          ),
                          fluidRow(
                                box(width=12, title = "Datos por Provincia Seleccionada", 
                                    status = "primary", plotOutput("distPlotProvincia"))
                          )
                  ),
                  
                  tabItem(tabName = "calendarplot",
                          h2("Comportamiento de cada Componente por día y por Provincia"),
                          
                          fluidRow(
                              box(width=4, selectInput("n2Provincia","Provincia:", lProvincia)),
                              box(width=4, selectInput("n2Anio","Año:", lAnio)),
                              box(width=4, selectInput("n2Pollutant","Componente químico:",lPollutant))
                              ),
                          
                          fluidRow(
                              box(width=12, title = "Calendario por Componente Provincia y Año", 
                                  status = "primary", plotOutput("distPlotCalendar"))
                              )
                  ),
                  
                  tabItem(tabName = "timeplot",
                          h2("Comportamiento de cada Componente a lo largo del tiempo"),
                          fluidRow(
                              box(width=4, selectInput("n3Month","Mes:", lMonth)),
                              box(width=4, selectInput("n3Anio","Año:", lAnio)),
                              box(width=4, selectInput("n3Provincia","Provincia:",lProvincia))
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Comportamiento en el tiempo", 
                                    status = "primary", plotOutput("distTimePlot"))
                          )
                  ),
                  
                  tabItem(tabName = "smoothtrend",
                          h2("Tendencia de cada Componente por día del año"),
                          fluidRow(
                                box(width=4, selectInput("n4Provincia","Provincia:",lProvincia)),
                                box(width=4, selectInput("n4Pollutant","Componente químico:",lPollutant))
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Tendencia de cada Componente por día del año", 
                                    status = "primary", plotOutput("distSmoothTrend"))
                          )
                  ),
                  
                  tabItem(tabName = "timevariation",
                          h2("Variación de cada Componente en el tiempo"),
                          fluidRow(
                                box(width=4, selectInput("n5Provincia","Provincia:",lProvincia))
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Variación de cada Componente en el tiempo", 
                                    status = "primary", plotOutput("distTimeVariation"))
                          )
                  ),
                  
                  tabItem(tabName = "scatterplot",
                          h2("Comportamiento de cada Componente"),
                          
                          fluidRow(
                                box(width=4, selectInput("n6Provincia","Provincia:",lProvincia)),
                                box(width=4, selectInput("n6Anio","Año:",lAnio))
                          ),
                          fluidRow(
                                box(width=4, selectInput("n6EjeX","Componente en eje X:",lPollutant)),
                                box(width=4, selectInput("n6EjeY","Componente en eje Y:",lPollutant)),
                                box(width=4, selectInput("n6Method","Metodo:",c("hexbin"="hexbin", "density"="density")))
                          ),
                          
                          fluidRow(
                                box(width=12, title = paste("Relaciones entre dos Componetes a lo largo del tiempo"), 
                                    status = "primary", plotOutput("distScatterPlot"))
                          )
                  ),
                  
                  tabItem(tabName = "linealrelation",
                          h2("Relaciones entre Componentes a lo largo del tiempo"),
                          
                          fluidRow(
                                box(width=4, selectInput("n7Provincia","Provincia:",lProvincia)),
                                box(width=4, selectInput("n7EjeX","Componente en eje X:",lPollutant)),
                                box(width=4, selectInput("n7EjeY","Componente en eje Y:",lPollutant))
                               
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Relaciones entre dos Componetes a lo largo del tiempo", 
                                    status = "primary", plotOutput("distLinealRelationSum"))
                          )
                  ),
                  
                  tabItem(tabName = "trendlevel",
                          h2("Niveles de tendencia a lo largo del tiempo"),
                          
                          fluidRow(
                                box(width=4, selectInput("n8Provincia","Provincia:",lProvincia))
                                
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Niveles de tendencia a lo largo del tiempo", 
                                    status = "primary", plotOutput("distTrendLevel"))
                          )
                  ),
                  tabItem(tabName = "theilsend",
                          h2("Tendencias de componentes a lo largo del tiempo"),
                          
                          fluidRow(
                                box(width=4, selectInput("n10Provincia","Provincia:",lProvincia)),
                                box(width=4, selectInput("n10Pollutant","Componente:",lPollutant))
                                
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Tendencias de componentes a lo largo del tiempo", 
                                    status = "primary", plotOutput("distTheilSend"))
                          )
                  ),
                  tabItem(tabName = "mapssituation",
                          h2("Situacion geografica de las estaciones"),
                          
                          fluidRow(
                                box(width=3, selectInput("n9Provincia","Provincia:",lProvincia)),
                                box(width=3, selectInput("n9Actividad","Con actividad:",c("Todas" = "Todas", "Si" = "Si", "No" = "No"))),
                                box(width=2, numericInput("n9Zoom","Zoom:", 6, min = 5, max = 15)),
                                box(width=2, numericInput("n9Size","Size:", 3, min = 2, max = 6)),
                                box(width=2, numericInput("n9Alpha","Alpha:", 0.5, min = 0.1, max = 0.9))
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Ubicación geográfica de las estaciones", 
                                    status = "primary", plotOutput("distMapsSituation"))
                          )
                  ),
                  tabItem(tabName = "pollutantmaps",
                          h2("Cantidad de Componente por provincia"),
                          
                          fluidRow(
                                box(width=4, selectInput("n11Pollutant","Componente químico:",lPollutant))
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Medición de Anual de Componente por Provincia", collapsible = TRUE,
                                    status = "primary", plotOutput("distPlotAnnual"))
                          ),
                          fluidRow(
                                box(width=12, title = "Media de Componente por Provincia y Estación del Año", collapsible = TRUE,
                                    status = "primary", plotOutput("distPlotMeans"))
                          ),
                          fluidRow(
                                box(width=12, title = "Máxima de Componente por Provincia y Estación del Año", collapsible = TRUE,
                                    status = "primary", plotOutput("distPlotPeaks"))
                          )
                  )
            )
      )
dashboardPage(
      dashboardHeader(title = "AIRCYL"),
      sidebar,
      body
)      