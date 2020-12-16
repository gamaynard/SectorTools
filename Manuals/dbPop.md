# Populating an empty sector database

Congratulations on making it to this step; the MySQL server is almost ready to use for the new Fishing Year. The next step to getting it there will require moving some files from your local machine to the server. If you need an example of how to do that, please check out the [WinSCP instructions pages of the manual](/Manuals/WinSCP.md). Once you have an established WinSCP connection to the server and understand how to move files from your local machine to the server, you can use WinSCP to create a new directory on the server at `/home/ubuntu/FYXX` replacing `FYXX` with the appropriate fishing year, by right-clicking in the remote directory listing, selecting the **NEW-->DIRECTORY** option, and naming the new directory. This is where we will upload all of the supporting files for the new fishing year.  These uploads to the server take the form of specially formatted .csv files, some of which can be downloaded from NOAA, but some of which must be manually created. Requisite information and formatting is explained below. 

## Permit Holders
Filename: `FY20XXPermitHolders.csv`

This file contains a list of permit holders enrolled in the sector for FY20XX. It is generated manually based on last year’s `FY20XXPermitHolders.csv` file, removing anyone who unenrolled and adding new enrollees. An example file can be seen [here](/SupportingFiles/FY20XXPermitHolders.csv).
```diff
- WARNING: DO NOT USE COMMAS IN BUSINESS NAMES
- WARNING: DO NOT USE SPECIAL CHARACTER IN PHONE NUMBERS
- WARNING: VALUES IN THE STATE COLUMN SHOULD BE TWO LETTER POSTAL ABBREVIATIONS
```
