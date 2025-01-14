
## * "PM.1" ========
shinyjs::useShinyjs()

tabPanel("PM 3",
         # tabBox(width=12,
                fluidRow(
                  box(width=12, title="PM #3: Usefulness of the Buffalo All Access app Trip Planning and Booking Process",
                      tags$div(
                        tags$h5("This addresses user needs around the trip planning and booking processes"),
                        tags$h5("Hypothesis: People will plan and book trips in the Buffalo All Access app because of its utility and ease of use"),
                        tags$h5("Metrics:")),
                      tags$ul(
                        tags$li("System user ratings of the ease of planning a door-to-door trip route/path", em("(Data source: Post-Survey)")),
                        tags$li("System user ratings of the ease of booking on-demand (CS) transit trips via the system.", em("(Data source: Post-Survey)")),
                        tags$li("System user ratings of the ease of reporting incidents or conditions encountered during a trip in the Buffalo All Access app.", em("(Data source: Post-Survey)")),
                        tags$li("System user ratings of the satisfaction with the specific route/path options provided by the Buffalo All Access app.", em("(Data source: Post-Survey)")),
                        tags$li("The percent of Buffalo All Access app users who use the Buffalo All Access app function to review past trip history.", em("(Data source: Post-Survey)")),
                        tags$li("System user ratings of the usefulness of reporting past trip history in the Buffalo All Access app.", em("(Data source: Post-Survey)")),
                        tags$li("The percent of Buffalo All Access app users who use the system to book on-demand transit trips (CS).", em("(Data source: Buffalo All Access app trip data)")),
                        tags$li("The percent of Buffalo All Access app users who use the Buffalo All Access app to report incidents or travel conditions during their trips.", em("(Data source: Post-Survey)")),
                        
                      )
                  )
                ),
                fluidRow(
                  box(width = 12, title = "System user ratings of....",
                      column(width = 12, 
                             box(width=12, title = "", style = "height:250px",
                               plotlyOutput("pm31_all_plot"),
                            ),
                            box(width = 12,
                                dataTableOutput("pm3_all_table1")
                                )
                  ),
                )      
             ),
               fluidRow(
                  box(width = 12, title = "System user ratings of....",
                      column(width = 12, 
                             box(width = 12, style= "height:180px", 
                               plotlyOutput("pm32_all_plot")
                      ),
                      box(width = 12,
                          dataTableOutput("pm3_all_table2")
                          )
                      ) 
                  ),
             ),

           fluidRow(
            box(width = 12, title = "System user ratings of....",
               column(width = 12, 
                      box(width = 12, style= "height:180px", 
                          plotlyOutput("pm38_all_plot")
                      ),
                      box(width = 12,
                          dataTableOutput("pm3_all_table8")
                      )
               ) 
           ),
         ),
             
            
          fluidRow(
            box(width=12, title="The percent of Buffalo All Access app users who use ...",
                column(width=4,
                       box(width=12, title="system to book on-demand transit trips (CS).",
                          plotlyOutput("pm3_3_plot"),
                          tableOutput("pm3_table3")
                             ),
                      ),
                column(width=4,
                       box(width=12, title="the Buffalo All Access app function to review past trip history.",
                           plotlyOutput("pm3_7_plot"),
                           tableOutput("pm3_table7")
                       ),
                ),
                column(width=4,
                      box(width=12, title="Buffalo All Access app to report incidents or travel conditions during their trips.",
                          plotlyOutput("pm3_5_plot"),
                          tableOutput("pm3_table5")
                      ),
                  ),
              )
            ),
# ) # tabBox closing
) # tab-panel closing
