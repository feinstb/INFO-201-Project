#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
fluidPage(
  
    navbarPage("Examination of the US Religious Environment",
               tabPanel("About"),
               tabPanel("Multivariable Analysis Based on Religiosity",
                        sidebarLayout(
                          sidebarPanel(
                            radioButtons("religious", "Select religiosity of 
                                         respondents:", choices = 
                                           c("Religious", "Nonreligious")),
                            selectInput("var_pg1", "Variable to Display:",
                                        choices = c("Immigration", 
                                                    "Environmental Concern", 
                                                    "Sex Education", 
                                                    "Death Penalty", 
                                                    "Gay Marriage"))
                            
                          ),
                          mainPanel(
                            plotOutput("multivariable"),
                            textOutput("pg1desc")
                          )
                        )),
               tabPanel("Interactive pg 2"),
               tabPanel("Prevalence of Interfaith Marriage",
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("pg3_religiosity", "Select a religious affiliation:", 
                                        choices = c("Protestant", "Catholic",
                                                    "Jewish", "None", "Other",
                                                    "Buddhism", "Hinduism",
                                                    "Other Eastern Religions",
                                                    "Muslim/Islam",
                                                    "Orthodox Christian",
                                                    "Christian", "Native American",
                                                    "Inter/nondenominational")),
    
                          ),
                          mainPanel(
                            plotOutput("pg3_plot"),
                            textOutput("pg3_desc")
                          )
                        )
                        ),
               tabPanel("Summary"))

)


