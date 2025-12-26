# Childhood Preventable Vaccine Disease (CPVD) Case Counts and Incidence Rate Trend Analysis between 2022-2024

## Overview
- This project analyzes childhood preventable vaccine diseases case counts and incidence rate trends over time to support public health surveillance using the CDC National Notifiable Disease Surveillance System (NNDSS) dataset.
- The goal is to identify patterns in disease burden and provide insights for public health monitoring.

## Data Source
This project uses the following publicly available datasets:
- CDC National Notifiable Diseases Surveillance System (NNDSS) at https://data.cdc.gov/NNDSS/NNDSS-Weekly-Data/x9gk-5huc/about_data (NOTE: File size is not included in this repository due to size limitations; This analysis uses data from the CDC NNDSS dataset last updated on September 24, 2025)
- National and State U.S. Population data used to calculate disease incidence rates were derived from the U.S. Census Bureau (https://www.census.gov/data/tables/time-series/demo/popest/2020s-state-total.html?utm_source=chatgpt.com) and World Population Review (https://worldpopulationreview.com/states) numbers. Data points from both sources were taken and processed into the two raw datasets included in the `data/raw` directory. 

## Repository Structure
- `README.md` — This file
- `Raw dataset` — Original raw datasets
- `Processed dataset` — Cleaned and merged datasets used in analysis
- `R-scripts` — R script(s) for data cleaning, manipulation, and analysis
- `Tables` — Final tables used to create figures
- `Figures` — Graphs and visual outputs
- `Documents` — Presentation summarizing background, methods, limitations, and results

## Key Outputs
- Final tables summarizing disease case counts and incidence rates
- Figures displaying trends over time
- Full methods, analysis steps, and results are summarized in the presentation

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
