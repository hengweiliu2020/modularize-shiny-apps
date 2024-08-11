

tm_custom_module <- function(label, dataname,  param_var, aval_var){
  module(
    label=label, 
    
    ui = function(id){
      ns <- NS(id)
      fluidPage(
        
        fluidRow(
          column(width=3, box(title ="Option for plot", solidHeader =T, status = "primary",width = NULL,
                              
                              box( status = "primary",width = NULL,
                                   inputPanel(uiOutput(ns("aval_var")))),
                              
                              box( status = "primary",width = NULL,
                                   inputPanel(uiOutput(ns("par_var")))),
                              
                              box( status = "primary",width = NULL,
                                   inputPanel(uiOutput(ns("paramcd")))),
                              box( status = "primary",width = NULL,
                                   inputPanel(uiOutput(ns("subjid"))))
                              )), 
          column(width=9, box(title = "Lab data Plot", width = NULL, status = "primary", solidHeader = T ,
                              plotOutput(ns("spPlot"),  width = "100%", height = "400px"))) 
          ))
                   
        
      
        
      },
    
    server = function(id, data){
      
      moduleServer(id,
                   function(input, output, session) {
                     ns <- session$ns
                     
                     lb <-reactive({
                       data()[[dataname]]
                     }) 
                       
                     output$par_var = renderUI ({
                       selectInput(inputId =ns("par_var"), label = "Select a parameter variable:",  multiple=FALSE,
                                   choices = param_var$choices, selected = param_var$selected )
                     })
                     
                     output$aval_var = renderUI ({
                       selectInput(inputId =ns("aval_var"), label = "Select a variable for y-axis:",  multiple=FALSE,
                                   choices = aval_var$choices, selected = aval_var$selected )
                     })
                     
                     
                     paramval  <-  reactive({ 
                      
                       c(unique(lb()[[input$par_var]])) 
                       })
                     
                     subjval <-  reactive({ c(unique(lb()$SUBJID)) })
                
                     
                     output$paramcd = renderUI ({
                       selectInput(inputId =ns("paramcd"), label = "Select a parameter:",  multiple=TRUE,
                                   choices = paramval(), selected = paramval()[1] )
                     })
                     
                     output$subjid = renderUI ({
                       selectInput(inputId =ns("subjid"), label = "Select a subjid:",  multiple=FALSE,
                                   choices = subjval(), selected = subjval()[1] )
                     })
                
                     
                     dataInput1 <- reactive({
                       
                       LB2 <- lb()[(lb()[[input$par_var]] %in% c(input$paramcd) & lb()$SUBJID %in% c(input$subjid) ),]
                       
                       LB2
                     })
                     
                     output$spPlot <- renderPlot({ 
                         myplot <- ggplot(dataInput1(), aes(x = factor(AVISITN), y = dataInput1()[[input$aval_var]], group=dataInput1()[[param_var$selected]], col=dataInput1()[[param_var$selected]])) + 
                         labs(title = "Line plot by PARAMCD for Lab Result Over Avisit", 
                              x="AVISIT", y = "Lab Result") +
                         
                         geom_line(size=1) + 
                         geom_hline(yintercept=dataInput1()$LLOQ, linetype=2) +
                         geom_hline(yintercept=dataInput1()$ULOQ, linetype=2) +
                           
                         scale_color_manual(values=c("red","black","green","purple", "pink","blue","orange","yellow")) +
                         scale_x_discrete( breaks=c(unique(unique(dataInput1()[c("AVISITN","AVISIT")]$AVISITN))), 
                                           
                                           labels=c(unique(unique(dataInput1()[c("AVISITN","AVISIT")]$AVISIT)))
                                           
                                           
                         ) +
                         theme(axis.text.x = element_text(angle = 60)) 
                         
                         myplot
                         
                       
                     }) 
                   })
      
    }
    
    
  )
    
  
}
