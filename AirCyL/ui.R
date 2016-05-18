#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(navbarPage("AIRCyL",
                   tabPanel("Resumen"),
                   tabPanel("Calendario"),
                   tabPanel("Evolución"),
                   tabPanel("Tendencia"),
                   tabPanel("Variación"),
                   tabPanel("Scatter"),
                   tabPanel("Relación"),
                   tabPanel("Niveles Tendencia")
))
