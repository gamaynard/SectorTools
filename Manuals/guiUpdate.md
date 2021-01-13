## Updating the R script that manages the Graphical User Interface

1. Open a WinSCP connection to the server (as described [here](/Manuals/WinSCPold.md))

2. Create a new directory at `/srv/shiny-server/CCCFA/FisheriesTrust/FYXX` replacing `XX` with the new year.

3. Navigate to last year's interface directory (should be at `/srv/shiny-server/CCCFA/FisheriesTrust/FYXX/MooncusserDatabase`). There will be two files (`ui.R` and `server.R`). You will need to make a few small changes to both.

4. Copy and paste the entire `MooncusserDatabase` file and its contents into the new `FYXX` directory.

5. Navigate to the new directory, right click on the new `ui.R` file and select the option `Edit --> Notepad ++`. Notepad ++ is a  text editor like Notepad, but with some extra features that will make your life easier. 

6. Starting from the top of the file, for consistency's sake update the header section (lines 1:14)

    - Line 5 needs a new fishing year
  
    - Add or update your name as the Editor on Line 8
  
    - Add or update the Date Edited on Line 10

```
1  ## ---------------------------
2  ##
3  ## Script name: ui.R
4  ##
5  ## Purpose of script: ui side script for FY20XX CCFT database
6  ##
7  ## Author: George A. Maynard
8  ## Editor: YOUR NAME HERE
9  ## Date Created: 2020-07-20
10 ## Date Edited: TODAY'S DATE HERE
11 ## Copyright (c) George Alphonse Maynard, 2020
12 ## Email: galphonsemaynard@gmail.com
13 ##
14 ## ---------------------------
```

7. Update the database connection block that starts around Line 58 to point to the new year's database. In the example below, the line that needs to be updated is Line 61

```
58 ## Connect to database
59   db=dbConnect(
60     MySQL(),
61     dbname="FY20XX",
62     host="localhost",
63     port=3306,
64     user=user,
65     password=password
66   )
  ```

8. The trickiest block to update control the select user menus. These two blocks need to match the new year's permit holders file (typically located at `/home/ubuntu/FY20XX/FY20XXPermitHolders.csv`). The block of code you will need to edit will start around Line 296 and look similar to the following:
```
selectInput(
    inputId="ownerTo",
    label="Lessee",
    multiple=FALSE,
    choices=list(
        "CCCFA"=1,
        "PERMIT HOLDER 2"=2,
        "PERMIT HOLDER 3"=3,
        "PERMIT HOLDER 4"=4,
        "PERMIT HOLDER 5"=5,
        "NULL"
        ),
    selected="NULL"
    ),
 selectInput(
    inputId="ownerFrom",
    label="Lessor",
    multiple=FALSE,
    choices=list(
        "CCCFA"=1,
        "PERMIT HOLDER 2"=2,
        "PERMIT HOLDER 3"=3,
        "PERMIT HOLDER 4"=4,
        "PERMIT HOLDER 5"=5,
        "NULL"
        ),
     selected="NULL"
     ),
```
        
   - There can be as many or as few permit holders as you need in the list. Obviously CCCFA will always be one of the permit holders. The other permit holders should be listed in the `/home/ubuntu/FY20XX/FY20XXPermitHolders.csv` file with the same numbers that they correspond to in the list here. 
   - The lists need to match each other exactly. A few things to watch out for:
       - Each entry should end with a comma
       - The name of the permit holder must be enclosed in quotation marks
       - The final entry must be "NULL" with no comma
