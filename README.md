# Childhood Preventable Vaccine Disease Case Counts and Incidence Rate Trend Analysis between 2022-2024

## Overview
- This project analyzes chilhood preventable vaccine diseases case counts and incidence rate trends over time to support public health surveillance using the Center for Disease Control and Prevention (CDC) National Notifiable Disease Surveillance System (NNDSS) dataset.
- The goal is to identify patterns in disease burden and provide insights for public health monitoring.

## Data Source
This project uses the following publicly available datasets:
- CDC National Notifiable Diseases Surveillance System (NNDSS) at https://data.cdc.gov/NNDSS/NNDSS-Weekly-Data/x9gk-5huc/about_data (NOTE: File size is not included in this repository due to size limitations; Data used here in this analysis was last updated on September 24, 2025)
- National and State U.S. Population data used to calculate incidence rates were derived from the U.S. Census Bureau and World Population Review, processed into analysis-ready datasets included in the `data/processed/` directory. 

## Repository Structure
- `README.md` — This file
- `data/raw` — Original raw datasets
- `data/processed` — Cleaned and merged datasets used in analysis
- `scripts` — R script(s) for data cleaning, manipulation, and analysis
- `tables` — Final tables used to create figures
- `figures` — Graphs and visual outputs
- `documents` — Presentation summarizing background, methods, limitations, and results

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
