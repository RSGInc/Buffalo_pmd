# pm2.1_plot -----

pm_metrics_text <- c('The ease of the registration process.',
                     'The extent to which the options available during <br> registration served their needs.')

# create pm2 metrics data table ---
pm_metrics_dt <- data.table(pmid = 1:2, pm_metrics_label = gsub("<br> ", "", pm_metrics_text))
test_post_svy_pm2 <- test_post_svy[, c(list(ID = as.character(ID)), 
                                     lapply(.SD, as.integer)),
                                   .SDcols = names(test_post_svy)[8:9]]

## melt the data to long format ---
test_post_svy_melt <- melt.data.table(test_post_svy_pm2,
                                      id.vars = c("ID"),
                                      variable.name = "pmid",
                                      value.name = "id")
pm_sum_dt <- test_post_svy_melt[,.N, .(id, pmid)]
names(pm_sum_dt)[3] = "Freq"

## merge with svy_pmd_5likert to get Likert scale values ---
pm_sum_dt1 <- merge(pm_sum_dt[pmid %in% c("PM2_1")], easy_5Likert_option_text, by.x = "id",  by.y = "id", all.x = TRUE)
pm_sum_dt2 <- merge(pm_sum_dt[pmid %in% c("PM2_2")], useful_5Likert_option_text, by.x = "id",  by.y = "id", all.x = TRUE)

# pm_sum_dt <- pm_sum_dt[svy_pmd_5likert[,.(id = pmd_5likert_value, pmd_5likert)], on = "id"]
pm_sum_dt1[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]
pm_sum_dt2[, Freq_per := round(Freq/sum(Freq, na.rm = T) * 100,1), by = "pmid"]

## create a data table containing all PM metrics data
pm_all_dt1 <- pm_sum_dt1[,.(pmid = as.integer(gsub("PM2_", "",pmid)), id, options, Freq, Freq_per)]
# pm_all_dt$pmd_5likert_value <- rep(seq(1, 5), each = 2)
pm_all_dt1 <- pm_all_dt1[order(pmid),]

pm_all_dt2 <- pm_sum_dt2[,.(pmid = as.integer(gsub("PM2_", "",pmid)), id, options, Freq, Freq_per)]
pm_all_dt2 <- pm_all_dt2[order(pmid),]

pm_all_dt <- rbind(pm_all_dt1, pm_all_dt2)
## merge with pm_metrics_dt to add metric labels ---
pm_all_dt[pm_metrics_dt, pm_metrics_label := i.pm_metrics_label, on = "pmid"]
setcolorder(pm_all_dt, c("pmid", "pm_metrics_label", "id", "options", "Freq", "Freq_per"))
pm_all_dt <- pm_all_dt[order(pmid, id)]

pm_all_df = data.frame(pm_all_dt)
pm_all_dt_2 <- pm_all_dt
download_date_info = format(Sys.time(), "%Y-%m-%d")

## process data for download
pm2_summary_table <- pm_all_dt_2[, c("pmid", "pm_metrics_label", "options", "Freq", "Freq_per")]
setnames(pm2_summary_table, old = c("pm_metrics_label", "options", "Freq", "Freq_per"),
         new = c("PM metrics label", "Response", "Count",  "Percentage"))


# pm2.1_plot (pie chart) ------
pm2_1_colors <- c('Very easy' = '#023e8a',
                  'Easy' = '#4895ef',
                  'Neutral' = '#76c893',
                  'Difficult' = '#fca311',
                  'Very difficult' = '#f94144')

## plot pie chart ---
pm2_1 <- plot_ly(pm_all_df[pm_all_df$pmid==1,], labels = ~options, values = ~Freq_per , sort = FALSE, type = 'pie',
                 textposition = 'inside',
                 textinfo = 'label+percent',
                 insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'text',
                 # text = ~paste('', Freq_per, ' percentage'),
                 marker = list(colors = pm2_1_colors,
                               line = list(color = '#FFFFFF', width = 1)),
                 #The 'pull' attribute can also be used to create space between the sectors
                 showlegend = FALSE)
pm2_1 <- pm2_1 %>% layout(# title = '',
  xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
  yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

pm2_1 <- pm2_1 %>% config(toImageButtonOptions = list(format= 'png',
                                                      filename= paste0('pm2_1 Ratings Chart_', download_date_info),
                                                      scale= 1 ))
## render the figure ---
output$pm2_1_plot <- renderPlotly({
  ggplotly(
    pm2_1
  )
})

# pm2.1_table ------
pm2_1_data <- pm_all_df[pm_all_df$pmid == 1, c("options", "Freq", "Freq_per")]
colnames(pm2_1_data) <- c("Likert_Scale", "Count", "Percentage")

pm2_1_data$Likert_Scale <- factor(pm2_1_data$Likert_Scale, levels = easy_5Likert_option_text$options)
pm2_1_data <- pm2_1_data[order(pm2_1_data$Likert_Scale), ]

## render the table ---
output$pm2_table1 <- renderDataTable({

  pm2_1_data
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)
# pm2.2_plot ------
data <- as.data.frame(pm_all_df[pm_all_df$pmid==2,])

## plot bar chart ---
pm2_2_colors <- c('Very useful' = '#023e8a',
                  'Useful' = '#4895ef',
                  'Neutral' = '#76c893',
                  'Not very useful' = '#fca311',
                  'Not useful at all' = '#f94144')
pm2_2 <- plot_ly(data, x = ~factor(options, levels = options), y = ~Freq_per, type = 'bar',
                 color = ~options, colors = pm2_2_colors,
                 text = ~paste(Freq_per, "%"),
                 hoverinfo = 'text', showlegend = FALSE) %>%
  layout(title = "",
         xaxis = list(title = "Response"),
         yaxis = list(title = "Frequency (%)"))
# pm2_2 <- pm2_2 %>% layout(# title = '',
#   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
#   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

pm2_2 <- pm2_2 %>% config(toImageButtonOptions = list(format= 'png',
                                                      filename= paste0('pm2_2 Ratings Chart_', download_date_info),
                                                      scale= 1 ))

output$pm2_2_plot <- renderPlotly({
  ggplotly(
    pm2_2
  )
})

# pm2.2_table ------
pm2_2_data <- pm_all_df[pm_all_df$pmid == 2, c("options", "Freq", "Freq_per")]
colnames(pm2_2_data) <- c("Likert_Scale", "Count", "Percentage")

pm2_2_data$Likert_Scale <- factor(pm2_2_data$Likert_Scale, levels = useful_5Likert_option_text$options)
pm2_2_data <- pm2_2_data[order(pm2_2_data$Likert_Scale), ]


output$pm2_table2 <- renderDataTable({

  pm2_2_data
}, options = list(lengthMenu = c(5,10,15),
                  searching = FALSE,
                  pageLength = 5,
                  dom = 't'), rownames=FALSE)

















