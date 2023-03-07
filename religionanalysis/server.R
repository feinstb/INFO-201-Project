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
                       CAPPUN, SPREL)
    
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
    
    pg1_data$RELIG <- factor(pg1_data$RELIG, levels = c(1, 2, 3, 4, 5, 6, 7,
                                                        8, 9, 10, 11, 12, 13),
                             labels = c("Protestant", "Catholic",
                                        "Jewish", "None", "Other",
                                        "Buddhism", "Hinduism",
                                        "Other Eastern Religions",
                                        "Muslim/Islam",
                                        "Orthodox Christian",
                                        "Christian", "Native American",
                                        "Inter/nondenominational"))
    
    pg1_data$SPREL <- factor(pg1_data$SPREL, levels = c(1, 2, 3, 4, 5, 6, 7),
                             labels = c("Protestant", "Catholic", "Jewish",
                                        "None", "Other", "Buddhism", "Hinduism"))
    
    
    pg1_reactive <- reactive({
      if (input$religious == "Religious") {
        pg1_data %>%
          filter(RELIG != "None")
      } else if (input$religious == "Nonreligious"){
        pg1_data %>%
          filter(RELIG == "None")
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
      return("The intention of this page is to paint a general picture of
             the attitudes of respondents based on their religious
             preference. In order to do this, the application allows the user
             to select religiosity and then choose a variable to see plotted.
             Then users can switch back and forth between the two radio buttons
             to compare attitudes of religious respondents to nonreligious
             respondents. The variables chosen for comparison are pretty
             contested issues in American politics and cultural life and before 
             viewing the plot, users can probably guess what the trends will look
             like. The plot does allow for direct visual comparison between 
             religiosity, as well as an idea of what current attitudes are,
             at least as of 2021.")
    })
    
    pg3_reactive <- reactive({
      pg1_data %>%
        filter(RELIG == input$pg3_religiosity)
    })
    
    output$pg3_plot <- renderPlot({
      ggplot(pg3_reactive(), aes(x = SPREL)) +
          geom_bar()
    })
    
    output$pg3_desc <- renderText({
      return("This plot gives the user a chance to select the religious affiliation
             of respondents and then see what the religious affiliation is of
             their spouse (if they are married). NA is the number of missing
             responses and in a few cases of religiosity, the numbers were so
             low and the prevalence of missing answers so high that the plot
             doesn't offer much useful information besides a visualization of
             missing responses. For the majority, we can see that people
             overwhelmingly marry within their faith.")
    })
    
    zodiac_convert <- data.frame(
      sign = c("Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo",
               "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius",
               "Pisces"),
      value = c(1, 2, 3, 4, 5,6,7,8,9,10,11,12)
    )    
    pg2_data <- reactive({
      if (input$zodiac == "Total Sample") {
        # If "Total Sample" is selected, use all data
        data <- data_2021
      } else {
        filter(data_2021, ZODIAC == zodiac_convert$value[zodiac_convert$sign == input$zodiac])
      }
    })
    religion_counts <- reactive({
      pg2_data() %>%
        group_by(RELIG) %>%
        summarize(count = n())
    })
    total_people <- reactive({
      sum(religion_counts()$count)
    })
    output$zodiac_bar <- renderPlot({
      if (input$zodiac == "Total Sample") {
        # If "Total Sample" is selected, use all data and title plot accordingly
        plot_title <- "Total Sample"
        data <- religion_counts()
      } else {
        # Otherwise, filter data based on selected zodiac sign and title plot accordingly
        plot_title <- paste("Zodiac sign:", input$zodiac)
        data <- religion_counts()
      }
      ggplot(data, aes(x = RELIG, y = count / total_people())) +
        geom_bar(stat = "identity") + 
        ggtitle(plot_title) +
        xlab("Religion") + ylab("Percentage") +
        scale_x_continuous(breaks = 1:13, labels = c("Protestant", "Catholic", "Jewish", "None", "Other", "Buddhism", "Hinduism", 
                                                     "Other Eastern religions", "Muslim/Islam", "Orthodox Christian", "Christian", 
                                                     "Native American", "Inter/nondenominational"))
    })
    output$pg2_desc <- renderText({
      return("This plot gives the user the ability to see what ratio of each religion
             is based on their zodiac sign. From this we can see that zodiac sign does 
             not have any stastically significant impact, with most zodiac signs 
             having a similar ratio of religions to the total sample. Generally, 
             protestant has the highest ratio, followed by none and then catholicism
             and then the remaining all being a low amount compartively. There are some
             small outliers, such as virgo having a plurality of people who have no 
             religion and pisces having a relatively higher level of budhists, but
             overall we can conclude that zodiac sign has no true impact on religion.")
    })
    
    
    
    



}
