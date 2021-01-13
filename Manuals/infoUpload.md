## Uploading Data into a newly created database

# Required files

First, create any required text files by following the instructions [here](/Manuals/dbPop.md)

# Direct uploads
Some files can simply be uploaded as-is. For these files, the easiest way to load them is through the database administrator interface  [here](https://admin.fisheriestrust.xyz). 

Once logged in, you'll see a list of available databases on the left hand side of the screen. Expand the year you are interested in as shown here. 

![PHP_home](/SupportingFiles/phpMenu.PNG)

The following tables can be directly uploaded from text files following the procedure outlined below.

  - FY20XXPermitHolders.csv --> PERMIT_HOLDERS
  - FY20XXSectors.csv --> SECTORS
  - FY20XXStaff.csv --> STAFF
  - FY20XXStocks.csv --> STOCKS
  
In the example, we'll walk through uploading the PermitHolders.csv file. To upload a text file:

1. Select the database table of interest. There will not be any records in the table currently if you are starting a new year's database, so the scribbled out space in this image will be blank. Click on the `Import` option above the table (red circle). 

![PHP_step1](/SupportingFiles/php_step1.PNG)

2. Browse to the correct file on your local computer. You do not need to adjust any other options if you are importing a file into a blank table. Once you've selected the correct file, scroll down and press `<GO>`.

![PHP_step2](/SupportingFiles/php_step2.PNG)

3. You should get a message from the server that says *Import has been successfully finished*. To make sure the records imported correctly, click on the table again in the left hand column to view the data that was just imported. 

[**Click here to return to the main README file**](/README.md)
