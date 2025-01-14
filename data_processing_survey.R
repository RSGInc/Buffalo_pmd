# note:
# The scripts are written by Kyeongsu Kim, RSG, kyeongsu.kim@rsginc.com

# A list of PMs from pre-deployment survey: matched questions, data.table
# PM1_1 : presvydt1_q1.1
# PM1_2 : presvydt1_q1.2
# PM1_3 : presvydt1_q1.3
# PM1_4 : presvydt1_q1.4
# PM1_5 : presvydt1_q1.5
# PM5_4 : presvydt1_q5.4
# PM5_5  presvydt1_q5.5

# rm(list=ls())
source('config.R')


# 1 baseline survey data processing  -----------------------------------
presvydt
names(presvydt)
str(presvydt)
cols_index_otherspecified = c(12,14,16,18,58,60,62)
# cols_index_reason_notraveled_option = 26:30
# cols_index_mobilityequip_option = 42:52
cols_index_reason_notraveled_option0 = 25:30
cols_index_mobilityequip_option0 = 41:52

q25_notraveled_option_text = unlist(unname(presvydt[1, ..cols_index_reason_notraveled_option0]))
q41_mobilityequip_option_text = unlist(unname(presvydt[1, ..cols_index_mobilityequip_option0]))

presvydt1 <- presvydt[2:nrow(presvydt), ]
presvydt2 <- presvydt[2:nrow(presvydt), ..cols_index_reason_notraveled_option0]
presvydt3 <- presvydt[2:nrow(presvydt), ..cols_index_mobilityequip_option0]

# label column with question order 
# names(presvydt1)[10] <- c("Q1")
# names(presvydt1)[11:12] <- c("Q2", "Q2o")
# names(presvydt1)[13:14] <- c("Q3", "Q3o")
# names(presvydt1)[15:16] <- c("Q4", "Q4o")
# names(presvydt1)[17:18] <- c("Q5", "Q5o")
# names(presvydt1)[19:24] <- paste0("Q", 6:11)
# names(presvydt1)[25:30] <- paste0("Q12_",1:6)
# names(presvydt1)[31:40] <- paste0("Q", 13:22)
# names(presvydt1)[41:52] <- paste0("Q23_",1:12)
# names(presvydt1)[53:56] <- paste0("Q", 24:27)
# names(presvydt1)[57:58] <- c("Q28", "Q28o")
# names(presvydt1)[59:60] <- c("Q29", "Q29o")
# names(presvydt1)[61:62] <- c("Q30", "Q30o")
# names(presvydt1)[63:64] <- paste0("Q", 31:32)
# names(presvydt1)[65] <- "remark"
# names(presvydt1)[66] <- "drawing"

names(presvydt1) <- gsub(" ", "", names(presvydt1))

## 
presvydt1_q1 <- presvydt1[, c(1,10)]
names(presvydt1_q1)[2] = "options"
presvydt1_q1[FreqT2BNMC_option_textMC_option_text, id := i.id, on = "options"]
rm(FreqT2BNMC_option_textMC_option_text)
                                                            
presvydt1_q2 <- presvydt1[, c(1,11,12)]
names(presvydt1_q2)[2:3] = c("options", "others")
presvydt1_q2[Purp2BNMC_option_text, id := i.id, on = "options"]

presvydt1_q3 <- presvydt1[, c(1,13,14)]
names(presvydt1_q3)[2:3] = c("options", "others")
presvydt1_q3[Mode2BNMC_option_text, id := i.id, on = "options"]
rm(Mode2BNMC_option_text)

presvydt1_q4 <- presvydt1[, c(1,15,16)]
names(presvydt1_q4)[2:3] = c("options", "others")
presvydt1_q4[Assist2BNMC_option_text, id := i.id, on = "options"]

presvydt1_q5 <- presvydt1[, c(1,17,18)]
names(presvydt1_q5)[2:3] = c("options", "others")
presvydt1_q5[Assist2BNMC_option_text, id := i.id, on = "options"]

# PM1_1 : presvydt1_q1.1, "System user ratings of the ease of making door-to-door trips to, from and within the BNMC." -----
presvydt1_q1.1 <- presvydt1[, c(1,21)]
names(presvydt1_q1.1)[2] = c("options")
presvydt1_q1.1[q_5Likert_option_text, id := i.id, on = "options"]
names(presvydt)
# PM1_2 : presvydt1_q1.2, "System user ratings of how safe door-to-door travel paths are for trips to, from and within the BNMC, including level, slip-resistant paths." -----
presvydt1_q1.2 <- presvydt1[, c(1,22)]
names(presvydt1_q1.2)[2] = c("options")
presvydt1_q1.2[q_5Likert_option_text, id := i.id, on = "options"]

# PM1_3 : presvydt1_q1.3, "System user ratings of the availability of information for making trips to, from and within the BNMC"-----
presvydt1_q1.3 <- presvydt1[, c(1,19)]
names(presvydt1_q1.3)[2] = c("options")
presvydt1_q1.3[q_5Likert_option_text, id := i.id, on = "options"]

# PM1_4: presvydt1_q1.4, "System user ratings of the usefulness of information for making trips to, from and within the BNMC"-----
presvydt1_q1.4 <- presvydt1[, c(1,20)]
names(presvydt1_q1.4)[2] = c("options")
presvydt1_q1.4[q_5Likert_option_no_text, id := i.id, on = "options"]

# PM1_5 : presvydt1_q1.5, "System user ratings of the ability to make trips using integrated transit services. to, from and within the BNMC"-----
presvydt1_q1.5 <- presvydt1[, c(1,23)]
names(presvydt1_q1.5)[2] = c("options")
presvydt1_q1.5[q_5Likert_option_text, id := i.id, on = "options"]

presvydt1_q11 <- presvydt1[, c(1,24)]
names(presvydt1_q11)[2] = c("options")
presvydt1_q11[q_5Likert_option_text, id := i.id, on = "options"]

presvydt1_q5.4 <- presvydt1[, c(1,31)]
names(presvydt1_q5.4)[2] = c("options")
presvydt1_q5.4[CrossIntersect_option_text, id := i.id, on = "options"]

# PM5_5 : presvydt1_q5.5, "Perceived safety of crossing the intersections with smart signals"-----
presvydt1_q5.5 <- presvydt1[, c(1,32)]
names(presvydt1_q5.5)[2] = c("options")
presvydt1_q5.5[q_5Likert_option_text, id := i.id, on = "options"]

presvydt1_q15 <- presvydt1[, c(1,33)]
names(presvydt1_q15)[2] = c("options")
presvydt1_q15[q_yesno_option_text, id := i.id, on = "options"]

presvydt1_q16 <- presvydt1[, c(1,34)]
names(presvydt1_q16)[2] = c("options")
presvydt1_q16[freq6_option_text, id := i.id, on = "options"]

presvydt1_q17 <- presvydt1[, c(1,35)]
names(presvydt1_q17)[2] = c("options")
presvydt1_q17[freq6_option_text, id := i.id, on = "options"]
rm(freq6_option_text)

presvydt1_q18 <- presvydt1[, c(1,36)]
names(presvydt1_q18)[2] = c("options")
presvydt1_q18[q_yesno_option_text, id := i.id, on = "options"]

presvydt1_q19 <- presvydt1[, c(1,37)]
names(presvydt1_q19)[2] = c("options")
presvydt1_q19[freq_option_driveride_text, id := i.id, on = "options"]
rm(freq_option_driveride_text)

presvydt1_q20 <- presvydt1[, c(1,38)]
names(presvydt1_q20)[2] = c("options")
presvydt1_q20[q_yesno_option_text, id := i.id, on = "options"]

presvydt1_q21 <- presvydt1[, c(1,39)]
names(presvydt1_q21)[2] = c("options")
presvydt1_q21[q_yesno_option_text, id := i.id, on = "options"]

presvydt1_q22 <- presvydt1[, c(1,40)]
names(presvydt1_q22)[2] = c("options")
presvydt1_q22[q_yesno_option_text, id := i.id, on = "options"]

presvydt1_q24 <- presvydt1[, c(1,53)]
names(presvydt1_q24)[2] = c("options")
presvydt1_q25 <- presvydt1[, c(1,54)]
names(presvydt1_q25)[2] = c("options")
presvydt1_q26 <- presvydt1[, c(1,55)]
names(presvydt1_q26)[2] = c("options")

presvydt1_q27 <- presvydt1[, c(1,56)]
names(presvydt1_q27)[2] = c("options")
presvydt1_q27[hhsize_option_text, id := i.id, on = "options"]
rm(hhsize_option_text)

presvydt1_q28 <- presvydt1[, c(1,57,58)]
names(presvydt1_q28)[2:3] = c("options", "others")
presvydt1_q28[educ_option_text, id := i.id, on = "options"]
rm(educ_option_text)

presvydt1_q29 <- presvydt1[, c(1,59,60)]
names(presvydt1_q29)[2:3] = c("options", "others")
presvydt1_q29[employment_option_text, id := i.id, on = "options"]
rm(employment_option_text)

presvydt1_q30 <- presvydt1[, c(1,61,62)]
names(presvydt1_q30)[2:3] = c("options", "others")
presvydt1_q30[race_option_text, id := i.id, on = "options"]
rm(race_option_text)

presvydt1_q31 <- presvydt1[, c(1,63)]
names(presvydt1_q31)[2] = c("options")
presvydt1_q31[hisp_option_text, id := i.id, on = "options"]
rm(hisp_option_text)

presvydt1_q32 <- presvydt1[, c(1,64)]
names(presvydt1_q32)[2] = c("options")
presvydt1_q32[hhinc_option_text, id := i.id, on = "options"]
rm(hhinc_option_text)


# restructure Q25 multiple opition questions
names(presvydt2)
names(presvydt2) = c(paste0("X", 1:6))
presvydt2[, c("notravel1","notravel2","notravel3","notravel4","notravel5","notravel6"):=0]

for (i in 1:nrow(presvydt2)) {
  presvydt2[i, "notravel1"][presvydt2[i, X1] %in% q25_notraveled_option_text[1]] = 1
  presvydt2[i, "notravel2"][presvydt2[i, X2] %in% q25_notraveled_option_text[2]] = 1
  presvydt2[i, "notravel3"][presvydt2[i, X3] %in% q25_notraveled_option_text[3]] = 1
  presvydt2[i, "notravel4"][presvydt2[i, X4] %in% q25_notraveled_option_text[4]] = 1
  presvydt2[i, "notravel5"][presvydt2[i, X5] %in% q25_notraveled_option_text[5]] = 1
  presvydt2[i, "notravel6"][presvydt2[i, X6] %in% q25_notraveled_option_text[6]] = 1
}
presvydt1_q12 <- presvydt2[, c(paste0("X", 1:6)):=NULL]


# restructure Q41 multiple opition questions
names(presvydt3) = c(paste0("X", 1:12))
presvydt3[, c("mobility1","mobility2","mobility3","mobility4","mobility5","mobility6","mobility7","mobility8","mobility9","mobility10","mobility11","mobility12"):=0]

for (i in 1:nrow(presvydt3)) {
  presvydt3[i, "mobility1"][presvydt3[i, X1] %in% q41_mobilityequip_option_text[1]] = 1
  presvydt3[i, "mobility2"][presvydt3[i, X2] %in% q41_mobilityequip_option_text[2]] = 1
  presvydt3[i, "mobility3"][presvydt3[i, X3] %in% q41_mobilityequip_option_text[3]] = 1
  presvydt3[i, "mobility4"][presvydt3[i, X4] %in% q41_mobilityequip_option_text[4]] = 1
  presvydt3[i, "mobility5"][presvydt3[i, X5] %in% q41_mobilityequip_option_text[5]] = 1
  presvydt3[i, "mobility6"][presvydt3[i, X6] %in% q41_mobilityequip_option_text[6]] = 1
  presvydt3[i, "mobility7"][presvydt3[i, X7] %in% q41_mobilityequip_option_text[7]] = 1
  presvydt3[i, "mobility8"][presvydt3[i, X8] %in% q41_mobilityequip_option_text[8]] = 1
  presvydt3[i, "mobility9"][presvydt3[i, X9] %in% q41_mobilityequip_option_text[9]] = 1
  presvydt3[i, "mobility10"][presvydt3[i, X10] %in% q41_mobilityequip_option_text[10]] = 1
  presvydt3[i, "mobility11"][presvydt3[i, X11] %in% q41_mobilityequip_option_text[11]] = 1
  presvydt3[i, "mobility12"][presvydt3[i, X12] %in% q41_mobilityequip_option_text[12]] = 1
}
presvydt1_q23 <- presvydt3[, c(paste0("X", 1:12)):=NULL]

rm(presvydt2, presvydt3)

# PM1_1 : presvydt1_q1.1
# PM1_2 : presvydt1_q1.2
# PM1_3 : presvydt1_q1.3
# PM1_4 : presvydt1_q1.4
# PM1_5 : presvydt1_q1.5
# PM5_4 : presvydt1_q5.4
# PM5_5 : presvydt1_q5.5

# finalize pre survey PM data table -----
presvydt1_q1.1[, row_no:= .I]
presvydt1_q1.2[, row_no:= .I]
presvydt1_q1.3[, row_no:= .I]
presvydt1_q1.4[, row_no:= .I]
presvydt1_q1.5[, row_no:= .I]
presvydt1_q5.4[, row_no:= .I]
presvydt1_q5.5[, row_no:= .I]

presvy_PMs <- merge(presvydt1_q1.1[, .(RespondentID, PM1_1 = id, row_no)], presvydt1_q1.2[, .(RespondentID, PM1_2 = id, row_no)], by = c("RespondentID", "row_no"))
presvy_PMs <- merge(presvy_PMs, presvydt1_q1.3[, .(RespondentID, PM1_3 = id, row_no)], by = c("RespondentID", "row_no"))
presvy_PMs <- merge(presvy_PMs, presvydt1_q1.4[, .(RespondentID, PM1_4 = id, row_no)], by = c("RespondentID", "row_no"))
presvy_PMs <- merge(presvy_PMs, presvydt1_q1.5[, .(RespondentID, PM1_5 = id, row_no)], by = c("RespondentID", "row_no"))
presvy_PMs <- merge(presvy_PMs, presvydt1_q5.4[, .(RespondentID, PM5_4 = id, row_no)], by = c("RespondentID", "row_no"))
presvy_PMs <- merge(presvy_PMs, presvydt1_q5.5[, .(RespondentID, PM5_5 = id, row_no)], by = c("RespondentID", "row_no"))

presvy_PMs[, row_no:= NULL]
write.csv(presvy_PMs, file.path(SYSTEM_APP_INPUT_PATH, paste0("pre_deployment_survey_pm_", Sys.Date(), ".csv", row.names=FALSE)))




# 2. post deployment survey -----------------

names(postsvydt)
postsvydt1 <- postsvydt[2:nrow(postsvydt), ]
# names(postsvydt1)

easy_5Likert_option_text = data.table(id = 1:5, 
                                      options = c("Very easy",
                                                  "Easy",
                                                  "Neutral",
                                                  "Difficult",
                                                  "Very difficult"))

useful_5Likert_option_text = data.table(id = 1:5, 
                                        options = c("Very useful",
                                                    "Useful",
                                                    "Neutral",
                                                    "Not very useful",
                                                    "Not useful at all"))
# PM1_1 : postsvydt1_q1.1, "System user ratings of the ease of making door-to-door trips to, from and within the BNMC."-----
postsvydt1_q1.1 <- postsvydt1[, c(1,16)]
names(postsvydt1_q1.1)[2] = c("options")
postsvydt1_q1.1[q_5Likert_option_text, id := i.id, on = "options"]

# PM1_2 : postsvydt1_q1.2, "System user ratings of how safe door-to-door travel paths are for trips to, from and within the BNMC, including level, slip-resistant paths." -----
postsvydt1_q1.2 <- postsvydt1[, c(1,17)]
names(postsvydt1_q1.2)[2] = c("options")
postsvydt1_q1.2[q_5Likert_option_text, id := i.id, on = "options"]

# PM1_3 : postsvydt1_q1.3, "System user ratings of the availability of information for making trips to, from and within the BNMC"-----
postsvydt1_q1.3 <- postsvydt1[, c(1,15)]
names(postsvydt1_q1.3)[2] = c("options")
postsvydt1_q1.3[q_5Likert_option_text, id := i.id, on = "options"]

# PM1_4: postsvydt1_q1.4, "System user ratings of the usefulness of information for making trips to, from and within the BNMC"-----
postsvydt1_q1.4 <- postsvydt1[, c(1,18)]
names(postsvydt1_q1.4)[2] = c("options")
postsvydt1_q1.4[q_5Likert_option_no_text, id := i.id, on = "options"]

# PM1_5 : postsvydt1_q1.5, "System user ratings of the ability to make trips using integrated transit services. to, from and within the BNMC"-----
postsvydt1_q1.5 <- postsvydt1[, c(1,19)]
names(postsvydt1_q1.5)[2] = c("options")
postsvydt1_q1.5[q_5Likert_option_text, id := i.id, on = "options"]

# PM2_1 : postsvydt1_q2.1, "System user ratings of the ease of the registration process"-----
postsvydt1_q2.1 <- postsvydt1[, c(1,20)]
names(postsvydt1_q2.1)[2] = c("options")
postsvydt1_q2.1[easy_5Likert_option_text, id := i.id, on = "options"]

# PM2_2 : postsvydt1_q5, "System user ratings of the extent to which the options available during registration served their needs"-----
postsvydt1_q2.2 <- postsvydt1[, c(1,21)]
names(postsvydt1_q2.2)[2] = c("options")
postsvydt1_q2.2[useful_5Likert_option_text, id := i.id, on = "options"]

# PM3_1 : postsvydt1_q3.1, "System user ratings of the ease of planning a door-to-door trip route/path"-----
postsvydt1_q3.1 <- postsvydt1[, c(1,24)]
names(postsvydt1_q3.1)[2] = c("options")
postsvydt1_q3.1[easy_5Likert_option_text, id := i.id, on = "options"]

# PM3_2 : postsvydt1_q3.2, "System user ratings of the satisfaction with the specific route/path options provided by the CTP"-----
postsvydt1_q3.2 <- postsvydt1[, c(1,25)]
names(postsvydt1_q3.2)[2] = c("options")
postsvydt1_q3.2[satisfy_5Likert_option_text, id := i.id, on = "options"]

# PM3_3 : (from ctp trip data)

# PM3_4 : postsvydt1_q3.4, "System user ratings of the ease of booking on-demand (CS) transit trips via the system "-----
postsvydt1_q3.4 <- postsvydt1[, c(1,28)]
names(postsvydt1_q3.4)[2] = c("options")
postsvydt1_q3.4[easy_5Likert_option_text, id := i.id, on = "options"]

# PM3_5 : postsvydt1_q3.5, "The percent of CTP users who use the CTP to report incidents or travel conditions during their trips"-----
postsvydt1_q3.5 <- postsvydt1[, c(1,30)]
names(postsvydt1_q3.5)[2] = c("options")
postsvydt1_q3.5[q_yesno_option_text, id := i.id, on = "options"]

# PM3_6 : postsvydt1_q3.6, "System user ratings of the ease of reporting incidents or conditions encountered during a trip in the CTP"-----
postsvydt1_q3.6 <- postsvydt1[, c(1,32)]
names(postsvydt1_q3.6)[2] = c("options")
postsvydt1_q3.6[easy_5Likert_option_text, id := i.id, on = "options"]

# PM3_7 : postsvydt1_q3.7, "The percent of CTP users who use the CTP function to review past trip history"-----
postsvydt1_q3.7 <- postsvydt1[, c(1,34)]
names(postsvydt1_q3.7)[2] = c("options")
postsvydt1_q3.7[freq5_option_text, id := i.id, on = "options"]

# PM3_8 : postsvydt1_q3.8, "System user ratings of the usefulness of reporting past trip history in the CTP"-----
postsvydt1_q3.8 <- postsvydt1[, c(1,35)]
names(postsvydt1_q3.8)[2] = c("options")
postsvydt1_q3.8[useful_5Likert_option_text, id := i.id, on = "options"]


# PM4_1 : (from ctp trip data), "The fraction of CTP users who elect to receive outdoor wayfinding notifications"

# PM4_2 : postsvydt1_q4.2, "System user self-reported frequency of using outdoor wayfinding notifications"-----
postsvydt1_q4.2 <- postsvydt1[, c(1,37)]
names(postsvydt1_q4.2)[2] = c("options")
postsvydt1_q4.2[freq5_option_text, id := i.id, on = "options"]

# PM4_3 : (from ctp trip data), "The fraction of CTP users who elect to receive indoor wayfinding notifications"

# PM4_4 : postsvydt1_q4.4, "System user self-reported frequency of using indoor wayfinding notifications"-----
postsvydt1_q4.4 <- postsvydt1[, c(1,47)]
names(postsvydt1_q4.4)[2] = c("options")
postsvydt1_q4.4[freq5_option_text, id := i.id, on = "options"]

# PM4_5 : postsvydt1_q4.5, "System user ratings of the how useful the outdoor wayfinding functionality is in reaching their trip destination on time "-----
postsvydt1_q4.5 <- postsvydt1[, c(1,38)]
names(postsvydt1_q4.5)[2] = c("options")
postsvydt1_q4.5[useful_5Likert_option_text, id := i.id, on = "options"]

# PM4_6 : postsvydt1_q4.6, "System user ratings of the how useful the indoor wayfinding functionality is in reaching their trip destination on time "-----
postsvydt1_q4.6 <- postsvydt1[, c(1,48)]
names(postsvydt1_q4.6)[2] = c("options")
postsvydt1_q4.6[useful_5Likert_option_text, id := i.id, on = "options"]

# PM4_7 : postsvydt1_q4.7, "User ratings of various dimensions of using the CTP outdoor wayfinding functionality using the RAPUUD method "-----
# PM4_7.1 This feature is easy to use.
postsvydt1_q4.7.1 <- postsvydt1[, c(1,39)]
names(postsvydt1_q4.7.1)[2] = c("options")
postsvydt1_q4.7.1[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_7.2 For me, using this feature poses a personal safety risk.
postsvydt1_q4.7.2 <- postsvydt1[, c(1,40)]
names(postsvydt1_q4.7.2)[2] = c("options")
postsvydt1_q4.7.2[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_7.3 I often need assistance to use this feature.
postsvydt1_q4.7.3 <- postsvydt1[, c(1,41)]
names(postsvydt1_q4.7.3)[2] = c("options")
postsvydt1_q4.7.3[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_7.4 When using this feature, I make mistakes that require me to do over some steps.
postsvydt1_q4.7.4 <- postsvydt1[, c(1,42)]
names(postsvydt1_q4.7.4)[2] = c("options")
postsvydt1_q4.7.4[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_7.5 Using this feature takes more time than it should.
postsvydt1_q4.7.5 <- postsvydt1[, c(1,43)]
names(postsvydt1_q4.7.5)[2] = c("options")
postsvydt1_q4.7.5[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_7.6 Using this feature requires minimal mental effort.
postsvydt1_q4.7.6 <- postsvydt1[, c(1,44)]
names(postsvydt1_q4.7.6)[2] = c("options")
postsvydt1_q4.7.6[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_7.7 Using this feature draws unwanted attention to me.
postsvydt1_q4.7.7 <- postsvydt1[, c(1,45)]
names(postsvydt1_q4.7.7)[2] = c("options")
postsvydt1_q4.7.7[q_5Likert_option_text, id := i.id, on = "options"]


# PM4_8 : postsvydt1_q4.8, "User ratings of various dimensions of using the CTP indoor wayfinding functionality using the RAPUUD method "-----

# names(postsvydt1)
# PM4_8.1 For me, using this feature poses a personal safety risk.
postsvydt1_q4.8.1 <- postsvydt1[, c(1,49)]
names(postsvydt1_q4.8.1)[2] = c("options")
postsvydt1_q4.8.1[q_5Likert_option_text, id := i.id, on = "options"]
names(postsvydt1)[1:50]

# PM4_8.2 For me, using this feature poses a personal safety risk.
postsvydt1_q4.8.2 <- postsvydt1[, c(1,50)]
names(postsvydt1_q4.8.2)[2] = c("options")
postsvydt1_q4.8.2[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_8.3 I often need assistance to use this feature.
postsvydt1_q4.8.3 <- postsvydt1[, c(1,51)]
names(postsvydt1_q4.8.3)[2] = c("options")
postsvydt1_q4.8.3[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_8.4 When using this feature, I make mistakes that require me to do over some steps.
postsvydt1_q4.8.4 <- postsvydt1[, c(1,52)]
names(postsvydt1_q4.8.4)[2] = c("options")
postsvydt1_q4.8.4[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_8.5 Using this feature takes more time than it should.
postsvydt1_q4.8.5 <- postsvydt1[, c(1,53)]
names(postsvydt1_q4.8.5)[2] = c("options")
postsvydt1_q4.8.5[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_8.6 Using this feature requires minimal mental effort.
postsvydt1_q4.8.6 <- postsvydt1[, c(1,54)]
names(postsvydt1_q4.8.6)[2] = c("options")
postsvydt1_q4.8.6[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_8.7 Using this feature draws unwanted attention to me.
postsvydt1_q4.8.7 <- postsvydt1[, c(1,55)]
names(postsvydt1_q4.8.7)[2] = c("options")
postsvydt1_q4.8.7[q_5Likert_option_text, id := i.id, on = "options"]


# PM5_1 : (from ctp trip data), "The percent of CTP trips crossing at the relevant intersections who use the smart signal remote activation function."

# PM5_2 : postsvydt1_q5.2, "Self-reported fraction of people who cross at the relevant intersections who use the CTP smart signal activation functionality"-----
postsvydt1_q5.2 <- postsvydt1[, c(1,56)]
names(postsvydt1_q5.2)[2] = c("options")
postsvydt1_q5.2[CrossIntersect_option_text, id := i.id, on = "options"]

# PM5_3 : postsvydt1_q5.3, "Perceived ease of use and ratings of various aspects of using the smart signals, using the RAPUUD method"-----
postsvydt1_q5.3 <- postsvydt1[, c(1,58)]
names(postsvydt1_q5.3)[2] = c("options")
postsvydt1_q5.3[easy_5Likert_option_text, id := i.id, on = "options"]

# PM5_4 : postsvydt1_q5.4, "Self-reported frequency of crossing at the intersections with smart signals"-----
postsvydt1_q5.4 <- postsvydt1[, c(1,57)]
names(postsvydt1_q5.4)[2] = c("options")
postsvydt1_q5.4[freq5_option_text, id := i.id, on = "options"]

# PM5_5 : postsvydt1_q5.5, "Perceived safety of crossing the intersections with smart signals"-----
postsvydt1_q5.5 <- postsvydt1[, c(1,60)]
names(postsvydt1_q5.5)[2] = c("options")
postsvydt1_q5.5[q_5Likert_option_text, id := i.id, on = "options"]

# PM6_1 : (from ctp trip data), "Percent of CS trips that arrive at the boarding stop within the targeted time allowance of the scheduled arrival time "

# PM6_2 : (from ctp trip data), "Percent of CS trips that arrive at the alighting stop within the targeted time allowance of the scheduled arrival time "

# PM6_3 : (HDS and SDS Operations data, supplemented by additional system cost data), "Cost efficiency of the HDS and SDS shuttle services in terms of operating cost per passenger trip."-----







=======

# A list of PMs from pre-deployment survey: matched questions, data.table
# PM1_1 : presvydt1_q1.1
# PM1_2 : presvydt1_q1.2
# PM1_3 : presvydt1_q1.3
# PM1_4 : presvydt1_q1.4
# PM1_5 : presvydt1_q1.5
# PM5_4 : presvydt1_q5.4
# PM5_5  presvydt1_q5.5

# rm(list=ls())
# source('config.R')
>>>>>>> b5b469218986539869bacefb9bbb304ddca87065



# 0 list of survey answer options ===================
freq6_option_text = data.table(id = 1:6, 
                               options = c("Every day or almost every day",
                                           "At least once a week",
                                           "At least once a month",
                                           "5 to 10 times in the past 12 months",
                                           "1 to 4 times in the past 12 months",
                                           "Not at all in the past 12 months"))

freq5_option_text = data.table(id = 1:5, 
                               options = c("Every day or almost every day",
                                           "At least once a week",
                                           "At least once a month",
                                           "Only once or twice",
                                           "Not at all"))


freq_option_driveride_text = data.table(id = 1:5,
                                        options = c("Every day or almost every day",
                                                    "At least once a week",
                                                    "At least once a month",
                                                    "Multiple times in the past 12 months",
                                                    "Never"))


FreqT2BNMC_option_textMC_option_text = data.table(id = 1:8, 
                                                  options = c("Every day or almost every day",
                                                              "At least once a week",
                                                              "At least once a month",
                                                              "About every two months",
                                                              "Multiple times in the last 12 months",
                                                              "Only once in the last 12 months",
                                                              "Have traveled there, but not in the last 12 months",
                                                              "Have never traveled there"))

Purp2BNMC_option_text = data.table(id = 1:6, 
                                   options = c("Work", 
                                               "Healthcare services (i.e., in or outpatient treatment)",
                                               "School",
                                               "Visit family/friend(s) receiving healthcare services",
                                               "Accompany a patient to a medical visit",
                                               "Other (please specify)))"))

Mode2BNMC_option_text = data.table(id = 1:9, 
                                   options = c("Driver in a personal vehicle",
                                               "Passenger in a personal vehicle",
                                               "NFTA-Metro paratransit (PAL) service",
                                               "Other shuttle service for persons with disabilities",
                                               "NFTA bus or light rail service",
                                               "Taxi, Uber, or Lyft",
                                               "Walk / wheelchair",
                                               "Bicycle",
                                               "Other (please specify)"))
Assist2BNMC_option_text = data.table(id = 1:4, 
                                     options = c("No",
                                                 "Yes, a family member or friend",
                                                 "Yes, a professional caregiver or assistant",
                                                 "Other (please specify)"))

q_5Likert_option_text = data.table(id = 1:5, 
                                   options = c("Strongly agree",
                                               "Somewhat agree",
                                               "Neither agree nor disagree",
                                               "Somewhat disagree",
                                               "Strongly disagree"))

q_5Likert_option_no_text = data.table(id = 1:6, 
                                      options = c("Strongly agree",
                                                  "Somewhat agree",
                                                  "Neither agree nor disagree",
                                                  "Somewhat disagree",
                                                  "Strongly disagree",
                                                  "I have not used public transportation to travel to/from the BNMC"))

q_yesno_option_text = data.table(id = 1:2, options = c("Yes", "No"))

CrossIntersect_option_text = data.table(id = 1:3, 
                                        options = c("Yes, quite often",
                                                    "Yes, but not very often",
                                                    "No, not at all"))

easy_5Likert_option_text = data.table(id = 1:5, 
                                      options = c("Very easy",
                                                  "Easy",
                                                  "Neutral",
                                                  "Difficult",
                                                  "Very difficult"))

useful_5Likert_option_text = data.table(id = 1:5, 
                                        options = c("Very useful",
                                                    "Useful",
                                                    "Neutral",
                                                    "Not very useful",
                                                    "Not useful at all"))

satisfy_5Likert_option_text = data.table(id = 1:5, 
                                         options = c("Very satisfied",
                                                     "Satisfied",
                                                     "Neutral",
                                                     "Unsatisfied",
                                                     "Very Unsatisfied"))

reliable_5Likert_option_text = data.table(id = 1:5, 
                                          options = c("Very reliable",
                                                      "Somewhat reliable",
                                                      "Neutral",
                                                      "Somewhat unreliable",
                                                      "Very unreliable"))

hhsize_option_text = data.table(id = 1:5, 
                                options = c("1 person (only yourself)",
                                            "2 people",
                                            "3 people",
                                            "4 people",
                                            "5 or more people"))
educ_option_text = data.table(id = 1:7, 
                              options = c("Less than high school, high school diploma or GED",
                                          "Some college",
                                          "Associate’s degree",
                                          "Bachelor’s degree",
                                          "Graduate degree or higher",
                                          "Prefer not to answer",
                                          "Other (please specify)"))
employment_option_text = data.table(id = 1:6, 
                                    options = c("Employed, working full-time",
                                                "Employed, working part-time",
                                                "Not employed, looking for employment",
                                                "Retired",
                                                "Prefer not to answer",
                                                "Other (please describe)"))

race_option_text = data.table(id = 1:7, 
                              options = c("American Indian or Alaska Native",
                                          "Asian",
                                          "Black or African American",
                                          "Native Hawaiian or Other Pacific Islander",
                                          "White",
                                          "Prefer not to answer",
                                          "Two or more races (please describe)"))


hhinc_option_text = data.table(id = 1:8, 
                               options = c("Less than $10,000",
                                           "$10,000 to $24,999",
                                           "$25,000 to $49,999",
                                           "$50,000 to $74,999",
                                           "$75,000 to $99,999",
                                           "$100,000 to $149,999",
                                           "$150,000 or more",
                                           "Prefer not to answer"))

hisp_option_text = data.table(id = 1:3, options = c("Yes", "No", "Prefer not to answer"))

# 1 baseline survey data processing  -----------------------------------
presvydt
names(presvydt)
str(presvydt)
cols_index_otherspecified = c(12,14,16,18,58,60,62)
# cols_index_reason_notraveled_option = 26:30
# cols_index_mobilityequip_option = 42:52
cols_index_reason_notraveled_option0 = 25:30
cols_index_mobilityequip_option0 = 41:52

q25_notraveled_option_text = unlist(unname(presvydt[1, ..cols_index_reason_notraveled_option0]))
q41_mobilityequip_option_text = unlist(unname(presvydt[1, ..cols_index_mobilityequip_option0]))

presvydt1 <- presvydt[2:nrow(presvydt), ]
presvydt2 <- presvydt[2:nrow(presvydt), ..cols_index_reason_notraveled_option0]
presvydt3 <- presvydt[2:nrow(presvydt), ..cols_index_mobilityequip_option0]

# label column with question order 
# names(presvydt1)[10] <- c("Q1")
# names(presvydt1)[11:12] <- c("Q2", "Q2o")
# names(presvydt1)[13:14] <- c("Q3", "Q3o")
# names(presvydt1)[15:16] <- c("Q4", "Q4o")
# names(presvydt1)[17:18] <- c("Q5", "Q5o")
# names(presvydt1)[19:24] <- paste0("Q", 6:11)
# names(presvydt1)[25:30] <- paste0("Q12_",1:6)
# names(presvydt1)[31:40] <- paste0("Q", 13:22)
# names(presvydt1)[41:52] <- paste0("Q23_",1:12)
# names(presvydt1)[53:56] <- paste0("Q", 24:27)
# names(presvydt1)[57:58] <- c("Q28", "Q28o")
# names(presvydt1)[59:60] <- c("Q29", "Q29o")
# names(presvydt1)[61:62] <- c("Q30", "Q30o")
# names(presvydt1)[63:64] <- paste0("Q", 31:32)
# names(presvydt1)[65] <- "remark"
# names(presvydt1)[66] <- "drawing"

names(presvydt1) <- gsub(" ", "", names(presvydt1))

## 
presvydt1_q1 <- presvydt1[, c(1,10)]
names(presvydt1_q1)[2] = "options"
presvydt1_q1[FreqT2BNMC_option_textMC_option_text, id := i.id, on = "options"]
rm(FreqT2BNMC_option_textMC_option_text)

presvydt1_q2 <- presvydt1[, c(1,11,12)]
names(presvydt1_q2)[2:3] = c("options", "others")
presvydt1_q2[Purp2BNMC_option_text, id := i.id, on = "options"]

presvydt1_q3 <- presvydt1[, c(1,13,14)]
names(presvydt1_q3)[2:3] = c("options", "others")
presvydt1_q3[Mode2BNMC_option_text, id := i.id, on = "options"]
rm(Mode2BNMC_option_text)

presvydt1_q4 <- presvydt1[, c(1,15,16)]
names(presvydt1_q4)[2:3] = c("options", "others")
presvydt1_q4[Assist2BNMC_option_text, id := i.id, on = "options"]

presvydt1_q5 <- presvydt1[, c(1,17,18)]
names(presvydt1_q5)[2:3] = c("options", "others")
presvydt1_q5[Assist2BNMC_option_text, id := i.id, on = "options"]

# PM1_1 : presvydt1_q1.1, "System user ratings of the ease of making door-to-door trips to, from and within the BNMC." -----
presvydt1_q1.1 <- presvydt1[, c(1,21)]
names(presvydt1_q1.1)[2] = c("options")
presvydt1_q1.1[q_5Likert_option_text, id := i.id, on = "options"]

# PM1_2 : presvydt1_q1.2, "System user ratings of how safe door-to-door travel paths are for trips to, from and within the BNMC, including level, slip-resistant paths." -----
presvydt1_q1.2 <- presvydt1[, c(1,22)]
names(presvydt1_q1.2)[2] = c("options")
presvydt1_q1.2[q_5Likert_option_text, id := i.id, on = "options"]

# PM1_3 : presvydt1_q1.3, "System user ratings of the availability of information for making trips to, from and within the BNMC"-----
presvydt1_q1.3 <- presvydt1[, c(1,19)]
names(presvydt1_q1.3)[2] = c("options")
presvydt1_q1.3[q_5Likert_option_text, id := i.id, on = "options"]

# PM1_4: presvydt1_q1.4, "System user ratings of the usefulness of information for making trips to, from and within the BNMC"-----
presvydt1_q1.4 <- presvydt1[, c(1,20)]
names(presvydt1_q1.4)[2] = c("options")
presvydt1_q1.4[q_5Likert_option_no_text, id := i.id, on = "options"]

# PM1_5 : presvydt1_q1.5, "System user ratings of the ability to make trips using integrated transit services. to, from and within the BNMC"-----
presvydt1_q1.5 <- presvydt1[, c(1,23)]
names(presvydt1_q1.5)[2] = c("options")
presvydt1_q1.5[q_5Likert_option_text, id := i.id, on = "options"]

presvydt1_q11 <- presvydt1[, c(1,24)]
names(presvydt1_q11)[2] = c("options")
presvydt1_q11[q_5Likert_option_text, id := i.id, on = "options"]

presvydt1_q5.4 <- presvydt1[, c(1,31)]
names(presvydt1_q5.4)[2] = c("options")
presvydt1_q5.4[CrossIntersect_option_text, id := i.id, on = "options"]

# PM5_5 : presvydt1_q5.5, "Perceived safety of crossing the intersections with smart signals"-----
presvydt1_q5.5 <- presvydt1[, c(1,32)]
names(presvydt1_q5.5)[2] = c("options")
presvydt1_q5.5[q_5Likert_option_text, id := i.id, on = "options"]

presvydt1_q15 <- presvydt1[, c(1,33)]
names(presvydt1_q15)[2] = c("options")
presvydt1_q15[q_yesno_option_text, id := i.id, on = "options"]

presvydt1_q16 <- presvydt1[, c(1,34)]
names(presvydt1_q16)[2] = c("options")
presvydt1_q16[freq6_option_text, id := i.id, on = "options"]

presvydt1_q17 <- presvydt1[, c(1,35)]
names(presvydt1_q17)[2] = c("options")
presvydt1_q17[freq6_option_text, id := i.id, on = "options"]
rm(freq6_option_text)

presvydt1_q18 <- presvydt1[, c(1,36)]
names(presvydt1_q18)[2] = c("options")
presvydt1_q18[q_yesno_option_text, id := i.id, on = "options"]

presvydt1_q19 <- presvydt1[, c(1,37)]
names(presvydt1_q19)[2] = c("options")
presvydt1_q19[freq_option_driveride_text, id := i.id, on = "options"]
rm(freq_option_driveride_text)

presvydt1_q20 <- presvydt1[, c(1,38)]
names(presvydt1_q20)[2] = c("options")
presvydt1_q20[q_yesno_option_text, id := i.id, on = "options"]

presvydt1_q21 <- presvydt1[, c(1,39)]
names(presvydt1_q21)[2] = c("options")
presvydt1_q21[q_yesno_option_text, id := i.id, on = "options"]

presvydt1_q22 <- presvydt1[, c(1,40)]
names(presvydt1_q22)[2] = c("options")
presvydt1_q22[q_yesno_option_text, id := i.id, on = "options"]

presvydt1_q24 <- presvydt1[, c(1,53)]
names(presvydt1_q24)[2] = c("options")
presvydt1_q25 <- presvydt1[, c(1,54)]
names(presvydt1_q25)[2] = c("options")
presvydt1_q26 <- presvydt1[, c(1,55)]
names(presvydt1_q26)[2] = c("options")

presvydt1_q27 <- presvydt1[, c(1,56)]
names(presvydt1_q27)[2] = c("options")
presvydt1_q27[hhsize_option_text, id := i.id, on = "options"]
rm(hhsize_option_text)

presvydt1_q28 <- presvydt1[, c(1,57,58)]
names(presvydt1_q28)[2:3] = c("options", "others")
presvydt1_q28[educ_option_text, id := i.id, on = "options"]
rm(educ_option_text)

presvydt1_q29 <- presvydt1[, c(1,59,60)]
names(presvydt1_q29)[2:3] = c("options", "others")
presvydt1_q29[employment_option_text, id := i.id, on = "options"]
rm(employment_option_text)

presvydt1_q30 <- presvydt1[, c(1,61,62)]
names(presvydt1_q30)[2:3] = c("options", "others")
presvydt1_q30[race_option_text, id := i.id, on = "options"]
rm(race_option_text)

presvydt1_q31 <- presvydt1[, c(1,63)]
names(presvydt1_q31)[2] = c("options")
presvydt1_q31[hisp_option_text, id := i.id, on = "options"]
rm(hisp_option_text)

presvydt1_q32 <- presvydt1[, c(1,64)]
names(presvydt1_q32)[2] = c("options")
presvydt1_q32[hhinc_option_text, id := i.id, on = "options"]
rm(hhinc_option_text)


# restructure Q25 multiple opition questions
names(presvydt2)
names(presvydt2) = c(paste0("X", 1:6))
presvydt2[, c("notravel1","notravel2","notravel3","notravel4","notravel5","notravel6"):=0]

for (i in 1:nrow(presvydt2)) {
  presvydt2[i, "notravel1"][presvydt2[i, X1] %in% q25_notraveled_option_text[1]] = 1
  presvydt2[i, "notravel2"][presvydt2[i, X2] %in% q25_notraveled_option_text[2]] = 1
  presvydt2[i, "notravel3"][presvydt2[i, X3] %in% q25_notraveled_option_text[3]] = 1
  presvydt2[i, "notravel4"][presvydt2[i, X4] %in% q25_notraveled_option_text[4]] = 1
  presvydt2[i, "notravel5"][presvydt2[i, X5] %in% q25_notraveled_option_text[5]] = 1
  presvydt2[i, "notravel6"][presvydt2[i, X6] %in% q25_notraveled_option_text[6]] = 1
}
presvydt1_q12 <- presvydt2[, c(paste0("X", 1:6)):=NULL]


# restructure Q41 multiple opition questions
names(presvydt3) = c(paste0("X", 1:12))
presvydt3[, c("mobility1","mobility2","mobility3","mobility4","mobility5","mobility6","mobility7","mobility8","mobility9","mobility10","mobility11","mobility12"):=0]

for (i in 1:nrow(presvydt3)) {
  presvydt3[i, "mobility1"][presvydt3[i, X1] %in% q41_mobilityequip_option_text[1]] = 1
  presvydt3[i, "mobility2"][presvydt3[i, X2] %in% q41_mobilityequip_option_text[2]] = 1
  presvydt3[i, "mobility3"][presvydt3[i, X3] %in% q41_mobilityequip_option_text[3]] = 1
  presvydt3[i, "mobility4"][presvydt3[i, X4] %in% q41_mobilityequip_option_text[4]] = 1
  presvydt3[i, "mobility5"][presvydt3[i, X5] %in% q41_mobilityequip_option_text[5]] = 1
  presvydt3[i, "mobility6"][presvydt3[i, X6] %in% q41_mobilityequip_option_text[6]] = 1
  presvydt3[i, "mobility7"][presvydt3[i, X7] %in% q41_mobilityequip_option_text[7]] = 1
  presvydt3[i, "mobility8"][presvydt3[i, X8] %in% q41_mobilityequip_option_text[8]] = 1
  presvydt3[i, "mobility9"][presvydt3[i, X9] %in% q41_mobilityequip_option_text[9]] = 1
  presvydt3[i, "mobility10"][presvydt3[i, X10] %in% q41_mobilityequip_option_text[10]] = 1
  presvydt3[i, "mobility11"][presvydt3[i, X11] %in% q41_mobilityequip_option_text[11]] = 1
  presvydt3[i, "mobility12"][presvydt3[i, X12] %in% q41_mobilityequip_option_text[12]] = 1
}
presvydt1_q23 <- presvydt3[, c(paste0("X", 1:12)):=NULL]

rm(presvydt2, presvydt3)

# PM1_1 : presvydt1_q1.1
# PM1_2 : presvydt1_q1.2
# PM1_3 : presvydt1_q1.3
# PM1_4 : presvydt1_q1.4
# PM1_5 : presvydt1_q1.5
# PM5_4 : presvydt1_q5.4
# PM5_5 : presvydt1_q5.5

# finalize pre survey PM data table -----
presvy_PMs <- merge(presvydt1_q1.1[, .(RespondentID, PM1_1 = id)], presvydt1_q1.2[, .(RespondentID, PM1_2 = id)], by = "RespondentID")
presvy_PMs <- merge(presvy_PMs, presvydt1_q1.3[, .(RespondentID, PM1_3 = id)], by = "RespondentID")
presvy_PMs <- merge(presvy_PMs, presvydt1_q1.4[, .(RespondentID, PM1_4 = id)], by = "RespondentID")
presvy_PMs <- merge(presvy_PMs, presvydt1_q1.5[, .(RespondentID, PM1_5 = id)], by = "RespondentID")
presvy_PMs <- merge(presvy_PMs, presvydt1_q5.4[, .(RespondentID, PM5_4 = id)], by = "RespondentID")
presvy_PMs <- merge(presvy_PMs, presvydt1_q5.5[, .(RespondentID, PM5_5 = id)], by = "RespondentID")


write.csv(presvy_PMs, file.path(SYSTEM_APP_INPUT_PATH, paste0("pre_deployment_survey_pm_", Sys.Date(), ".csv")))




# 2. post deployment survey -----------------

postsvydt1 <- postsvydt[2:nrow(postsvydt), ]
names(postsvydt1) <- gsub(" ", "", names(postsvydt1))

# names(postsvydt1)

postsvydt1[,50:59]
easy_5Likert_option_text = data.table(id = 1:5, 
                                      options = c("Very easy",
                                                  "Easy",
                                                  "Neutral",
                                                  "Difficult",
                                                  "Very difficult"))

useful_5Likert_option_text = data.table(id = 1:5, 
                                        options = c("Very useful",
                                                    "Useful",
                                                    "Neutral",
                                                    "Not very useful",
                                                    "Not useful at all"))
# PM1_1 : postsvydt1_q1.1, "System user ratings of the ease of making door-to-door trips to, from and within the BNMC."-----
postsvydt1_q1.1 <- postsvydt1[, c(1,16)]
names(postsvydt1_q1.1)[2] = c("options")
postsvydt1_q1.1[q_5Likert_option_text, id := i.id, on = "options"]

# PM1_2 : postsvydt1_q1.2, "System user ratings of how safe door-to-door travel paths are for trips to, from and within the BNMC, including level, slip-resistant paths." -----
postsvydt1_q1.2 <- postsvydt1[, c(1,17)]
names(postsvydt1_q1.2)[2] = c("options")
postsvydt1_q1.2[q_5Likert_option_text, id := i.id, on = "options"]

# PM1_3 : postsvydt1_q1.3, "System user ratings of the availability of information for making trips to, from and within the BNMC"-----
postsvydt1_q1.3 <- postsvydt1[, c(1,15)]
names(postsvydt1_q1.3)[2] = c("options")
postsvydt1_q1.3[q_5Likert_option_text, id := i.id, on = "options"]

# PM1_4: postsvydt1_q1.4, "System user ratings of the usefulness of information for making trips to, from and within the BNMC"-----
postsvydt1_q1.4 <- postsvydt1[, c(1,18)]
names(postsvydt1_q1.4)[2] = c("options")
postsvydt1_q1.4[q_5Likert_option_no_text, id := i.id, on = "options"]

# PM1_5 : postsvydt1_q1.5, "System user ratings of the ability to make trips using integrated transit services. to, from and within the BNMC"-----
postsvydt1_q1.5 <- postsvydt1[, c(1,19)]
names(postsvydt1_q1.5)[2] = c("options")
postsvydt1_q1.5[q_5Likert_option_text, id := i.id, on = "options"]

# PM2_1 : postsvydt1_q2.1, "System user ratings of the ease of the registration process"-----
postsvydt1_q2.1 <- postsvydt1[, c(1,20)]
names(postsvydt1_q2.1)[2] = c("options")
postsvydt1_q2.1[easy_5Likert_option_text, id := i.id, on = "options"]

# PM2_2 : postsvydt1_q5, "System user ratings of the extent to which the options available during registration served their needs"-----
postsvydt1_q2.2 <- postsvydt1[, c(1,21)]
names(postsvydt1_q2.2)[2] = c("options")
postsvydt1_q2.2[useful_5Likert_option_text, id := i.id, on = "options"]

# PM3_1 : postsvydt1_q3.1, "System user ratings of the ease of planning a door-to-door trip route/path"-----
postsvydt1_q3.1 <- postsvydt1[, c(1,24)]
names(postsvydt1_q3.1)[2] = c("options")
postsvydt1_q3.1[easy_5Likert_option_text, id := i.id, on = "options"]

# PM3_2 : postsvydt1_q3.2, "System user ratings of the satisfaction with the specific route/path options provided by the CTP"-----
postsvydt1_q3.2 <- postsvydt1[, c(1,25)]
names(postsvydt1_q3.2)[2] = c("options")
postsvydt1_q3.2[satisfy_5Likert_option_text, id := i.id, on = "options"]

# PM3_3 : (from ctp trip data)

# PM3_4 : postsvydt1_q3.4, "System user ratings of the ease of booking on-demand (CS) transit trips via the system "-----
postsvydt1_q3.4 <- postsvydt1[, c(1,28)]
names(postsvydt1_q3.4)[2] = c("options")
postsvydt1_q3.4[easy_5Likert_option_text, id := i.id, on = "options"]

# PM3_5 : postsvydt1_q3.5, "The percent of CTP users who use the CTP to report incidents or travel conditions during their trips"-----
postsvydt1_q3.5 <- postsvydt1[, c(1,30)]
names(postsvydt1_q3.5)[2] = c("options")
postsvydt1_q3.5[q_yesno_option_text, id := i.id, on = "options"]

# PM3_6 : postsvydt1_q3.6, "System user ratings of the ease of reporting incidents or conditions encountered during a trip in the CTP"-----
postsvydt1_q3.6 <- postsvydt1[, c(1,32)]
names(postsvydt1_q3.6)[2] = c("options")
postsvydt1_q3.6[easy_5Likert_option_text, id := i.id, on = "options"]

# PM3_7 : postsvydt1_q3.7, "The percent of CTP users who use the CTP function to review past trip history"-----
postsvydt1_q3.7 <- postsvydt1[, c(1,34)]
names(postsvydt1_q3.7)[2] = c("options")
postsvydt1_q3.7[freq5_option_text, id := i.id, on = "options"]

# PM3_8 : postsvydt1_q3.8, "System user ratings of the usefulness of reporting past trip history in the CTP"-----
postsvydt1_q3.8 <- postsvydt1[, c(1,35)]
names(postsvydt1_q3.8)[2] = c("options")
postsvydt1_q3.8[useful_5Likert_option_text, id := i.id, on = "options"]


# PM4_1 : (from ctp trip data), "The fraction of CTP users who elect to receive outdoor wayfinding notifications"

# PM4_2 : postsvydt1_q4.2, "System user self-reported frequency of using outdoor wayfinding notifications"-----
postsvydt1_q4.2 <- postsvydt1[, c(1,37)]
names(postsvydt1_q4.2)[2] = c("options")
postsvydt1_q4.2[freq5_option_text, id := i.id, on = "options"]

# PM4_3 : (from ctp trip data), "The fraction of CTP users who elect to receive indoor wayfinding notifications"

# PM4_4 : postsvydt1_q4.4, "System user self-reported frequency of using indoor wayfinding notifications"-----
postsvydt1_q4.4 <- postsvydt1[, c(1,47)]
names(postsvydt1_q4.4)[2] = c("options")
postsvydt1_q4.4[freq5_option_text, id := i.id, on = "options"]

# PM4_5 : postsvydt1_q4.5, "System user ratings of the how useful the outdoor wayfinding functionality is in reaching their trip destination on time "-----
postsvydt1_q4.5 <- postsvydt1[, c(1,38)]
names(postsvydt1_q4.5)[2] = c("options")
postsvydt1_q4.5[useful_5Likert_option_text, id := i.id, on = "options"]

# PM4_6 : postsvydt1_q4.6, "System user ratings of the how useful the indoor wayfinding functionality is in reaching their trip destination on time "-----
postsvydt1_q4.6 <- postsvydt1[, c(1,48)]
names(postsvydt1_q4.6)[2] = c("options")
postsvydt1_q4.6[useful_5Likert_option_text, id := i.id, on = "options"]

# PM4_7 : postsvydt1_q4.7, "User ratings of various dimensions of using the CTP outdoor wayfinding functionality using the RAPUUD method "-----
# PM4_7.1 This feature is easy to use.
postsvydt1_q4.7.1 <- postsvydt1[, c(1,39)]
names(postsvydt1_q4.7.1)[2] = c("options")
postsvydt1_q4.7.1[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_7.2 For me, using this feature poses a personal safety risk.
postsvydt1_q4.7.2 <- postsvydt1[, c(1,40)]
names(postsvydt1_q4.7.2)[2] = c("options")
postsvydt1_q4.7.2[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_7.3 I often need assistance to use this feature.
postsvydt1_q4.7.3 <- postsvydt1[, c(1,41)]
names(postsvydt1_q4.7.3)[2] = c("options")
postsvydt1_q4.7.3[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_7.4 When using this feature, I make mistakes that require me to do over some steps.
postsvydt1_q4.7.4 <- postsvydt1[, c(1,42)]
names(postsvydt1_q4.7.4)[2] = c("options")
postsvydt1_q4.7.4[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_7.5 Using this feature takes more time than it should.
postsvydt1_q4.7.5 <- postsvydt1[, c(1,43)]
names(postsvydt1_q4.7.5)[2] = c("options")
postsvydt1_q4.7.5[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_7.6 Using this feature requires minimal mental effort.
postsvydt1_q4.7.6 <- postsvydt1[, c(1,44)]
names(postsvydt1_q4.7.6)[2] = c("options")
postsvydt1_q4.7.6[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_7.7 Using this feature draws unwanted attention to me.
postsvydt1_q4.7.7 <- postsvydt1[, c(1,45)]
names(postsvydt1_q4.7.7)[2] = c("options")
postsvydt1_q4.7.7[q_5Likert_option_text, id := i.id, on = "options"]


# PM4_8 : postsvydt1_q4.8, "User ratings of various dimensions of using the CTP indoor wayfinding functionality using the RAPUUD method "-----

# names(postsvydt1)
# PM4_8.1 For me, using this feature poses a personal safety risk.
postsvydt1_q4.8.1 <- postsvydt1[, c(1,49)]
names(postsvydt1_q4.8.1)[2] = c("options")
postsvydt1_q4.8.1[q_5Likert_option_text, id := i.id, on = "options"]
names(postsvydt1)[1:50]

# PM4_8.2 For me, using this feature poses a personal safety risk.
postsvydt1_q4.8.2 <- postsvydt1[, c(1,50)]
names(postsvydt1_q4.8.2)[2] = c("options")
postsvydt1_q4.8.2[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_8.3 I often need assistance to use this feature.
postsvydt1_q4.8.3 <- postsvydt1[, c(1,51)]
names(postsvydt1_q4.8.3)[2] = c("options")
postsvydt1_q4.8.3[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_8.4 When using this feature, I make mistakes that require me to do over some steps.
postsvydt1_q4.8.4 <- postsvydt1[, c(1,52)]
names(postsvydt1_q4.8.4)[2] = c("options")
postsvydt1_q4.8.4[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_8.5 Using this feature takes more time than it should.
postsvydt1_q4.8.5 <- postsvydt1[, c(1,53)]
names(postsvydt1_q4.8.5)[2] = c("options")
postsvydt1_q4.8.5[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_8.6 Using this feature requires minimal mental effort.
postsvydt1_q4.8.6 <- postsvydt1[, c(1,54)]
names(postsvydt1_q4.8.6)[2] = c("options")
postsvydt1_q4.8.6[q_5Likert_option_text, id := i.id, on = "options"]

# PM4_8.7 Using this feature draws unwanted attention to me.
postsvydt1_q4.8.7 <- postsvydt1[, c(1,55)]
names(postsvydt1_q4.8.7)[2] = c("options")
postsvydt1_q4.8.7[q_5Likert_option_text, id := i.id, on = "options"]


# PM5_1 : (from ctp trip data), "The percent of CTP trips crossing at the relevant intersections who use the smart signal remote activation function."

# PM5_2 : postsvydt1_q5.2, "Self-reported fraction of people who cross at the relevant intersections who use the CTP smart signal activation functionality"-----
postsvydt1_q5.2 <- postsvydt1[, c(1,56)]
names(postsvydt1_q5.2)[2] = c("options")
postsvydt1_q5.2[CrossIntersect_option_text, id := i.id, on = "options"]

# PM5_3 : postsvydt1_q5.3, "Perceived ease of use and ratings of various aspects of using the smart signals, using the RAPUUD method"-----
postsvydt1_q5.3 <- postsvydt1[, c(1,58)]
names(postsvydt1_q5.3)[2] = c("options")
postsvydt1_q5.3[easy_5Likert_option_text, id := i.id, on = "options"]

# PM5_4 : postsvydt1_q5.4, "Self-reported frequency of crossing at the intersections with smart signals"-----
postsvydt1_q5.4 <- postsvydt1[, c(1,57)]
names(postsvydt1_q5.4)[2] = c("options")
postsvydt1_q5.4[freq5_option_text, id := i.id, on = "options"]

# PM5_5 : postsvydt1_q5.5, "Perceived safety of crossing the intersections with smart signals"-----
postsvydt1_q5.5 <- postsvydt1[, c(1,60)]
names(postsvydt1_q5.5)[2] = c("options")
postsvydt1_q5.5[q_5Likert_option_text, id := i.id, on = "options"]

# PM6_1 : (from ctp trip data), "Percent of CS trips that arrive at the boarding stop within the targeted time allowance of the scheduled arrival time "

# PM6_2 : (from ctp trip data), "Percent of CS trips that arrive at the alighting stop within the targeted time allowance of the scheduled arrival time "

# PM6_3 : (HDS and SDS Operations data, supplemented by additional system cost data), "Cost efficiency of the HDS and SDS shuttle services in terms of operating cost per passenger trip."-----





# finalize pre survey PM data table -----
postsvy_PMs <- merge(postsvydt1_q1.1[, .(RespondentID, PM1_1 = id)], postsvydt1_q1.2[, .(RespondentID, PM1_2 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q1.3[, .(RespondentID, PM1_3 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q1.4[, .(RespondentID, PM1_4 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q1.5[, .(RespondentID, PM1_5 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.4[, .(RespondentID, PM1_4 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.5[, .(RespondentID, PM1_5 = id)], by = "RespondentID")

postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q2.1[, .(RespondentID, PM2_1 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q2.2[, .(RespondentID, PM2_2 = id)], by = "RespondentID")

postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.1[, .(RespondentID, PM3_1 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.2[, .(RespondentID, PM3_2 = id)], by = "RespondentID")
# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.3[, .(RespondentID, PM3_3 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.4[, .(RespondentID, PM3_4 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.5[, .(RespondentID, PM3_5 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.6[, .(RespondentID, PM3_6 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.7[, .(RespondentID, PM3_7 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.8[, .(RespondentID, PM3_8 = id)], by = "RespondentID")

# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.1[, .(RespondentID, PM4_1 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.2[, .(RespondentID, PM4_2 = id)], by = "RespondentID")
# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.3[, .(RespondentID, PM4_3 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.4[, .(RespondentID, PM4_4 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.5[, .(RespondentID, PM4_5 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.6[, .(RespondentID, PM4_6 = id)], by = "RespondentID")

postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.7.1[, .(RespondentID, PM4_7_1 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.7.2[, .(RespondentID, PM4_7_2 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.7.3[, .(RespondentID, PM4_7_3 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.7.4[, .(RespondentID, PM4_7_4 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.7.5[, .(RespondentID, PM4_7_5 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.7.6[, .(RespondentID, PM4_7_6 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.7.7[, .(RespondentID, PM4_7_7 = id)], by = "RespondentID")

postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.8.1[, .(RespondentID, PM4_8_1 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.8.2[, .(RespondentID, PM4_8_2 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.8.3[, .(RespondentID, PM4_8_3 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.8.4[, .(RespondentID, PM4_8_4 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.8.5[, .(RespondentID, PM4_8_5 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.8.6[, .(RespondentID, PM4_8_6 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.8.7[, .(RespondentID, PM4_8_7 = id)], by = "RespondentID")

# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.1[, .(RespondentID, PM5_1 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.2[, .(RespondentID, PM5_2 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.3[, .(RespondentID, PM5_3 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.4[, .(RespondentID, PM5_4 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.5[, .(RespondentID, PM5_5 = id)], by = "RespondentID")

# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q6.3[, .(RespondentID, PM6_3 = id)], by = "RespondentID")
# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q6.4[, .(RespondentID, PM6_4 = id)], by = "RespondentID")
# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q6.5[, .(RespondentID, PM6_5 = id)], by = "RespondentID")

fwrite(postsvy_PMs, file.path(SYSTEM_APP_INPUT_PATH, paste0("postsvy_PMs.csv")))
fwrite(presvy_PMs, file.path(SYSTEM_APP_INPUT_PATH, paste0("presvy_PMs.csv")))

