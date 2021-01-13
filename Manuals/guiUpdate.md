## Updating the R script that manages the Graphical User Interface

1. Open a WinSCP connection to the server (as described [here](/Manuals/WinSCPold.md))

2. Create a new directory at `/srv/shiny-server/CCCFA/FisheriesTrust/FYXX` replacing `XX` with the new year.

3. Navigate to last year's interface directory (should be at `/srv/shiny-server/CCCFA/FisheriesTrust/FYXX/MooncusserDatabase`). There will be two files (`ui.R` and `server.R`). You will need to make a few small changes to `ui.R` but `server.R` will stay the same year to year.

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
