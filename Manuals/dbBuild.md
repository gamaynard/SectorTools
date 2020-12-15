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
