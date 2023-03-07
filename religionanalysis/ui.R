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
                        p("Some questions we seek to answer in this analysis
                          are:"), 
                        p("- What are the opinions of survey respondents on various topics
                          and does religiosity seem to have an impact?"),
                        p("- What is the rate of irreligiosity as of 2021?"),
                        p("- What are the most religious zodiac signs?"),
                        p("- How common is interfaith marriage?"),
                        br(),
                        p("This dataset will help answer the questions above using
                          a variety of statistics present in the dataset, including zodiac signs and marriage status"),
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
               tabPanel("Summary",
                        p((h2(strong("Conclusion")))),
                          p("A recurring pattern in our data was religiously 
                          affiliated people and non-affiliated people tending 
                          to disagree more heavily on already controversial topics.
                          This included issues such as the death penality and 
                          immigration where the two groups had starkly 
                          different views while the difference in opinion for 
                          topics such as sex education in grade school was almost negligable. 
                          The broader implications of these results are that 
                          religiously affiliated people and non-affiliated 
                          people have fumdentally different beliefs and values 
                          in matters that are more grey and less clear as to 
                          what is acceptable or right in our current society. 
                          It is also important to note that in a vast majority
                          of cases religion informs an individual's ethics and 
                          shapes their political inclinations. It isn't inherently 
                          a tool for division, but does seem to unintentionally 
                          create a divide. The rise in the nonreligious population,
                          at least in the U.S., creates the potential for a shift 
                          in attitudes regarding many important political and 
                          cultural topics, which could have a far-reaching 
                          impact on the country as a whole."),
                        p((h2(strong("Future Research")))),
                          p("Viewing trends over time as they relate to this 
                            topic would be incredibly insightful, when it comes 
                            to the general social survey we'd have to merge several 
                            large datasets into one to display trends and it would 
                            require a lot of time, but it could be an interesting 
                            future project."),
                          p((h2(strong("Data Quality")))),
                          p("The dataset we used was of reasonable quality. There 
                          wasn't any clear signs of bias in the original survey and 
                          when it came to choosing variables we tried to choose 
                          the survey questions that had the least potential to 
                          draw in biased results. There were 710 variables in 
                          the original dataset and so some of the questions, with 
                          the way they were phrased and the terminology used, could 
                          have unintentially biased the responses of those surveyed.
                          There were multiple sensitive topics in the dataset, since 
                          the survey gathered data on such a vast amount of things and 
                          aimed to develop an understanding on American opinions in 
                          general, but for the most part the questions simply bring 
                          awareness to current attitudes without asserting judgement."))
                          
    )

)


