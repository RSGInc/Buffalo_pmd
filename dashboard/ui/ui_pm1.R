
## * "PM.1" ========
shinyjs::useShinyjs()

tabPanel("PM 1",
         # tabBox(width=12,
                fluidRow(
                  box(width = 12, title="PM #1: Ability to Make Complete Trips in the Study Area",
                      tags$div(
                        tags$h5("Ensuring that there is a safe, accessible path, compatible with user-defined preferences and capabilities to/from/within the BNMC and other desired origins and destinations. 
                              This requires real-time information on end-to-end travel options and infrastructure usability and accessibility."),
                        tags$h5("Hypothesis: The ability of system users to make Complete Trips will improve from the pre-deployment baseline situation."),
                        tags$h5("Metrics:")),
                      tags$ul(
                        tags$li("System user ratings of the ease of making door-to-door trips to, from and within the BNMC.", em("(Data source: Pre & Post-Survey)")),
                        tags$li("System user ratings of how safe door-to-door travel paths are for trips to, from and within the BNMC, including level, slip-resistant paths.", em("(Data source: Pre & Post-Survey)")),
                        tags$li("System user ratings of the availability of information for making trips to, from and within the BNMC.", em("(Data source: Pre & Post-Survey)")),
                        tags$li("System user ratings of the ability to make trips using integrated transit services. to, from and within the BNMC.", em("(Data source: Pre & Post-Survey)")),
                        tags$li("System user ratings of the usefulness of information for making trips to, from and within the BNMC.", em("(Data source: Pre & Post-Survey)")),
                        tags$li("The satisfaction with making a trip using the Buffalo All Access app app.", em("(Data source: Buffalo All Access app trip data)"))
                      )
                  ),

                ),
               
        
                fluidRow(
                  box(width=12, title="System user ratings of ...",
                      column(width=6,
                             box(width=12, title="Ease of making door-to-door trips to/from and within the BNMC.",
                                 plotlyOutput("pm1_1_plot")
                             ),
                             dataTableOutput("pm1_table1")
                      ),
                      column(width=6,
                             box(width=12, title="How safe door-to-door travel paths are for trips to, from and within the BNMC, including level, slip-resistant paths.",
                                 plotlyOutput("pm1_2_plot")
                             ),
                             dataTableOutput("pm1_table2")
                      ),
                      # column(width=4,
                      #        box(width=12, title="Availability of information for making trips to, from and within the BNMC.",
                      #            plotlyOutput("pm1_3_plot")
                      #        ),
                      #        dataTableOutput("pm1_table3")
                      # ),
                  )
                ),
                fluidRow(
                  box(width=12, title="System user ratings of ...",
                      column(width=6,
                             box(width=12, title="Availability of information for making trips to, from and within the BNMC.",
                                 plotlyOutput("pm1_3_plot")
                             ),
                             dataTableOutput("pm1_table3")
                      ),
                      column(width=6,
                             box(width=12, title="Ability to make trips using integrated transit services to/from and within the BNMC.",
                                 plotlyOutput("pm1_5_plot")
                             ),
                             dataTableOutput("pm1_table5")
                      ),
                  )
                ),
                fluidRow(
                  box(width=12, title="System user ratings of ...",
                      column(width=7,
                             box(width=12, title="Usefulness of information for making trips to/from and within the BNMC.",
                                 plotlyOutput("pm1_4_plot")
                             ),
                             
                             dataTableOutput("pm1_table4")
                      ),
                      column(width=5,
                             box(width=12, title="Satisfaction with making a trip using the Buffalo All Access app.",
                                 plotlyOutput("pm1_6_plot")
                             ),
                             dataTableOutput("pm1_table6")
                      ),
                  )
                ),
         # ) # tabBox closing
) # tab-panel closing
