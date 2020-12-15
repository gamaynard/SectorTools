# Creating a new, empty database at the start of a fishing year

1. Log in to the AWS server through PuTTY following the instructions [here](/Manuals/server_connect.md)
2. Download the latest version of the database builder script by entering the following command into the server terminal

```
curl -o databaseBuilder.sql https://raw.githubusercontent.com/gamaynard/SectorTools/master/Scripts/DatabaseSkeleton.sql
```

3. Log in to the MySQL server in the AWS terminal by typing in the following code and entering the password when prompted.

```
mysql -u root -p
```

4. Once you're in the MySQL console, enter the following command to initialize a new database, replacing `FY20XX` with the appropriate fishing year.
```diff
-WARNING: THERE CANNOT BE SPACES IN NAMES, SO `FY 20XX` WON'T WORK, BUT `FY20XX` WILL
```
```
CREATE DATABASE FY20XX;
exit;
```

5. Run the database builder script from the main AWS terminal to construct the database architecture (tables, relationships, etc.), again, replacing `FYXX` with the name of your new database and entering your password when prompted. 
```
mysql -u root -p FY20XX < /home/ubuntu/databaseBuilder.sql
```

6. Log back in to the MySQL console to see if everything worked. Run the following code (replacing `FYXX` with your database name) to view the tables present in your new database. 
```
mysql -u root -p
USE FY20XX;
SHOW TABLES;
```

7. If everything worked correctly, you should see the following output:

![mysql_init1.PNG](/SupportingFiles/mysql_init1.PNG)

Congratulations! The initial database architecture for the new fishing year has been assembled. The next step will be to upload staffing information, sector rosters, manager contact information, etc. Those instructions can be found [here](/Manuals/infoUpload.md)

[**Click here to return to the main README file**](/README.md)
