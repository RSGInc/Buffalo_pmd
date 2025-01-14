

output$map_studyarea <-renderLeaflet({
  binpal <- colorBin(palette_studyarea, gis_StudyZone$zoneid, 9, pretty = FALSE)
  
  leaflet() %>% 
    addTiles(group = "OSM") %>%
    addProviderTiles(providers$CartoDB.Positron, group ="CartoDB.Positron") %>%
    addProviderTiles(providers$Stamen.TonerLite, group = "TonerLite", options = providerTileOptions(noWrap = TRUE)) %>%
    
    addPolygons(
      data = gis_StudyZone,
      # fillColor = ~ zone_colors[zoneid],
      fillOpacity = 0.8,
      smoothFactor = 0.8, 
      color = ~binpal(gis_StudyZone$zoneid),
      weight = 1,
      stroke = TRUE,
      # opacity = 0.5,
      layerId = ~ zoneid,
      # label = ~zoneid,
      # labelOptions = labelOptions(noHide=T),
      highlight = highlightOptions(
        weight = 2, color = 'red', fillOpacity = 0.7, bringToFront = TRUE),
      label = sprintf("<strong>ZoneID: %s</strong>", gis_StudyZone$zoneid) %>% #<br/> Neighorhoods: %s , gis_StudyZone$Field
        lapply(htmltools::HTML)
    ) %>%

    addLayersControl(baseGroups = c("CartoDB.Positron", "OSM"),
                     position = "topright",
                     options = layersControlOptions(collapOD = TRUE)) %>%
    
    setView(lng = "-78.8719", lat = "42.9033" , zoom = 13) 
    # addLegend(data = gis_StudyZone,
    #           pal = binpal, values = ~as.integer(zoneid), title = "Study Zone", position = "bottomright") 
})

# 3.1. map for faf tab ----------
## Render the map for selecting geographies
output$map_faf <- renderLeaflet({
  leaflet() %>% 
    addTiles(group = "OSM") %>%
    addProviderTiles(providers$CartoDB.Positron, group ="CartoDB.Positron") %>%
    addProviderTiles(providers$Stamen.TonerLite, group = "TonerLite", options = providerTileOptions(noWrap = TRUE)) %>%
    setView(lng=-73.984213, lat=40.798932,zoom=8) %>%
    addPolygons(data=gis_layer_faf(),layerId = ~geo_id, label = ~full_name, 
                color="#048495",
                group = "first_map_faf") %>%
    addLayersControl(baseGroups = c( "CartoDB.Positron", "TonerLite", "OSM"),
                     position = "topright",
                     options = layersControlOptions(collapOD = TRUE)) 
})
# 42.89590816237511, -

# download summary file in XLXS format  -------------
output$download_pm_summary_table <- downloadHandler(
  filename = function() {
    rename <- paste0("ITS4US Bufflo Performance Measure Summary Table_downloaded " , download_date_info, ".csv")
    rename
  },
  content = function(file) {
    # Create a workbook and add sheets
    wb <- createWorkbook()
    addWorksheet(wb, "PM1")
    addWorksheet(wb, "PM2")
    addWorksheet(wb, "PM3")
    addWorksheet(wb, "PM4")
    addWorksheet(wb, "PM5")
    
    # Write data to sheets
    writeData(wb, sheet = "PM1", x = pm1_summary_table)
    writeData(wb, sheet = "PM2", x = pm2_summary_table)
    writeData(wb, sheet = "PM3", x = pm3_summary_table)
    writeData(wb, sheet = "PM4", x = pm4_summary_table)
    writeData(wb, sheet = "PM5", x = pm5_summary_table)
    
    
    # Save workbook
    saveWorkbook(wb, file, overwrite = TRUE)
    # write.csv(pm_all_dt_5, file, row.names = FALSE)
  }
)

# download survey data in XLXS format  -------------
output$download_pm_survey_input_data <- downloadHandler(
  filename = function() {
    rename <- paste0("ITS4US Bufflo Performance Measure Survey Input Data_downloaded " , download_date_info, ".csv")
    rename
  },
  content = function(file) {
    # pre survey pm
    sel_baseline_svy <- test_pre_svy
    pm_names <- c("ID",
                  "System user ratings of the ease of making door-to-door trips to, from and within the BNMC.",
                  "System user ratings of how safe door-to-door travel paths are for trips to, from and within the BNMC, including level, slip-resistant paths.",
                  "System user ratings of the availability of information for making trips to, from and within the BNMC.",
                  "System user ratings of the usefulness of information for making trips to, from and within the BNMC.",
                  "System user ratings of the ability to make trips using integrated transit services. to, from and within the BNMC",
                  "Self-reported frequency of crossing at the intersections with smart signals",
                  "Perceived safety of crossing the intersections with smart signals")
    colnames(sel_baseline_svy) <- pm_names
    
    # Define the different scales
    scales <- list(
      freq6_option_text = c("Every day or almost every day", "At least once a week", "At least once a month", "5 to 10 times in the past 12 months", "1 to 4 times in the past 12 months",
                            "Not at all in the past 12 months"),
      freq5_option_text = c("Every day or almost every day", "At least once a week", "At least once a month", "Only once or twice", "Not at all"),
      freq_option_driveride_text = c("Every day or almost every day", "At least once a week", "At least once a month", "Multiple times in the past 12 months", "Never"),
      q_5Likert_option_text = c("Strongly agree", "Somewhat agree", "Neither agree nor disagree", "Somewhat disagree", "Strongly disagree"),
      q_5Likert_option_no_text = c("Strongly agree", "Somewhat agree", "Neither agree nor disagree", "Somewhat disagree", "Strongly disagree", "I have not used public transportation to travel to/from the BNMC"),
      easy_5Likert_option_text = c("Very easy", "Easy", "Neutral", "Difficult", "Very difficult"),
      CrossIntersect_option_text = c("Yes, quite often", "Yes, but not very often", "No, not at all"),
      q_yesno_option_text = c("Yes", "No"),
      useful_5Likert_option_text = c("Very useful", "Useful", "Neutral", "Not very useful", "Not useful at all"),
      satisfy_5Likert_option_text = c("Very satisfied", "Satisfied", "Neutral", "Unsatisfied", "Very Unsatisfied"),
      reliable_5Likert_option_text = c("Very reliable", "Somewhat reliable", "Neutral", "Somewhat unreliable", "Very unreliable"),
      numeric_percentage = c("Numeric percentage"),
      numeric_cost = c("Numeric cost")
    )
    
    # Define the variable names and their corresponding scales
    variable_scale <- setNames(
      list(
        scales$q_5Likert_option_text,     
        scales$q_5Likert_option_text,      
        scales$q_5Likert_option_text,  
        scales$q_5Likert_option_no_text,    
        scales$q_5Likert_option_text,          
        scales$freq5_option_text,  
        scales$q_5Likert_option_text          
      ),
      pm_names[2:8]  
    )
    
    pm_numbers <- names(test_pre_svy)[-1]
    
    # Function to create metadata dataframe
    pm_data_dictionary <- function(name, scale, pm_number) {
      n <- length(scale)
      data.frame(
        PM_Number = c(pm_number, rep("", n - 1)),
        Variable = c(name, rep("", n - 1)),
        Value = 1:n,
        Description = scale,
        stringsAsFactors = FALSE
      )
    }
    
    data_dictionary_list <- mapply(function(name, pm_number) {
      pm_data_dictionary(name, variable_scale[[name]], pm_number)
    }, names(variable_scale), pm_numbers, SIMPLIFY = FALSE)
    
    ## workbook sheet
    pre_pm_variables <- do.call(rbind, data_dictionary_list)
    
    
    
    # post survey pm
    test_post_svy_copy <- copy(test_post_svy)
    drop_column <- c("PM1_6", "PM3_3", "PM5_1")
    drop_col_exist <- drop_column[drop_column %in% names(test_post_svy_copy)]
    if (length(drop_col_exist) > 0){
      test_post_svy_copy[, (drop_column) := NULL]
    }
    
    test_base_svy_copy <- test_post_svy_copy
 
    
    pm_names <- c("ID", 
                  "System user ratings of the ease of making door-to-door trips to, from and within the BNMC.",
                  "System user ratings of how safe door-to-door travel paths are for trips to, from and within the BNMC, including level, slip-resistant paths.",
                  "System user ratings of the availability of information for making trips to, from and within the BNMC",
                  "System user ratings of the usefulness of information for making trips to, from and within the BNMC",
                  "System user ratings of the ability to make trips using integrated transit services. to, from and within the BNMC",
                  # "System user ratings of the satisfaction with making a trip using the Buffalo All Access app app.",
                  "System user ratings of the ease of the registration process",
                  "System user ratings of the extent to which the options available during registration served their needs",
                  "System user ratings of the ease of planning a door-to-door trip route/path",
                  "System user ratings of the satisfaction with the specific route/path options provided by the Buffalo All Access app",
                  # "The percent of Buffalo All Access app users who use system to book on-demand transit trips (CS).",
                  "System user ratings of the ease of booking on-demand (CS) transit trips via the system",
                  "The percent of Buffalo All Access app users who use the Buffalo All Access app to report incidents or travel conditions during their trips",
                  "System user ratings of the ease of reporting incidents or conditions encountered during a trip in the Buffalo All Access app",
                  "The percent of Buffalo All Access app users who use the Buffalo All Access app function to review past trip history",
                  "System user ratings of the usefulness of reporting past trip history in the Buffalo All Access app",
                  "The fraction of Buffalo All Access app users who elect to receive outdoor wayfinding notifications",
                  "System user self-reported frequency of using outdoor wayfinding notifications",
                  "The fraction of Buffalo All Access app users who elect to receive indoor wayfinding notifications",
                  "System user self-reported frequency of using indoor wayfinding notifications",
                  "System user ratings of the how useful the outdoor wayfinding functionality is in reaching their trip destination on time",
                  "System user ratings of the how useful the indoor wayfinding functionality is in reaching their trip destination on time",
                  "User ratings of various dimensions of using the Buffalo All Access app outdoor wayfinding functionality using the RAPUUD method: This feature is easy to use.",
                  "User ratings of various dimensions of using the Buffalo All Access app outdoor wayfinding functionality using the RAPUUD method: For me, using this feature poses a personal safety risk.",
                  "User ratings of various dimensions of using the Buffalo All Access app outdoor wayfinding functionality using the RAPUUD method: I often need assistance to use this feature.",
                  "User ratings of various dimensions of using the Buffalo All Access app outdoor wayfinding functionality using the RAPUUD method: When using this feature, I make mistakes that require me to do over some steps.",
                  "User ratings of various dimensions of using the Buffalo All Access app outdoor wayfinding functionality using the RAPUUD method: Using this feature takes more time than it should.",
                  "User ratings of various dimensions of using the Buffalo All Access app outdoor wayfinding functionality using the RAPUUD method: Using this feature requires minimal mental effort.",
                  "User ratings of various dimensions of using the Buffalo All Access app outdoor wayfinding functionality using the RAPUUD method: Using this feature draws unwanted attention to me.",
                  "User ratings of various dimensions of using the Buffalo All Access app indoor wayfinding functionality using the RAPUUD method: This feature is easy to use.",
                  "User ratings of various dimensions of using the Buffalo All Access app indoor wayfinding functionality using the RAPUUD method: For me, using this feature poses a personal safety risk.",
                  "User ratings of various dimensions of using the Buffalo All Access app indoor wayfinding functionality using the RAPUUD method: I often need assistance to use this feature.",
                  "User ratings of various dimensions of using the Buffalo All Access app indoor wayfinding functionality using the RAPUUD method: When using this feature, I make mistakes that require me to do over some steps.",
                  "User ratings of various dimensions of using the Buffalo All Access app indoor wayfinding functionality using the RAPUUD method: Using this feature takes more time than it should.",
                  "User ratings of various dimensions of using the Buffalo All Access app indoor wayfinding functionality using the RAPUUD method: Using this feature requires minimal mental effort.",
                  "User ratings of various dimensions of using the Buffalo All Access app indoor wayfinding functionality using the RAPUUD method: Using this feature draws unwanted attention to me.",
                  # "The percent of Buffalo All Access app trips crossing at the relevant intersections who use the smart signal remote activation function.",
                  "Self-reported fraction of people who cross at the relevant intersections who use the Buffalo All Access app smart signal activation functionality.",
                  "Perceived ease of use and ratings of various aspects of using the smart signals, using the RAPUUD method.",
                  "Self-reported frequency of crossing at the intersections with smart signals",
                  "Perceived safety of crossing the intersections with smart signals")
    colnames(test_base_svy_copy) <- pm_names

    # Define the variable names and their corresponding scales
    variable_scale <- setNames(
      list(
        scales$q_5Likert_option_text,     
        scales$q_5Likert_option_text,      
        scales$q_5Likert_option_text,  
        scales$q_5Likert_option_no_text,    
        scales$q_5Likert_option_text,          
        # scales$q_5Likert_option_text,  
        scales$easy_5Likert_option_text,          
        scales$useful_5Likert_option_text,       
        scales$easy_5Likert_option_text,          
        scales$satisfy_5Likert_option_text,
        # scales$q_yesno_option_text,          
        scales$easy_5Likert_option_text,  
        scales$q_yesno_option_text,          
        scales$easy_5Likert_option_text,  
        scales$q_yesno_option_text,          
        scales$useful_5Likert_option_text,  
        scales$q_yesno_option_text,          
        scales$freq5_option_text,  
        scales$q_yesno_option_text,          
        scales$freq5_option_text,  
        scales$useful_5Likert_option_text,          
        scales$useful_5Likert_option_text,  
        scales$q_5Likert_option_text,          
        scales$q_5Likert_option_text,  
        scales$q_5Likert_option_text,          
        scales$q_5Likert_option_text,  
        scales$q_5Likert_option_text,          
        scales$q_5Likert_option_text,  
        scales$q_5Likert_option_text, 
        scales$q_5Likert_option_text,          
        scales$q_5Likert_option_text,  
        scales$q_5Likert_option_text,          
        scales$q_5Likert_option_text,  
        scales$q_5Likert_option_text,          
        scales$q_5Likert_option_text,  
        scales$q_5Likert_option_text, 
        # scales$CrossIntersect_option_text,  
        scales$CrossIntersect_option_text,          
        scales$easy_5Likert_option_text,
        scales$freq5_option_text,          
        scales$q_5Likert_option_text
      ),
      pm_names[2:39]  
    )
    
    pm_numbers <- names(test_post_svy_copy)[-1]
    # pm_number <- gsub("^([0-9]+):.*", "\\1", pm_no)
    
    
    # Function to create metadata dataframe
    pm_data_dictionary <- function(name, scale, pm_number) {
      n <- length(scale)
      data.frame(
        PM_Number = c(pm_number, rep("", n - 1)),
        Variable = c(name, rep("", n - 1)),
        Value = 1:n,
        Description = scale,
        stringsAsFactors = FALSE
      )
    }
    
    # Create metadata using the mapping
    
    # data_dictionary_list <- lapply(names(variable_scale), function(name) {
    #   pm_data_dictionary(name, variable_scale[[name]])
    # })
    
    data_dictionary_list <- mapply(function(name, pm_number) {
      pm_data_dictionary(name, variable_scale[[name]], pm_number)
    }, names(variable_scale), pm_numbers, SIMPLIFY = FALSE)
    
    ## workbook sheet
    post_pm_variables <- do.call(rbind, data_dictionary_list)
    
    # Create a workbook and add sheets
    wb <- createWorkbook()
    addWorksheet(wb, "pre_survey_data")
    addWorksheet(wb, "pre_survey_dictionary")
    addWorksheet(wb, "post_survey_data")
    addWorksheet(wb, "post_survey_dictionary")
    
    
    # Write data to sheets
    writeData(wb, sheet = "pre_survey_data", x = sel_baseline_svy_df)
    writeData(wb, sheet = "pre_survey_dictionary", x = pre_pm_variables)
    # writeData(wb, sheet = "post_survey_data", x = test_base_svy_copy[-nrow(test_base_svy_copy), ])
    writeData(wb, sheet = "post_survey_data", x = test_post_svy_copy)
    writeData(wb, sheet = "post_survey_dictionary", x = post_pm_variables)
    

    # Save workbook
    saveWorkbook(wb, file, overwrite = TRUE)
    
    # write.csv(test_base_svy_copy, file, row.names = FALSE)
  }
)

# download Buffalo All Access app data file in CSV format  -------------
library(lubridate)
output$download_pm_ctp_input_data <- downloadHandler(
  filename = function() {
    rename <- paste0("ITS4US Bufflo Performance Measure Survey Buffalo All Access app Data_downloaded " , download_date_info, ".csv")
    rename
  },
  content = function(file) {
    etchtrip_dt <- as.data.table(etch_df_example) 
    setnames(etchtrip_dt, old = c("Depart Rounded", "Arrive Rounded"), new = c("Depart_Time", "Arrive_Time"))
    
    classify_time <- function(datetime) {
      time <- hour(datetime) + minute(datetime) / 60
      
      if (time >= 6.25 & time <= 10.0) {
        return("AM")
      } else if (time >= 10.25 & time <= 15.0) {
        return("MD")
      } else if (time >= 15.25 & time <= 22.0) {
        return("PM")
      } else {
        return("NT")
      }
    }
    etchtrip_dt[, Depart_Time := ymd_hms(Depart_Time, tz = "America/New_York")]
    etchtrip_dt[, Arrive_Time := ymd_hms(Arrive_Time, tz = "America/New_York")]
    etchtrip_dt[, Depart := sapply(Depart_Time, classify_time)]
    etchtrip_dt[, Arrive := sapply(Arrive_Time, classify_time)]
    
    etchtrip_dt[, Depart_Time := Depart]
    etchtrip_dt[, Arrive_Time := Arrive]
    etchtrip_dt[, Depart := NULL]
    etchtrip_dt[, Arrive := NULL]
    etchtrip_dt[, 'Origin Zip' := NULL]
    etchtrip_dt[, 'Destination Zip' := NULL]
    write.csv(etchtrip_dt, file, row.names = FALSE)
  }
)


# download pre_deploy_sample file in CSV format  -------------
output$download_pre_deploy_sample <- downloadHandler(
  filename = function() {
    rename <- paste0("ITS4US Bufflo Performance Measure Survey Sample (test) Data_downloaded " , download_date_info, ".csv")
    rename
  },
  content = function(file) {
    write.csv(sample_base_svy, file, row.names = FALSE)
  }
)