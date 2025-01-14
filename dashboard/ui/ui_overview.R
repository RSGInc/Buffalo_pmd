
## * 1. overview ========
Text_github_shiny_link  = "This tool was created in Shiny and the full tool code can be found on"
Text_github_data_link   = "Visit bnmc.org/allaccess to learn more!"
Text_Intro_app_version  = paste0("Dashboard Version: ", app_version)

shinyjs::useShinyjs()

linebreaks <- function(n){HTML(strrep(br(), n))}

tabPanel("Overview",
         # tabBox(width=12,
                fluidRow(

                  column(width=5,
                         box(width=12, title="Study Area",
                             leafletOutput("map_studyarea", height = 500) %>% withSpinner()
                         )
                  ),
                  column(width=4,
                         box(width=12,
                             tags$div(
                               tags$h2("Introduction of Performance Measurement Dashboard"),
                               # tags$h4("Testing text..testing text.. The PMD will ingest five key datasets, including data collected during baseline (pre-deployment) and post-deployment surveys, CTP user and trip data, and user ratings and operation performance of the CS (including SDS and HDS) trips (Req-PMD-001). The project team will collect the baseline and post-deployment survey data and store them in secure servers. To comply with Institutional Review Board (IRB) regulations and protect PII, the survey data collection team will take necessary steps to anonymize the survey data for the PMD development and share the anonymized data via SharePoint data transfer with MFA. CTP- and CS-related data will also be shared through a secure API (ICD # XX and YY). Each subsystem will remove or anonymize PII before sharing the data with the PMD (Req-PMD-003)....... "),
                               tags$h4("Buffalo All Access Performance Measure Dashboard (PMD), a comprehensive tool designed to assess and visualize user experiences and performance
                                        metrics associated with Buffalo All Access app. This dashboard provides insights into how users interact with some systems, particularly in the context of
                                        door-to-door trip planning, booking on-demand services, safety, and accessibility within the Buffalo Niagara Medical Campus (BNMC).
                                        
                                       "),
                               # linebreaks(1),
                               tags$h4("The PMD integrate and analyze five key datasets, including data obtained from both baseline (pre-deployment) and post-deployment surveys. It also 
                                        ingest data from Buffalo All Access app user registration and trip records, as well as user ratings and operational performance metrics for the CS 
                                       (including SDS and HDS) trips. The collected data is processed to show the performance of subsystems implemented for Buffalo All Access project."),
                               tags$h4(HTML("The dashboard features a range of performance measures (PMs) that demonstrate various dimensions of user experience:
                                       <ul>
                                          <li>Ease of trip planning and making</li>
                                            <li>Safety and accessibility</li>
                                            <li>Availability and usefulness of travel information</li>
                                            <li>System functionality and user engagement.</li>")),
                               # tags$h4("Testing text..testing text..The collected data will be processed to show the performance metrics defined in the PMESP. This involves quality checking (Req-PMD-002) and applying analytical techniques, algorithms, and statistical methods to transform the data into valuable information. During this stage, the data will be cleaned, organized, and transformed as necessary to ensure accuracy and consistency (Req-PMD-014). Potential PII will also be double-checked and removed (Req-PMD-003). In addition, metadata on all datasets stored in the PMD data layer will be developed (Req-PMD-005)......"),
                               linebreaks(1),
                               # tags$h4("text..."),
                               linebreaks(1),
                               # img(src='ITS4US Logo.jpg',  height = 100, width = 250),
                               # linebreaks(2),
                               tags$h4(tags$p(Text_github_shiny_link, tags$a(href="", "Github"))),
                               tags$h4(tags$p(Text_github_data_link, tags$a(href="https://bnmc.org/allaccess", "bnmc.org/allaccess"))),
                               linebreaks(1),
                               tags$h4(Text_Intro_app_version, style="font-weight: bold")
                               )
                         ),
                  ),
                  column(width=3,
                         box(width = 12, title = "Download",
                             tags$div(
                               tags$h5("It is a processed PM summary table"), 
                               downloadButton("download_pm_summary_table", "Download Summary Table"),
                             ),
                             # style = 'overflow-x: scroll',
                             # tags$br(),
                             
                             tags$div(
                               tags$h5("It is a processed survey data"), 
                               downloadButton("download_pm_survey_input_data", "Download Survey Data")
                             ),
                             # tags$br(),
                             
                             tags$div(
                               tags$h5("It is a processed Buffalo All Access app data"), 
                               downloadButton("download_pm_ctp_input_data", "Download Buffalo All Access app Data")
                             ),
                             
                             # tags$div(
                             #   tags$h5("(testing: won't be public) pre-deployment survey samples"), 
                             #   downloadButton("download_pre_deploy_sample", "Download Pre-Deployment Survey Samples")
                             # ),
                         )
                  ),
                )
         # )
)