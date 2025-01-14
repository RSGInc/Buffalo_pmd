
## * "PM.1" ========
shinyjs::useShinyjs()

tabPanel("PM 2",
         # tabBox(width=12,
                fluidRow(
                  box(width=12, title="PM #2: Usefulness of the CTP Registration and Trip Preferences Process",
                      tags$div(
                        tags$h5("This addresses user needs around whether the CTP registration process is feasible to complete for the great majority of (potential) users, 
                                and whether the trip preference options that are presented are deemed as relevant and useful inputs for planning their travel"),
                        tags$h5("Hypothesis: People will want to register in the CTP because of it perceived usefulness."),
                        tags$h5("Metrics:")),
                      tags$ul(
                        tags$li("System user ratings of the ease of the registration process.", em("(Data source: Post-Survey)")),
                        tags$li("System user ratings of the extent to which the options available during registration served their needs.", em("(Data source: Post-Survey)")),
                      )
                  )
                ),
                # fluidRow(
                #   box(width=12, title="System user ratings of ...",
                #       column(width=12,
                #              # box(width=12, title="ease of making door-to-door trips to, from and within the BNMC.",
                #              plotlyOutput("pm2_all_plot"),
                #              plotlyOutput("pm22_all_plot")
                #              # formattableOutput("pm2.1_plot") %>% withSpinner()
                #              # ),
                #       ),
                #   )
                # ),
                
                fluidRow(
                  box(width=12, title="System user ratings of ...",
                         column(width=6,
                                box(width=12, title="ease of the registration process.",
                                plotlyOutput("pm2_1_plot")
                                ),
                                dataTableOutput("pm2_table1")

                         ),
                         column(width=6,
                                box(width=12, title="extent to which the options available during registration served their needs.",
                                   plotlyOutput("pm2_2_plot")
                                ),
                                dataTableOutput("pm2_table2")
                         ),
                  )
                ),
         # ) # tabBox closing
) # tab-panel closing

