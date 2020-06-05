## ---------------------------
##
## Script name: SHS_scraper.R
##
## Purpose of script: pulls data from Sustainable Harvest Sector
##    quota lisings
##
## Author: George A. Maynard
##
## Date Created: 2020-06-03
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
## Should default to GitHub repo
## ---------------------------

## Set options
options(scipen = 6, digits = 4) # eliminate scientific notation
## ---------------------------

## load up the packages we will need:  (uncomment as required)
library(lubridate)
library(tabulizer)
library(dplyr)
library(XLConnect)
## ---------------------------

## load up our functions into memory

## ---------------------------
## Set fishing year
fy="FY19"
## Read in all SHS-generated listings for the fishing year in question
directory=paste("C:/Users/George/Desktop/Autotask Workplace/Common/Mooncusser Sector, Inc/Quota Listings/Other_",fy,sep="")
filelist=paste(directory,dir(directory)[which(grepl("SHS",dir(directory))*grepl(".pdf",dir(directory))==1)],sep="/")
speciesLookup=read.csv("SHS_SpeciesList.csv")
master=data.frame(
  DATE=character(),
  LBS=integer(),
  PRICE=double(),
  SPECIES=character(),
  STOCK=character()
)
for(filename in filelist){
  raw=extract_tables(filename)
  if(length(raw)>1){
    raw[[1]]=cbind(raw[[1]],"ISO")
    raw[[2]]=cbind(raw[[2]],"Available")
    data=rbind(raw[[1]][-1,],raw[[2]][-1,])
    colnames(data)=c("DATE","TRADEID","SHS_SPECIES","LBS","PRICE","STATUS")
    data=as.data.frame(data)
    data$DATE=ifelse(is.na(data$DATE)==FALSE,as.character(mdy(paste(data$DATE,year(now()),sep="/"))),NA)
    data=merge(data,speciesLookup)
    data$SHS_SPECIES=NULL
    data$LBS=as.numeric(gsub("[^0-9.]", "", data$LBS))
    data$PRICE=as.numeric(gsub("[^0-9.]", "", data$PRICE))
    data$SECTOR="SHS"
    data=select(data,DATE,LBS,PRICE,SPECIES,STOCK)
    master=rbind(master,data)
  }
}
## Assign each listing a month
master$MONTH=month(ymd(as.character(master$DATE)))
## Calculate a monthly average for each stock
prices=matrix(nrow=0,ncol=4)
for(i in seq(1,12,1)){
  month=subset(master,master$MONTH==i)
  ## remove all listings with NA lbs or price values
  month=subset(month,is.na(month$LBS*month$PRICE)==FALSE)
  ## assign each listing a stock
  stocks=unique(paste(month$SPECIES,month$STOCK,sep=", "))
  ## Calculate a lb weighted average and a listing average 
  ## for each stock
  for(s in stocks){
    x=subset(month,paste(month$SPECIES,month$STOCK,sep=", ")==s)
    x$dup=duplicated(x)
    x=subset(x,x$dup==FALSE)
    newrow=c(i,s,mean(x$PRICE),sum(x$LBS*x$PRICE)/sum(x$LBS))
    prices=rbind(prices,newrow)
    colnames(prices)=c("MONTH","STOCK","LIST","WEIGHTED")
  }
}
prices=as.data.frame(prices)
prices$MONTH=as.numeric(as.character(prices$MONTH))
prices$STOCK=as.character(prices$STOCK)
prices$LIST=round(as.numeric(as.character(prices$LIST)),3)
prices$WEIGHTED=round(as.numeric(as.character(prices$WEIGHTED)),3)
## Write the results out to a file
setwd("C:/Users/George/Desktop/Autotask Workplace/Common/Mooncusser Sector, Inc/Quota Listings/")
wb=loadWorkbook(
  paste("QuotaPrices_",fy,".xlsx",sep=""), 
  create = TRUE
)

## Create a worksheet in the workbook for each result object and write out the results
createSheet(
  wb, 
  name="MarketPrices"
)
writeWorksheet(
  wb, 
  as.data.frame(prices), 
  sheet="MarketPrices", 
  startRow=1, 
  startCol=1
)
## Save out the workbook
saveWorkbook(wb)
