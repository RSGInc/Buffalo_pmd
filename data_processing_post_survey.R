source('config.R')

# 2. post deployment survey -----------------

postsvydt1 <- postsvydt[2:nrow(postsvydt), ]
names(postsvydt1) <- gsub(" ", "", names(postsvydt1))

# names(postsvydt1)


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

# PM1_6: (from Buffalo All Access app trip data)

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

# PM3_2 : postsvydt1_q3.2, "System user ratings of the satisfaction with the specific route/path options provided by the Buffalo All Access app"-----
postsvydt1_q3.2 <- postsvydt1[, c(1,25)]
names(postsvydt1_q3.2)[2] = c("options")
postsvydt1_q3.2[satisfy_5Likert_option_text, id := i.id, on = "options"]

# PM3_3 : (from Buffalo All Access app trip data)

# PM3_4 : postsvydt1_q3.4, "System user ratings of the ease of booking on-demand (CS) transit trips via the system "-----
postsvydt1_q3.4 <- postsvydt1[, c(1,28)]
names(postsvydt1_q3.4)[2] = c("options")
postsvydt1_q3.4[easy_5Likert_option_text, id := i.id, on = "options"]

# PM3_5 : postsvydt1_q3.5, "The percent of Buffalo All Access app users who use the Buffalo All Access app to report incidents or travel conditions during their trips"-----
postsvydt1_q3.5 <- postsvydt1[, c(1,30)]
names(postsvydt1_q3.5)[2] = c("options")
postsvydt1_q3.5[q_yesno_option_text, id := i.id, on = "options"]

# PM3_6 : postsvydt1_q3.6, "System user ratings of the ease of reporting incidents or conditions encountered during a trip in the Buffalo All Access app"-----
postsvydt1_q3.6 <- postsvydt1[, c(1,32)]
names(postsvydt1_q3.6)[2] = c("options")
postsvydt1_q3.6[easy_5Likert_option_text, id := i.id, on = "options"]

# PM3_7 : postsvydt1_q3.7, "The percent of Buffalo All Access app users who use the Buffalo All Access app function to review past trip history"-----
postsvydt1_q3.7 <- postsvydt1[, c(1,33)]
names(postsvydt1_q3.7)[2] = c("options")
postsvydt1_q3.7[q_yesno_option_text, id := i.id, on = "options"]

# PM3_8 : postsvydt1_q3.8, "System user ratings of the usefulness of reporting past trip history in the Buffalo All Access app"-----
postsvydt1_q3.8 <- postsvydt1[, c(1,35)]
names(postsvydt1_q3.8)[2] = c("options")
postsvydt1_q3.8[useful_5Likert_option_text, id := i.id, on = "options"]


# PM4_1 : postsvydt1_q4.1, "The fraction of Buffalo All Access app users who elect to receive outdoor wayfinding notifications"
postsvydt1_q4.1 <- postsvydt1[, c(1,36)]
names(postsvydt1_q4.1)[2] = c("options")
postsvydt1_q4.1[q_yesno_option_text, id := i.id, on = "options"]

# PM4_2 : postsvydt1_q4.2, "System user self-reported frequency of using outdoor wayfinding notifications"-----
postsvydt1_q4.2 <- postsvydt1[, c(1,37)]
names(postsvydt1_q4.2)[2] = c("options")
postsvydt1_q4.2[freq5_option_text, id := i.id, on = "options"]

# PM4_3 : postsvydt1_q4.3, "The fraction of Buffalo All Access app users who elect to receive indoor wayfinding notifications"
postsvydt1_q4.3 <- postsvydt1[, c(1,46)]
names(postsvydt1_q4.3)[2] = c("options")
postsvydt1_q4.3[q_yesno_option_text, id := i.id, on = "options"]

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

# PM4_7 : postsvydt1_q4.7, "User ratings of various dimensions of using the Buffalo All Access app outdoor wayfinding functionality using the RAPUUD method "-----
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


# PM4_8 : postsvydt1_q4.8, "User ratings of various dimensions of using the Buffalo All Access app indoor wayfinding functionality using the RAPUUD method "-----

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


# PM5_1 : (from Buffalo All Access app trip data), "The percent of Buffalo All Access app trips crossing at the relevant intersections who use the smart signal remote activation function."

# PM5_2 : postsvydt1_q5.2, "Self-reported fraction of people who cross at the relevant intersections who use the Buffalo All Access app smart signal activation functionality"-----
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

# PM6_1 : (from Buffalo All Access app trip data), "Percent of CS trips that arrive at the boarding stop within the targeted time allowance of the scheduled arrival time "

# PM6_2 : (from Buffalo All Access app trip data), "Percent of CS trips that arrive at the alighting stop within the targeted time allowance of the scheduled arrival time "

# PM6_3 : (HDS and SDS Operations data, supplemented by additional system cost data), "Cost efficiency of the HDS and SDS shuttle services in terms of operating cost per passenger trip."-----





# finalize pre survey PM data table -----
postsvy_PMs <- merge(postsvydt1_q1.1[, .(RespondentID, PM1_1 = id)], postsvydt1_q1.2[, .(RespondentID, PM1_2 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q1.3[, .(RespondentID, PM1_3 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q1.4[, .(RespondentID, PM1_4 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q1.5[, .(RespondentID, PM1_5 = id)], by = "RespondentID")
postsvy_PMs[, PM1_6 := NA]
# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.4[, .(RespondentID, PM1_6 = id)], by = "RespondentID")
# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.5[, .(RespondentID, PM1_5 = id)], by = "RespondentID")

postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q2.1[, .(RespondentID, PM2_1 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q2.2[, .(RespondentID, PM2_2 = id)], by = "RespondentID")

postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.1[, .(RespondentID, PM3_1 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.2[, .(RespondentID, PM3_2 = id)], by = "RespondentID")
postsvy_PMs[, PM3_3 := NA]
# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.3[, .(RespondentID, PM3_3 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.4[, .(RespondentID, PM3_4 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.5[, .(RespondentID, PM3_5 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.6[, .(RespondentID, PM3_6 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.7[, .(RespondentID, PM3_7 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q3.8[, .(RespondentID, PM3_8 = id)], by = "RespondentID")

postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.1[, .(RespondentID, PM4_1 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.2[, .(RespondentID, PM4_2 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q4.3[, .(RespondentID, PM4_3 = id)], by = "RespondentID")
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

postsvy_PMs[, PM5_1 := NA]
# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.1[, .(RespondentID, PM5_1 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.2[, .(RespondentID, PM5_2 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.3[, .(RespondentID, PM5_3 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.4[, .(RespondentID, PM5_4 = id)], by = "RespondentID")
postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q5.5[, .(RespondentID, PM5_5 = id)], by = "RespondentID")

# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q6.3[, .(RespondentID, PM6_3 = id)], by = "RespondentID")
# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q6.4[, .(RespondentID, PM6_4 = id)], by = "RespondentID")
# postsvy_PMs <- merge(postsvy_PMs, postsvydt1_q6.5[, .(RespondentID, PM6_5 = id)], by = "RespondentID")

fwrite(postsvy_PMs, file.path(SYSTEM_APP_INPUT_PATH, paste0("post_deployment_survey_pm_", Sys.Date(), ".csv")), row.names = FALSE)
