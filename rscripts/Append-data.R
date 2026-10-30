# Adverse labor market outcomes and hate crimes 
# Dr.Oulatta

# These codes allow you to combine UCR data into one file. 
rm(list = ls())
install.packages("tidyverse")
install.packages("writexl")
library(tidyverse)
library(writexl)


setwd ("C:/Users/muuno/Desktop/Social Sciences and Humanities Open (Final)/rscripts/Total incidents")

xlfiles <- list.files(
  path = ".",
  pattern = "\\.xlsx$",
  full.names = TRUE
)

xlfiles

hate <- purrr::map_dfr(xlfiles, readxl::read_excel)

View(hate)

write_csv(hate, "observed-hate-crimes.csv")