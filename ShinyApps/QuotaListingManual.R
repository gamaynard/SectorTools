## ---------------------------
##
## Script name: 
##
## Purpose of script:
##
## Author: George A. Maynard
##
## Date Created: 2020-08-07
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
library(shinyjs)
library(dplyr)
library(DT)
library(digest)
## ---------------------------

## load up our functions into memory

## ---------------------------
shinyApp(
  ui = fluidPage(
    titlePanel("Mimicking a Google Form with a Shiny app"),
    div(
      id = "form",
      
      textInput("name", "Name", ""),
      textInput("favourite_pkg", "Favourite R package"),
      checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE),
      sliderInput("r_num_years", "Number of years using R", 0, 25, 2, ticks = FALSE),
      selectInput("os_type", "Operating system used most frequently",
                  c("",  "Windows", "Mac", "Linux")),
      actionButton("submit", "Submit", class = "btn-primary")
    )
  ),
  server = function(input, output, session) {
  }
)