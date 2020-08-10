## ---------------------------
##
## Script name: QuotaListingManual.R
##
## Purpose of script: Allows the user to manually add quota listings from non
##    standardized sources (i.e., all sectors except for SHS)
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
## Create a star label for mandatory fields
labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}
humanTime <- function() format(Sys.time(), "%Y%m%d-%H%M%OS")
epochTime <- function() {
  as.integer(Sys.time())
}
## ---------------------------
## Define which fields will be mandatory
fieldsMandatory=c("name", "favourite_pkg")
## Define the color of the mandatory star emphasis
appCSS=".mandatory_star { color: red; }"
## Name the fields that will be exported
fieldsAll=c("name", 
            "favourite_pkg", 
            "used_shiny", 
            "r_num_years", 
            "os_type"
            )
## Define the directory path for storing results
responsesDir="C:/Users/George/Desktop/Autotask Workplace/Common/Mooncusser Sector, Inc/Database/responses/"
## Read in the up to date species list
speciesList=read.csv("https://raw.githubusercontent.com/gamaynard/SectorTools/master/SHS_SpeciesList.csv")
shinyApp(
  ##############################################################################
  ## UI
  ##############################################################################
  ui = fluidPage(
    ## All shinyjs language goes here
    shinyjs::useShinyjs(),
    shinyjs::inlineCSS(appCSS),
    ## Give the app a title
    titlePanel("Manual Quota Listing Uploads"),
    ## Create the first screen that the user sees ("form")
    div(
      id="form",
      selectInput(
        inputId="stock", 
        label=labelMandatory("Stock"),
        choices=speciesList$
        value=""),
      textInput("favourite_pkg", labelMandatory("Favourite R package")),
      checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE),
      sliderInput("r_num_years", "Number of years using R", 0, 25, 2, ticks = FALSE),
      selectInput("os_type", "Operating system used most frequently",
                  c("",  "Windows", "Mac", "Linux")),
      actionButton("submit", "Submit", class = "btn-primary")
    ),
    shinyjs::hidden(
      div(
        id = "thankyou_msg",
        h3("Thanks, your response was submitted successfully!"),
        actionLink("submit_another", "Submit another response")
      )
    )  
  ),
  server = function(input, output, session) {
    observe({
      mandatoryFilled <-
        vapply(fieldsMandatory,
               function(x) {
                 !is.null(input[[x]]) && input[[x]] != ""
               },
               logical(1))
      mandatoryFilled <- all(mandatoryFilled)
      
      shinyjs::toggleState(id = "submit", condition = mandatoryFilled)
    })
    formData <- reactive({
      data <- sapply(fieldsAll, function(x) input[[x]])
      data <- c(data, timestamp = epochTime())
      data <- t(data)
      data
    })
    saveData <- function(data) {
      fileName <- sprintf("%s_%s.csv",
                          humanTime(),
                          digest::digest(data))
      
      write.csv(x = data, file = file.path(responsesDir, fileName),
                row.names = FALSE, quote = TRUE)
    }
    # action to take when submit button is pressed
    observeEvent(input$submit, {
      saveData(formData())
      shinyjs::reset("form")
      shinyjs::hide("form")
      shinyjs::show("thankyou_msg")
    })
    observeEvent(input$submit_another, {
      shinyjs::show("form")
      shinyjs::hide("thankyou_msg")
    })    
  }
)