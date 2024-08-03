

library(teal)
library(haven)
library(shiny)
library(ggplot2)
library(shinydashboard)

source("teal_custom_module.R")


elec <- read.csv("elct2020.csv")

data <- teal_data(ELEC=elec)



 app <- init(
   
   data <- data, 
   modules = tm_custom_module(label="election data 2020", mydata="ELEC")
   
  
 )
 
 shinyApp(app$ui, app$server)
 