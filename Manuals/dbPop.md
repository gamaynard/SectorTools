# Populating an empty sector database

Congratulations on making it to this step; the MySQL server is almost ready to use for the new Fishing Year. The next step to getting it there will require moving some files from your local machine to the server. If you need an example of how to do that, please check out the [WinSCP instructions pages of the manual](/Manuals/WinSCP.md). Once you have an established WinSCP connection to the server and understand how to move files from your local machine to the server, you can use WinSCP to create a new directory on the server at `/home/ubuntu/FYXX` replacing `FYXX` with the appropriate fishing year, by right-clicking in the remote directory listing, selecting the **NEW-->DIRECTORY** option, and naming the new directory. This is where we will upload all of the supporting files for the new fishing year.  These uploads to the server take the form of specially formatted .csv files, some of which can be downloaded from NOAA, but some of which must be manually created. Requisite information and formatting is explained below. 

## Permit Holders
Filename: `FY20XXPermitHolders.csv`

This file contains a list of permit holders enrolled in the sector for FY20XX. It is generated manually based on last year’s `FY20XXPermitHolders.csv` file, removing anyone who unenrolled and adding new enrollees. An example file can be seen [here](/SupportingFiles/FY20XXPermitHolders.csv). The `OwnerID` column is an index that should start at "1" and increment by 1. For example, if there are three members in the sector, the OwnerID column should contain the values 1, 2, and 3. 
```diff
- WARNING: DO NOT USE COMMAS IN ANY FIELDS
- WARNING: DO NOT USE SPECIAL CHARACTER IN PHONE NUMBERS
- WARNING: VALUES IN THE STATE COLUMN SHOULD BE TWO LETTER POSTAL ABBREVIATIONS
```

## Sector Roster
Filename: `FY20XXSectorRoster.csv`

This file was downloaded as is from the SIMM (path: **Planning Downloads --> Sector Roster --> Generate Report in CSV**). It contains all of the MRI numbers, PSC values, and ACE values for each permit, but not the permit owners. Once the file has been downloaded from the SIMM, you will need to manually add permit holder information from the sector records, being sure to match the names in `FY2020PermitHolders.csv`. An example file can be seen [here](/SupportingFiles/FY20XXSectorRoster.csv)
```diff
- WARNING: THE OWNER COLUMN MUST BE MANUALLY ADDED
- WARNING: ALL OWNER RECORDS MUST HAVE AN EXACT MATCH (INCLUDING CASE) IN THE OWNER COLUMN OF THE PERMIT HOLDERS TABLE
- WARNING: THE FORMATTING OF THIS SIMM DOWNLOAD WAS LAST VERIFIED IN FY2020
```

## Sectors
Filename: `FY20XXSectors.csv`

This file contains contact information for all New England sector managers. It was originally created using the information available through NOAA [here](https://www.fisheries.noaa.gov/new-england-mid-atlantic/commercial-fishing/sector-manager-contact-information). However, this information is not necessarily up to date, so the MOON sector manager should double check as necessary. An example file can be seen [here](/SupportingFiles/FY20XXSectors.csv). Much of this information may remain the same year to year. 
```diff
- WARNING: DO NOT USE COMMAS IN ANY FIELDS
- WARNING: DO NOT USE SPECIAL CHARACTERS IN PHONE NUMBERS
- WARNING: VALUES IN THE STATE COLUMN SHOUDL BE TWO LETTER POSTAL ABBREVIATIONS
```

## Staff
Filename: `FY20XXStaff.csv`

This file contains contact information for all CCCFA staff associated with the CCFT. Each transaction that is entered into the ledger for this year will be stamped with the StaffID of the staff member who entered it. That StaffID links back to this table for easy tracking of who cut what deals when. The file must be manually compiled at the beginning of each year. Last year’s file is a good starting point. An example file can be seen [here](/SupportingFiles/FY20XXStaff.csv). The `StaffID` column is an index that should start at "1" and increment by 1. For example, if there are three staff working on the data, the StaffID column should contain the values 1, 2, and 3. The **Role** column should contain either the value `admin` for people who have access to the database to actually edit the data or `readonly` for people who only view the information without changing it. 
```diff
- WARNING: DO NOT USE COMMAS IN ANY FIELDS
- WARNING: DO NOT USE SPECIAL CHARACTERS IN PHONE NUMBERS
```

## Stocks
Filename:`FY20XXStocks.csv`

Barring major changes in the New England Multispecies FMP, this file should be the same year to year, just with a different name. It is a translator between different data silos so that species names and stock areas can be compared as needed. You can manually download the most up to date version of the file [here](https://raw.githubusercontent.com/gamaynard/SectorTools/master/SupportingFiles/FY20XXStocks.csv) by copy/pasting the text data into a spreadsheet and saving it out as a .csv file with the appropriate name. Alternately, you can download it directly to the AWS server by logging in to a server session through PuTTY and entering the following code, replacing FY20XX with the appropriate fishing year:

`cd /home/ubuntu/FY20XX/`

`curl -o FY20XXStocks.csv https://raw.githubusercontent.com/gamaynard/SectorTools/master/SupportingFiles/FY20XXStocks.csv`

