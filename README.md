
I. Instructions 

This file provides guidelines for replicating all the empirical results found in this study. The replication files are located in a folder called replication. The latter includes three subfolders named raw_data, codes, and rscripts. The raw_data folder includes three files. An Excel file (raw-hate-crime-data.xlsx) that shows the raw observations for hate crimes. Secondly, it includes another Excel file (imputation calculations.xlsx) that shows how the missing and zero estimates are imputed. Lastly, the raw_data folder includes a STATA file named raw-data.dta; this is the main dataset to be used for the study.

The codes folder includes a file named final.do. This file provides all the instructions to compute the regressions, tables, and figures listed in the paper. I used RStudio to append the FBI's UCR data into one large Excel file. Instead of having to look for all the data in PDF files, this study contributes to the literature by making the FBI’s UCR data easily available. You can access the script file (Append-data.R) in a folder named rscripts. The latter also reports the total number of incidents reported by each state in a folder called Total incidents.

II. Main data

•	raw-data.dta

III. Codes

•	codes.do	

•	Append-data.R		

III. STATA instructions:

1.	Open STATA. 
2.	Open the replication zip folder.
3.	Copy all the folders from the replication zip folder and paste them onto your desktop.
4.	From STATA, open the file final.do.
5.	Follow the instructions on final.do. Make sure to install the necessary packages needed to run the regressions. 

IV. Data Sources

https://www.fbi.gov/how-we-can-help-you/more-fbi-services-and-information/ucr/publications?utm_source=chatgpt.com

https://cde.ucr.cjis.gov/LATEST/webapp/#/pages/explorer/crime/arrest

https://www.rand.org/research/gun-policy/gun-ownership.html

https://fred.stlouisfed.org/help/about/about-fred/what-is-fred

https://www.fhfa.gov/data/hpi

