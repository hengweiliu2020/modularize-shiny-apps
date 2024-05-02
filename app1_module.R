
swimmerUI <- function(id){
  ns <- NS(id)
  tagList(
    mainPanel( plotOutput(ns("swPlot")) 
    ) , 
    inputPanel( selectInput(ns("candidate"),"Select a candidate:", c( "Biden", "Trump")))
        
  )}

swimmerServer <- function(id){
  
  moduleServer(id,
               function(input, output, session) {
                 ns <- session$ns


                 elec <- read.csv("elct2020.csv")
  
                 print(elec)
  dataInput1 <- reactive({ 
    elec2 <- elec[(elec$candidate == input$candidate),]
    
    
    elec2$state <- factor(elec2$state, levels = elec2$state[order(elec2$percent, decreasing = FALSE)])
    
    return(elec2)
    
  })
  

  output$swPlot <- renderPlot({ 
    
     ggplot(dataInput1(),  aes( x=percent , y=state )) +
      labs(title = "percentage by state", 
           x = "Percentage of Votes", y = "State") + 
      geom_col(data=dataInput1(), width = 0.9)+
      aes(fill=candidate, color=candidate) + 
      scale_color_manual(values=c("red","blue")) +
      scale_fill_manual(values=c("Trump"="red","Biden"="blue")) 
    
     }) 
     })
}


