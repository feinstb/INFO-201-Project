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
               tabPanel("About",
                        p(h4("This page dives into the impacts of the 'demise of religion,'
                          observing the many choices individuals make as factors of religion. 
                          Data from the General Social Survey taken in 2021 will be used 
                          and can be found at https://www.thearda.com/")),
                        br(),
                        p((h5(strong("Questions:")))),
                        p("Some questions we are seeking to answer in this analysis
                          are:"), 
                        p("- What is the demographic makeup of the unaffiliated?"),
                        p("- A well known upside to belief in religion is the idea that 
                          life has a very well-defined meaning, but those without religious 
                          belief are left to cope with the relative meaningless of life in other ways. 
                          What are they? This would be a hard question to answer without in-the-field 
                          research, but it could be interesting to develop a qualitative understanding of this."),
                        p("- What kind of irreligious organizations exist? Are there 
                          more in recent years than previously?"),
                        p("- Does parent religiosity increase child religiosity?"),
                        p("- Does belief in religion make one more resilient to hardship?"),
                        br(),
                        p("This dataset will help answer the questions above using
                          a variety of statistics, present in the datast, including zodiac signs and marraige status"),
                        br(),
                        img(src = "different-religions.jpeg", height = 500, width = 800),
                        ),
                
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
               tabPanel("Cross-Analyzing Environmentalism and Sex Education in Schools Across Different Religions",
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("sprel", "Select a religious affiliation:", 
                                        choices = c("1", "2", "3", "4", "5", "6","7")),
                          ),
                          mainPanel(
                            plotOutput("sprel_plot")
                          )
                        )
                        ),
               tabPanel("Summary"))

)


