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

## Assign each listing a quarter
master$QUART=ifelse(
  master$MONTH%in%c(5,6,7),1,
  ifelse(master$MONTH%in%c(8,9,10),2,
    ifelse(master$MONTH%in%c(11,12,1),3,
      ifelse(master$MONTH%in%c(2,3,4),4,NA
      )
    )
  )
)
## Create a new matrix to store quarterly prices
qp=matrix(nrow=0,ncol=5)
for(i in seq(1,4,1)){
  q=subset(master,master$QUART==i)
  ## remove all listings with NA lbs or price values
  q=subset(q,is.na(q$LBS*q$PRICE)==FALSE)
  ## assign each listing a stock
  stocks=unique(paste(q$SPECIES,q$STOCK,sep=", "))
  ## Calculate a lb weighted average and a listing average 
  ## for each stock
  for(s in stocks){
    x=subset(q,paste(q$SPECIES,q$STOCK,sep=", ")==s)
    x$dup=duplicated(x)
    x=subset(x,x$dup==FALSE)
    newrow=c(
      i,
      s,
      mean(x$PRICE),
      sum(x$LBS*x$PRICE)/sum(x$LBS),
      mean(subset(x,x$MONTH==min(x$MONTH))$PRICE)
      )
    qp=rbind(qp,newrow)
    colnames(qp)=c("QUART","STOCK","LIST","WEIGHTED","FIRST")
  }
}
qp=as.data.frame(qp)
qp$QUART=as.numeric(as.character(qp$QUART))
qp$STOCK=as.character(qp$STOCK)
qp$LIST=round(as.numeric(as.character(qp$LIST)),3)
qp$WEIGHTED=round(as.numeric(as.character(qp$WEIGHTED)),3)
qp$FIRST=round(as.numeric(as.character(qp$FIRST)),3)

## Write the results out to a file
setwd("C:/Users/George/Desktop/Autotask Workplace/Common/Mooncusser Sector, Inc/Quota Listings/")
wb=loadWorkbook(
  paste("QuotaPrices_",fy,".xlsx",sep=""), 
  create = TRUE
)
## Create a worksheet in the workbook for each result object 
## and write out the results
createSheet(
  wb, 
  name="MonthlyPrices"
)
writeWorksheet(
  wb, 
  as.data.frame(prices), 
  sheet="MonthlyPrices", 
  startRow=1, 
  startCol=1
)
createSheet(
  wb,
  name="QuarterlyPrices"
)
writeWorksheet(
  wb,
  as.data.frame(qp),
  sheet="QuarterlyPrices",
  startRow=1,
  startCol=1
)
## Save out the workbook
saveWorkbook(wb)
