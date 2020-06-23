## ---------------------------
##
## Script name: PFEX_scraper.R
##
## Purpose of script: To download fish prices from the Portland Fish Exchange
##
## Author: George A. Maynard
##
## Date Created: 2020-06-19
##
## Copyright (c) George Alphonse Maynard, 2020
## Email: galphonsemaynard@gmail.com
##
## ---------------------------
##
## Notes:
##   
##
## ---------------------------

## set working directory

## ---------------------------

## Set options
options(scipen = 6, digits = 4) # eliminate scientific notation
## ---------------------------

## load up the packages we will need:  (uncomment as required)
library(RSelenium)
library(V8)
library(rvest)
library(lubridate)
## ---------------------------

## load up our functions into memory

## ---------------------------
## Select the last week of data
endDate=Sys.Date()
startDate=Sys.Date()-days(7)
## Create the download link
Link=paste("https://reports.pfex.org/customreport_iframe.asp?submitted=true&startdate=",
    month(startDate),
    "%2F",
    day(startDate),
    "%2F",
    year(startDate),
    "&enddate=",
    month(endDate),
    "%2F",
    day(endDate),
    "%2F",
    year(endDate),
    "#",
    sep="")
## Scrape the data off the website
data=xml2::read_html(Link) %>%
  rvest::html_nodes(
    css="#pricesTable"
  ) %>%
  rvest::html_text()
## Cleanup
rm(Link)
## Remove the column names
data=gsub(
  pattern='WeightPricesItemConsignedSoldLowAverageHigh',
  replacement="",
  x=data
)
## Standardize capitalization
data=toupper(data)
## Split the data up into individual characters to loop over
splitData=strsplit(x=data,split="")[[1]]
## Create an empty vector to store the results
newdata=c()
## Set the loop to start at character 1
lineStart=1
## For each character
for(i in 2:nchar(data)){
  ## If the previous character is a number and the current character is a letter
  if((
    splitData[i-1]%in%seq(0,9,1)&&grepl("[A-Za-z]",splitData[i]))
    ## or if the current character is the last character in the data
    ||
    (i==nchar(data))){
    lineStop=i
    ## Create a new line of data, stopping here
    newline=substr(
      x=data, 
      start=lineStart, 
      stop=lineStop-1
    )
    ## Write the new line out to a new character vector
    newdata=c(newdata,newline)
    ## Reset the startpoint for the next cut
    lineStart=i
  }
}
## Clean up loop variables
rm(lineStart,lineStop,splitData,startDate,endDate,i,newline)
## REMEMBER TO TRIM THE LAST TWO VALUES OUT OF THE DATA
## Rename newdata to data
data=newdata;rm(newdata)
## Create a new matrix with two columns (species+size and everything else)
newdata=matrix(ncol=2,nrow=length(data))
## Split the data object into two columns
for(i in 1:length(data)){
  newdata[i,]=strsplit(
    x=data[i],
    split=" | ",
    fixed=TRUE
  )[[1]]
}
## Clean up loop variables
rm(a,i)
## Rename newdata to data
data=newdata;rm(newdata)