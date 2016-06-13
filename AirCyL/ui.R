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
                  menuItem("Theil-Sen", tabName = "theil-sen", icon = icon("signal")),
                  menuItem("Pollution Maps", tabName = "pollutantmaps", icon = icon("map"))
            )
      )
      
      body <- dashboardBody(
            tabItems(
                  tabItem(tabName = "summaryplot",
                          h2("Valores generales de calidad del aire en Castilla y León"), 
                          h3("Datos agregados para todas las estaciones."),
                          p("Muestra la distribución de datos para todos los contaminantes en el tiempo. 
                            Color amarillo corresponde a NA's, es decir no existe medida. Muestra valores medios.
                            Utilizado para detección de tendencias."),
                          p("Límites legales para NO y NO2: 40 microgramos/m3. y del O3 es de 120 microgramos/m3."),
                          fluidRow(
                                box(width=12, title = "Datos genericos", status = "primary", 
                                    solidHeader = TRUE, collapsible = TRUE, plotOutput("distPlotGenerico"))
                          ),
                          fluidRow(
                                box(width=6, selectInput("nProvincia","Selección de Provincia:", lProvincia))
                          ),
                          h2("Valores de los Contaminantes principales por Provincia."), 
                          h3("Datos agregados para todas las estaciones."),                          
                          p("Muestra la distribución de datos para todos los contaminantes en el tiempo. 
                            Color amarillo corresponde a NA's, es decir no existe medida. Muestra valores medios.
                            Utilizado para detección de tendencias."),
                          p("Límites legales para NO y NO2: 40 microgramos/m3. y del O3 es de 120 microgramos/m3."),
                          fluidRow(
                                box(width=12, title = "Datos por Provincia Seleccionada", 
                                    status = "primary", plotOutput("distPlotProvincia"))
                          )
                  ),
                  
                  tabItem(tabName = "calendarplot",
                          h2("Comportamiento de cada Contaminante por día y por Provincia"),
                          p("Datos de Contaminante calendarizado. Se muestran los valores mediante escala de color."),
                          fluidRow(
                              box(width=4, selectInput("n2Provincia","Provincia:", lProvincia)),
                              box(width=4, selectInput("n2Anio","Año:", lAnio)),
                              box(width=4, selectInput("n2Pollutant","Contaminante:",lPollutant))
                              ),
                          
                          fluidRow(
                              box(width=12, title = "Calendario por Contaminante Provincia y Año", 
                                  status = "primary", plotOutput("distPlotCalendar"))
                              )
                  ),
                  
                  tabItem(tabName = "timeplot",
                          h2("Comportamiento de cada Contaminante a lo largo del tiempo"),
                          p("Muestra los contaminantes principales a lo largo de una serie de tiempo agregado por estación."),
                          p("Límites legales para NO y NO2: 40 microgramos/m3. y del O3 es de 120 microgramos/m3."),
                          fluidRow(
                              box(width=4, selectInput("n3Provincia","Provincia:",lProvincia)),
                              box(width=4, selectInput("n3Anio","Año:",lAnio))
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Comportamiento en el tiempo", 
                                    status = "primary", plotOutput("distTimePlot"))
                          )
                  ),
                  
                  tabItem(tabName = "smoothtrend",
                          h2("Tendencia de cada Contaminante por día del año"),
                          p("El gráfico muestra y calcula tendencias suaves en las concentraciones medias mensuales de contaminantes. 
                            Se crea gráfico de las concentraciones mensuales y ajusta una línea con los intervalos de confianza del 95% del ajuste."),
                          
                          fluidRow(
                                box(width=4, selectInput("n4Provincia","Provincia:",lProvincia)),
                                box(width=4, selectInput("n4Pollutant","Contaminante:",lPollutant))
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Tendencia de cada Contaminante por día del año", 
                                    status = "primary", plotOutput("distSmoothTrend"))
                          )
                  ),
                  
                  tabItem(tabName = "timevariation",
                          h2("Variación de cada Contaminante en el tiempo"),
                          p("Distribución de los contaminantes por horas del día y meses del año. Detección de mayor y menor distribución."),
                          fluidRow(
                                box(width=4, selectInput("n5Provincia","Provincia:",lProvincia))
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Variación de cada Contaminante en el tiempo", 
                                    status = "primary", plotOutput("distTimeVariation"))
                          )
                  ),
                  
                  tabItem(tabName = "scatterplot",
                          h2("Comportamiento de cada Contaminante"),
                          p("Muestra el gráfico de relación entre dos contaminantes con posibilidad de seleccionar año y provincia a estudiar.
                            Existe la posibilidad de elección de dos métodos de visualización: hexbin y density."),
                          p("Se debeb seleccionar 2 contaminantes DIFERENTES para cada eje X e Y."),
                          
                          fluidRow(
                                box(width=4, selectInput("n6Provincia","Provincia:",lProvincia)),
                                box(width=4, selectInput("n6Anio","Año:",lAnio))
                          ),
                          fluidRow(
                                box(width=4, selectInput("n6EjeX","Contaminante en eje X:",lPollutant)),
                                box(width=4, selectInput("n6EjeY","Contaminante en eje Y:",lPollutant)),
                                box(width=4, selectInput("n6Method","Metodo:",c("hexbin"="hexbin", "density"="density")))
                          ),
                          
                          fluidRow(
                                box(width=12, title = paste("Relaciones entre dos Componetes a lo largo del tiempo"), 
                                    status = "primary", plotOutput("distScatterPlot"))
                          )
                  ),
                  
                  tabItem(tabName = "linealrelation",
                          h2("Relaciones entre Contaminantes a lo largo del tiempo"),
                          p("Muestra la relación lineal entre 2 contaminantes. Se calcula mediante un modelo lineal con intervalo 
                            de confianza del 95%. Su utilización determina si hay relación consistente entre esos contaminantes.
                            Útil para obtener información sobre la fuente de emisión y cómo cambia."),
                          p("Se debeb seleccionar 2 contaminantes DIFERENTES para cada eje X e Y."),
                          
                          fluidRow(
                                box(width=4, selectInput("n7Provincia","Provincia:",lProvincia)),
                                box(width=4, selectInput("n7EjeX","Contaminante en eje X:",lPollutant)),
                                box(width=4, selectInput("n7EjeY","Contaminante en eje Y:",lPollutant))
                               
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Relaciones entre dos Contaminantes a lo largo del tiempo", 
                                    status = "primary", plotOutput("distLinealRelationSum"))
                          )
                  ),
                  
                  tabItem(tabName = "trendlevel",
                          h2("Tendencia a lo largo del tiempo del O3 respecto al NOx y NO2"),
                          p("Muestra cómo el Ozono (O3) varía de acuerdo al intervalo de otras dos variables: 
                            Eje X: NOx, Eje Y: NO2. El estadístico usado es la MEDIA."),                       
                          fluidRow(
                                box(width=4, selectInput("n8Provincia","Provincia:",lProvincia))
                                
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Tendencia a lo largo del tiempo del O3 respecto al NOx y NO2", 
                                    status = "primary", plotOutput("distTrendLevel"))
                          )
                  ),
                  tabItem(tabName = "theil-sen",
                          h2("Tendencias de Contaminantes a lo largo del tiempo"),
                          p("Gráfico que muestra las tendencias en las concentraciones de contaminantes a lo largo del tiempo.
                             Junto a cada estimación aparece la estimación de la tendencia de la forma:
                            p <0,001 = * * *, p <0,01 ** = p <0,05 = * y p <0,1 = +."),
                          
                          fluidRow(
                                box(width=4, selectInput("n10Provincia","Provincia:",lProvincia)),
                                box(width=4, selectInput("n10Pollutant","Contaminante:",lPollutant))
                                
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Tendencias de Contaminantes a lo largo del tiempo", 
                                    status = "primary", plotOutput("distTheilSen"))
                          )
                  ),
                  tabItem(tabName = "mapssituation",
                          h2("Situación geográfica de las estaciones de medición"),
                          p("Situación actual de cada estación por provincia. Posibilidad de filtro por estaciones activas o no."),
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
                          h2("Cantidad de Contaminante por provincia"),
                          
                          fluidRow(
                                box(width=4, selectInput("n11Pollutant","Contaminante:",lPollutant))
                          ),
                          
                          fluidRow(
                                box(width=12, title = "Medición de Anual de Contaminante por Provincia", collapsible = TRUE,
                                    status = "primary", plotOutput("distPlotAnnual"))
                          ),
                          fluidRow(
                                box(width=12, title = "Media de Contaminante por Provincia y Estación del Año", collapsible = TRUE,
                                    status = "primary", plotOutput("distPlotMeans"))
                          ),
                          fluidRow(
                                box(width=12, title = "Máxima de Contaminante por Provincia y Estación del Año", collapsible = TRUE,
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