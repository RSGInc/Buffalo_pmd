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
# - develop shiny UI/


# Library initialization
if(!require('tidyverse')) install.packages("tidyverse")
if(!require('stringr')) install.packages("stringr")
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
if(!require("devtools", quietly = TRUE)) install.packages("devtools")
if(!require('readr')) install.packages("readr")
if(!require('httr')) install.packages("httr")
if(!require('curl')) install.packages("curl")
if(!require('jsonlite')) install.packages("jsonlite")

options(scipen=999) 
options(digits = 6)

# 0. data directory setup
SYSTEM_PATH = getwd()
SYSTEM_GIS_DATA_PATH  = file.path(SYSTEM_PATH, "input", 'gis')
SYSTEM_BASESVY_DATA_PATH  = file.path(SYSTEM_PATH, "input", "basesurvey")
SYSTEM_POSTSVY_DATA_PATH  = file.path(SYSTEM_PATH, "input", "postsurvey")
SYSTEM_ETCH_DATA_PATH = file.path(SYSTEM_PATH, "input", 'etchtrip')
SYSTEM_APP_PATH       = file.path(SYSTEM_PATH, 'dashboard')
SYSTEM_APP_LOG_PATH   = file.path(SYSTEM_APP_PATH, 'logs')
SYSTEM_APP_INPUT_PATH   = file.path(SYSTEM_APP_PATH, 'input')

dir.create(file.path(SYSTEM_APP_LOG_PATH), showWarnings =FALSE)
dir.create(file.path(SYSTEM_APP_INPUT_PATH), showWarnings =FALSE)

# 1. study zone layer ----------------

if(!file.exists(file.path(SYSTEM_GIS_DATA_PATH, "StudyZone.rds"))) {
  StudyZone = st_read(file.path(SYSTEM_GIS_DATA_PATH, "ITS4USBuffalo_zone.shp")) %>% st_transform(4326)
  saveRDS(StudyZone, file.path(SYSTEM_APP_INPUT_PATH, "StudyZone.rds"))
} else {
  StudyZone = readRDS(file.path(SYSTEM_APP_INPUT_PATH, "StudyZone.rds")) %>% st_transform(4326)
  StudyZone = StudyZone[order(StudyZone$zoneid),]
}

# leaflet() %>% addProviderTiles(providers$CartoDB.Positron, group ="CartoDB.Positron") %>%
#   addPolygons(data=StudyZone,
#               color ="#04a99b",
#               label= ~zoneid) %>%
#   addLayersControl(baseGroups = c("CartoDB.Positron"),
#                    position = "topright",
#                    options = layersControlOptions(collapOD = TRUE))


# 2. baseline (pre-deployment) survey data import ----------------
# find the latest baseline (pre-deployment) survey file
presvyfile_date = sort(as.Date(str_extract(list.files(SYSTEM_BASESVY_DATA_PATH),"\\d{2}.\\d{2}.\\d{4}"),"%m.%d.%Y"))
presvyfile_sel_date = gsub("-", ".", max(presvyfile_date))
presvyfile_sel_date = paste(substr(presvyfile_sel_date, 6,10), substr(presvyfile_sel_date, 1,4), sep = ".")
presvyfile_sel = list.files(SYSTEM_BASESVY_DATA_PATH)[grep(presvyfile_sel_date, list.files(SYSTEM_BASESVY_DATA_PATH, pattern = "Pre-Deployment.*\\.csv", full.names = TRUE, all.files = TRUE), fixed=T)]

# read file
presvydt = fread(file.path(SYSTEM_BASESVY_DATA_PATH, presvyfile_sel))


# 3. post-deployment survey data import ----------------
# find the latest post-deployment survey file
postsvyfile_date = sort(as.Date(str_extract(list.files(SYSTEM_POSTSVY_DATA_PATH),"\\d{2}.\\d{2}.\\d{4}"),"%m.%d.%Y"))
postsvyfile_sel_date = gsub("-", ".", max(postsvyfile_date))
postsvyfile_sel_date = paste(substr(postsvyfile_sel_date, 6,10), substr(postsvyfile_sel_date, 1,4), sep = ".")
postsvyfile_sel = list.files(SYSTEM_POSTSVY_DATA_PATH)[grep(postsvyfile_sel_date, list.files(SYSTEM_POSTSVY_DATA_PATH), fixed=T)]

# read file
postsvydt = fread(file.path(SYSTEM_POSTSVY_DATA_PATH, postsvyfile_sel))

# 4. etch trip data import ----------------
# curl_location  = "mmapi.etch.app/stats/?metric=trips&start=2023-09-01T00%3A00%3A00&end=2023-09-01T23%3A59%3A59"
# curl_header  = "Bearer XLCBDZWPzYPTTHFQGZM9ALGuFkj5x5fY"

# get file from rest api 1
# get_data <- GET(curl_location, add_headers(authorization = curl_header))
# ctp_json = jsonlite::prettify(get_data)

# get file from rest api 2
# h = new_handle(verbose = TRUE)
# handle_setheaders(h,
#                   "Content-Type" = "application/json",
#                   "Authorization" = curl_header
# )
# ## method 
# con <- curl(curl_location, handle = h)
# ctp_json = jsonlite::prettify(readLines(con))

# data file conversion from json to data.frame
# ctp_data = fromJSON(ctp_json, simplifyVector = FALSE)
# ctptripdt = setDT(rbindlist(ctp_data$results, fill=TRUE))

# ctpfile_date = sort(as.Date(str_extract(list.files(SYSTEM_ETCH_DATA_PATH),"\\d{4}_\\d{2}_\\d{2}"),"%Y_%m_%d"))
# ctpfile_sel_date = gsub("-", "_", max(ctpfile_date))
# ctpfile_sel_csv = list.files(SYSTEM_ETCH_DATA_PATH)[grep(paste0(ctpfile_sel_date, ".csv"), list.files(SYSTEM_ETCH_DATA_PATH), fixed=T)]
# # ctpfile_sel_xlsx = list.files(SYSTEM_ETCH_DATA_PATH)[grep(paste0(ctpfile_sel_date, ".xlsx"), list.files(SYSTEM_ETCH_DATA_PATH), fixed=T)]
# 
# # read csv file
# ctptripdt = fread(file.path(SYSTEM_ETCH_DATA_PATH, ctpfile_sel_csv))
# names(ctptripdt) <- gsub(" ", "", names(ctptripdt))
# ctptripdt[,.N, sort(TravelerID)]
# # read xlsx file format (reference)
# stp_xlsx_sheets = readxl::excel_sheets(file.path(SYSTEM_ETCH_DATA_PATH, ctpfile_sel_xlsx))
# ctptripdt_xlsx = readxl::read_excel(file.path(SYSTEM_ETCH_DATA_PATH, ctpfile_sel_xlsx), sheet = stp_xlsx_sheets[1])

etch_date = sort(as.Date(str_extract(list.files(SYSTEM_ETCH_DATA_PATH),"\\d{2}.\\d{2}.\\d{4}"),"%m.%d.%Y"))
etch_sel_date = gsub("-", ".", max(etch_date))
etch_sel_date = paste(substr(etch_sel_date, 6,10), substr(etch_sel_date, 1,4), sep = ".")
etch_sel = list.files(SYSTEM_ETCH_DATA_PATH)[grep(etch_sel_date, list.files(SYSTEM_ETCH_DATA_PATH), fixed=T)]

# read file
etchdt = fread(file.path(SYSTEM_ETCH_DATA_PATH, etch_sel))

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



