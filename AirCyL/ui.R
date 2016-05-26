#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shinydashboard)
library(lubridate)
library(stringi)
      sidebar <- dashboardSidebar(
            sidebarMenu(
                  menuItem("SummaryPlot", tabName = "summaryplot", icon = icon("dashboard")),
                  menuItem("CalendarPlot", tabName = "calendarplot", icon = icon("calendar")),
                  menuItem("TimePlot", tabName = "timeplot", icon = icon("line-chart")),
                  menuItem("SmoothTrend", tabName = "smoothtrend", icon = icon("area-chart")),
                  menuItem("TimeVariation", tabName = "timevariation", icon = icon("line-chart")),
                  menuItem("ScatterPlot", tabName = "scatterplot", icon = icon("signal")),
                  menuItem("LinealRelation", tabName = "linealrelation", icon = icon("line-chart")),
                  menuItem("TrendLevel", tabName = "trendlevel", icon = icon("signal"))
            )
      )
      
      body <- dashboardBody(
            tabItems(
                  tabItem(tabName = "summaryplot",
                          h2("Valores de calidad del aire generales y por provincia"),
                          
                          fluidRow(
                                box(width=12, title = "Datos genericos", plotOutput("distPlotGenerico"))
                              ),
                          fluidRow(
                                box(width=6, selectInput("nProvincia","Selección de Provincia:",
                                                      c("Avila"="AVILA", "Burgos" = "BURGOS", "Leon" = "LEON", "Palencia" = "PALENCIA",
                                                      "Salamanca" = "SALAMANCA", "Segovia" = "SEGOVIA", "Soria" = "SORIA", 
                                                      "Valladolid" = "VALLADOLID", "Zamora" = "ZAMORA")
                                ))
                          ),
                          fluidRow(
                                box(width=12, title = "Datos por Provincia", plotOutput("distPlotProvincia"))
                              )
                  ),
                  tabItem(tabName = "calendarplot",
                          h2("Comportamiento de cada agente por día del año"),
                          
                          fluidRow(
                                box(width=4, selectInput("nProvinciaC","Provincia:",
                                                         stri_trans_general(mydata$provincia, id = "Title")      
                                )),
                                box(width=4, selectInput("nAnioC","Año:",
                                                       sort((unique(substr(mydata$date, 7,10))))
                                )),
                                box(width=4, selectInput("nPollutantC","Componente químico:",
                                                        c("CO"="co", "NO" = "nox", "NO2" = "no2", "O3" = "o3",
                                                        "SO2" = "so2", "PM10" = "pm10", "PM25" = "pm25")
                                ))
                              ),
                          fluidRow(
                                box(width=12, title = "Calendario por Componente, Provincia y Año", plotOutput("distPlotCalendar"))
                          )
                  ),
                  tabItem(tabName = "timeplot",
                          h2("Comportamiento de cada agente a lo largo del tiempo")
                  ),
                  tabItem(tabName = "smoothtrend",
                          h2("Tendencia de cada agente por día del año")
                  ),
                  tabItem(tabName = "timevariation",
                          h2("Variación de cada agente en el tiempo")
                  ),
                  tabItem(tabName = "scatterplot",
                          h2("Comportamiento de cada agente")
                  ),
                  tabItem(tabName = "linealrelation",
                          h2("Relaciones entre agentes por día del año")
                  ),
                  tabItem(tabName = "trendlevel",
                          h2("Niveles de tendencia a lo largo del tiempo")
                  )
            )
      )
dashboardPage(
      dashboardHeader(title = "AIRCYL"),
      sidebar,
      body
)      