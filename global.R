### LOAD PACKAGES <--CREATE HEADERS IN YOUR FILES TO KEEP LIKE CODE TOGETHER AND TO STAY ORGANIZED!
library(dplyr)
library(shinyjs)
library(magrittr)
library(logging)
library(ggplot2)
library(sf)
library(s2)
library(plotly)
library(DT)
library(leaflet)
library(gapminder)
library(shinythemes)
library(terra)
library(giscoR)
library(dygraphs)
library(xts)
library(tidycensus)
library(tidyverse)
library(RColorBrewer)
library(mapping)
library(readxl)
library(reactable)
library(fresh)
library(tigris)
library(scales)
library(shiny)
library(bslib)

# Define custom navbar styles
my_theme <- create_theme(
  bs_vars_navbar(
    height = "40px",
    default_color = "#0E84F0",
    inverse_color = "#FFFFFF",
    default_bg = "#072384",
    default_border = "#0E84F0"
  )
)

### LOAD DATA SETS 
#gap = as.data.frame(gapminder)
FLORENCE <- read_excel("data/FSU_Demo.xlsx")
FLORENCE <- as.data.frame(FLORENCE)
#FLORENCE[3:71] <- sapply(FLORENCE[3:71], function(x) percent(x, accuracy=.01))
data <- unique(FLORENCE)

#Columns available for toggle Table 1
all_columns <- c("Domain", "Factor", "Alachua", 
                   "Baker",
                   "Bay", 
                   "Bradford", 
                   "Brevard", 
                   "Broward", 
                   "Calhoun" ,
                   "Charlotte", 
                   "Citrus",
                   "Clay", 
                   "Collier", 
                   "Columbia", 
                   "DeSoto", 
                   "Dixie", 
                   "Duval", 
                   "Escambia", 
                   "Flagler", 
                   "Franklin", 
                   "Gadsden", 
                   "Gilchrist", 
                   "Glades", 
                   "Gulf", 
                   "Hamilton", 
                   "Hardee", 
                   "Hendry", 
                   "Hernando", 
                   "Highlands", 
                   "Hillsborough", 
                   "Holmes", 
                   "Indian River", 
                   "Jackson", 
                   "Jefferson",
                   "Lafayette", 
                   "Lake",
                   "Lee", 
                   "Leon", 
                   "Levy", 
                   "Liberty", 
                   "Madison", 
                   "Manatee", 
                   "Marion", 
                   "Martin", 
                   "Miami-Dade", 
                   "Monroe", 
                   "Nassau", 
                   "Okaloosa", 
                   "Okeechobee", 
                   "Orange", 
                   "Osceola", 
                   "Palm Beach", 
                   "Pasco", 
                   "Pinellas", 
                   "Polk", 
                   "Putnam",
                   "Saint Johns", 
                   "Saint Lucie", 
                   "Santa Rosa", 
                   "Sarasota", 
                   "Seminole", 
                   "Sumter", 
                   "Suwannee", 
                   "Taylor", 
                   "Union", 
                   "Volusia", 
                   "Wakulla", 
                   "Walton", 
                   "Washington",
                  "Florida",
                  "U.S.")

#Columns available for toggle Table 2
all_columns2 <- c("Alachua", 
                 "Baker",
                 "Bay", 
                 "Bradford", 
                 "Brevard", 
                 "Broward", 
                 "Calhoun" ,
                 "Charlotte", 
                 "Citrus",
                 "Clay", 
                 "Collier", 
                 "Columbia", 
                 "DeSoto", 
                 "Dixie", 
                 "Duval", 
                 "Escambia", 
                 "Flagler", 
                 "Franklin", 
                 "Gadsden", 
                 "Gilchrist", 
                 "Glades", 
                 "Gulf", 
                 "Hamilton", 
                 "Hardee", 
                 "Hendry", 
                 "Hernando", 
                 "Highlands", 
                 "Hillsborough", 
                 "Holmes", 
                 "Indian River", 
                 "Jackson", 
                 "Jefferson",
                 "Lafayette", 
                 "Lake",
                 "Lee", 
                 "Leon", 
                 "Levy", 
                 "Liberty", 
                 "Madison", 
                 "Manatee", 
                 "Marion", 
                 "Martin", 
                 "Miami-Dade", 
                 "Monroe", 
                 "Nassau", 
                 "Okaloosa", 
                 "Okeechobee", 
                 "Orange", 
                 "Osceola", 
                 "Palm Beach", 
                 "Pasco", 
                 "Pinellas", 
                 "Polk", 
                 "Putnam",
                 "Saint Johns", 
                 "Saint Lucie", 
                 "Santa Rosa", 
                 "Sarasota", 
                 "Seminole", 
                 "Sumter", 
                 "Suwannee", 
                 "Taylor", 
                 "Union", 
                 "Volusia", 
                 "Wakulla", 
                 "Walton", 
                 "Washington",
                 "Florida",
                 "U.S.")


## Outcome Datasets
OUTCOMES <- read_excel("data/FSU_Demo_Outcomes.xlsx")
OUTCOMES  <- as.data.frame(OUTCOMES)
#OUTCOMES[3:71] <- sapply(OUTCOMES[3:71], function(x) percent(x, accuracy=.01))
data_out <- unique(OUTCOMES)
Sliders <- read_excel("data/FSU_Demo_Outcomes_Sliders.xlsx")
Sliders   <- as.data.frame(Sliders)
#Sliders[3:10] <- sapply(Sliders [3:10], function(x) percent(x, accuracy=.01))
Sliders_out <- unique(Sliders)

FLORENCE <- read_excel("data/FSU_Demo.xlsx")
FLORENCE <- as.data.frame(FLORENCE)
FLORENCE[3:71] <- sapply(FLORENCE[3:71], function(x) percent(x, accuracy=.01))
data <- unique(FLORENCE)

##... other global code...
#gap_map = readRDS("gapminder_spatial.rds")
florida_counties_sf <- st_read("data/FloridaCountyBoundarieswithFDOTDistricts.shp")
saveRDS(florida_counties_sf, "data/FloridaCountyBoundarieswithFDOTDistricts.rds")
Florida = readRDS("data/FloridaCountyBoundarieswithFDOTDistricts.rds")

#Merge data with Map
Out_Map <- read_excel("data/FSU_Demo_Map.xlsx")
Out_Map <- as.data.frame(Out_Map)
Out_Map <- Out_Map %>%
  select(1:6)
Out_Map[, (2:6)] <- lapply(Out_Map[, (2:6)], as.numeric)
#Out_Map[2:6] <- sapply(Out_Map[2:6], function(x) percent(x, accuracy=.01))
merged_out <- left_join(Florida, Out_Map, by = c("NAME" = "County"))

Sliders_out[, (2:17)] <- lapply(Sliders_out[, (2:17)], as.numeric)
Sliders_out <- left_join(Florida, Sliders_out, by = "County")

#Nested Populations Table
# Specify which columns to format
#col_defs1 <- names(FLORENCE)[!names(FLORENCE) %in% c("Domain", "Factor")]
#names(col_defs1) <- col_defs1

#reactable(data,columns = col_defs1,
 #         details = function(index) {
 #           data <- FLORENCE[FLORENCE$Domain == data$Domain[index], ]
  #          htmltools::div(style = "padding: 1rem",
#                           reactable(data, outlined = TRUE))},
#)


#Nested Outcomes Table
# Specify which columns to format
#col_defs2 <- names(OUTCOMES)[!names(OUTCOMES) %in% ("Domain")]
#names(col_defs2) <- col_defs2

#reactable(out,columns = col_defs2,
 #         details = function(index) {
  #          out <- OUTCOMES[OUTCOMES$Domain == OUTCOMES$Domain[index], ]
  #          htmltools::div(style = "padding: 1rem",
    #                       reactable(out, outlined = TRUE))},
#)


#Select by Columns
#CountyChoices <- 1:ncol(data)
#names(CountyChoices) <- names(data)

# Background style to visually distinguish sticky columns
sticky_style <- list(backgroundColor = "#f7f7f7")

#Images and Links
link_shiny <- tags$a(
  icon("github"), "Shiny",
  href = "https://github.com/rstudio/shiny",
  target = "_blank"
)
link_ISF <- tags$a(
  img("2024_New ISF Logo.JPG"), "ISF, Inc.",
  href = "https://www.isf.com",
  target = "_blank"
)

