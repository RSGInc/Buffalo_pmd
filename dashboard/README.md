# ITS4US Buffalo All Access Performance Measurement Dashboard
This directory includes all the required source code required to construct the web application that drives the dashboard. In addition, this repository contains all the final processed datasets (e.g., pre- & post-deployment surveys, and complete trip app data) for the performance measures. 
  
## Repository Structure
The structure of the repository is shown in the tree diagram below:

```bash
/buffalo_all_access_pmd/
  ├── ...
  ├── dashboard/                                             # Source code for building a dashboard web app
  │   ├── input/                                             # Final processed data folder
  │   │   └── ...
  │   ├── logs/
  │   │   └── ...
  │   ├── rsconnect/                                         # App deployment configurations for shinyapps.io
  │   │   └── shinyapps.io/
  │   │       └── rsginc/
  │   │           └── BuffaloAccess-PM-Dashboard.dcf         # Dashboard configuration files
  │   ├── server/                                            # Source code for each dashboard tab for the PMs      
  │   │   ├── server_overview.R                              # Server-side logic for the app
  │   │   ├── server_pm1.R
  │   │   ├── server_pm2.R
  │   │   ├── server_pm3.R
  │   │   ├── server_pm4.R
  │   │   ├── server_pm5.R
  │   │   └── server_pm6.R
  │   ├── ui/                                               # UI definition for the app that defines the layout and user interface                                          
  │   │   ├── ui_overview.R
  │   │   ├── ui_pm1.R
  │   │   ├── ui_pm2.R
  │   │   ├── ui_pm3.R
  │   │   ├── ui_pm4.R
  │   │   ├── ui_pm5.R
  │   │   └── ui_pm6.R                                
  │   ├── www/                                               # Image folder
  │   │   ├── ITS4US Logo.jpg                                # Buffalo All Access logo
  │   │   └── RSG Logo.jpg                                   # Company logo (RSG)
  │   ├── app.R                                              # Source code (app file) to launch the app
  │   ├── dashboard.Rproj                                    # R project file for the app
  │   ├── dashboard_config.R                                 # Configuration script for the dashboard 
  │   ├── data_import.R                                      # Configuration file to import data and other inputs, load the necessary libraries and environment
  │   └── README.md                                          # User guide
  └── ...
```

### **input**
The `input` directory contains the final processed datasets used in the dashboard. These datasets are crucial to the application's functionality and are derived from surveys and complete trip app data. The processed file name is suffixed with the latest processing date of the raw data. "pre_deployment_survey_pm_YYYY/MM/DD" is the processed baseline (pre-deployment) survey data, "post_deployment_survey_pm_YYYY/MM/DD" is the processed post-deployment survey data, and etch_pm_YYYY/MM/DD is the complete trip app data. 

### **logs** 
The `logs` directory includes the project's revision history.

### **rsconnect**
The `rsconnect` directory contains the necessary scripts and configurations for deploying the dashboard on shinyapps.io. This is the platform where the web application will be hosted.
The files in this directory are essential for the deployment process.

### **server**
The `server` directory houses the server-side logic of the application. This folder typically contains the server.R script, which defines the source codes responsible for processing inputs, performing estimations, and generating outputs that are rendered to the user interface. This folder is essential to ensure the seamless operation of the app, enabling it to respond to user input in real time. There are seven `server.R` files for seven tabs: one script (`server_overview.R`) for the overview of the dashboard, and six other scripts (`server_pm1.R` to `server_pm6.`R) are for the six different performance measures (PMs).

### **ui**
The `ui` directory contains the user interface components of the application. This folder typically includes ui.R scripts that define the layout and appearance of the app's interface, including the arrangement and design of input controls, output displays, and other interactive elements. There are also seven `ui.R`, each corresponding to one of the seven `server.R` scripts.

### **www**
The directory houses images utilized in the dashboard. These images are essential for enhancing the visual experience of the application.

### **app.R**
The `app.R` file is an R script responsible for building the web application that powers the dashboard. It serves as the main entry point for the application, integrating `server.R` and `ui` and launch the app.

### **dashboard.Rproj** 
The `dashboard.Rproj` file is an R project file. It is used to organize and manage various components, such as the R environment, project settings, and dependencies for this dashboard, after finalizing the data processing in the initial stages. When this file is opened in RStudio, it automatically sets the working directory to the project's root directory, making it easier to manage paths to data files, scripts, and outputs. 

### **data_import.R**
The `data_import.R` file is an R script that acts as a configuration file for importing data and other inputs required for the web app. It also handles the loading of necessary libraries and environment settings, ensuring the smooth operation of the application functions.

### **README.md**
The `README.md` file provides the comprehensive information about the repository. 

## Accessing the Dashboard
The dashboard is hosted on Shiny.io. To view the dashboard, please visit this link. [BuffaloAccess-PM-Dashboard](https://rsginc.shinyapps.io/BuffaloAccess-PM-Dashboard/)

The following description provides guidance on how to navigate through the interface:

1. **Tab Selection for Different Performance Measure**
  This feature (as shown in item 1 of the figure below) allows (users) to switch between tabs to view different performance metrics. 
  
2. **Data and Summary Table Downloads**
  Users have the option to download summary tables and the original survey and Buffalo All Access app data (refer to item 2 in the figure below).



![dashboard_image](https://github.com/user-attachments/assets/1efd35f5-74a6-4624-93e6-689b6893e133)


















