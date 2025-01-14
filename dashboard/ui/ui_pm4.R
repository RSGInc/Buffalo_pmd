
## * "PM.4" ========
shinyjs::useShinyjs()

tabPanel("PM 4",
         # tabBox(width=12,
                fluidRow(
                  box(width=12, title="PM #4: Improved ability to find destinations efficiently using the Buffalo All Access app wayfinding functionality",
                      tags$div(
                        tags$h5("This addresses user needs around outdoor and indoor mobility and wayfinding for travelers in the target groups"),
                        tags$h5("Hypothesis: Wayfinding functionality both outdoor and indoor will be perceived as useful support for efficient trip making"),
                        tags$h5("Metrics:")),
                      tags$ul(
                        tags$li("The fraction of Buffalo All Access app users who elect to receive outdoor wayfinding notifications.", em("(Data source: Buffalo All Access app trip data)")),
                        tags$li("The fraction of Buffalo All Access app users who elect to receive indoor wayfinding notifications.", em("(Data source: Buffalo All Access app trip data)")),
                        tags$li("System user self-reported frequency of using outdoor wayfinding notifications.", em("(Data source: Post-Survey)")),
                        tags$li("System user self-reported frequency of using indoor wayfinding notifications.", em("(Data source: Post-Survey)")),
                        tags$li("System user ratings of the how useful the outdoor wayfinding functionality is in reaching their trip destination on time.", em("(Data source: Post-Survey)")),
                        tags$li("System user ratings of the how useful the indoor wayfinding functionality is in reaching their trip destination on time.", em("(Data source: Post-Survey)")),
                        tags$li("System user ratings of various dimensions of using the Buffalo All Access app outdoor wayfinding functionality using the RAPUUD method.", em("(Data source: Post-Survey)")),
                        tags$li("System user ratings of various dimensions of using the Buffalo All Access app indoor wayfinding functionality using the RAPUUD method.", em("(Data source: Post-Survey)")),
                      )
                  )
                ),
         
                fluidRow(
                  box(width=12, title="The fraction of ...",
                      column(width=6,
                             box(width=12, title="Buffalo All Access app users who elect to receive outdoor wayfinding notifications.",
                                 plotlyOutput("pm4_1_plot"),
                                 tableOutput("pm4_table1")
                             ),

                      ),
                      column(width=6,
                             box(width=12, title="Buffalo All Access app users who elect to receive indoor wayfinding notifications.",
                                 plotlyOutput("pm4_3_plot"),
                                 tableOutput("pm4_table3")
                             ),

                      ),
                  )
                ),
         
                fluidRow(
                  box(width=12, title="System user self-reported ...",
                      column(width=12, 
                            box(width = 12, style = "height:200px",
                            plotlyOutput("pm4_all_plot")
                      ),
                      box(width = 12,
                          dataTableOutput("pm4_all_table1")
                      )
                      )
                  )
                ),
         
                fluidRow(
                  box(width=12, title="System user ratings of ...",
                      column(width=12, 
                            box(width = 12, style= "height:200px",
                            plotlyOutput("pm4u_all_plot")
                      ),
                      box(width = 12,
                          dataTableOutput("pm4_all_table2")
                          )
                      )
                  )
                ),
   
                fluidRow(
                  box(width=12, title="User ratings of various dimensions of using the Buffalo All Access app outdoor & indoor wayfinding functionality using the RAPUUD method",
                      column(width=12,
                             box(width=12, style= "height:950px",
                                 plotlyOutput("combined_plot2", height = "100%")
                             ),
                             box(width = 12, style = "height:500px; overflow-y: scroll;",
                                 dataTableOutput("pm4_table78", height = "100%")
                             )

                      ),

                  )
  ),

) # tab-panel closing

