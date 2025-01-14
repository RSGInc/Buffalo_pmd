rm(list=ls())

source('config.R')

# # get file from rest api 1
# get_data <- GET(curl_location, add_headers(authorization = curl_header))
# etch_json = jsonlite::prettify(get_data)
# 
# # get file from rest api 2
# # h = new_handle(verbose = TRUE)
# # handle_setheaders(h,
# #                   "Content-Type" = "application/json",
# #                   "Authorization" = curl_header
# # )
# # ## method 
# # con <- curl(curl_location, handle = h)
# # etch_json = jsonlite::prettify(readLines(con))
# 
# # data file conversion from json to data.frame
# etch_data = fromJSON(etch_json, simplifyVector = FALSE)
# etch_data_df = setDT(rbindlist(etch_data$results, fill=TRUE))
# # head(etch_data_df); str(etch_data_df)
# etch_data_df = etch_data_df[, lapply(.SD, as.character), by=travelerID]
# etch_data_df[, id := seq_len(.N), by = "travelerID"]
# etch_data_df1 = dcast(etch_data_df, travelerID ~ id, value.var = "requestedModes")
# etch_data_df1 = etch_data_df1[, lapply(.SD, as.character), by=travelerID]
# names(etch_data_df1)[2:15] = paste0("requestedModes", c(1:14))
# etch_data_df = etch_data_df[!duplicated(etch_data_df$travelerID, etch_data_df$departDate)]
# etch_data_df[, id:=NULL]
# etch_data_df[, requestedModes:=NULL]
# etch_data_df = etch_data_df %>% merge(etch_data_df1, by = "travelerID", all = TRUE) 
# rm(etch_data_df1)
# 
# names(etch_data_df)
# 
# ctp_trip_data <- etch_data_df
# ctp_trip_data <- ctp_trip_data[,c(1:10)]
# ctp_trip_data[, kiosk:=NULL]
# 
# ctp_register_data <- etch_data_df[,1:5]
# ctp_register_data[,2] <- c("xxxx@gmail.com", "xxxx@aol.com", "xxxx@icloud.com", "xxxx@outlook.com")
# ctp_register_data[,3] <- c("2024-xx-xx")
# ctp_register_data[,4:5] <- "Yes"
# ctp_register_data[3,4] <- "No"
# ctp_register_data[4,5] <- "No"
# 
# names(ctp_register_data)[2:5] <- c("email address", "registration date", "elect to receive outdoor wayfinding notifications", "elect to receive indoor wayfinding notifications")
# # write.csv(etch_data_df, file.path(SYSTEM_APP_INPUT_PATH, paste0("etch_trip_input_api_extracted_", Sys.Date(), ".csv")))
# saveRDS(etch_data_df, file.path(SYSTEM_APP_INPUT_PATH, paste0("etch_trip_input_api_extracted_", Sys.Date(), ".rds")))


##etch trip data
names(etchdt) <- gsub(" ", "", names(etchdt))

# PM1_6: etchdt_q1.6, "The satisfaction with making a trip using Buffalo All Access app."-----
etchdt_q1.6 <- etchdt[,c(5,42)]
names(etchdt_q1.6)[2] = "options"
etchdt_q1.6[satisfy_5Likert_option_text, id := i.id, on = "options"]

# PM3_3: etchdt_q3.3, "The percent of Buffalo All Access app users who use the system to book on-demand transit trips (CS)."-----
etchdt_q3.3 <- etchdt[,c(5,43)]
names(etchdt_q3.3)[2] = "options"
etchdt_q3.3[q_yesno_option_text, id := i.id, on = "options"]

# PM5_1: etchdt_q5.1, "The percent of Buffalo All Access app trips crossing at the relevant intersections who use the smart signal remote activation function."-----
etchdt_q5.1 <- etchdt[,c(5,44)]
names(etchdt_q5.1)[2] = "options"
etchdt_q5.1[q_yesno_option_text, id := i.id, on = "options"]

# PM6_1 : etchdt_q6.1, "Percent of CS trips that arrive at the boarding stop within the targeted time allowance of the scheduled arrival time "
etchdt_q6.1 <- etchdt[,c(5,45)]
names(etchdt_q6.1)[2] = "options"
etchdt_q6.1[q_yesno_option_text, id := i.id, on = "options"]

etch_PMs <- merge(etchdt_q1.6[, .(RespondentID, PM1_6 = id)], etchdt_q3.3[, .(RespondentID, PM3_3 = id)], by = "RespondentID")
etch_PMs <- merge(etch_PMs, etchdt_q5.1[, .(RespondentID, PM5_1 = id)], by = "RespondentID")
etch_PMs <- merge(etch_PMs, etchdt_q6.1[, .(RespondentID, PM6_1 = id)], by = "RespondentID")

write.csv(etch_PMs, file.path(SYSTEM_APP_INPUT_PATH, paste0("etch_pm_", Sys.Date(), ".csv")), row.names = FALSE)
