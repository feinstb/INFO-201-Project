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
    
    print(head(pg1_data))
    
    pg1_reactive <- reactive({
      if (input$religious == "Religious") {
        pg1_data %>%
          filter(RELIG != 4)
      } else {
        pg1_data %>%
          filter(RELIG == 4)
      }
    })
    
    # have to fix labels and add description of chart
    output$multivariable <- renderPlot({
      if (input$var_pg1 == "Immigration") {
        ggplot(pg1_reactive(), aes(x = IMMLIMIT)) +
          geom_bar() +
          labs(
            title = "Survey Prompt: America should limit immigration",
            x = "Responses",
            y = "Count")
      } else if (input$var_pg1 == "Environmental Concern") {
        ggplot(pg1_reactive(), aes(x = GRNCON)) +
          geom_bar() +
          labs(
            title = "Survey Prompt: Generally speaking, how concerned are you 
            about environmental issues?",
            x = "Level of concern ranging from no concern to very concerned",
            y = "Count")
      } else if (input$var_pg1 == "Sex Education") {
        ggplot(pg1_reactive(), aes(x = SEXEDUC)) +
          geom_bar() +
          labs(
            title = "Survey Prompt: Would you be for or against sex education 
            in the public schools?",
            x = "Favor vs Oppose",
            y = "Count")
      } else if (input$var_pg1 == "Death Penalty") {
        ggplot(pg1_reactive(), aes(x = CAPPUN)) +
          geom_bar() +
          labs(
            title = "Survey Prompt: Do you favor or oppose the death penalty 
            for persons convicted of murder?",
            x = "Favor vs Oppose",
            y = "Count")
      } else if (input$var_pg1 == "Gay Marriage") {
        ggplot(pg1_reactive(), aes(x = MARHOMO)) +
          geom_bar() +
          labs(
            title = "Survey Prompt: Homosexual couples should have the right to 
            marry one another.",
            x = "Responses",
            y = "Count")
      }
    })



}
