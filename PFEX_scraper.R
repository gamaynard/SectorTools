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
library(RCurl)
library(lubridate)
library(xml2)
library(rvest)
library(stringdist)
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
    if(i!=nchar(data)){
      newline=substr(
        x=data, 
        start=lineStart, 
        stop=lineStop-1
      )
    }
    if(i==nchar(data)){
      newline=substr(
        x=data,
        start=lineStart,
        stop=lineStop
      )
    }
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
## Create a new matrix to store three columns of data (species/size, size,
## and everything else)
newdata=matrix(nrow=nrow(data),ncol=3)
for(i in 1:nrow(data)){
  ## The first column stays the same
  newdata[i,1]=data[i,1]
  ## The second column is the size class
  ## Create a split character vector to loop through
  splitData=strsplit(x=data[i,2],split="")[[1]]
  ## Set the loop to start at character 1
  lineStart=1
  ## As long as the fish isn't halibut
  if(grepl(
      pattern="HALIBUT",
      x=data[i,1]
  )==FALSE){
    ## For each character
    for(j in 2:nchar(data[i,2])){
      ## If the previous character is a number and the current character is a letter
      if(splitData[j]%in%seq(0,9,1)&&grepl("[A-Za-z]",splitData[j-1])){
        lineStop=j
        ## Create a new line of data, stopping here
        newline=substr(
          x=data[i,2], 
          start=lineStart, 
          stop=lineStop-1
        )
        ## Write the new line out to the second column of newdata
        newdata[i,2]=newline
        ## Write the remainder out to the third column of newdata
        newdata[i,3]=substr(
          x=data[i,2],
          start=j,
          stop=nchar(data[i,2])
        )
      }
    }
  }
  if(grepl(
      pattern="HALIBUT",
      x=data[i,1]
    )==TRUE){
      ## For each character
      for(j in 2:nchar(data[i,2])){
        ## If the previous character is a hyphen, and the current character is a 
        ## number greater than 1
        if(splitData[j-1]=="-"&&as.numeric(splitData[j])>1){
          lineStop=j+2
          ## Create a new line of data, stopping here
          newline=substr(
            x=data[i,2], 
            start=lineStart, 
            stop=lineStop-1
          )
          ## Write the new line out to the second column of newdata
          newdata[i,2]=newline
          ## Write the remainder out to the third column of newdata
          newdata[i,3]=substr(
            x=data[i,2],
            start=j,
            stop=nchar(data[i,2])
          )
        }
        ## If the previous character is a hyphen, and the current character is 1
        if(splitData[j-1]=="-"&&as.numeric(splitData[j])==1){
          lineStop=j+3
          ## Create a new line of data, stopping here
          newline=substr(
            x=data[i,2], 
            start=lineStart, 
            stop=lineStop-1
          )
          ## Write the new line out to the second column of newdata
          newdata[i,2]=newline
          ## Write the remainder out to the third column of newdata
          newdata[i,3]=substr(
            x=data[i,2],
            start=j,
            stop=nchar(data[i,2])
          )
        }  
      }
    }
  }
## Clean up
data=newdata;rm(newdata,i,j,lineStart,lineStop,newline,splitData)
## Create a new matrix with four columns to store prices in the fourth column
newdata=matrix(nrow=nrow(data),ncol=4)
for(i in 1:nrow(data)){
  ## The first column stays the same
  newdata[i,1]=data[i,1]
  ## The second column stays the same
  newdata[i,2]=data[i,2]
  ## Create a split character vector to loop through
  splitData=strsplit(x=data[i,3],split="")[[1]]
  ## Set the loop to start at character 1
  lineStart=1
  for(j in 2:nchar(data[i,3])){
    ## If the current character is a $ and there are no $ before it
    if(splitData[j]=="$"&&sum(splitData[1:j-1]=="$")==0){
      lineStart=j
      lineStop=nchar(data[i,3])
      newline=substr(
        x=data[i,3], 
        start=lineStart, 
        stop=lineStop
      )
      newdata[i,4]=newline
      newdata[i,3]=substr(
        x=data[i,3],
        start=1,
        stop=lineStart-1
      )
    }
  }
}
## Clean up
data=newdata
rm(newdata,i,j,lineStart,lineStop,newline,splitData)
## Create an empty matrix to store split apart pricing values
newdata=matrix(ncol=6,nrow=nrow(data))
for(i in 1:nrow(data)){
  ## The first three columns are the same
  newdata[i,1]=data[i,1]
  newdata[i,2]=data[i,2]
  newdata[i,3]=data[i,3]
  ## The fourth through sixth columns are prices, separated by $
  newdata[i,4:6]=strsplit(
    x=data[i,4],
    split="$",
    fixed=TRUE
  )[[1]][2:4]
  ## In the last row of data, remove the sum total values
  if(i==nrow(data)){
    newdata[i,6]=substr(
      newdata[i,6],
      start=1,
      stop=4
    )
  }
}
## Turn the matrix into a data frame and clean up 
data=as.data.frame(newdata)
rm(newdata,i)
## Rename the data columns to something meaningful
colnames(data)=c("species","size","weights_bad","low","avg","high")
data$species=as.character(data$species)
## Match the PFEX species to human-readable, standarized species names
species=read.csv("species.csv")
for(i in 1:nrow(data)){
  a=as.character(data[i,1])
  y=stringsim(
    a,
    as.character(
      species[,1]
      )
    )
  z=which(y==max(y))
  x=as.character(species[z,3])
  data$species[i]=x
  rm(a,y,z,x)
}
data$weights_bad=NULL
## Create a summary file
sink(
  file="/home/ubuntu/PFEXMarketReport.txt",
  append=FALSE
)
## Print out the data
cat(paste("Subject: PFEX Market Report ",Sys.Date(),sep=""))
cat("\n")
cat("To: Server Admin")
cat("\n")
cat("From: CCFT Server Bot")
cat("\n")
cat(data)
sink()