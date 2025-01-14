
## * "PM.5" ========
shinyjs::useShinyjs()

tabPanel("PM 5",
         # tabBox(width=12,
                fluidRow(
                  box(width=12, title="PM #5: Improved ability to cross specific intersections safely using the Buffalo All Access app smart-signal functionality",
                      tags$div(
                        tags$h5("This addresses user needs around outdoor mobility safety at intersections, particularly for travelers who have visual impairments, 
                                who are in wheelchairs, or older adults who need more time crossing"),
                        tags$h5("Hypothesis: At those intersections where it is deployed, the smart-signal functionality will facilitate safer crossing and so will be used"),
                        tags$h5("Metrics:")),
                      tags$ul(
                        tags$li("The percent of Buffalo All Access app trips crossing at the relevant intersections who use the smart signal remote activation function.", em("(Data source: Buffalo All Access app trip data)")),
                        tags$li("Self-reported fraction of people who cross at the relevant intersections who use the Buffalo All Access app smart signal activation functionality.", em("(Data source: Post-Survey)")),
                        tags$li("Perceived ease of use and ratings of various aspects of using the smart signals, using the RAPUUD method.", em("(Data source: Post-Survey)")),
                        tags$li("Perceived safety of crossing the intersections with smart signals.", em("(Data source: Pre & Post-Survey)")),
                        tags$li("Self-reported frequency of crossing at the interesections with smart signals.", em("(Data source: Post-Survey)")),
                      )
                  )
                ),    
                
                # fluidRow(
                #   box(width=12, title="Perceived ...",
                #       column(width=12,
                #              # box(width=12, title="ease of use and ratings of various aspects of using the smart signals, using the RAPUUD method.",
                #              plotlyOutput("pm5_all_plot")
                #              # ,plotlyOutput("pm51_all_plot")
                #              # ),
                #       ),
                #   )
                # ),
                # 
                fluidRow(
                  box(width=12, title="Self-reported ...",
                      column(width=6,
                             box(width=12, title="percent of Buffalo All Access app trips crossing at the relevant intersections who use the smart signal remote activation function.",
                                 plotlyOutput("pm5_1_plot"),
                                 tableOutput("pm5_table1")
                             ),
                      ),
                      column(width=6,
                             box(width=12, title="fraction of people who cross at the relevant intersections who use the Buffalo All Access app smart signal activation functionality.",
                                 plotlyOutput("pm5_2_plot")
                             ),
                             dataTableOutput("pm5_table2")
                      ),
                  )
                ),
         
                fluidRow(
                  box(width=12, title="Perceived ...",
                      column(width=6,
                             box(width=12, title="ease of use and ratings of various aspects of using the smart signals, using the RAPUUD method.",
                                 plotlyOutput("pm5_3_plot")
                             ),
                             dataTableOutput("pm5_table3")
                      ),
                      column(width=6,
                             box(width=12, title="safety of crossing the intersections with smart signals.",
                                 plotlyOutput("pm5_5_plot_com")
                             ),
                             dataTableOutput("pm5_table5")
                      ),
                  )
                ),


                fluidRow(
                  box(width=12, title="Self-reported ...",
                      # column(width=6,
                      #        box(width=12, title="frequency of crossing at the intersections with smart signals.",
                      #            plotlyOutput("pm5_4_plot")
                      #        )
                      # ),
                      column(width=6,
                             box(width=12, title="frequency of crossing at the intersections with smart signals.",
                                 plotlyOutput("pm5_4_plot_com")
                             ),
                             dataTableOutput("pm5_table4")
                            
                      ),
                  )
                ),
         
                # fluidRow(
                #   box(width=12, title="Perceived ...",
                #       column(width=6,
                #              box(width=12, title="safety of crossing the intersections with smart signals.",
                #                  plotlyOutput("pm5_5_plot_com")
                #              ),
                #       ),
                #   )
                # ),


         # ) # tabBox closing
) # tab-panel closing
