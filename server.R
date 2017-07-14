#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/

library(shiny)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram
df = as.data.frame(read.csv(file = "C:/vedant/StatisticalLearning/RShiny/CAPA_sheet.csv"
                            ,header = TRUE,sep = ",",quote = "",stringsAsFactors = FALSE
                          ,strip.white = TRUE,check.names = TRUE,fileEncoding="UTF-8-BOM"))
df$Assigned.to = as.factor(df$Assigned.to)
df$OnSchedule =as.factor(ifelse(df$Current.Due.Date>df$Original.Due.Date,"NO","YES"))

shinyServer(function(input, output) {

  output$contents = renderTable({
       df
  })
  
  ### Reactive plot
  m <- list(
    l = 50,
    r = 50,
    b = 10,
    t = 100,
    pad = 4
  )
  
  colorr = c("red","green");
  
  capaOnSchedule=ggplotly(
            ggplot(df,aes(x=OnSchedule,fill=OnSchedule))
           
            +geom_bar(stat='count',width =0.5)
            +scale_fill_manual(values=c("red","green"))
            +
            theme(legend.title = element_text(colour="blue", size=9,face="bold"))
      )%>% layout(autosize=T,margin=m)
    
  
  p = ggplot(df,aes(x= Assigned.to,fill=OnSchedule)) + geom_bar(stat='count', width =0.5)
  q = p +theme(axis.text.x=element_text(angle=90,hjust=0.9,vjust=.5,size=6))+theme(legend.title =
                                                                                     element_text(colour="blue",
                                                                                                  size=9,face="bold"
                                                                                                  ,vjust = .2))
  capabyAssigned =
    ggplotly(q)%>% layout(autosize=T);
  
  ## Make graph which shows CAPA on schedule
  
  plotType = function(type){
    switch (
      type,
      CS = capaOnSchedule,
      AC = capabyAssigned
    )
  }
  
  output$graph = renderPlotly({
    plotType(input$select)
  }
  )
})
