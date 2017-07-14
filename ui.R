#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

input = c("CAPA on schedule"="CS","Assignment Count"="AC")

title = "Status Report for June";

shinyUI(
    
  fluidPage(
    ## Created a header for the Application
    headerPanel(title,windowTitle = title),
    
    sidebarPanel(
      selectInput(inputId ="select",label = "Select to see visual summary",choices = input,
                  selected = "CAPA on schedule")
      
      ),
      tags$hr()
    ,
    ## Creating the main Panel
    mainPanel(
      
      tabsetPanel(
        
        tabPanel(title="Graphs",
                 
                 plotlyOutput("graph")),
        tabPanel(title="Data"
                 ,tableOutput("contents"))
        
      )
      
      ##tableOutput("contents")
    )
  )
    
    ## select the input file to show the report.
  
    
    
    
  )
  


