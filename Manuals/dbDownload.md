## Downloading all of the tables in a database as individual .csv files

1. Log in to the MySQL [administrative page](https://admin.fisheriestrust.xyz)  

![phpMyAdmin1](/SupportingFiles/php1.PNG)

2. Select the database you'd like to download from in the menu on the left hand side of the page (red circle). You should now see all of the available tables listed in the center of the screen (yellow highlight). 

3. Select the `Export` option on the top menu (blue circle). 

![phpMyAdmin2](/SupportingFiles/php2.PNG)

4. Once in the export menu, select `Custom` and `.csv` options as above

![phpMyAdmin3](/SupportingFiles/php3.PNG)

5. Scrolling down, be sure to select the `Export tables as separate files` option and the `Put column names in the first row` option as above before pressing the `Go` button. You should now get a zipped archive of all of the data in the database. You may need to do some work in Excel to reestablish the links that are explained in the database schemas. 
