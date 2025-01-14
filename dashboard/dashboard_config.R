# The groups of scripts are writted by Kyeongsu Kim, RSG, kyeongsu.kim@rsginc.com
# File (DIR) Structure
# - config.R
# - data_processing_survey.R
# - data_processing_etch_api.R
# - input (folder)
# -- basesurvey (folder)
# -- etchtrip (folder) 
# -- gis (folder) 
# - output (folder)
# - ITS4US_PMD.Rproj
#
# To do list
# - update shiny UI/ 

# Library initialization
if(!require('tidyverse')) install.packages("tidyverse")
if(!require('scales')) install.packages("scales")
if(!require('sf')) install.packages("sf")
if(!require('leaflet')) install.packages("leaflet")
if(!require('leafgl')) install.packages("leafgl")
if(!require('data.table')) install.packages("data.table")
if(!require('DT')) install.packages("DT")
if(!require('htmltools')) install.packages("htmltools")
if(!require('tidycensus')) install.packages("tidycensus")
if(!require('tigris')) install.packages("tigris")
if(!require('RColorBrewer')) install.packages("RColorBrewer")
if(!require('readr')) install.packages("readr")
if(!require('httr')) install.packages("httr")
if(!require('curl')) install.packages("curl")
if(!require('jsonlite')) install.packages("jsonlite")
if(!require('plotly')) install.packages("plotly")
if(!require('fmsb')) install.packages("fmsb")
if(!require('openxlsx')) install.packages("openxlsx")
if(!require('likert'))install.packages("likert")

options(scipen=999) 
options(digits = 6)

app_version = "2024-V2"
Text_Intro_app_version  = paste0("Dashboard Version: ", app_version)

# 0. data directory setup
SYSTEM_APP_PATH = getwd()
SYSTEM_APP_SHINY_INPUT_PATH = file.path(SYSTEM_APP_PATH, 'input')

# rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
# display.brewer.all(type="seq")
# display.brewer.all(type="qual")
# display.brewer.all(type="div")
palette_studyarea   = "Spectral"
piePalette1 <- brewer.pal(5, "Set2") 
barPalette1 <- brewer.pal(5, "Blues") 


# 1. study zone layer ----------------
gis_StudyZone <- readRDS(file.path(SYSTEM_APP_SHINY_INPUT_PATH, "StudyZone.rds")) %>% st_transform(4326)
gis_StudyZone = gis_StudyZone[order(gis_StudyZone$zoneid),]

# leaflet() %>% addProviderTiles(providers$CartoDB.Positron, group ="CartoDB.Positron") %>%
#   addPolygons(data=gis_StudyZone,
#               color ="#04a99b",
#               label= ~zoneid) %>%
#   addLayersControl(baseGroups = c("CartoDB.Positron"),
#                    position = "topright",
#                    options = layersControlOptions(collapOD = TRUE))

# 2. survey data import ----------------

# Pre-survey performance data
sel_baseline_svy_file_name = max(list.files(SYSTEM_APP_SHINY_INPUT_PATH, pattern ="pre_deployment")); 
cat("baseline svy file name: ",sel_baseline_svy_file_name, "\n")
test_pre_svy <- fread(file.path(SYSTEM_APP_SHINY_INPUT_PATH, sel_baseline_svy_file_name))
setnames(test_pre_svy, old = "RespondentID", new = "ID")
# colnames(sel_baseline_svy_df)

# Post-survey performance data
post_svy_file_name = max(list.files(SYSTEM_APP_SHINY_INPUT_PATH, pattern ="post_deployment")); 
cat("post svy file name: ",post_svy_file_name, "\n")
test_post_svy <- fread(file.path(SYSTEM_APP_SHINY_INPUT_PATH, post_svy_file_name))
setnames(test_post_svy, old = "RespondentID", new = "ID")

# 3. etch trip data import ----------------
sel_etch_trip_file_name = max(list.files(SYSTEM_APP_SHINY_INPUT_PATH, pattern ="etch_pm")); 
cat("ctp trip file name: ", sel_etch_trip_file_name, "\n")
# sel_etch_trip_df <- readRDS(file.path(SYSTEM_APP_SHINY_INPUT_PATH, sel_etch_trip_file_name))
sel_etch_trip_df <- fread(file.path(SYSTEM_APP_SHINY_INPUT_PATH, sel_etch_trip_file_name))

### file copied from ".input/etchtrip"
etch_file_name_example = "tripreport_06.05.2024.xlsx"
etch_df_example = readxl::read_excel(file.path(SYSTEM_APP_SHINY_INPUT_PATH, etch_file_name_example))
setnames(sel_etch_trip_df, old = "RespondentID", new = "ID")

# colnames(sel_etch_trip_df)

pmd_5likert_value = c(1, 2, 3, 4, 5)
# pmd_5likert = c("Strongly disagree", "Somewhat disagree", "Neither agree or disagree", "Somewhat agree", "Strongly agree")
pmd_5likert = c('Strongly disagree', 'Disagree', 'Neutral', 'Agree' , 'Strongly agree')
pmd_purpose = c("Work","Healthcare services","School","Visit family/friend(s)","Accompany a patient")
pmd_mode = c("Driver","Passenger","NFTA-Metro PAL","Other shuttle service for persons with disabilities",
             "NFTA scheduled bus or light rail service","Taxi, Uber or Lyft","Walk/Wheelchair","Bicycle")

svy_pmd_5likert = data.table(pmd_5likert_value, pmd_5likert)
# svy_pmd_5likert$pmd_5likert_value = factor(svy_pmd_5likert$pmd_5likert_value, level = c("1","2", "3", "4","5"))

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

