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
                  menuItem("SummaryPlot", tabName = "summaryplot", icon = icon("dashboard")),
                  menuItem("CalendarPlot", tabName = "calendarplot", icon = icon("calendar")),
                  menuItem("TimePlot", tabName = "timeplot", icon = icon("line-chart")),
                  menuItem("SmoothTrend", tabName = "smoothtrend", icon = icon("area-chart")),
                  menuItem("TimeVariation", tabName = "timevariation", icon = icon("line-chart")),
                  menuItem("ScatterPlot", tabName = "scatterplot", icon = icon("signal")),
                  menuItem("LinealRelation", tabName = "linealrelation", icon = icon("line-chart")),
                  menuItem("TrendLevel", tabName = "trendlevel", icon = icon("signal")),
                  menuItem("Maps Situation", tabName = "mapssituation", icon = icon("map")),
                  menuItem("Pollution Maps", tabName = "ozonemaps", icon = icon("map"))
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
                          h2("Comportamiento de cada agente por día y por Provincia"),
                          
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
                          h2("Comportamiento de cada agente a lo largo del tiempo"),
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
                          h2("Tendencia de cada agente por día del año"),
                          fluidRow(
                                box(width=4, selectInput("n4Provincia","Provincia:",lProvincia)),
                                box(width=4, selectInput("n4Pollutant","Componente químico:",lPollutant))
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Tendencia de cada agente por día del año", 
                                    status = "primary", plotOutput("distSmoothTrend"))
                          )
                  ),
                  
                  tabItem(tabName = "timevariation",
                          h2("Variación de cada agente en el tiempo"),
                          fluidRow(
                                box(width=4, selectInput("n5Provincia","Provincia:",lProvincia))
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Variación de cada agente en el tiempo", 
                                    status = "primary", plotOutput("distTimeVariation"))
                          )
                  ),
                  
                  tabItem(tabName = "scatterplot",
                          h2("Comportamiento de cada agente"),
                          
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
                          h2("Relaciones entre agentes a lo largo del tiempo"),
                          
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
                  tabItem(tabName = "ozonemaps",
                          h2("Cantidad de Ozono por provincia"),
                          
                          fluidRow(
                                box(width=12, title = "Medición Ozono Anual por Provincia", collapsible = TRUE,
                                    status = "primary", plotOutput("distPlotAnnual"))
                          ),
                          fluidRow(
                                box(width=12, title = "Media Ozono por Provincia y Estación del Año", collapsible = TRUE,
                                    status = "primary", plotOutput("distPlotMeans"))
                          ),
                          fluidRow(
                                box(width=12, title = "Máxima Ozono por Provincia y Estación del Año", collapsible = TRUE,
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