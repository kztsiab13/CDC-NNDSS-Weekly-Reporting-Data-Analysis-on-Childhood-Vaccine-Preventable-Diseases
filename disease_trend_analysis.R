#Hack the Gap Personal Project
##Katherine Thao
###CDC NNDSS Weekly Reporting Data Analysis on Childhood Vaccine Preventable Diseases (CVPDs)

#Installing R packages
library(tidyverse)
library(dplyr)
library(tidyr)
library(janitor)
library(stringr)


#Importing Datasets
##CDC Disease Reporting
rawdata_disease_reports <- read_csv(
  "C:\\Users\\kaths\\Downloads\\NNDSS_Weekly_Data_20251030.csv") #Raw dataset for reference

disease_reports <- read_csv(
  "C:\\Users\\kaths\\Downloads\\NNDSS_Weekly_Data_20251030.csv") #Dataset for modifcations
head(disease_reports) #Short summary of the data

##U.S. State Populations
statepopulation <- read_csv(
  "C:\\Users\\kaths\\Downloads\\statepopulation_dataset.csv") #Raw dataset for reference
head(uspopulation) #Short summary of the data

##Creating a National US Population data frame
uspopulation <- data.frame(
  `Reporting Area` = c("US Residents",
                       "US Residents",
                       "US Residents",
                       "US Residents"),
  `Current MMWR Year` = c(2022, 2023, 2024, 2025),
  Population = c(334017321, 336806231, 340110988, 347956170) # 2025 population as of Nov 17, 2025
)

uspopulation <- uspopulation %>%
  rename(
    `Reporting Area` = Reporting.Area,
    `Current MMWR Year` = Current.MMWR.Year
  )

print(uspopulation) #Display US population dataset


#Understanding dataset characteristics
##Dataset summary
glimpse(rawdata_disease_reports)


#Data Cleaning and Manipulation
##Disease list
rawdata_diseaseslist <- sort(unique(rawdata_disease_reports$Label)) #List of all unique reported diseases, some diseases listed are broken down specifically by type, disease variance, age,
length(rawdata_diseaseslist) #Total count of all unique reported diseases

###Subgrouping diseases together; NOTE: Some disease listed are distinct based on confirmed/probable cases, infection type, and disease variant
hepatitisB <- c("Hepatitis B, acute, Confirmed",
                "Hepatitis B, acute, Probable",
                "Hepatitis B, chronic, Confirmed",
                "Hepatitis B, chronic, Probable",
                "Hepatitis B, perinatal infection",
                "Hepatitis B, perinatal, Confirmed") #Group all Hepatitis B

measles <- c("Measles, Imported",
             "Measles, Indigenous") #Group all measles

pneumococcal <- c("Invasive pneumococcal disease, all ages, Confirmed",
                  "Invasive pneumococcal disease, all ages, Probable") #Group all pneumococcals

polio <- c("Poliomyelitis, paralytic",
           "Poliovirus infection, nonparalytic") #Group all polio cases

rubella <- c("Rubella",
             "Rubella, congenital syndrome") #Group all rubellas

varicella <- c("Varicella disease",
               "Varicella morbidity") #Group all varicellas

influenza <- c("Haemophilus influenzae, invasive disease, All ages, all serotypes",
               "Influenza-associated pediatric mortality") #Group all varicellas

###Group all the Childhood Vaccine Preventable Disease (CVPD)
CVPD_list <- c(hepatitisB,
               measles,
               pneumococcal,
               polio,
               rubella,
               varicella,
               influenza,
               "Hepatitis A, Confirmed",
               "Meningococcal disease, All serogroups",
               "Mumps",
               "Pertussis") 

length(CVPD_list) #Total count of all unique reported CVPDs
          
##Temporal lists
year <- sort(unique(disease_reports$`Current MMWR Year`)) #List of all unique reporting years
week <- sort(unique(disease_reports$`MMWR WEEK`)) #List of all unique reporting weeks

###Grouping yearly quarters by MMWR week in a new column
disease_reports <- disease_reports %>%
  mutate(
    `Yearly Quarter` = case_when(
      `MMWR WEEK` %in% 1:13  ~ "Q1",
      `MMWR WEEK` %in% 14:26 ~ "Q2",
      `MMWR WEEK` %in% 27:39 ~ "Q3",
      `MMWR WEEK` %in% 40:52 ~ "Q4"))

disease_reports <- disease_reports %>%
  relocate(`Yearly Quarter`, .after = `MMWR WEEK`) #Moving column

###Grouping seasons by MMWR weeks in a new column
disease_reports <- disease_reports %>%
  mutate(
    Season = case_when(
      `MMWR WEEK` %in% c(49:52, 1:8) ~ "Winter",
      `MMWR WEEK` %in% 9:21           ~ "Spring",
      `MMWR WEEK` %in% 22:34          ~ "Summer",
      `MMWR WEEK` %in% 35:48          ~ "Fall"
    ))

disease_reports <- disease_reports %>%
  relocate(`Season`, .after = `Yearly Quarter`) #Moving column

##Reporting location list
raw_reportlocations <- sort(unique(rawdata_disease_reports$`Reporting Area`)) #List of all unique reporting locations; Duplicated data and inconsistent value input formatting, capitalization and abbreviations

disease_reports <- disease_reports %>%    #Standardizing value inputs
  mutate(`Reporting Area` = `Reporting Area` %>%
           str_trim() %>%
           str_replace_all("(?i)u\\.?\\s*s\\.?", "US") %>%  #Unify all "U.S.", "Us", etc.
           str_to_title() %>%
           str_replace_all("\\bUs\\b", "US"))  #Fix title-case "Us" back to "US"

reportlocations <- sort(unique(disease_reports$`Reporting Area`))

US_states <- c(state.name, "District Of Columbia")

#Filtering and sorting
disease_reports <- disease_reports %>% #Filtering selected columns
  select(`Reporting Area`,
         `Current MMWR Year`,
         `MMWR WEEK`,
         `Yearly Quarter`,
         `Season`,
         `Label`,
         `Current week`,
         `Cumulative YTD Current MMWR Year`,
         `sort_order`)

##ONLY US States and CVPDs
CVPD_data <- disease_reports %>%
  filter(`Reporting Area` %in% US_states,
         `Label` %in% CVPD_list,
         `MMWR WEEK` == 52)

CVPD_data <- CVPD_data %>% #Add disease category column
  mutate(
    Disease_Category = case_when(
      Label %in% hepatitisB ~ "Hepatitis B",
      Label %in% measles ~ "Measles",
      Label %in% pneumococcal ~ "Pneumococcal",
      Label %in% polio ~ "Polio",
      Label %in% rubella ~ "Rubella",
      Label %in% varicella ~ "Varicella",
      Label %in% influenza ~ "Influenza",
      Label == "Mumps" ~ "Mumps",
      Label == "Pertussis" ~ "Pertussis",
      Label == "Hepatitis A, Confirmed" ~ "Hepatitis A",
      Label == "Meningococcal disease, All serogroups" ~ "Meningococcal"))

CVPD_data <- CVPD_data %>%
  relocate(Disease_Category, .after = Label) #Move column to apporpiate location

##National US cases
CVPD_USresident <- disease_reports %>% #Filtering total US national case totals and CVPDs
  filter(`Reporting Area` == "US Residents",
         `Label` %in% CVPD_list,
         `MMWR WEEK` == 52)

CVPD_USresident <- CVPD_USresident %>%
  mutate(
    Disease_Category = case_when(
      Label %in% hepatitisB ~ "Hepatitis B",
      Label %in% measles ~ "Measles",
      Label %in% pneumococcal ~ "Pneumococcal",
      Label %in% polio ~ "Polio",
      Label %in% rubella ~ "Rubella",
      Label %in% varicella ~ "Varicella",
      Label %in% influenza ~ "Influenza",
      Label == "Mumps" ~ "Mumps",
      Label == "Pertussis" ~ "Pertussis",
      Label == "Hepatitis A, Confirmed" ~ "Hepatitis A",
      Label == "Meningococcal disease, All serogroups" ~ "Meningococcal"))

CVPD_USresident <- CVPD_USresident %>%
  relocate(Disease_Category, .after = Label) #Move column


##State Disease Incidents Prevalence
CVPD_staterates <- CVPD_data %>% #Sum all total cases by Disease Category
  group_by(`Reporting Area`,`Current MMWR Year`, Disease_Category) %>%
  summarise(total_cases = sum(`Cumulative YTD Current MMWR Year`, na.rm = TRUE)) %>%
  ungroup()

CVPD_staterates <- CVPD_staterates %>% #Merge in the U.S. population by State dataet
  left_join(
   statepopulation,by = c("Reporting Area",
      "Current MMWR Year"))

CVPD_staterates <- CVPD_staterates %>%
  mutate(incidence_rate = (total_cases / Population) * 100000) #Calculation for state incident rates

CVPD_staterates <- CVPD_staterates %>%
  mutate(incidence_rate = round(incidence_rate, 2)) #Round the state incident rates 


##National Incidents rates
CVPD_nationalrates <- CVPD_USresident %>% #Sum all total cases by Disease Category
  group_by(`Current MMWR Year`, Disease_Category) %>%
  summarise(total_cases = sum(`Cumulative YTD Current MMWR Year`, na.rm = TRUE)) %>%
  ungroup()

CVPD_nationalrates <- CVPD_nationalrates %>% #Merge in the National U.S. population dataet
  left_join(
    uspopulation,by = c(
      "Current MMWR Year"))

CVPD_nationalrates <- CVPD_nationalrates %>% select(-`Reporting Area`) #Removed unrelevant columns

CVPD_nationalrates <- CVPD_nationalrates %>%
  mutate(incidence_rate = (total_cases / Population) * 100000) #Calculating national annual incident rates by disease

CVPD_nationalrates <- CVPD_nationalrates %>%
  mutate(incidence_rate = round(incidence_rate, 2)) # Round numeric columns to 2 decimal places



#Data Analysis
##Overall total number of reported CVPDs cases by year in the US between 2022-2024, bar graph
overallcase_by_year <- CVPD_nationalrates %>%
  group_by(`Current MMWR Year`) %>%
  summarise(total_cases = sum(total_cases, na.rm = TRUE)) %>%
  arrange(`Current MMWR Year`)

write.csv(overallcase_by_year, "nationalcase_by_year.csv", row.names = FALSE)

##Overall total number of reported cases by CVPDs in the US between 2022-2024, bar graph
cases_disease <- CVPD_nationalrates %>%
  group_by(Disease_Category) %>%
  summarise(total_cases = sum(total_cases, na.rm = TRUE)) %>%
  arrange(-`total_cases`)

write.csv(cases_disease, "nationalcases_by_disease.csv", row.names = FALSE)

##National incident rates by CVPDs between 2022-2024
table_nationalrates <- CVPD_nationalrates %>%
  select(`Current MMWR Year`,
         Disease_Category,
         incidence_rate) %>%
  arrange(`Disease_Category`)

write.csv(table_nationalrates, "nationalrates_by_disease.csv", row.names = FALSE)

table_nationalrates_wide <- table_nationalrates %>%
  pivot_wider(
    names_from = `Current MMWR Year`,
    values_from = incidence_rate        
  )

table_nationalrates_wide <- table_nationalrates_wide %>%
  select(Disease_Category, `2022`, `2023`, `2024`)

##Annual CVPD Incidence Rates By US State Between 2022-2025
###Measles
measles_staterates <- CVPD_staterates %>%
  filter(Disease_Category == "Measles")

write.csv(measles_staterates, "measles_staterates.csv", row.names = FALSE)

measles_staterates2023 <- measles_staterates %>%
  select(`Reporting Area`,
         `Current MMWR Year`,
         Disease_Category,
         incidence_rate) %>%
  filter(`Current MMWR Year` == 2023) %>%
  arrange(-incidence_rate)

measles_staterates2024 <- measles_staterates %>%
  select(`Reporting Area`,
         `Current MMWR Year`,
         Disease_Category,
         incidence_rate) %>%
  filter(`Current MMWR Year` == 2024) %>%
  arrange(-incidence_rate)

###Pertussis
pertussis_staterates <- CVPD_staterates %>%
  filter(Disease_Category == "Pertussis")

write.csv(pertussis_staterates, "pertussis_staterates.csv", row.names = FALSE)

pertussis_staterates2023 <- pertussis_staterates %>%
  select(`Reporting Area`,
         `Current MMWR Year`,
         Disease_Category,
         incidence_rate) %>%
  filter(`Current MMWR Year` == 2023) %>%
  arrange(-incidence_rate)

pertussis_staterates2024 <- pertussis_staterates %>%
  select(`Reporting Area`,
         `Current MMWR Year`,
         Disease_Category,
         incidence_rate) %>%
  filter(`Current MMWR Year` == 2024) %>%
  arrange(-incidence_rate)



