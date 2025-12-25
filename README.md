# Chilhood Preventable Vaccine Disease Case Counts and Incidence Rate Trend Analysis between 2022-2024

## Overview
- This project analyzes chilhood preventable vaccine diseases case counts and incidence rate trends over time to support public health surveillance using the Center for Disease Control and Prevention (CDC) National Notifiable Disease Surveillance System (NNDSS) dataset.
- The goal is to identify patterns in disease burden and provide insights for public health monitoring.

## Data Source
Data were obtained from publicly available surveillance sources. Raw datasets are included when permitted; otherwise, only cleaned and aggregated datasets are shared.

## Repository Structure
├── `README.md` — This file
├── `data`
│    ├── `raw` — Original raw datasets
│    │      ├── `CDC_NNDSS_Weekly_Data_2025-10-30.csv` - 
│    │      ├── `nationalpopulation_dataset.csv` - 
│    │      └── `statepopulation_dataset.csv` - 
│    └── `processed` — Cleaned and merged datasets used in analysis
│           ├── `CVPDnational_by_year.csv` - 
│           └── `CVPDstate_by_year` - 
├── `scripts` — R script(s) for data cleaning, manipulation, and analysis
│       └──  `CVPD_data_anaylsis` -
├── `tables` — Final tables used to create figures
├── `figures` — Graphs and visual outputs
└── `documents` — Presentation summarizing background, methods, limitations, and results

## Key Outputs
- Final tables summarizing disease case counts and incidence rates
- Figures displaying trends over time
- Full methods, analysis steps, and results summarized in the presentation

## Tools Used
- Microsoft Excel
- R (tidyverse, dyplr, janitor, and stringr)
- Tableau

## Notes
This repository is intended for educational and portfolio purposes. Analyses are descriptive and based on reported case data, which may be subject to underreporting or reporting delays.

## Contact
Created by Katherine Thao  
Master of Public Health Student | Epidemiology
Portfolio: https://katherinethao-projects.my.canva.site/portfolio
