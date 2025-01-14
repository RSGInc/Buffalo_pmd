pm_metrics_text <- c('Ease of planning a door-to-door trip route/path.',
                     'Satisfaction with the specific route/path options <br> provided by the Buffalo All Access app.',
                     'The percent of Buffalo All Access app users who use the system to <br> book on-demand transit trips (CS).',
                     'Ease of booking on-demand (CS) transit trips <br> via the system.',
                     'The percent of Buffalo All Access app users who use the Buffalo All Access app to report incidents or <br> travel conditions during their trips.',
                     'Ease of reporting incidents or conditions <br> encountered during a trip in the Buffalo All Access app.',
                     'The percent of Buffalo All Access app users who use the <br> Buffalo All Access app function to review past trip history.',
                     'Usefulness of reporting past trip history in the <br> Buffalo All Access app.'
                     )

# create pm3 metrics data table ---
pm_metrics_dt <- data.table(pmid = 1:8, pm_metrics_label = gsub("<br> ", "", pm_metrics_text))
# test_post_svy_pm3 <- test_post_svy[1:(nrow(test_post_svy)-1), c("ID", names(test_post_svy)[10:17]), with = FALSE]
test_post_svy_pm3 <- test_post_svy[, c(list(ID = as.character(ID)), 
                                     lapply(.SD, as.integer)),
                                   .SDcols = names(test_post_svy)[10:17]]

## melt the data to long format ---
test_post_svy_melt <- melt.data.table(test_post_svy_pm3[, -c(4), with = FALSE],
                                      id.vars = c("ID"),
                                      variable.name = "pmid",
                                      value.name = "id")

pm_sum_dt <- test_post_svy_melt[,.N, .(id, pmid)]
names(pm_sum_dt)[3] = "Freq"

## merge with svy_pmd_5likert to get Likert scale values ---
pm_sum_dt1 <- merge(pm_sum_dt[pmid %in% c("PM3_1","PM3_4","PM3_6")], easy_5Likert_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt2 <- merge(pm_sum_dt[pmid %in% c("PM3_2")], satisfy_5Likert_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt3 <- merge(pm_sum_dt[pmid %in% c("PM3_5", "PM3_7")], q_yesno_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
# pm_sum_dt4 <- merge(pm_sum_dt[pmid %in% c("PM3_7")], q_yesno_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt4 <- merge(pm_sum_dt[pmid %in% c("PM3_8")], useful_5Likert_option_text, by.x = "id",  by.y = "id", all.x = TRUE)

# pm_sum_dt <- pm_sum_dt[svy_pmd_5likert[,.(id = pmd_5likert_value, pmd_5likert)], on = "id"]
pm_sum_dt1[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt2[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt3[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt4[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
# pm_sum_dt5[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]

pm_sum_dt <- rbind(pm_sum_dt1, pm_sum_dt2, pm_sum_dt3, pm_sum_dt4)

## create a data table containing all PM metrics data
pm_all_dt <- pm_sum_dt[,.(pmid = as.integer(gsub("PM3_", "",pmid)), id, options, Freq, Freq_per)]
# pm_all_dt$pmd_5likert_value <- rep(seq(1, 5), each = 5)
pm_all_dt <- pm_all_dt[order(pmid),]

## merge with pm_metrics_dt to add metric labels ---
pm_all_dt[pm_metrics_dt, pm_metrics_label := i.pm_metrics_label, on = "pmid"]
setcolorder(pm_all_dt, c("pmid", "pm_metrics_label", "id", "options", "Freq", "Freq_per"))
# pm_all_dt <- pm_all_dt[order(pmid, pmd_5likert_value)]

pm_all_df = data.frame(pm_all_dt)

pm_all_df_3 <- pm_all_df
download_date_info = format(Sys.time(), "%Y-%m-%d")

## process data for download
pm3_summary_table <- pm_all_dt[, c("pmid", "pm_metrics_label", "options", "Freq", "Freq_per")]
setnames(pm3_summary_table, old = c("pm_metrics_label", "options", "Freq", "Freq_per"),
         new = c("PM metrics label", "Response", "Count",  "Percentage"))


# etch trip data

etch_pm3 <- sel_etch_trip_df[ , c(list(ID = as.character(ID)), 
                                  lapply(.SD, as.integer)),
                              .SDcols = names(sel_etch_trip_df)[3]]

etch_melt <- melt.data.table(etch_pm3, 
                             id.vars = c("ID"),
                             variable.name = "pmid",
                             value.name = "id")

pm_sum_dt_etch <- etch_melt[,.N, .(id, pmid)]
names(pm_sum_dt_etch)[3] = "Freq"

pm_sum_dt_etch <- merge(pm_sum_dt_etch[pmid %in% c("PM3_3")], q_yesno_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt_etch[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]

## create a data table containing all PM metrics data
pm_all_etch_dt <- pm_sum_dt_etch[,.(pmid = as.integer(gsub("PM3_", "",pmid)), id, options, Freq, Freq_per)]
## change order based on pmid
pm_all_etch_dt <- pm_all_etch_dt[order(pmid),]

## merge with pm_metrics_dt to add metric labels ---
pm_all_etch_dt[pm_metrics_dt, pm_metrics_label := i.pm_metrics_label, on = "pmid"]
setcolorder(pm_all_etch_dt, c("pmid", "pm_metrics_label", "id", "options", "Freq", "Freq_per"))

pm_all_etch_df = data.frame(pm_all_etch_dt)


# pm3_all_plot ------
pm3_dt <- dcast.data.table(pm_all_dt[pmid %in% c(1,4,6)], pmid ~ id, value.var = "Freq_per")
colnames(pm3_dt)[2:6] = paste0("x", names(pm3_dt)[2:6])
pm_metrics_text_plot1 <- pm_metrics_text[c(1, 4, 6)]
pm3_dt = cbind(pm_metrics_text_plot1, pm3_dt)
setnames(pm3_dt, "pm_metrics_text_plot1", "pm_metrics")
pm3_dt$pm_metrics = factor(pm3_dt$pm_metrics, levels= rev(pm3_dt$pm_metrics) )

pm3_df = data.frame(pm3_dt)

pm3_all <- plot_ly(pm3_df, x = ~x1, y = ~pm_metrics, type = 'bar', orientation = 'h', name = "Very easy", hoverinfo = "name+x", height = 245,
                   marker = list(color = '#023e8a', 
                                 line = list(color = 'rgb(248, 248, 249)', width = 1)))
pm3_all <- pm3_all %>% add_trace(x = ~x2, marker = list(color = '#4895ef'), name = "Easy") 
pm3_all <- pm3_all %>% add_trace(x = ~x3, marker = list(color = '#76c893'), name = "Neutral") 
pm3_all <- pm3_all %>% add_trace(x = ~x4, marker = list(color = '#fca311'), name = "Difficult") 
pm3_all <- pm3_all %>% add_trace(x = ~x5, marker = list(color = '#f94144'), name = "Very difficult") 
pm3_all <- pm3_all %>% layout(xaxis = list(title = "",
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
pm3_all <- pm3_all %>% add_annotations(xref = 'paper', yref = 'y', x = 0.14, y = pm_metrics_text[c(1, 4, 6)],
                                       xanchor = 'right',
                                       text = pm_metrics_text[c(1, 4, 6)],
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(67, 67, 67)'),
                                       showarrow = FALSE, align = 'right') 

# labeling the percentages of each bar (x_axis)
x1_loc <- pm3_df[,"x1"]/2
pm3_all <- pm3_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x1_loc, # y = pm_metrics_text,
                                       text = paste(pm3_df[,"x1"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 
x2_loc <- pm3_df[, "x1"] + pm3_df[, "x2"] /2
pm3_all <- pm3_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x2_loc, # y = pm_metrics_text,
                                       text = paste(pm3_df[,"x2"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 
x3_loc <- pm3_df[, "x1"] + pm3_df[, "x2"] + pm3_df[, "x3"] /2
pm3_all <- pm3_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x3_loc, # y = pm_metrics_text,
                                       text = paste(pm3_df[,"x3"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 
x4_loc <- pm3_df[, "x1"] + pm3_df[, "x2"] + pm3_df[, "x3"] + pm3_df[, "x4"] /2
pm3_all <- pm3_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x4_loc, # y = pm_metrics_text,
                                       text = paste(pm3_df[,"x4"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 
x5_loc <- pm3_df[, "x1"] + pm3_df[, "x2"] + pm3_df[, "x3"] + pm3_df[, "x4"]  + pm3_df[, "x5"] /2
pm3_all <- pm3_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x5_loc, # y = pm_metrics_text,
                                       text = paste(pm3_df[,"x5"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 

rm(x1_loc, x2_loc, x3_loc, x4_loc, x5_loc)

# labeling the first Likert scale (on the top)
pm3_all <- pm3_all %>% add_annotations(xref = 'x', yref = 'paper',
                                       x = c(8, 28, 48, 68, 90),
                                       y = 1.20,
                                       text = easy_5Likert_option_text$options,
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(67, 67, 67)'),
                                       showarrow = FALSE)

pm3_all <- pm3_all %>% config(toImageButtonOptions = list(format= 'png', # one of png, svg, jpeg, webp
                                                          filename= paste0('pm3 All Ratings Chart_', download_date_info), 
                                                          scale= 1 ))
# pm3_all

output$pm31_all_plot <- renderPlotly({
  ggplotly(
    pm3_all
  )
})

# pm3_all table output 
pm3_all_dt <- dcast.data.table(pm_all_dt[pmid %in% c(1,4,6)], pmid ~ id, value.var = "Freq")
colnames(pm3_all_dt)[2:6] = paste0("x", names(pm3_all_dt)[2:6])
pm_metrics_text_plot1 <- pm_metrics_text[c(1,4,6)]
pm3_all_dt = cbind(pm_metrics_text_plot1, pm3_all_dt)
pm3_all_dt[, pm_metrics_text_plot1 := gsub("<br>", "", pm_metrics_text_plot1, fixed = TRUE)]
pm3_all_dt[, pmid:= NULL]
pm3_all_dt[, Total := rowSums(.SD, na.rm = TRUE), .SDcols = c("x1", "x2", "x3", "x4", "x5")]
pm3_all_df = data.frame(pm3_all_dt)
setnames(pm3_all_df, old = c("pm_metrics_text_plot1", "x1", "x2", "x3", "x4", "x5"),
         new = c("PM","Very easy", "Easy", "Neutral", "Difficult", "Very difficult"))

output$pm3_all_table1 <- renderDataTable({
  
  pm3_all_df
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)

# pm32_all_plot ------
pm32_dt <- dcast.data.table(pm_all_dt[pmid==2], pmid ~ id, value.var = "Freq_per")
colnames(pm32_dt)[2:6] = paste0("x", names(pm32_dt)[2:6])
pm32_dt = cbind(pm_metrics_text = pm_metrics_text[2], pm32_dt)
setnames(pm32_dt, "pm_metrics_text", "pm_metrics")
pm32_dt$pm_metrics = factor(pm32_dt$pm_metrics, levels= rev(pm32_dt$pm_metrics) )

pm32_df = data.frame(pm32_dt)

pm32_all <- plot_ly(pm32_df, x = ~x1, y = ~pm_metrics, type = 'bar', orientation = 'h', name = "Very satisfied", hoverinfo = 'name+x', height = 130,
                   marker = list(color = '#023e8a', 
                                 line = list(color = 'rgb(248, 248, 249)', width = 1)))
pm32_all <- pm32_all %>% add_trace(x = ~x2, marker = list(color = '#4895ef'), name = "Satisfied") 
pm32_all <- pm32_all %>% add_trace(x = ~x3, marker = list(color = '#76c893'), name = "Neutral") 
pm32_all <- pm32_all %>% add_trace(x = ~x4, marker = list(color = '#fca311'), name = "unsatisfied") 
pm32_all <- pm32_all %>% add_trace(x = ~x5, marker = list(color = '#f94144'), name = "Very unatisfied") 
pm32_all <- pm32_all %>% layout(xaxis = list(title = "",
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
pm32_all <- pm32_all %>% add_annotations(xref = 'paper', yref = 'y', x = 0.14, y = pm_metrics_text[2],
                                       xanchor = 'right',
                                       text = pm_metrics_text[2],
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(67, 67, 67)'),
                                       showarrow = FALSE, align = 'right') 

# labeling the percentages of each bar (x_axis)
x1_loc <- pm32_df[,"x1"]/2
pm32_all <- pm32_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x1_loc, # y = pm_metrics_text,
                                       text = paste(pm32_df[,"x1"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 
x2_loc <- pm32_df[, "x1"] + pm32_df[, "x2"] /2
pm32_all <- pm32_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x2_loc, # y = pm_metrics_text,
                                       text = paste(pm32_df[,"x2"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 
x3_loc <- pm32_df[, "x1"] + pm32_df[, "x2"] + pm32_df[, "x3"] /2
pm32_all <- pm32_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x3_loc, # y = pm_metrics_text,
                                       text = paste(pm32_df[,"x3"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 
x4_loc <- pm32_df[, "x1"] + pm32_df[, "x2"] + pm32_df[, "x3"] + pm32_df[, "x4"] /2
pm32_all <- pm32_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x4_loc, # y = pm_metrics_text,
                                       text = paste(pm32_df[,"x4"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 
x5_loc <- pm32_df[, "x1"] + pm32_df[, "x2"] + pm32_df[, "x3"] + pm32_df[, "x4"]  + pm32_df[, "x5"] /2
pm32_all <- pm32_all %>% add_annotations(xref = 'x', yref = 'y',
                                       x = x5_loc, # y = pm_metrics_text,
                                       text = paste(pm32_df[,"x5"], '%'),
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(248, 248, 255)'),
                                       showarrow = FALSE) 

rm(x1_loc, x2_loc, x3_loc, x4_loc, x5_loc)

# labeling the first Likert scale (on the top)
pm32_all <- pm32_all %>% add_annotations(xref = 'x', yref = 'paper',
                                       x = c(6, 14, 32, 60, 85),
                                       y = 1.45,
                                       text = satisfy_5Likert_option_text$options,
                                       font = list(family = 'Arial', size = 12,
                                                   color = 'rgb(67, 67, 67)'),
                                       showarrow = FALSE)

pm32_all <- pm32_all %>% config(toImageButtonOptions = list(format= 'png', # one of png, svg, jpeg, webp
                                                          filename= paste0('pm32 All Ratings Chart_', download_date_info), 
                                                          scale= 1 ))
# pm32_all

output$pm32_all_plot <- renderPlotly({
  ggplotly(
    pm32_all
  )
})

# pm32_all table output 
pm32_all_dt <- dcast.data.table(pm_all_dt[pmid == 2], pmid ~ id, value.var = "Freq")
colnames(pm32_all_dt)[2:6] = paste0("x", names(pm32_all_dt)[2:6])
pm_metrics_text_plot1 <- pm_metrics_text[2]
pm32_all_dt = cbind(pm_metrics_text_plot1, pm32_all_dt)
pm32_all_dt[, pm_metrics_text_plot1 := gsub("<br>", "", pm_metrics_text_plot1, fixed = TRUE)]
pm32_all_dt[, pmid:= NULL]
pm32_all_dt[, Total := rowSums(.SD, na.rm = TRUE), .SDcols = c("x1", "x2", "x3", "x4", "x5")]
pm32_all_df = data.frame(pm32_all_dt)
setnames(pm32_all_df, old = c("pm_metrics_text_plot1", "x1", "x2", "x3", "x4", "x5"),
         new = c("PM","Very satisfied", "Satisfied", "Neutral", "Unsatisfied", "Very unsatisfied"))

output$pm3_all_table2 <- renderDataTable({
  
  pm32_all_df
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)


# pm38_all_plot ------
pm38_dt <- dcast.data.table(pm_all_dt[pmid==8], pmid ~ id, value.var = "Freq_per")
colnames(pm38_dt)[2:6] = paste0("x", names(pm38_dt)[2:6])
pm38_dt = cbind(pm_metrics_text = pm_metrics_text[8], pm38_dt)
setnames(pm38_dt, "pm_metrics_text", "pm_metrics")
pm38_dt$pm_metrics = factor(pm38_dt$pm_metrics, levels= rev(pm38_dt$pm_metrics) )

pm38_df = data.frame(pm38_dt)

pm38_all <- plot_ly(pm38_df, x = ~x1, y = ~pm_metrics, type = 'bar', orientation = 'h', name = 'Very useful', hoverinfo = 'name+x', height = 140,
                    marker = list(color = '#023e8a', 
                                  line = list(color = 'rgb(248, 248, 249)', width = 1)))
pm38_all <- pm38_all %>% add_trace(x = ~x2, marker = list(color = '#4895ef'), name = 'Useful') 
pm38_all <- pm38_all %>% add_trace(x = ~x3, marker = list(color = '#76c893'), name = 'Neutral') 
pm38_all <- pm38_all %>% add_trace(x = ~x4, marker = list(color = '#fca311'), name = 'Not very useful') 
pm38_all <- pm38_all %>% add_trace(x = ~x5, marker = list(color = '#f94144'), name = 'Not useful at all') 
pm38_all <- pm38_all %>% layout(xaxis = list(title = "",
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
pm38_all <- pm38_all %>% add_annotations(xref = 'paper', yref = 'y', x = 0.14, y = pm_metrics_text[8],
                                         xanchor = 'right',
                                         text = pm_metrics_text[8],
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(67, 67, 67)'),
                                         showarrow = FALSE, align = 'right') 

# labeling the percentages of each bar (x_axis)
x1_loc <- pm38_df[,"x1"]/2
pm38_all <- pm38_all %>% add_annotations(xref = 'x', yref = 'y',
                                         x = x1_loc, # y = pm_metrics_text,
                                         text = paste(pm38_df[,"x1"], '%'),
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(248, 248, 255)'),
                                         showarrow = FALSE) 
x2_loc <- pm38_df[, "x1"] + pm38_df[, "x2"] /2
pm38_all <- pm38_all %>% add_annotations(xref = 'x', yref = 'y',
                                         x = x2_loc, # y = pm_metrics_text,
                                         text = paste(pm38_df[,"x2"], '%'),
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(248, 248, 255)'),
                                         showarrow = FALSE) 
x3_loc <- pm38_df[, "x1"] + pm38_df[, "x2"] + pm38_df[, "x3"] /2
pm38_all <- pm38_all %>% add_annotations(xref = 'x', yref = 'y',
                                         x = x3_loc, # y = pm_metrics_text,
                                         text = paste(pm38_df[,"x3"], '%'),
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(248, 248, 255)'),
                                         showarrow = FALSE) 
x4_loc <- pm38_df[, "x1"] + pm38_df[, "x2"] + pm38_df[, "x3"] + pm38_df[, "x4"] /2
pm38_all <- pm38_all %>% add_annotations(xref = 'x', yref = 'y',
                                         x = x4_loc, # y = pm_metrics_text,
                                         text = paste(pm38_df[,"x4"], '%'),
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(248, 248, 255)'),
                                         showarrow = FALSE) 
x5_loc <- pm38_df[, "x1"] + pm38_df[, "x2"] + pm38_df[, "x3"] + pm38_df[, "x4"]  + pm38_df[, "x5"] /2
pm38_all <- pm38_all %>% add_annotations(xref = 'x', yref = 'y',
                                         x = x5_loc, # y = pm_metrics_text,
                                         text = paste(pm38_df[,"x5"], '%'),
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(248, 248, 255)'),
                                         showarrow = FALSE) 

rm(x1_loc, x2_loc, x3_loc, x4_loc, x5_loc)

# labeling the first Likert scale (on the top)
pm38_all <- pm38_all %>% add_annotations(xref = 'x', yref = 'paper',
                                         x = c(8, 28, 48, 68, 90),
                                         y = 1.40,
                                         text = useful_5Likert_option_text$options,
                                         font = list(family = 'Arial', size = 12,
                                                     color = 'rgb(67, 67, 67)'),
                                         showarrow = FALSE)

pm38_all <- pm38_all %>% config(toImageButtonOptions = list(format= 'png', # one of png, svg, jpeg, webp
                                                            filename= paste0('pm38 All Ratings Chart_', download_date_info), 
                                                            scale= 1 ))
# pm38_all

output$pm38_all_plot <- renderPlotly({
  ggplotly(
    pm38_all
  )
})

# pm38_all table output 
pm38_all_dt <- dcast.data.table(pm_all_dt[pmid == 8], pmid ~ id, value.var = "Freq")
colnames(pm38_all_dt)[2:6] = paste0("x", names(pm38_all_dt)[2:6])
pm_metrics_text_plot1 <- pm_metrics_text[8]
pm38_all_dt = cbind(pm_metrics_text_plot1, pm38_all_dt)
pm38_all_dt[, pm_metrics_text_plot1 := gsub("<br>", "", pm_metrics_text_plot1, fixed = TRUE)]
pm38_all_dt[, pmid:= NULL]
pm38_all_dt[, Total := rowSums(.SD, na.rm = TRUE), .SDcols = c("x1", "x2", "x3", "x4", "x5")]
pm38_all_df = data.frame(pm38_all_dt)
setnames(pm38_all_df, old = c("pm_metrics_text_plot1", "x1", "x2", "x3", "x4", "x5"),
         new = c("PM","Very useful", "Useful", "Neutral", "Not very useful", "Not useful at all"))

output$pm3_all_table8 <- renderDataTable({
  
  pm38_all_df
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)




# pm3.3_plot -----
pm3_3_colors <- c('#f94144', '#023e8a')
frequency_pm3_3 <- table(etch_pm3$PM3_3)
labels <- c("Yes", "No")
names(frequency_pm3_3) <- labels

no_percent <- frequency_pm3_3["No"]/sum(frequency_pm3_3) * 100
yes_percent <- frequency_pm3_3["Yes"]/sum(frequency_pm3_3) * 100

pm3_3 <- plot_ly(x = c("No", "Yes"),
                 y = c(no_percent, yes_percent),
                 type = "bar",
                 marker = list(color = pm3_3_colors))


pm3_3 <- pm3_3 %>% layout(
  # title = "Responses Distribution",
  xaxis = list(title = "Response"),
  yaxis = list(title = "Percentage"),
  barmode = "stack"
)


pm3_3 <- pm3_3 %>% config(toImageButtonOptions = list(format= 'png',
                                                      filename= paste0('pm3_3 Ratings Chart_', download_date_info),
                                                      scale= 1 ))
output$pm3_3_plot <- renderPlotly({
  ggplotly(
    pm3_3
  )
})

output$pm3_table3 <- renderTable({
  frequency_table <- data.frame(Category = names(frequency_pm3_3), Frequency = as.vector(frequency_pm3_3))
  total <- sum(frequency_table$Frequency)
  frequency_table <- rbind(frequency_table, c("Total", total))
  colnames(frequency_table) <- c("Category", "Frequency")
  frequency_table
})


# pm3.5_plot -----
pm3_5_colors <- c('#f94144', '#023e8a')
frequency_pm3_5 <- table(test_post_svy_pm3$PM3_5)
labels <- c("Yes", "No")
names(frequency_pm3_5) <- labels

no_percent <- frequency_pm3_5["No"]/sum(frequency_pm3_5) * 100
yes_percent <- frequency_pm3_5["Yes"]/sum(frequency_pm3_5) * 100

pm3_5 <- plot_ly(x = c("No", "Yes"),
                 y = c(no_percent, yes_percent),
                 type = "bar",
                 marker = list(color = pm3_5_colors))


pm3_5 <- pm3_5 %>% layout(
  # title = "Responses Distribution",
  xaxis = list(title = "Response"),
  yaxis = list(title = "Percentage"),
  barmode = "stack"
)


pm3_5 <- pm3_5 %>% config(toImageButtonOptions = list(format= 'png',
                                                      filename= paste0('pm3_5 Ratings Chart_', download_date_info),
                                                      scale= 1 ))
output$pm3_5_plot <- renderPlotly({
  ggplotly(
    pm3_5
  )
})

output$pm3_table5 <- renderTable({
  frequency_table <- data.frame(Category = names(frequency_pm3_5), Frequency = as.vector(frequency_pm3_5))
  total <- sum(frequency_table$Frequency)
  frequency_table <- rbind(frequency_table, c("Total", total))
  colnames(frequency_table) <- c("Category", "Frequency")
  frequency_table
})

# pm3.7_plot -----
pm3_7_colors <- c('#f94144', '#023e8a')
frequency_pm3_7 <- table(test_post_svy_pm3$PM3_7)
labels <- c("Yes", "No")
names(frequency_pm3_7) <- labels

no_percent <- frequency_pm3_7["No"]/sum(frequency_pm3_7) * 100
yes_percent <- frequency_pm3_7["Yes"]/sum(frequency_pm3_7) * 100

pm3_7 <- plot_ly(x = c("No", "Yes"),
                 y = c(no_percent, yes_percent),
                 type = "bar",
                 marker = list(color = pm3_7_colors))


pm3_7 <- pm3_7 %>% layout(
  # title = "Responses Distribution",
  xaxis = list(title = "Response"),
  yaxis = list(title = "Percentage"),
  barmode = "stack"
)


pm3_7 <- pm3_7 %>% config(toImageButtonOptions = list(format= 'png',
                                                      filename= paste0('pm3_7 Ratings Chart_', download_date_info),
                                                      scale= 1 ))
output$pm3_7_plot <- renderPlotly({
  ggplotly(
    pm3_7
  )
})

output$pm3_table7 <- renderTable({
  frequency_table <- data.frame(Category = names(frequency_pm3_7), Frequency = as.vector(frequency_pm3_7))
  total <- sum(frequency_table$Frequency)
  frequency_table <- rbind(frequency_table, c("Total", total))
  colnames(frequency_table) <- c("Category", "Frequency")
  frequency_table
})


