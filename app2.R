library(shiny)
library(haven)
library(ggplot2)

ui <- fluidPage( 
  
  mainPanel( plotOutput("swPlot") 
  ) , 
  inputPanel( selectInput("candidate","Select a candidate:", c( "Biden", "Trump")))
  
) 

server <- function(input, output) {
  elec <- read.csv("elct2020.csv")
  
  dataInput1 <- reactive({ 
    elec2 <- elec[(elec$candidate == input$candidate),]
    
    
    elec2$state <- factor(elec2$state, levels = elec2$state[order(elec2$percent, decreasing = FALSE)])
    elec2
    
  })
  

  output$swPlot <- renderPlot({ 
    
    myPlot <- ggplot(dataInput1(),  aes( y=percent , x=state )) +
      labs(title = "percentage by state", 
           y = "Percentage of Votes", x = "State") + 
      geom_col(data=dataInput1(), width = 0.9)+
      aes(fill=candidate, color=candidate) + 
      scale_color_manual(values=c("red","blue")) +
      scale_fill_manual(values=c("Trump"="red","Biden"="blue")) 
      
    
    print(myPlot) }) 
}

shinyApp(ui=ui, server=server)
