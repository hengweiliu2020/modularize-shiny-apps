
waterfallUI <- function(id){
  ns <- NS(id)
  tagList(
    
    mainPanel( plotOutput(ns("wfPlot")) 
    ) , 
    inputPanel( selectInput(ns("candidate"),"Select a candidate:", c( "Biden", "Trump")))
  )
}


waterfallServer <- function(id){
  
  moduleServer(id,
               function(input, output, session) {
                 ns <- session$ns
                 
  elec <- read.csv("elct2020.csv")
  
  dataInput1 <- reactive({ 
    elec2 <- elec[(elec$candidate == input$candidate),]
    
    
    elec2$state <- factor(elec2$state, levels = elec2$state[order(elec2$percent, decreasing = FALSE)])
    return(elec2)
    
  })
  

  output$wfPlot <- renderPlot({ 
    
     ggplot(dataInput1(),  aes( y=percent , x=state )) +
      labs(title = "percentage by state", 
           y = "Percentage of Votes", x = "State") + 
      geom_col(data=dataInput1(), width = 0.9)+
      aes(fill=candidate, color=candidate) + 
      scale_color_manual(values=c("red","blue")) +
      scale_fill_manual(values=c("Trump"="red","Biden"="blue")) 
     }) 
    })
}

