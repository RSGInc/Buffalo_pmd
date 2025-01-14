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


write.csv(presvy_PMs, file.path(SYSTEM_APP_INPUT_PATH, paste0("pre_deployment_survey_pm_", Sys.Date(), ".csv")), row.names = FALSE)

# fwrite(presvy_PMs, file.path(SYSTEM_APP_INPUT_PATH, paste0("presvy_PMs.csv")))

