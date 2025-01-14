
## * "PM.6" ========
shinyjs::useShinyjs()

tabPanel("PM 6",
         # tabBox(width=12,
                fluidRow(
                  box(width=12, title="PM #6: The community shuttle is an efficient, reliable, safe mode of transportation",
                      tags$div(
                        tags$h5("This addresses the operations of both the HDS and SDS"),
                        tags$h5("Hypothesis: The CS will provide a level of service that will encourage usage"),
                        tags$h5("Metrics:")),
                      tags$ul(
                        tags$li("Percent of CS trips that arrive at the boarding stop within the targeted time allowance of the scheduled arrival time.", em("(Data source: Buffalo All Access app trip data)")),
                        tags$li("Cost efficiency of the HDS and SDS shuttle services in terms of operating cost per passenger trip.", em("(Data source: HDS and SDS operations data)")),
                      )
                  )
                ),
                
                fluidRow(
                  box(width=12, title="Percent of ...",
                      column(width=6,
                             box(width=12, title="CS trips that arrive at the boarding stop within the targeted time allowance of the scheduled arrival time.",
                                 plotlyOutput("pm6_1_plot"),
                                 tableOutput("pm6_table1")
                             ),
                      ),
                      column(width=6,
                             box(width=12, title=HTML("CS trips that arrive at the alighting stop within the targeted time allowance of the scheduled arrival time. 
                                                      <br><br><br><br><b>HDS and SDS operations data is <span style='color:red;'> Not Available!</span>"),
                                 plotlyOutput("pm6_2_plot")
                             ),
                      ),
                      
                  )
                ),
                
         # ) # tabBox closing
) # tab-panel closing

# title = HTML("CS trips that arrive at the <span style='color:red;'>alighting stop</span> within the targeted time allowance of the scheduled arrival time."),
# plotlyOutput("pm6_2_plot")
