# source(file.path("dashboard_config.R"))

# data process ------

pm_metrics_text <- c('Ease of making door-to-door trips to/from and <br> within the BNMC.',
                     'How safe door-to-door travel paths are for trips <br> to/from and within the BNMC, including level, <br> slip-resistant paths.',
                     'Availability of information for making trips to/from <br> and within the BNMC.',
                     'Usefulness of information for making trips to/from <br> and within the BNMC.',
                     'Ability to make trips using integrated transit services <br> to/from and within the BNMC.',
                     'Satisfaction with making a trip using the Buffalo All Access app app.'
                     )

# create pm1 metrics data table ---
pm_metrics_dt <- data.table(pmid = 1:6, pm_metrics_label = gsub("<br> ", "", pm_metrics_text))

# Pre deployment survey

test_pre_svy_pm1 <- test_pre_svy[ , c(list(ID = as.character(ID)), 
                                        lapply(.SD, as.integer)),
                                    .SDcols = names(test_pre_svy)[2:6]]

test_pre_svy_melt <- melt.data.table(test_pre_svy_pm1, 
                                      id.vars = c("ID"),
                                      variable.name = "pmid",
                                      value.name = "id")

pm_sum_dt_pre <- test_pre_svy_melt[,.N, .(id, pmid)]
names(pm_sum_dt_pre)[3] = "Freq"

pm_sum_dt_pre1 <- merge(pm_sum_dt_pre[pmid %in% c("PM1_1","PM1_2","PM1_3","PM1_5", "PM1_6")], q_5Likert_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt_pre2 <- merge(pm_sum_dt_pre[pmid %in% c("PM1_4")], q_5Likert_option_no_text, by.x = "id",  by.y = "id", all.x = TRUE)

pm_sum_dt_pre1[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt_pre2[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]

pm_sum_dt_pre <- rbind(pm_sum_dt_pre1, pm_sum_dt_pre2)

## create a data table containing all PM metrics data
pm_all_pre_dt <- pm_sum_dt_pre[,.(pmid = as.integer(gsub("PM1_", "",pmid)), id, options, Freq, Freq_per)]
## change order based on pmid
pm_all_pre_dt <- pm_all_pre_dt[order(pmid),]

## merge with pm_metrics_dt to add metric labels ---
pm_all_pre_dt[pm_metrics_dt, pm_metrics_label := i.pm_metrics_label, on = "pmid"]
setcolorder(pm_all_pre_dt, c("pmid", "pm_metrics_label", "id", "options", "Freq", "Freq_per"))

pm_all_pre_df = data.frame(pm_all_pre_dt)
pm_all_pre_dt_1 <- pm_all_pre_dt


# Post deployment survey
# test_post_svy_pm1 <- test_post_svy[ , c("ID", names(test_post_svy)[2:6]), with = FALSE]
# test_post_svy_pm1 <- test_post_svy[1:(nrow(test_post_svy) - 1), 
#                                    lapply(.SD, as.integer), 
#                                    .SDcols = c("ID", names(test_post_svy)[2:6])]
test_post_svy_pm1 <- test_post_svy[ , c(list(ID = as.character(ID)), 
                                     lapply(.SD, as.integer)),
                                   .SDcols = names(test_post_svy)[2:6]]

test_post_svy_melt <- melt.data.table(test_post_svy_pm1, 
                                      id.vars = c("ID"),
                                      variable.name = "pmid",
                                      value.name = "id")

pm_sum_dt <- test_post_svy_melt[,.N, .(id, pmid)]
names(pm_sum_dt)[3] = "Freq"

pm_sum_dt1 <- merge(pm_sum_dt[pmid %in% c("PM1_1","PM1_2","PM1_3","PM1_5", "PM1_6")], q_5Likert_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt2 <- merge(pm_sum_dt[pmid %in% c("PM1_4")], q_5Likert_option_no_text, by.x = "id",  by.y = "id", all.x = TRUE)

pm_sum_dt1[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt2[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]

pm_sum_dt <- rbind(pm_sum_dt1, pm_sum_dt2)

## create a data table containing all PM metrics data
pm_all_dt <- pm_sum_dt[,.(pmid = as.integer(gsub("PM1_", "",pmid)), id, options, Freq, Freq_per)]
## change order based on pmid
pm_all_dt <- pm_all_dt[order(pmid),]

## merge with pm_metrics_dt to add metric labels ---
pm_all_dt[pm_metrics_dt, pm_metrics_label := i.pm_metrics_label, on = "pmid"]
setcolorder(pm_all_dt, c("pmid", "pm_metrics_label", "id", "options", "Freq", "Freq_per"))

pm_all_df = data.frame(pm_all_dt)
pm_all_dt_1 <- pm_all_dt
download_date_info = format(Sys.time(), "%Y-%m-%d")


# Combine pre and post survey

pm_all_pre_dt_com <- copy(pm_all_pre_dt)
# names(pm_all_dt_com)
pm_all_pre_dt_com[, c("pm_metrics_label", "options"):= NULL]
setnames(pm_all_pre_dt_com, old = c("Freq", "Freq_per"), new = c("Count_pre", "Pre_survey"))

pm_all_dt_com <- copy(pm_all_dt)
setnames(pm_all_dt_com, old = c("Freq", "Freq_per"), new = c("Count_post", "Post_survey"))

combine_pm1_dt <- merge(pm_all_dt_com, pm_all_pre_dt_com, by = c("pmid", "id"), all.x = TRUE)
combine_pm1_df = as.data.frame(combine_pm1_dt)

## process data for download
pm1_summary_table <- combine_pm1_dt[, c("pmid", "pm_metrics_label", "options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]
setnames(pm1_summary_table, old = c("pm_metrics_label", "options", "Count_pre", "Count_post", "Pre_survey", "Post_survey"),
         new = c("PM metrics label", "Response", "Count: pre-survey",  "Count: post-survey", "Percentage: pre-survey",  "Percentage: post-survey"))


# etch trip data

etch_pm1 <- sel_etch_trip_df[ , c(list(ID = as.character(ID)), 
                                      lapply(.SD, as.integer)),
                                  .SDcols = names(sel_etch_trip_df)[2]]

etch_melt <- melt.data.table(etch_pm1, 
                                     id.vars = c("ID"),
                                     variable.name = "pmid",
                                     value.name = "id")

pm_sum_dt_etch <- etch_melt[,.N, .(id, pmid)]
names(pm_sum_dt_etch)[3] = "Freq"

pm_sum_dt_etch <- merge(pm_sum_dt_etch[pmid %in% c("PM1_6")], satisfy_5Likert_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt_etch[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]

## create a data table containing all PM metrics data
pm_all_etch_dt <- pm_sum_dt_etch[,.(pmid = as.integer(gsub("PM1_", "",pmid)), id, options, Freq, Freq_per)]
## change order based on pmid
pm_all_etch_dt <- pm_all_etch_dt[order(pmid),]

## merge with pm_metrics_dt to add metric labels ---
pm_all_etch_dt[pm_metrics_dt, pm_metrics_label := i.pm_metrics_label, on = "pmid"]
setcolorder(pm_all_etch_dt, c("pmid", "pm_metrics_label", "id", "options", "Freq", "Freq_per"))

pm_all_etch_df = data.frame(pm_all_etch_dt)


# pm1.1 pre vs post survey ----

pm1_1_data <- combine_pm1_df[combine_pm1_df$pmid == 1, 
                             c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]

pm1_1_data$options <- factor(pm1_1_data$options, 
                                levels = q_5Likert_option_text$options)



pm1_1_fig <- plot_ly(pm1_1_data, x = ~options, y = ~Pre_survey,type = 'bar', name = 'Pre-survey', hoverinfo = "name+x+y", 
                     text = ~Pre_survey, textposition = 'middle', textfont = list(color = 'white'),  marker = list(color = '#023e8a'))%>%
  add_trace(y = ~Post_survey, name = 'Post-survey', text = ~Post_survey, textposition = 'inside', textfont = list(color = 'white'),
            marker = list(color = '#fca311'))%>%
  layout(yaxis = list(title = 'Percentage'), 
         xaxis = list(title = ''), barmode = 'group', legend= list(
           orientation = 'h',
           x = 0.5,
           xanchor = 'center',
           y= -0.35
         ))


output$pm1_1_plot <- renderPlotly({
  ggplotly(
    pm1_1_fig
  )
})

# pm1.1_table pre vs post ------
pm1_1_data <- combine_pm1_df[combine_pm1_df$pmid == 1,
                                 c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]
colnames(pm1_1_data) <- c("Likert_Scale", "Count: pre-survey",  "Count: post-survey", "Percentage: pre-survey",  "Percentage: post-survey")

pm1_1_data$Likert_Scale <- factor(pm1_1_data$Likert_Scale, levels = q_5Likert_option_text$options)
pm1_1_data <- pm1_1_data[order(pm1_1_data$Likert_Scale), ]

output$pm1_table1 <- renderDataTable({
  
  pm1_1_data
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)

# pm1.2 pre vs post ----

pm1_2_data <- combine_pm1_df[combine_pm1_df$pmid == 2, 
                             c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]

pm1_2_data$options <- factor(pm1_2_data$options, 
                             levels = q_5Likert_option_text$options)



pm1_2_fig <- plot_ly(pm1_2_data, x = ~options, y = ~Pre_survey,type = 'bar', name = 'Pre-survey', hoverinfo = "name+x+y", 
                     text = ~Pre_survey, textposition = 'middle', textfont = list(color = 'white'),  marker = list(color = '#023e8a'))%>%
  add_trace(y = ~Post_survey, name = 'Post-survey', text = ~Post_survey, textposition = 'inside', textfont = list(color = 'white'),
            marker = list(color = '#fca311'))%>%
  layout(yaxis = list(title = 'Percentage'), 
         xaxis = list(title = ''), barmode = 'group', legend= list(
           orientation = 'h',
           x = 0.5,
           xanchor = 'center',
           y= -0.35
         ))


output$pm1_2_plot <- renderPlotly({
  ggplotly(
    pm1_2_fig
  )
})

# pm1.2_table pre vs post ------
pm1_2_data <- combine_pm1_df[combine_pm1_df$pmid == 2,
                             c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]
colnames(pm1_2_data) <- c("Likert_Scale", "Count: pre-survey",  "Count: post-survey", "Percentage: pre-survey",  "Percentage: post-survey")

pm1_2_data$Likert_Scale <- factor(pm1_2_data$Likert_Scale, levels = q_5Likert_option_text$options)
pm1_2_data <- pm1_2_data[order(pm1_2_data$Likert_Scale), ]

output$pm1_table2 <- renderDataTable({
  
  pm1_2_data
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)


# pm1.3 pre vs post----

pm1_3_data <- combine_pm1_df[combine_pm1_df$pmid == 3, 
                             c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]

pm1_3_data$options <- factor(pm1_3_data$options, 
                             levels = q_5Likert_option_text$options)



pm1_3_fig <- plot_ly(pm1_3_data, x = ~options, y = ~Pre_survey,type = 'bar', name = 'Pre-survey', hoverinfo = "name+x+y", 
                     text = ~Pre_survey, textposition = 'middle', textfont = list(color = 'white'),  marker = list(color = '#023e8a'))%>%
  add_trace(y = ~Post_survey, name = 'Post-survey', text = ~Post_survey, textposition = 'inside', textfont = list(color = 'white'),
            marker = list(color = '#fca311'))%>%
  layout(yaxis = list(title = 'Percentage'), 
         xaxis = list(title = ''), barmode = 'group', legend= list(
           orientation = 'h',
           x = 0.5,
           xanchor = 'center',
           y= -0.35
         ))


output$pm1_3_plot <- renderPlotly({
  ggplotly(
    pm1_3_fig
  )
})

# pm1.3_table pre vs post ------
pm1_3_data <- combine_pm1_df[combine_pm1_df$pmid == 3,
                             c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]
colnames(pm1_3_data) <- c("Likert_Scale", "Count: pre-survey",  "Count: post-survey", "Percentage: pre-survey",  "Percentage: post-survey")

pm1_3_data$Likert_Scale <- factor(pm1_3_data$Likert_Scale, levels = q_5Likert_option_text$options)
pm1_3_data <- pm1_3_data[order(pm1_3_data$Likert_Scale), ]

output$pm1_table3 <- renderDataTable({
  
  pm1_3_data
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)

# pm1.4 ----

pm1_4_data <- combine_pm1_df[combine_pm1_df$pmid == 4, 
                             c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]

pm1_4_data$options <- factor(pm1_4_data$options, 
                             levels = q_5Likert_option_no_text$options)



pm1_4_fig <- plot_ly(pm1_4_data, x = ~options, y = ~Pre_survey,type = 'bar', name = 'Pre-survey', hoverinfo = "name+x+y", 
                     text = ~Pre_survey, textposition = 'middle', textfont = list(color = 'white'),  marker = list(color = '#023e8a'))%>%
  add_trace(y = ~Post_survey, name = 'Post-survey', text = ~Post_survey, textposition = 'inside', textfont = list(color = 'white'),
            marker = list(color = '#fca311'))%>%
  layout(yaxis = list(title = 'Percentage'), 
         xaxis = list(title = '',
                      tickvals = ~options,
                      ticktext = c("Strongly agree", "Somewhat agree", "Neither agree nor disagree", "Strongly agree", 
                                   "Somewhat agree", "I have not used public <br>transportation to travel <br>to/from the BNMC")), 
         barmode = 'group', legend= list(
           orientation = 'h',
           x = 0.5,
           xanchor = 'center',
           y= -0.35
         ))


output$pm1_4_plot <- renderPlotly({
  ggplotly(
    pm1_4_fig
  )
})

# pm1.4_table pre vs post ------
pm1_4_data <- combine_pm1_df[combine_pm1_df$pmid == 4,
                             c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]
colnames(pm1_4_data) <- c("Likert_Scale", "Count: pre-survey",  "Count: post-survey", "Percentage: pre-survey",  "Percentage: post-survey")

pm1_4_data$Likert_Scale <- factor(pm1_4_data$Likert_Scale, levels = q_5Likert_option_no_text$options)
pm1_4_data <- pm1_4_data[order(pm1_4_data$Likert_Scale), ]

output$pm1_table4 <- renderDataTable({
  
  pm1_4_data
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 6,
                  dom = 't'), rownames=FALSE)

# pm1.5 pre vs post ----

pm1_5_data <- combine_pm1_df[combine_pm1_df$pmid == 5, 
                             c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]

pm1_5_data$options <- factor(pm1_5_data$options, 
                             levels = q_5Likert_option_text$options)



pm1_5_fig <- plot_ly(pm1_5_data, x = ~options, y = ~Pre_survey,type = 'bar', name = 'Pre-survey', hoverinfo = "name+x+y", 
                     text = ~Pre_survey, textposition = 'middle', textfont = list(color = 'white'),  marker = list(color = '#023e8a'))%>%
  add_trace(y = ~Post_survey, name = 'Post-survey', text = ~Post_survey, textposition = 'inside', textfont = list(color = 'white'),
            marker = list(color = '#fca311'))%>%
  layout(yaxis = list(title = 'Percentage'), 
         xaxis = list(title = ''), barmode = 'group', legend= list(
           orientation = 'h',
           x = 0.5,
           xanchor = 'center',
           y= -0.35
         ))


output$pm1_5_plot <- renderPlotly({
  ggplotly(
    pm1_5_fig
  )
})

# pm1.5_table pre vs post ------
pm1_5_data <- combine_pm1_df[combine_pm1_df$pmid == 5,
                             c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]
colnames(pm1_5_data) <- c("Likert_Scale", "Count: pre-survey",  "Count: post-survey", "Percentage: pre-survey",  "Percentage: post-survey")

pm1_5_data$Likert_Scale <- factor(pm1_5_data$Likert_Scale, levels = q_5Likert_option_text$options)
pm1_5_data <- pm1_5_data[order(pm1_5_data$Likert_Scale), ]

output$pm1_table5 <- renderDataTable({
  
  pm1_5_data
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)

# pm1.6 ------

pm1_6_colors <- c('Very satisfied' = '#023e8a',
                  'Satisfied' = '#4895ef',
                  'Neutral' = '#76c893',
                  'Unsatisfied' = '#fca311',
                  'Very unsatisfied' = '#f94144')
pm1_6 <- plot_ly(pm_all_etch_df[pm_all_etch_df$pmid==6,], labels = ~options, values = ~Freq_per, sort = FALSE, type = 'pie',
                 textposition = 'inside',
                 textinfo = 'label+percent',
                 insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'text',
                 # text = ~paste('', Freq_per, ' percentage'),
                 marker = list(colors = pm1_6_colors,
                               line = list(color = '#FFFFFF', width = 1)),
                 #The 'pull' attribute can also be used to create space between the sectors
                 showlegend = FALSE)
pm1_6 <- pm1_6 %>% layout(# title = '',
  xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
  yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

pm1_6 <- pm1_6 %>% config(toImageButtonOptions = list(format= 'png',
                                                      filename= paste0('pm5_3 Ratings Chart_', download_date_info),
                                                      scale= 1 ))

output$pm1_6_plot <- renderPlotly({
  ggplotly(
    pm1_6
  )
})

# pm1.6_table ------
pm1_6_data <- pm_all_etch_df[pm_all_etch_df$pmid == 6, c("options", "Freq", "Freq_per")]
colnames(pm1_6_data) <- c("Likert_Scale", "Count", "Percentage")

pm1_6_data$Likert_Scale <- factor(pm1_6_data$Likert_Scale, levels = satisfy_5Likert_option_text$options)
pm1_6_data <- pm1_6_data[order(pm1_6_data$Likert_Scale), ]

output$pm1_table6 <- renderDataTable({
  
  pm1_6_data
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)





