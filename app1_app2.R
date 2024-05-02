
library(haven)
library(shiny)
library(ggplot2)
library(shinydashboard)

source("app1_module.R")
source("app2_module.R")

ui <- dashboardPage(
    skin="blue",
    dashboardHeader(title="Election data 2020"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("vertical bar plot", tabName="waterfall"),
        menuItem("horizontal bar plot", tabName="swimmer")
        
      )
    ),
    
    dashboardBody(
      tabItems(
        tabItem(tabName="waterfall",
                fluidPage(
                  waterfallUI("water")
                    )
        ), 
                    
        tabItem(tabName="swimmer",
                fluidPage(
                  swimmerUI("swimmer")
                )) )
    ))

server <- function(input, output, session) {
  waterfallServer("water")
  swimmerServer("swimmer")
}

shinyApp(ui, server)


