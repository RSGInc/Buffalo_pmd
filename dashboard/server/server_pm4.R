pm_metrics_text <- c('The fraction of Buffalo All Access app users who elect to receive <br> <b>outdoor</b> wayfinding notifications.',
                     'Frequency of using outdoor wayfinding notifications.',
                     'The fraction of Buffalo All Access app users who elect to receive <b>indoor</b> <br> wayfinding notifications.',
                     'Frequency of using indoor wayfinding notifications.',
                     'How useful the outdoor wayfinding functionality is in <br> reaching their trip destination on time.',
                     'How useful the indoor wayfinding functionality is in <br> reaching their trip destination on time.'
                     # 'System user ratings of various dimensions of using <br> the Buffalo All Access app outdoor wayfinding functionality using the RAPUUD method.',
                     # 'System user ratings of various dimensions of using the Buffalo All Access app <br> indoor wayfinding functionality using the RAPUUD method.'
                     )

# create pm4 metrics data table ---
pm_metrics_dt <- data.table(pmid = 1:6, pm_metrics_label = gsub("<br> ", "", pm_metrics_text))
test_post_svy_pm4 <- test_post_svy[, c(list(ID = as.character(ID)), 
                                     lapply(.SD, as.integer)),
                                   .SDcols = names(test_post_svy)[18:37]]

## melt the data to long format ---
test_post_svy_melt <- melt.data.table(test_post_svy_pm4[, -c(8:20), with = FALSE],
                                      id.vars = c("ID"),
                                      variable.name = "pmid",
                                      value.name = "id")

pm_sum_dt <- test_post_svy_melt[,.N, .(id, pmid)]
names(pm_sum_dt)[3] = "Freq"
pm_sum_dt <- pm_sum_dt[complete.cases(pm_sum_dt),] #remove missing (NA) values

pm_sum_dt1 <- merge(pm_sum_dt[pmid %in% c("PM4_1","PM4_3")], q_yesno_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt2 <- merge(pm_sum_dt[pmid %in% c("PM4_2", "PM4_4")], freq5_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt3 <- merge(pm_sum_dt[pmid %in% c("PM4_5", "PM4_6")], useful_5Likert_option_text, by.x = "id",  by.y = "id", all.x = TRUE)

pm_sum_dt1[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt2[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt3[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]

pm_sum_dt <- rbind(pm_sum_dt1, pm_sum_dt2, pm_sum_dt3)
pm_all_dt <- pm_sum_dt[,.(pmid = as.integer(gsub("PM4_", "",pmid)), id, options, Freq, Freq_per)]
pm_all_dt <- pm_all_dt[order(pmid),]

pm_all_dt[pm_metrics_dt, pm_metrics_label := i.pm_metrics_label, on = "pmid"]
setcolorder(pm_all_dt, c("pmid", "pm_metrics_label", "id", "options", "Freq", "Freq_per"))

pm_all_df = data.frame(pm_all_dt)

## melt the data to long format (for sub category) ---
pm78_metrics_text <- c('<b>This feature is easy to use.',
                       '<b>For me, using this feature poses a personal <br> safety risk.',
                       '<b>I often need assistance to use this feature.',
                       '<b>When using this feature, I make mistakes that <br> require me to do over some steps.',
                       '<b>Using this feature takes more time than it should.',
                       '<b>Using this feature requires minimal mental effort.',
                       '<b>Using this feature draws unwanted attention to me.')

pm_metrics_dt_sub <- data.table(pmid_sub = 1:7, pm_metrics_label_sub = gsub("<br> ", "", pm78_metrics_text))
test_post_svy_melt_sub <- melt.data.table(test_post_svy_pm4[, -c(2:7), with = FALSE],
                                      id.vars = c("ID"),
                                      variable.name = "pmid",
                                      value.name = "id")


pm_sum_dt_sub <- test_post_svy_melt_sub[,.N, .(id, pmid)]
names(pm_sum_dt_sub)[3] = "Freq"
pm_sum_dt_sub <- pm_sum_dt_sub[complete.cases(pm_sum_dt_sub),] #remove missing (NA) values

pm_sum_dt_sub <- merge(pm_sum_dt_sub, q_5Likert_option_text, by = 'id')
pm_sum_dt_sub[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_all_dt_sub <- pm_sum_dt_sub[,.(pmid = as.integer(sub("^PM4_(\\d+)_(\\d+)$", "\\1\\2", pmid)), id, options, Freq, Freq_per)]
pm_all_dt_sub <- pm_all_dt_sub[order(pmid),]



# pm_all_dt_sub[, pmid_prefix := as.integer(substr(pmid, 1, 1))] # Extract prefix into a new column
# pm_all_dt_sub[pm_metrics_dt_sub, pm_metrics_label_sub := i.pm_metrics_label_sub, on = .(pmid = suffix, pmid = pmid)]
pm_all_dt_sub[, pmid_sub := as.integer(substr(pmid, 2, nchar(pmid)))]
pm_all_dt_sub[pm_metrics_dt_sub, pm_metrics_label_sub := i.pm_metrics_label_sub,on = "pmid_sub"]

setcolorder(pm_all_dt_sub, c("pmid", "pm_metrics_label_sub", "id", "options", "Freq", "Freq_per"))
# pm_all_dt_sub <- pm_all_dt_sub[order(pmid, pmd_5likert_value)]
pm_all_dt_sub[, pmid_sub := NULL]

pm_all_df_sub = data.frame(pm_all_dt_sub)

#summary pm4 data table
pm_all_sub_table <- pm_all_df_sub

setnames(pm_all_sub_table, old = c("pm_metrics_label_sub"), new = c( "pm_metrics_label"))
pm_all_df_4 <- rbind(pm_all_df, pm_all_sub_table)

download_date_info = format(Sys.time(), "%Y-%m-%d")

## process data for download
pm4_summary_table <- pm_all_df_4[, c("pmid", "pm_metrics_label", "options", "Freq", "Freq_per")]
pm4_summary_table$pm_metrics_label <- gsub("<b>","",pm4_summary_table$pm_metrics_label)
setnames(pm4_summary_table, old = c("pm_metrics_label", "options", "Freq", "Freq_per"),
         new = c("PM metrics label", "Response", "Count",  "Percentage"))



# pm4.1_plot ----
pm4_1_colors <- c('#f94144', '#023e8a')
frequency_pm4_1 <- table(test_post_svy_pm4$PM4_1)
labels <- c("Yes", "No")
names(frequency_pm4_1) <- labels

no_percent <- frequency_pm4_1["No"]/sum(frequency_pm4_1) * 100
yes_percent <- frequency_pm4_1["Yes"]/sum(frequency_pm4_1) * 100

pm4_1 <- plot_ly(x = c("No", "Yes"),
                 y = c(no_percent, yes_percent),
                 type = "bar",
                 marker = list(color = pm4_1_colors))


pm4_1 <- pm4_1 %>% layout(
  # title = "Responses Distribution",
  xaxis = list(title = "Response"),
  yaxis = list(title = "Percentage"),
  barmode = "stack"
)


pm4_1 <- pm4_1 %>% config(toImageButtonOptions = list(format= 'png',
                                                      filename= paste0('pm4_1 Ratings Chart_', download_date_info),
                                                      scale= 1 ))
output$pm4_1_plot <- renderPlotly({
  ggplotly(
    pm4_1
  )
})

output$pm4_table1 <- renderTable({
  frequency_table <- data.frame(Category = names(frequency_pm4_1), Frequency = as.vector(frequency_pm4_1))
  total <- sum(frequency_table$Frequency)
  frequency_table <- rbind(frequency_table, c("Total", total))
  colnames(frequency_table) <- c("Category", "Frequency")
  frequency_table
})


# pm4.3_plot ----
pm4_3_colors <- c('#f94144', '#023e8a')
frequency_pm4_3 <- table(test_post_svy_pm4$PM4_3)
labels <- c("Yes", "No")
names(frequency_pm4_3) <- labels

no_percent <- frequency_pm4_3["No"]/sum(frequency_pm4_3) * 100
yes_percent <- frequency_pm4_3["Yes"]/sum(frequency_pm4_3) * 100

pm4_3 <- plot_ly(x = c("No", "Yes"),
                 y = c(no_percent, yes_percent),
                 type = "bar",
                 marker = list(color = pm4_3_colors))


pm4_3 <- pm4_3 %>% layout(
  # title = "Responses Distribution",
  xaxis = list(title = "Response"),
  yaxis = list(title = "Percentage"),
  barmode = "stack"
)


pm4_3 <- pm4_3 %>% config(toImageButtonOptions = list(format= 'png',
                                                      filename= paste0('pm4_3 Ratings Chart_', download_date_info),
                                                      scale= 1 ))
output$pm4_3_plot <- renderPlotly({
  ggplotly(
    pm4_3
  )
})

output$pm4_table3 <- renderTable({
  frequency_table <- data.frame(Category = names(frequency_pm4_3), Frequency = as.vector(frequency_pm4_3))
  total <- sum(frequency_table$Frequency)
  frequency_table <- rbind(frequency_table, c("Total", total))
  colnames(frequency_table) <- c("Category", "Frequency")
  frequency_table
})

# pm4_freq5_all_plot ------
pm4_dt <- dcast.data.table(pm_all_dt[pmid %in% c(2,4)], pmid ~ id, value.var = "Freq_per")
colnames(pm4_dt)[2:6] = paste0("x", names(pm4_dt)[2:6])
pm_metrics_text_plot1 <- pm_metrics_text[c(2, 4)]
pm4_dt = cbind(pm_metrics_text_plot1, pm4_dt)
setnames(pm4_dt, "pm_metrics_text_plot1", "pm_metrics")
pm4_dt$pm_metrics = factor(pm4_dt$pm_metrics, levels= rev(pm4_dt$pm_metrics) )
# str(pm4_dt)

pm4_df = data.frame(pm4_dt)

pm4_all <- plot_ly(pm4_df, x = ~x1, y = ~pm_metrics, type = 'bar', orientation = 'h', name = 'Every day or almost every day', hoverinfo = 'name+x', height = 190,
                   marker = list(color = '#023e8a', 
                                 line = list(color = 'rgb(248, 248, 249)', width = 1)))
pm4_all <- pm4_all %>% add_trace(x = ~x2, marker = list(color = '#4895ef'), name = 'At least once a week') 
pm4_all <- pm4_all %>% add_trace(x = ~x3, marker = list(color = '#76c893'), name = 'At least once a month') 
pm4_all <- pm4_all %>% add_trace(x = ~x4, marker = list(color = '#fca311'), name = 'Only once or twice') 
pm4_all <- pm4_all %>% add_trace(x = ~x5, marker = list(color = '#f94144'), name = 'Not at all') 
pm4_all <- pm4_all %>% layout(xaxis = list(title = "",
                                           showgrid = FALSE,
                                           showline = FALSE,
                                           showticklabels = FALSE,
                                           zeroline = FALSE,
                                           domain = c(0.15, 1)),
                              yaxis = list(title = "",
                                           showgrid = FALSE,
                                           showline = FALSE,
                                           showticklabels = FALSE,
                                           zeroline = FALSE),
                              barmode = 'stack',
                              paper_bgcolor = 'rgb(248, 248, 255)', plot_bgcolor = 'rgb(248, 248, 255)',
                              margin = list(l = 140, r = 10, t = 60, b = 10),
                              showlegend = FALSE) 

# labeling the y-axis
pm4_all <- pm4_all %>% add_annotations(xref = 'paper', yref = 'y', x = 0.14, y = pm_metrics_text[c(2, 4)],
                                       xanchor = 'right',
                                       text = pm_metrics_text[c(2, 4)],
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(67, 67, 67)'),
                                       showarrow = FALSE, align = 'right') 

# labeling the percentages of each bar (x_axis)
x1_loc <- pm4_df[,"x1"]/2
pm4_all <- pm4_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x1_loc, # y = pm_metrics_text,
                                       text = paste(pm4_df[,"x1"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 
x2_loc <- pm4_df[, "x1"] + pm4_df[, "x2"] /2
pm4_all <- pm4_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x2_loc, # y = pm_metrics_text,
                                       text = paste(pm4_df[,"x2"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 
x3_loc <- pm4_df[, "x1"] + pm4_df[, "x2"] + pm4_df[, "x3"] /2
pm4_all <- pm4_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x3_loc, # y = pm_metrics_text,
                                       text = paste(pm4_df[,"x3"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 
x4_loc <- pm4_df[, "x1"] + pm4_df[, "x2"] + pm4_df[, "x3"] + pm4_df[, "x4"] /2
pm4_all <- pm4_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x4_loc, # y = pm_metrics_text,
                                       text = paste(pm4_df[,"x4"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 
x5_loc <- pm4_df[, "x1"] + pm4_df[, "x2"] + pm4_df[, "x3"] + pm4_df[, "x4"]  + pm4_df[, "x5"] /2
pm4_all <- pm4_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x5_loc, # y = pm_metrics_text,
                                       text = paste(pm4_df[,"x5"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 

rm(x1_loc, x2_loc, x3_loc, x4_loc, x5_loc)

# labeling the first Likert scale (on the top)
pm4_all <- pm4_all %>% add_annotations(xref = 'x', yref = 'paper',
                                       x = c(8, 28, 48, 68, 90),
                                       y = 1.35,
                                       text = freq5_option_text$options,
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(67, 67, 67)'),
                                       showarrow = FALSE)

pm4_all <- pm4_all %>% config(toImageButtonOptions = list(format= 'png', # one of png, svg, jpeg, webp
                                                          filename= paste0('pm4 All Ratings Chart_', download_date_info), 
                                                          scale= 1 ))
output$pm4_all_plot <- renderPlotly({
  ggplotly(
    pm4_all
  )
})

# pm4freq_all table output 
pm4_all_freq_dt <- dcast.data.table(pm_all_dt[pmid %in% c(2,4)], pmid ~ id, value.var = "Freq")
colnames(pm4_all_freq_dt)[2:6] = paste0("x", names(pm4_all_freq_dt)[2:6])
pm_metrics_text_plot1 <- pm_metrics_text[c(2,4)]
pm4_all_freq_dt = cbind(pm_metrics_text_plot1, pm4_all_freq_dt)
pm4_all_freq_dt[, pm_metrics_text_plot1 := gsub("<br>", "", pm_metrics_text_plot1, fixed = TRUE)]
pm4_all_freq_dt[, pm_metrics_text_plot1 := gsub("<b>", "", pm_metrics_text_plot1, fixed = TRUE)]
pm4_all_freq_dt[, pm_metrics_text_plot1 := gsub("</b>", "", pm_metrics_text_plot1, fixed = TRUE)]
pm4_all_freq_dt[, pmid:= NULL]
pm4_all_freq_dt[, Total := rowSums(.SD, na.rm = TRUE), .SDcols = c("x1", "x2", "x3", "x4", "x5")]
pm4_all_freq_df = data.frame(pm4_all_freq_dt)
setnames(pm4_all_freq_df, old = c("pm_metrics_text_plot1", "x1", "x2", "x3", "x4", "x5"),
         new = c("PM","Every day or almost every day", "At least once a week", "At least once a month", "Only once or twice", "Not at all"))

output$pm4_all_table1 <- renderDataTable({
  
  pm4_all_freq_df
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)

# pm4_useful_all_plot ------
pm4u_dt <- dcast.data.table(pm_all_dt[pmid %in% c(5,6)], pmid ~ id, value.var = "Freq_per")
colnames(pm4u_dt)[2:6] = paste0("x", names(pm4u_dt)[2:6])
pm_metrics_text_plot1 <- pm_metrics_text[c(5, 6)]
pm4u_dt = cbind(pm_metrics_text_plot1, pm4u_dt)
setnames(pm4u_dt, "pm_metrics_text_plot1", "pm_metrics")
pm4u_dt$pm_metrics = factor(pm4u_dt$pm_metrics, levels= rev(pm4u_dt$pm_metrics) )
# str(pm4u_dt)

pm4u_df = data.frame(pm4u_dt)

pm4u_all <- plot_ly(pm4u_df, x = ~x1, y = ~pm_metrics, type = 'bar', orientation = 'h', name = 'Very useful', hoverinfo = 'name+x', height = 190,
                    marker = list(color = '#023e8a', 
                                  line = list(color = 'rgb(248, 248, 249)', width = 1)))
pm4u_all <- pm4u_all %>% add_trace(x = ~x2, marker = list(color = '#4895ef'), name = 'Useful') 
pm4u_all <- pm4u_all %>% add_trace(x = ~x3, marker = list(color = '#76c893'), name = 'Neutral') 
pm4u_all <- pm4u_all %>% add_trace(x = ~x4, marker = list(color = '#fca311'), name = 'Not very useful') 
pm4u_all <- pm4u_all %>% add_trace(x = ~x5, marker = list(color = '#f94144'), name = 'Not useful at all') 
pm4u_all <- pm4u_all %>% layout(xaxis = list(title = "",
                                             showgrid = FALSE,
                                             showline = FALSE,
                                             showticklabels = FALSE,
                                             zeroline = FALSE,
                                             domain = c(0.15, 1)),
                                yaxis = list(title = "",
                                             showgrid = FALSE,
                                             showline = FALSE,
                                             showticklabels = FALSE,
                                             zeroline = FALSE),
                                barmode = 'stack',
                                paper_bgcolor = 'rgb(248, 248, 255)', plot_bgcolor = 'rgb(248, 248, 255)',
                                margin = list(l = 140, r = 10, t = 60, b = 10),
                                showlegend = FALSE) 

# labeling the y-axis
pm4u_all <- pm4u_all %>% add_annotations(xref = 'paper', yref = 'y', x = 0.14, y = pm_metrics_text[c(5, 6)],
                                         xanchor = 'right',
                                         text = pm_metrics_text[c(5, 6)],
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(67, 67, 67)'),
                                         showarrow = FALSE, align = 'right') 

# labeling the percentages of each bar (x_axis)
x1_loc <- pm4u_df[,"x1"]/2
pm4u_all <- pm4u_all %>% add_annotations(xref = 'x', yref = 'y',
                                         x = x1_loc, # y = pm_metrics_text,
                                         text = paste(pm4u_df[,"x1"], '%'),
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(248, 248, 255)'),
                                         showarrow = FALSE) 
x2_loc <- pm4u_df[, "x1"] + pm4u_df[, "x2"] /2
pm4u_all <- pm4u_all %>% add_annotations(xref = 'x', yref = 'y',
                                         x = x2_loc, # y = pm_metrics_text,
                                         text = paste(pm4u_df[,"x2"], '%'),
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(248, 248, 255)'),
                                         showarrow = FALSE) 
x3_loc <- pm4u_df[, "x1"] + pm4u_df[, "x2"] + pm4u_df[, "x3"] /2
pm4u_all <- pm4u_all %>% add_annotations(xref = 'x', yref = 'y',
                                         x = x3_loc, # y = pm_metrics_text,
                                         text = paste(pm4u_df[,"x3"], '%'),
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(248, 248, 255)'),
                                         showarrow = FALSE) 
x4_loc <- pm4u_df[, "x1"] + pm4u_df[, "x2"] + pm4u_df[, "x3"] + pm4u_df[, "x4"] /2
pm4u_all <- pm4u_all %>% add_annotations(xref = 'x', yref = 'y',
                                         x = x4_loc, # y = pm_metrics_text,
                                         text = paste(pm4u_df[,"x4"], '%'),
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(248, 248, 255)'),
                                         showarrow = FALSE) 
x5_loc <- pm4u_df[, "x1"] + pm4u_df[, "x2"] + pm4u_df[, "x3"] + pm4u_df[, "x4"]  + pm4u_df[, "x5"] /2
pm4u_all <- pm4u_all %>% add_annotations(xref = 'x', yref = 'y',
                                         x = x5_loc, # y = pm_metrics_text,
                                         text = paste(pm4u_df[,"x5"], '%'),
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(248, 248, 255)'),
                                         showarrow = FALSE) 

rm(x1_loc, x2_loc, x3_loc, x4_loc, x5_loc)

# labeling the first Likert scale (on the top)
pm4u_all <- pm4u_all %>% add_annotations(xref = 'x', yref = 'paper',
                                         x = c(8, 28, 48, 68, 90),
                                         y = 1.35,
                                         text = useful_5Likert_option_text$options,
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(67, 67, 67)'),
                                         showarrow = FALSE)

pm4u_all <- pm4u_all %>% config(toImageButtonOptions = list(format= 'png', # one of png, svg, jpeg, webp
                                                            filename= paste0('pm4u All Ratings Chart_', download_date_info), 
                                                            scale= 1 ))
output$pm4u_all_plot <- renderPlotly({
  ggplotly(
    pm4u_all
  )
})

# pm4useful_all table output 
pm4_all_use_dt <- dcast.data.table(pm_all_dt[pmid %in% c(5,6)], pmid ~ id, value.var = "Freq")
colnames(pm4_all_use_dt)[2:6] = paste0("x", names(pm4_all_use_dt)[2:6])
pm_metrics_text_plot1 <- pm_metrics_text[c(5,6)]
pm4_all_use_dt = cbind(pm_metrics_text_plot1, pm4_all_use_dt)
pm4_all_use_dt[, pm_metrics_text_plot1 := gsub("<br>", "", pm_metrics_text_plot1, fixed = TRUE)]
pm4_all_use_dt[, pm_metrics_text_plot1 := gsub("<b>", "", pm_metrics_text_plot1, fixed = TRUE)]
pm4_all_use_dt[, pm_metrics_text_plot1 := gsub("</b>", "", pm_metrics_text_plot1, fixed = TRUE)]
pm4_all_use_dt[, pmid:= NULL]
pm4_all_use_dt[, Total := rowSums(.SD, na.rm = TRUE), .SDcols = c("x1", "x2", "x3", "x4", "x5")]
pm4_all_use_df = data.frame(pm4_all_use_dt)
setnames(pm4_all_use_df, old = c("pm_metrics_text_plot1", "x1", "x2", "x3", "x4", "x5"),
         new = c("PM","Very useful", "Useful", "Neutral", "Not very useful", "Not useful at all"))

output$pm4_all_table2 <- renderDataTable({
  
  pm4_all_use_df
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)

# pm4.7 and pm4.8 comparison ----
pm_all_df_sub$group <- ''
pm_all_df_sub[pm_all_df_sub$pmid %in% 71:77,]$group <- "outdoor"
pm_all_df_sub[pm_all_df_sub$pmid %in% 81:87,]$group <- "indoor"

pm_all_df_sub$options <- factor(pm_all_df_sub$options,
                                levels = rev(q_5Likert_option_text$options))

combine_plot2 <- ggplot(pm_all_df_sub, aes(x = Freq_per, y = group, fill = options)) +
  geom_bar(stat = 'identity', position = 'stack', width = 0.8) +
  facet_wrap(~ pm_metrics_label, ncol = 1, scales = "free_y") +
  scale_fill_manual(values = c("Strongly agree" = "#023e8a",
                               "Somewhat agree" = "#4895ef",
                               "Neither agree nor disagree" = "#76c893",
                               "Somewhat disagree" = "#fca311",
                               "Strongly disagree" = "#f94144")) +
  geom_text(aes(label = Freq_per), position = position_stack(vjust = 0.5), color = "white", size = 3) +
  theme(legend.position = "bottom", axis.title.x = element_blank(), axis.title.y = element_blank(),
        panel.spacing = unit(0.3, "lines"))

group_plot2 <- ggplotly(combine_plot2, tooltip = c("x", "fill")) %>%
  layout(legend = list(
    orientation = "h",
    yanchor = "top",
    y = -0.1,
    xanchor = "center",
    x = 0.5,
    title = ""
  ))


output$combined_plot2 <- renderPlotly({
  group_plot2
})

# pm4.7 and pm4.8 comparison table ----

pm_all_df_sub_table <- copy(pm_all_df_sub)
pm_all_df_sub_table$pm_metrics_label <- gsub("<b>","",pm_all_df_sub_table$pm_metrics_label)
## separate the dataset into outdoor and indoor subsets
outdoor_df <- pm_all_df_sub_table %>% filter(group == "outdoor")
indoor_df <- pm_all_df_sub_table %>% filter(group == "indoor")

# merge two subsets
pm_all_sub_combined <- full_join(outdoor_df, indoor_df, by = c("id", "options", "pm_metrics_label"), suffix = c("_outdoor", "_indoor")) %>%
  select(pm_metrics_label, options, Freq_outdoor, Freq_indoor,
        Freq_per_outdoor, Freq_per_indoor) %>%
  mutate(across(c(Freq_outdoor, Freq_indoor, Freq_per_outdoor, Freq_per_indoor), ~replace_na(., 0)))

pm_all_sub_combined78 <- pm_all_sub_combined %>%
  group_by(pm_metrics_label) %>%
  mutate(pm_metrics_label = ifelse(row_number() == 1, pm_metrics_label, "")) %>%
  ungroup()
pm_all_sub_combined78 <- as.data.frame(pm_all_sub_combined78)

pm_all_sub_combined78 <- pm_all_sub_combined78[ c("pm_metrics_label","options", "Freq_outdoor", "Freq_indoor", "Freq_per_outdoor", "Freq_per_indoor")]
colnames(pm_all_sub_combined78) <- c("PM4_7_8","Likert_Scale", "Count: outdoor",  "Count: indoor", "Percentage: outdoor",  "Percentage: indoor")

# pm_all_sub_combined78$Likert_Scale <- factor(pm_all_sub_combined78$Likert_Scale, levels = q_5Likert_option_text$options)
# pm_all_sub_combined78 <- pm_all_sub_combined78[order(pm_all_sub_combined78$Likert_Scale), ]

# output$pm4_table78 <- renderDataTable({
#   
#   pm_all_sub_combined78
# }, options = list(lengthMenu = c(5,10,15),
#                   searching = FALSE,
#                   pageLength = 5,
#                   dom = 't'), rownames=FALSE)


output$pm4_table78 <- DT::renderDataTable({
  DT::datatable(pm_all_sub_combined78, 
                options = list(
                  scrollY = "400px", 
                  paging = FALSE,    
                  scrollX = TRUE,    
                  dom = 't'          
                ))
})





































