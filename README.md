README
Title: Adverse labor market outcomes and hate crimes 

Authors: Moon Oulatta, Ph.D. in economics

email: oulatta@niler.org 
_________________________________________________________
Description 

This file provides guidelines for replicating all the empirical results presented in this study. The replication files are located in a folder named replication, which contains three subfolders: raw_data, codes, and rscripts. The raw_data folder contains three files. The first is an Excel file (raw-hate-crime-data.xlsx) containing the raw observations on hate crimes. The second is another Excel file (imputation calculations.xlsx) showing how missing and zero estimates are imputed. Lastly, the raw_data folder contains a Stata file named raw-data.dta, which is the main dataset used in this study.

The codes folder contains a file named final.do, which provides all the instructions needed to generate the regressions, tables, and figures presented in the paper. I used RStudio to append the FBI's Uniform Crime Reporting (UCR) data into a single data file. Instead of spending time searching and extracting data from individual PDF files, this study contributes to the literature by making the UCR data more easily accessible. The corresponding R script (Append-data.R) is available in a folder named rscripts. This folder also contains a subfolder named Total incidents, which reports the total number of incidents reported by each state.

I. Main data

•	raw-data.dta

II. do files, R scripts

•	codes.do		

•	Append-data.R		

III. STATA instructions:

1.	Open STATA. 

2.	Open the replication zip folder.

3.	Copy all the folders from the replication zip folder and paste them on your desktop.

4.	From STATA, open the file final.do.

5.	Follow the instructions on final.do. Make sure to install the necessary packages needed to run the regressions. 

IV. Data Sources

https://www.bea.gov/data/gdp/gdp-state

https://www.bts.gov/browse-statistical-products-and-data/state-transportation-statistics/us-airline-traffic-airport

https://databank.worldbank.org/source/world-development-indicators/preview/on

https://fred.stlouisfed.org/

https://finance.yahoo.com/
https://usatradeonline.census.gov/home

