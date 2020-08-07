## ---------------------------
##
## Script name: ui.R
##
## Purpose of script: The UI to allow the user to upload quota listings as 
##  .pdf files, .csv files, or individual records
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
library(lubridate)
## ---------------------------

## load up our functions into memory

## ---------------------------
ui=shinyUI(
  fluidPage(
    titlePanel("Quota Listings Upload"),
    sidebarLayout(
      sidebarPanel(
        fileInput(
          inputId='file1',
          label="Upload File",
          multiple=FALSE,
          accept=c(".pdf")
          )
      ),
      mainPanel(
        uiOutput("pdfview")
      )
    )
  )
)