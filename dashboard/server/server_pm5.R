
pm_metrics_text <- c('The percent of Buffalo All Access app trips crossing at the relevant intersections <br> who use the smart signal remote activation function.',
                     'Self-reported fraction of people who cross at the relevant intersections <br> who use the Buffalo All Access app smart signal activation functionality.',
                     'Perceived ease of use and ratings of various aspects of <br> using the smart signals, using the RAPUUD method.',
                     'Self-reported frequency of crossing at the interesections <br> with smart signals.',
                     'Perceived safety of crossing the intersections <br> with smart signals.'
                     )

# create pm5 metrics data table ---
pm_metrics_dt <- data.table(pmid = 1:5, pm_metrics_label = gsub("<br> ", "", pm_metrics_text))

# Pre deployment survey

test_pre_svy_pm5 <- test_pre_svy[ , c(list(ID = as.character(ID)), 
                                      lapply(.SD, as.integer)),
                                  .SDcols = names(test_pre_svy)[7:8]]

test_pre_svy_melt <- melt.data.table(test_pre_svy_pm5, 
                                     id.vars = c("ID"),
                                     variable.name = "pmid",
                                     value.name = "id")

pm_sum_dt_pre <- test_pre_svy_melt[,.N, .(id, pmid)]
names(pm_sum_dt_pre)[3] = "Freq"

pm_sum_dt_pre1 <- merge(pm_sum_dt_pre[pmid %in% c("PM5_4")], freq5_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt_pre2 <- merge(pm_sum_dt_pre[pmid %in% c("PM5_5")], q_5Likert_option_text, by.x = "id",  by.y = "id", all.x = TRUE)

pm_sum_dt_pre1[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt_pre2[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]

pm_sum_dt_pre <- rbind(pm_sum_dt_pre1, pm_sum_dt_pre2)

## create a data table containing all PM metrics data
pm_all_pre_dt <- pm_sum_dt_pre[,.(pmid = as.integer(gsub("PM5_", "",pmid)), id, options, Freq, Freq_per)]
## change order based on pmid
pm_all_pre_dt <- pm_all_pre_dt[order(pmid),]

## merge with pm_metrics_dt to add metric labels ---
pm_all_pre_dt[pm_metrics_dt, pm_metrics_label := i.pm_metrics_label, on = "pmid"]
setcolorder(pm_all_pre_dt, c("pmid", "pm_metrics_label", "id", "options", "Freq", "Freq_per"))

pm_all_pre_df = data.frame(pm_all_pre_dt)
pm_all_pre_dt_5 <- pm_all_pre_dt


# Post deployment survey
test_post_svy_pm5 <- test_post_svy[, c(list(ID = as.character(ID)), 
                                     lapply(.SD, as.integer)),
                                   .SDcols = names(test_post_svy)[38:42]]
test_post_svy_melt <- melt.data.table(test_post_svy_pm5,
                                      id.vars = c("ID"),
                                      variable.name = "pmid",
                                      value.name = "id")

pm_sum_dt <- test_post_svy_melt[,.N, .(id, pmid)]
# setorder(pm_sum_dt, pmid, id)
names(pm_sum_dt)[3] = "Freq"
pm_sum_dt <- pm_sum_dt[complete.cases(pm_sum_dt),] #remove missing (NA) values

pm_sum_dt1 <- merge(pm_sum_dt[pmid %in% c("PM5_1")], q_yesno_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt2 <- merge(pm_sum_dt[pmid %in% c("PM5_2")], CrossIntersect_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt3 <- merge(pm_sum_dt[pmid %in% c("PM5_3")], easy_5Likert_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt4 <- merge(pm_sum_dt[pmid %in% c("PM5_4")], freq5_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt5 <- merge(pm_sum_dt[pmid %in% c("PM5_5")], q_5Likert_option_text, by.x = "id",  by.y = "id", all.x = TRUE)

pm_sum_dt1[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt2[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt3[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt4[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt5[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]

pm_sum_dt <- rbind(pm_sum_dt1, pm_sum_dt2, pm_sum_dt3, pm_sum_dt4, pm_sum_dt5)
pm_all_dt <- pm_sum_dt[,.(pmid = as.integer(gsub("PM5_", "",pmid)), id, options, Freq, Freq_per)]
pm_all_dt <- pm_all_dt[order(pmid),]

pm_all_dt[pm_metrics_dt, pm_metrics_label := i.pm_metrics_label, on = "pmid"]
setcolorder(pm_all_dt, c("pmid", "pm_metrics_label", "id", "options", "Freq", "Freq_per"))

pm_all_df = data.frame(pm_all_dt)
pm_all_dt_5 <- pm_all_dt
download_date_info = format(Sys.time(), "%Y-%m-%d")


# Combine pre and post survey

pm_all_pre_dt_com <- copy(pm_all_pre_dt)
names(pm_all_dt_com)
pm_all_pre_dt_com[, c("pm_metrics_label", "options"):= NULL]
setnames(pm_all_pre_dt_com, old = c("Freq", "Freq_per"), new = c("Count_pre", "Pre_survey"))

pm_all_dt_com <- pm_all_dt[pmid %in% c(4,5)]
setnames(pm_all_dt_com, old = c("Freq", "Freq_per"), new = c("Count_post", "Post_survey"))

combine_pm5_dt <- merge(pm_all_dt_com, pm_all_pre_dt_com, by = c("pmid", "id"), all.x = TRUE)
combine_pm5_df = as.data.frame(combine_pm5_dt)

## process data for download
pm_all_dt_com_full <- copy(pm_all_dt)
setnames(pm_all_dt_com_full, old = c("Freq", "Freq_per"), new = c("Count_post", "Post_survey"))

combine_pm5_dt_full <- merge(pm_all_dt_com_full, pm_all_pre_dt_com, by = c("pmid", "id"), all.x = TRUE)
pm5_summary_table <- combine_pm5_dt_full[, c("pmid", "pm_metrics_label", "options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]
pm5_summary_table[, Count_pre := as.character(Count_pre)]
pm5_summary_table[, Pre_survey := as.character(Pre_survey)]
pm5_summary_table[pmid < 4, c("Count_pre", "Pre_survey") := "NA"]
setnames(pm5_summary_table, old = c("pm_metrics_label", "options", "Count_pre", "Count_post", "Pre_survey", "Post_survey"),
         new = c("PM metrics label", "Response", "Count: pre-survey",  "Count: post-survey", "Percentage: pre-survey",  "Percentage: post-survey"))




# etch trip data

etch_pm5 <- sel_etch_trip_df[ , c(list(ID = as.character(ID)), 
                                  lapply(.SD, as.integer)),
                              .SDcols = names(sel_etch_trip_df)[4]]

etch_melt <- melt.data.table(etch_pm5, 
                             id.vars = c("ID"),
                             variable.name = "pmid",
                             value.name = "id")

pm_sum_dt_etch <- etch_melt[,.N, .(id, pmid)]
names(pm_sum_dt_etch)[3] = "Freq"

pm_sum_dt_etch <- merge(pm_sum_dt_etch[pmid %in% c("PM5_1")], q_yesno_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt_etch[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]

## create a data table containing all PM metrics data
pm_all_etch_dt <- pm_sum_dt_etch[,.(pmid = as.integer(gsub("PM5_", "",pmid)), id, options, Freq, Freq_per)]
## change order based on pmid
pm_all_etch_dt <- pm_all_etch_dt[order(pmid),]

## merge with pm_metrics_dt to add metric labels ---
pm_all_etch_dt[pm_metrics_dt, pm_metrics_label := i.pm_metrics_label, on = "pmid"]
setcolorder(pm_all_etch_dt, c("pmid", "pm_metrics_label", "id", "options", "Freq", "Freq_per"))

pm_all_etch_df = data.frame(pm_all_etch_dt)



# pm5.1_plot -----

pm5_1_colors <- c('#f94144', '#023e8a')
frequency_pm5_1 <- table(etch_pm5$PM5_1)
labels <- c("No", "Yes")
names(frequency_pm5_1) <- labels

pm5_1 <- plot_ly(labels = names(frequency_pm5_1),
                 values = as.vector(frequency_pm5_1),
                 type = "pie", marker = list(colors = pm5_1_colors,
                                             line = list(color = '#FFFFFF', width = 1)))

pm5_1 <- pm5_1 %>% layout(
  title = ""
)

pm5_1 <- pm5_1 %>% config(toImageButtonOptions = list(format= 'png',
                                                      filename= paste0('pm5_1 Ratings Chart_', download_date_info),
                                                      scale= 1 ))
output$pm5_1_plot <- renderPlotly({
  ggplotly(
    pm5_1
  )
})

output$pm5_table1 <- renderTable({
  frequency_table <- data.frame(Category = names(frequency_pm5_1), Frequency = as.vector(frequency_pm5_1))
  total <- sum(frequency_table$Frequency)
  frequency_table <- rbind(frequency_table, c("Total", total))
  colnames(frequency_table) <- c("Category", "Frequency")
  frequency_table
})


# pm5.2_plot ------
pm5_2_colors <- c('Yes, quite often' = '#023e8a',
                  'Yes, but not very often' = '#76c893',
                  'No, not at all' = '#f94144')
pm5_2 <- plot_ly(pm_all_df[pm_all_df$pmid==2,], labels = ~options, values = ~Freq_per , type = 'pie',
                 textposition = 'inside',
                 textinfo = 'label+percent',
                 insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'text',
                 # text = ~paste('', Freq_per, ' percentage'),
                 marker = list(colors = pm5_2_colors,
                               line = list(color = '#FFFFFF', width = 1)),
                 #The 'pull' attribute can also be used to create space between the sectors
                 showlegend = FALSE)
pm5_2 <- pm5_2 %>% layout(# title = '',
  xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
  yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

pm5_2 <- pm5_2 %>% config(toImageButtonOptions = list(format= 'png',
                                                      filename= paste0('pm5_2 Ratings Chart_', download_date_info),
                                                      scale= 1 ))

output$pm5_2_plot <- renderPlotly({
  ggplotly(
    pm5_2
  )
})

# pm5.2_table ------
pm5_2_data <- pm_all_df[pm_all_df$pmid == 2, c("options", "Freq", "Freq_per")]
colnames(pm5_2_data) <- c("Likert_Scale", "Count", "Percentage")

pm5_2_data$Likert_Scale <- factor(pm5_2_data$Likert_Scale, levels = CrossIntersect_option_text$options)
pm5_2_data <- pm5_2_data[order(pm5_2_data$Likert_Scale), ]

output$pm5_table2 <- renderDataTable({
  
  pm5_2_data
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)

# 
# pm5.3_plot (likert) ------
# pm5_3_colors <- c('f94144', '4895ef', 'fca311', '76c893', '023e8a')
pm5_3_colors <- c('very easy' = '#023e8a',
                  'easy' = '#4895ef',
                  'neutral' = '#76c893',
                  'difficult' = '#fca311',
                  'very difficult' = '#f94144')
pm5_3 <- plot_ly(pm_all_df[pm_all_df$pmid==3,], labels = ~options, values = ~Freq_per, sort = FALSE, type = 'pie',
                 textposition = 'inside',
                 textinfo = 'label+percent',
                 insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'text',
                 # text = ~paste('', Freq_per, ' percentage'),
                 marker = list(colors = pm5_3_colors,
                               line = list(color = '#FFFFFF', width = 1)),
                 #The 'pull' attribute can also be used to create space between the sectors
                 showlegend = FALSE)
pm5_3 <- pm5_3 %>% layout(# title = '',
  xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
  yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

pm5_3 <- pm5_3 %>% config(toImageButtonOptions = list(format= 'png',
                                                      filename= paste0('pm5_3 Ratings Chart_', download_date_info),
                                                      scale= 1 ))

output$pm5_3_plot <- renderPlotly({
  ggplotly(
    pm5_3
  )
})

# pm5.3_table ------
pm5_3_data <- pm_all_df[pm_all_df$pmid == 3, c("options", "Freq", "Freq_per")]
colnames(pm5_3_data) <- c("Likert_Scale", "Count", "Percentage")

pm5_3_data$Likert_Scale <- factor(pm5_3_data$Likert_Scale, levels = easy_5Likert_option_text$options)
pm5_3_data <- pm5_3_data[order(pm5_3_data$Likert_Scale), ]

output$pm5_table3 <- renderDataTable({

  pm5_3_data
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)


# # pm5.4_plot ------
# # pm5_4_colors <- c('f94144', '4895ef', 'fca311', '76c893', '023e8a')
# pm5_4_colors <- c("Every day or almost every day" = '#023e8a',
#                   "At least once a week" = '#4895ef',
#                   "At least once a month" = '#76c893',
#                   "Only once or twice" = '#fca311',
#                   "Not at all" = '#f94144')
# pm5_4 <- plot_ly(pm_all_df[pm_all_df$pmid==4,], labels = ~options, values = ~Freq_per, sort = FALSE, type = 'pie',
#                  textposition = 'inside',
#                  textinfo = 'label+percent',
#                  insidetextfont = list(color = '#FFFFFF'),
#                  hoverinfo = 'text',
#                  # text = ~paste('', Freq_per, ' percentage'),
#                  marker = list(colors = pm5_4_colors,
#                                line = list(color = '#FFFFFF', width = 1)),
#                  #The 'pull' attribute can also be used to create space between the sectors
#                  showlegend = FALSE)
# pm5_4 <- pm5_4 %>% layout(# title = '',
#   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
#   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
# 
# pm5_4 <- pm5_4 %>% config(toImageButtonOptions = list(format= 'png',
#                                                       filename= paste0('pm5_4 Ratings Chart_', download_date_info),
#                                                       scale= 1 ))
# 
# output$pm5_4_plot <- renderPlotly({
#   ggplotly(
#     pm5_4
#   )
# })
# 
# # pm5.4_table ------
# pm5_4_data <- pm_all_df[pm_all_df$pmid == 4, c("options", "Freq", "Freq_per")]
# colnames(pm5_4_data) <- c("Likert_Scale", "Count", "Percentage")
# 
# pm5_4_data$Likert_Scale <- factor(pm5_4_data$Likert_Scale, levels = freq5_option_text$options)
# pm5_4_data <- pm5_4_data[order(pm5_4_data$Likert_Scale), ]
# 
# output$pm5_table4 <- renderDataTable({
# 
#   pm5_4_data
# }, options = list(lengthMenu = c(5,10,15),
#                   searching = FALSE,
#                   pageLength = 5,
#                   dom = 't'), rownames=FALSE)

# # pm5.5_plot ------
# # pm5_5_colors <- c('f94144', '4895ef', 'fca311', '76c893', '023e8a')
# pm5_5_colors <- c('Strongly agree' = '#023e8a',
#                   'Somewhat agree' = '#4895ef',
#                   'Neither agree nor disagree' = '#76c893',
#                   'Somewhat disagree' = '#fca311',
#                   'Strongly disagree' = '#f94144')
# pm5_5 <- plot_ly(pm_all_df[pm_all_df$pmid==5,], labels = ~options, values = ~Freq_per, sort = FALSE, type = 'pie',
#                  textposition = 'inside',
#                  textinfo = 'label+percent',
#                  insidetextfont = list(color = '#FFFFFF'),
#                  hoverinfo = 'text',
#                  # text = ~paste('', Freq_per, ' percentage'),
#                  marker = list(colors = pm5_5_colors,
#                                line = list(color = '#FFFFFF', width = 1)),
#                  #The 'pull' attribute can also be used to create space between the sectors
#                  showlegend = FALSE)
# pm5_5 <- pm5_5 %>% layout(# title = '',
#   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
#   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
# 
# pm5_5 <- pm5_5 %>% config(toImageButtonOptions = list(format= 'png',
#                                                       filename= paste0('pm5_5 Ratings Chart_', download_date_info),
#                                                       scale= 1 ))
# 
# output$pm5_5_plot <- renderPlotly({
#   ggplotly(
#     pm5_5
#   )
# })
# 
# # pm5.5_table ------
# pm5_5_data <- pm_all_df[pm_all_df$pmid == 5, c("options", "Freq",  "Freq_per")]
# colnames(pm5_5_data) <- c("Likert_Scale", "Count",  "Percentage")
# 
# pm5_5_data$Likert_Scale <- factor(pm5_5_data$Likert_Scale, levels = q_5Likert_option_text$options)
# pm5_5_data <- pm5_5_data[order(pm5_5_data$Likert_Scale), ]
# 
# output$pm5_table5 <- renderDataTable({
#   
#   pm5_5_data
# }, options = list(lengthMenu = c(5,10,15),
#                   searching = FALSE,
#                   pageLength = 5,
#                   dom = 't'), rownames=FALSE)
# 




# pm5.4 pre vs post ----

pm5_4_com_data <- combine_pm5_df[combine_pm5_df$pmid == 4,
                                 c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]

pm5_4_com_data$options <- factor(pm5_4_com_data$options,
                                 levels = freq5_option_text$options)



pm5_4_com_fig <- plot_ly(pm5_4_com_data, x = ~options, y = ~Pre_survey,type = 'bar', name = 'Pre-survey', hoverinfo = "name+x+y",
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


output$pm5_4_plot_com <- renderPlotly({
  ggplotly(
    pm5_4_com_fig
  )
})

# pm5.4_table pre vs post ------
pm5_4_com_data <- combine_pm5_df[combine_pm5_df$pmid == 4,
                                 c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]
colnames(pm5_4_com_data) <- c("Likert_Scale", "Count: pre-survey",  "Count: post-survey", "Percentage: pre-survey",  "Percentage: post-survey")

pm5_4_com_data$Likert_Scale <- factor(pm5_4_com_data$Likert_Scale, levels = freq5_option_text$options)
pm5_4_com_data <- pm5_4_com_data[order(pm5_4_com_data$Likert_Scale), ]

output$pm5_table4 <- renderDataTable({
  
  pm5_4_com_data
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)

# pm5.5 pre vs post ----

pm5_5_com_data <- combine_pm5_df[combine_pm5_df$pmid == 5,
                             c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]

pm5_5_com_data$options <- factor(pm5_5_com_data$options,
                             levels = q_5Likert_option_text$options)



pm5_5_com_fig <- plot_ly(pm5_5_com_data, x = ~options, y = ~Pre_survey,type = 'bar', name = 'Pre-survey', hoverinfo = "name+x+y",
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


output$pm5_5_plot_com <- renderPlotly({
  ggplotly(
    pm5_5_com_fig
  )
})

# pm5.5_table pre vs post ------
pm5_5_com_data <- combine_pm5_df[combine_pm5_df$pmid == 5,
                                 c("options", "Count_pre", "Count_post", "Pre_survey", "Post_survey")]
colnames(pm5_5_com_data) <- c("Likert_Scale", "Count: pre-survey",  "Count: post-survey", "Percentage: pre-survey",  "Percentage: post-survey")

pm5_5_com_data$Likert_Scale <- factor(pm5_5_com_data$Likert_Scale, levels = q_5Likert_option_text$options)
pm5_5_com_data <- pm5_5_com_data[order(pm5_5_com_data$Likert_Scale), ]

output$pm5_table5 <- renderDataTable({
  
  pm5_5_com_data
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)

