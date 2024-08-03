

tm_custom_module <- function(label){
  module(
    label=label, 
    datanames="ELEC",
    ui = function(id){
      ns <- NS(id)
      tagList(
        mainPanel( plotOutput(ns("swPlot")) 
        ) , 
        inputPanel( selectInput(ns("candidate"),"Select a candidate:", c( "Biden", "Trump")))
        
      )},
    
    server = function(id, data){
      
      moduleServer(id,
                   function(input, output, session) {
                     ns <- session$ns
                     
                     
                     dataInput1 <- reactive({
                       
                       data()[["ELEC"]]
                       
                       
                     
                       
                       
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
    
    
    
    
  )
}
