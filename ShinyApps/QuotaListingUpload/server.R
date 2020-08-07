## ---------------------------
##
## Script name: server.R 
##
## Purpose of script:The server-side functions to allow the user to upload quota  
##  listings as .pdf files, .csv files, or individual records
##
## Author: George A. Maynard
##
## Date Created: 2020-08-06
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
library(shiny)
library(tidyverse)
## ---------------------------

## load up our functions into memory

## ---------------------------
server=shinyServer(
  function(input,output,session){
    addResourcePath(
      prefix="pdf", 
      directoryPath=tempdir()
      )
    test_file=reactive({
      req(input$file1$datapath)
      readBin(
        con=input$file1$datapath,
        what = 'raw',
        n=input$file1$size
        )
    })
    observe({
      temp=paste0(
        resourcePaths(), 
        "/myreport.pdf"
        )
      today=Sys.Date()
      FY=year(today)
      if(month(today)<5){
        FY=FY-1
      }
      FY=paste0("FY",FY-2000)
      writeBin(
        object=test_file(), 
        con=temp
        )
      file.copy(
        from=temp,
        to=paste0(
          "/home/ubuntu/QuotaListings/",FY,"/",input$file1), 
        overwrite=TRUE
        )
      output$pdfview=renderUI({
        tags$iframe(
          style="height:600px; width:100%", 
          src="pdf/myreport.pdf"
          )
      })
    })
  }
)