## --------------------------------------------------
##
## Script Name: ServerWatch
##
## Purpose of script: Reviews logins to the nginx server and creates a summary
##                    for each user
##
## Author: George A. Maynard
##
## Date Created: 2020-08-03
##
## Copyright (c) George Alphonse Maynard, 2020
## Email: galphonsemaynard@gmail.com
##
## --------------------------------------------------
## Notes:
## --------------------------------------------------
## 
## Set working directory:
setwd('/var/log/nginx')
##
## --------------------------------------------------
##
## Set options:
options(scipen=6, digits=4)
##
## --------------------------------------------------
##
## Load any necessary packages
##
library(lubridate)
##
## --------------------------------------------------
##
## Load any custom functions
## --------------------------------------------------
## Read in all of the access log files and concatenate them into one large 
## data table
filelist=dir()
for(i in 1:length(filelist)){
  if(grepl("access.log",filelist[i]) == TRUE){
    if(i==1){
      x=read.table(filelist[i])
    } else {
      x=rbind(x,read.table(filelist[i]))
    }
  }
}
## Subset out just the variables of interest
## 1: IP Address
## 3: Username
## 4: Date
## 10: Operating system / browser
colnames(x)=c("IP","-","user","date","-","request","status","bytesSent",
  "referralURL","OS")
x$date=round_date(dmy_hms(x$date),unit="day")
## Remove all non-user (automated) logins
x=subset(
  x,
  x$user!="-"
  )
x$IP=as.character(x$IP)
## If all of George's logins are from the same IP address, clear any other logins
## from that IP address that are just for testing purposes
if(
  length(
    table(
      subset(
        x,
        x$user=='george'
      )$IP
    )
  )==1
){
  x=subset(
    x,
    x$IP!=subset(
      x,
      x$user=='george'
    )$IP[1]
  )
}
## Create a summary file
sink(
  file="/home/ubuntu/ServerWatchSummary.txt",
  append=FALSE
  )
## For each user, print out a list of number of successful login attempts and 
## number of failed login attempts
cat("############## SERVER WATCH SUMMARY FILE #############")
cat("\n")
cat(paste("TODAY'S DATE: ",Sys.Date(),sep=""))
cat("\n")
cat(paste("DATE RANGE: ",min(x$date)," - ",max(x$date),sep=""))
cat("\n")
cat("#################### USER SUMMARY ####################")
cat("\n")
users=c("stephanie","holly","seth","john","mel")
for(u in users){
  y=subset(x,x$user==u)
  if(nrow(y)>=1){
    succ=nrow(subset(y,y$status%in%seq(200,299,1)))
    fail=nrow(subset(y,y$status%in%seq(400,499,1)))
    cat(paste("USER: ",u,sep=""))
    cat("\n")
    cat(paste("SUCCESSFUL LOGINS: ",succ,sep=""))
    cat("\n")
    cat(paste("FAILED LOGINS: ",fail,sep=""))
    cat("\n")
    cat(paste("MOST RECENT LOGIN: ",max(y$date),sep=""))
    cat("\n")
    cat("\n")
    cat("UNIQUE IP ADDRESSES")
    cat("\n")
    cat("-------------------")
    cat("\n")
    cat(unique(y$IP))
    cat("\n")
    cat("\n")
    cat("--------------------------------------------------")
    cat("\n")
  } else {
    cat(paste("USER: ",u,sep=""))
    cat("\n")
    cat("NO LOGINS RECORDED FOR USER")
    cat("\n")
    cat("\n")
    cat("--------------------------------------------------")
    cat("\n")
  }
}
sink()