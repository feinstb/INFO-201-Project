#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {
  
    data_2021 <- read.csv("gss2021.csv")
    pg1_data <- select(data_2021, RELIG, IMMLIMIT, MARHOMO, SEXEDUC, GRNCON,
                       CAPPUN)
    
    # Change multivariable plot labels from numerical values to corresponding
    # labels.
    pg1_data$IMMLIMIT <- factor(pg1_data$IMMLIMIT, levels = c(1, 2, 3, 4, 5),
                                labels = c("Strongly agree", "Agree",
                                           "Neither agree nor disagree",
                                           "Disagree",
                                           "Strongly disagree"))
    
    pg1_data$GRNCON <- factor(pg1_data$GRNCON, levels = c(1, 2, 3, 4, 5),
                              labels = c("Not at all concerned",
                                         "2", "3", "4", "Very concerned"))
    
    pg1_data$SEXEDUC <- factor(pg1_data$SEXEDUC, levels = c(1, 2),
                               labels = c("Favor", "Oppose"))
    
    pg1_data$CAPPUN <- factor(pg1_data$CAPPUN, levels = c(1, 2),
                              labels = c("Favor", "Oppose"))
    
    pg1_data$MARHOMO <- factor(pg1_data$MARHOMO, levels = c(1, 2, 3, 4, 5),
                               labels = c("Strongly agree", "Agree",
                                          "Neither agree nor disagree",
                                          "Disagree",
                                          "Strongly disagree"))
    
    
    pg1_reactive <- reactive({
      if (input$religious == "Religious") {
        pg1_data %>%
          filter(RELIG != 4)
      } else {
        pg1_data %>%
          filter(RELIG == 4)
      }
    })
    
    output$multivariable <- renderPlot({
      if (input$var_pg1 == "Immigration") {
        ggplot(pg1_reactive(), aes(x = IMMLIMIT)) +
          geom_bar() +
          scale_fill_discrete(labels = c("Strongly agree", "Agree",
                                        "Neither agree nor disagree",
                                        "Disagree",
                                        "Strongly disagree")) +
          labs(
            title = "Survey Prompt: America should limit immigration",
            x = "Responses",
            y = "Count")
      } else if (input$var_pg1 == "Environmental Concern") {
        ggplot(pg1_reactive(), aes(x = GRNCON)) +
          geom_bar() +
          scale_fill_discrete(labels = c("Not at all concerned",
                                         "2", "3", "4", "Very concerned")) +
          labs(
            title = "Survey Prompt: Generally speaking, how concerned are you 
            about environmental issues? 1 means not at all concerned and 5
            means very concerned",
            x = "Level of concern",
            y = "Count")
      } else if (input$var_pg1 == "Sex Education") {
        ggplot(pg1_reactive(), aes(x = SEXEDUC)) +
          geom_bar() +
          scale_fill_discrete(labels = c("Favor", "Oppose")) +
          labs(
            title = "Survey Prompt: Would you be for or against sex education 
            in the public schools?",
            x = "Favor vs Oppose",
            y = "Count")
      } else if (input$var_pg1 == "Death Penalty") {
        ggplot(pg1_reactive(), aes(x = CAPPUN)) +
          geom_bar() +
          scale_fill_discrete(labels = c("Favor", "Oppose")) +
          labs(
            title = "Survey Prompt: Do you favor or oppose the death penalty 
            for persons convicted of murder?",
            x = "Favor vs Oppose",
            y = "Count")
      } else if (input$var_pg1 == "Gay Marriage") {
        ggplot(pg1_reactive(), aes(x = MARHOMO)) +
          geom_bar() +
          scale_fill_discrete(labels = c("Strongly agree", "Agree",
                                         "Neither agree nor disagree",
                                         "Disagree",
                                         "Strongly disagree")) +
          labs(
            title = "Survey Prompt: Homosexual couples should have the right to 
            marry one another.",
            x = "Responses",
            y = "Count")
      }
    })
    
    output$pg1desc <- renderText({
      return("have to add a description still")
    })



}
