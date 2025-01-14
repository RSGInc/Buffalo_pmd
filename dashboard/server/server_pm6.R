
pm_metrics_text <- c('Percent of CS trips that arrive at the boarding stop within <br> the targeted time allowance of the scheduled arrival time.',
                     'Cost efficiency of the <b>HDS</b> and <b>SDS</b> shuttle services in terms <br> of operating cost per passenger trip.')

pm_metrics_dt <- data.table(pmid = 1:2, pm_metrics_label = gsub("<br> ", "", pm_metrics_text))
etch_pm6 <- sel_etch_trip_df[, lapply(.SD, as.numeric),
                                   .SDcols = c("ID", names(sel_etch_trip_df)[5])]

# etch_melt <- melt.data.table(etch_pm6, 
#                              id.vars = c("ID"),
#                              variable.name = "pmid",
#                              value.name = "id")

download_date_info = format(Sys.time(), "%Y-%m-%d")

# pm6.1_plot -----

pm6_1_colors <- c('#023e8a','#f94144')
frequency_pm6_1 <- table(etch_pm6$PM6_1)
labels <- c("Yes", "No")
names(frequency_pm6_1) <- labels

pm6_1 <- plot_ly(labels = names(frequency_pm6_1),
                 values = as.vector(frequency_pm6_1),
                 type = "pie", marker = list(colors = pm6_1_colors,
                                             line = list(color = '#FFFFFF', width = 1)))

pm6_1 <- pm6_1 %>% layout(
  title = ""
)

pm6_1 <- pm6_1 %>% config(toImageButtonOptions = list(format= 'png',
                                                      filename= paste0('pm6_1 Ratings Chart_', download_date_info),
                                                      scale= 1 ))
output$pm6_1_plot <- renderPlotly({
  ggplotly(
    pm6_1
  )
})

output$pm6_table1 <- renderTable({
  frequency_table <- data.frame(Category = names(frequency_pm6_1), Frequency = as.vector(frequency_pm6_1))
  total <- sum(frequency_table$Frequency)
  frequency_table <- rbind(frequency_table, c("Total", total))
  colnames(frequency_table) <- c("Category", "Frequency")
  frequency_table
})



# 
# # pm6.1_numeric ---
# min_value <- min(test_post_svy_pm6$PM6_1)
# max_value <- max(test_post_svy_pm6$PM6_1)
# bin_size <- 5
# bin_edges <- seq(min_value, max_value + bin_size, by = bin_size)
# freq <- table(cut(test_post_svy_pm6$PM6_1, breaks = bin_edges, right = FALSE))
# pm6_1 <- plot_ly(x = names(freq), y = freq, type = "bar",
#                  marker = list(color = '#023e8a'),
#                  hoverinfo = "text",
#                  text = paste(freq))
# 
# pm6_1 <- pm6_1 %>% layout(
#   xaxis = list(title = "Percentage of CS trips arrive", showgrid = FALSE, zeroline = FALSE, showticklabels = TRUE),
#   yaxis = list(title = "Frequency of percentage range", zeroline = FALSE, showticklabels = TRUE)
# )
# 
# pm6_1 <- pm6_1 %>% config(toImageButtonOptions = list(format= 'png', 
#                                                       filename= paste0('pm6_1 Ratings Chart_', download_date_info), 
#                                                       scale= 1 ))
# 
# output$pm6_1_plot <- renderPlotly({
#   ggplotly(
#     pm6_1
#   )
# })
# 
# 
# 
# # pm6.2_numeric ---
# pm6_2 <- plot_ly(test_post_svy_pm6, y = ~pm6_2,
#                  type = 'box',
#                  line = list(
#                    color =  '#023e8a'
#                  ), fillcolor = '#fca311',
#                  x = pm_metrics_text[3]
# ) 
# pm6_2 <- pm6_2 %>% add_trace(
#   hoverinfo = 'y', 
#   showlegend = FALSE
# )
# pm6_2 <- pm6_2 %>%layout(
#   yaxis = list(
#     title = "Cost",
#     zeroline = FALSE
#   )
# )
# 
# 
# pm6_2 <- pm6_2 %>% config( toImageButtonOptions = list(format= 'png',
#                                                       filename= paste0('pm6_2 Ratings Chart_', download_date_info),
#                                                       scale= 1 ))
# output$pm6_2_plot <- renderPlotly({
#   ggplotly(
#     pm6_2
#   )
# })


