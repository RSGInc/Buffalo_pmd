# ITS4US Buffalo All Access Performance Measure Dashboard

## This repository is intended to provide scripts and processed data for dashboard development.

This Buffalo All Access dashboard, [BuffaloAccess-PM-Dashboard](https://rsginc.shinyapps.io/BuffaloAccess-PM-Dashboard/) is designed to visualize performance measures for the following areas of the ITS4US Buffalo All Access project:  

  * Ease of trip planning and making
  * Safety and accessibility
  * Availability and usefulness of travel information
  * System functionality and user engagement.
  
## Repository Structure
The structure of the repository is shown in the tree diagram below:

```bash
/buffalo_all_access_pmd/ 
    ├── .gitignore                       # Ignore certain files (e.g., logs, credentials) 
    ├── README.md                        # Project documentation and information
    ├── dashboard                        # Source code for building a dashboard web app
    │     └── ...
    ├── input                            # Directory contains all the raw input data
    │     └── ...
    ├── buffalo_all_access_pmd.Rproj     # R project file that stores project-related files (e.g., source code, datasets, RStudio workspace)
    ├── config.R                         # Configuration script for project folder
    ├── data_processing_pre_survey.R     # Source code for pre-deployment survey data preparation
    ├── data_processing_post_survey.R    # Source code for post-deployment survey data preparation
    └── data_processing_etch_api.R       # Source code for complete trip app data preparation
    
```

### **dashboard**
This directory includes the source codes needed to build the dashboard. In addition, this repository contains all the datasets (e.g., pre- & post-deployment surveys, and complete trip app data) processed for a performance measurement. 

### **input**
This `input` directory contains all the raw data directly obtained from (both pre- and post-deployment) surveys, and complete trip app.

### **buffalo_all_access_pmd.Rproj**
The `buffalo_all_access_pmd.Rproj` file is an R project file which stores all the files related to the project. It is also used to maintain the R environment, project settings, and dependencies for this dashboard.
