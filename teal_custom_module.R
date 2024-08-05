

tm_custom_module <- function(label, mydata){
  module(
    label=label, 
    
    ui = function(id){
      ns <- NS(id)
      tagList(
        mainPanel( plotOutput(ns("swPlot")) 
        ) 
       
        
      )},
    
    server = function(id, data){
      
      moduleServer(id,
                   function(input, output, session) {
                     ns <- session$ns
                     
                     
                     dataInput1 <- reactive({
                       
                       data()[[mydata]]
                       
                       
                     
                       
                       
                     })
                   
                     
                     
                     output$swPlot <- renderPlot({ 
                       
                       ggplot(dataInput1(),  aes( x=percent , y=state )) +
                         labs(title = "percentage by state", 
                              x = "Percentage of Votes", y = "State") + 
                         geom_col(data=dataInput1(), width = 0.9)+
                         aes(fill=candidate, color=candidate) 
                       
                     }) 
                   })
    }
    
    
    
    
  )
}
