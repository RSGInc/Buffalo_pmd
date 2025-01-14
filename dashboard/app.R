# ITS4US PMD Dashboard 
# Developed by Kyeongsu Kim at RSG
# Begin to develop on 9/15/2023
# Latest Update on 2/14/2024 

source(file.path("dashboard_config.R"))

library(fmsb)
library(tidyverse)
library(data.table)
library(leaflet)
library(leafgl)
library(plotly)
library(readr)
library(sf)
library(shiny)
library(shinyjs)
library(shinyalert)
library(shinycssloaders)
library(shinydashboard)
library(shinyWidgets)
library(shinyFiles)
library(htmltools)
library(htmlwidgets)
library(mapview)
library(RColorBrewer)
library(scales)
library(DT)
library(reactable)
library(reactablefmtr)
library(purrr)
library(readxl)
library(formattable)


Main_Page = function(){
  tagList(

    dashboardPage(skin="black",
                  ## dashboardHeader -------------
                  dashboardHeader(title="ITS4US Buffalo All Access Performance Measure Dashboard",titleWidth = 650,
                                  tags$li(class = "dropdown",
                                          tags$a(href="https://bnmc.org/allaccess", target="_blank", 
                                                 tags$img(height = "30px", alt="ITS4US Logo", src="ITS4US Logo.jpg")))
                  ),
                  
                  ## dashboardSidebar -------------
                  dashboardSidebar(disable=T),
                  
                  ## dashboardBody -------------
                  dashboardBody(
                    fluidRow(
                      tabBox(width=12,
                             source(file.path("ui", "ui_overview.R"),  local = TRUE)$value,
                             source(file.path("ui", "ui_pm1.R"),  local = TRUE)$value,
                             source(file.path("ui", "ui_pm2.R"),  local = TRUE)$value,
                             source(file.path("ui", "ui_pm3.R"),  local = TRUE)$value,
                             source(file.path("ui", "ui_pm4.R"),  local = TRUE)$value,
                             source(file.path("ui", "ui_pm5.R"),  local = TRUE)$value,
                             source(file.path("ui", "ui_pm6.R"),  local = TRUE)$value

                      )
                    ), 
                    # footer
                    h5("Copyright | ITS4US BUFFALO ACCESS in and around BNMC", style=" color: #585353; font-weight: bold;  text-align: center")
                    
                  )
    )
  )
}

ui <- shinyUI(htmlOutput('Webpage'))

server <- function(input, output, session) {
  
  log_path <- paste("logs/log_", substr(Sys.time(), 1, 10), ".txt", sep = "")
  log_txt = "-------------- Session Start --------------"
  cat(file=log_path, log_txt, "\n", append=TRUE)
  message(log_txt)
  
  output$Webpage <- renderUI({Main_Page()})
  

  source(file.path("server", "server_overview.R"),  local = TRUE)$value
  source(file.path("server", "server_pm1.R"),  local = TRUE)$value
  source(file.path("server", "server_pm2.R"),  local = TRUE)$value
  source(file.path("server", "server_pm3.R"),  local = TRUE)$value
  source(file.path("server", "server_pm4.R"),  local = TRUE)$value
  source(file.path("server", "server_pm5.R"),  local = TRUE)$value
  source(file.path("server", "server_pm6.R"),  local = TRUE)$value
}

shinyApp(ui = ui, server = server)
