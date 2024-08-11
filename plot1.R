library(haven)
library(shinydashboard)
library(DT)
library(tidyr)
library(shiny)
library(ggplot2)
library(dplyr)
library(stringi)
library(shinythemes)
library(nestcolor)
library(teal)
library(teal.modules.clinical)
library(teal.modules.general)
library(plotly)
library(teal.widgets)


source("tm_custom_module.R")

adlb <- read_sas("adlb.sas7bdat")
adsl <- read_sas("adsl.sas7bdat")

adlb <- adlb[(adlb$DTYPE!="LOT" & adlb$DTYPE!="MAXIMUM" & adlb$DTYPE!="MINIMUM" & adlb$ANL01FL=='Y' 
              
              & (adlb$PARAMCD=="ALT" | adlb$PARAMCD=="AST" | adlb$PARAMCD=="BILI" | adlb$PARAMCD=="ALP" ) & adlb$AVISITN<=1101
),]

adlb <- adlb[c("SUBJID","PARAMCD","PARAM","AVISITN",'AVISIT',"TRTA", 'AVAL','CHG')]
adlb$LLOQ <- 1
adlb$ULOQ <- 100


ADLB <- adlb



app <- init(
  
  data <- teal_data(ADLB=ADLB) ,
  
  modules =modules(
    
    tm_custom_module(label="line plot", 
                     dataname="ADLB", 
                     
                     param_var=choices_selected(
                       choices=c("PARAMCD","PARAM"), 
                       selected="PARAM"), 
                     aval_var=choices_selected(
                         choices=c("AVAL","CHG"), 
                         selected="AVAL"
                       
                     )
                     ) 
  ) 
  )

shinyApp(app$ui, app$server)

