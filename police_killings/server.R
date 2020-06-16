library(shiny); library(tidyverse)

pk <- read_csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/fatal-police-shootings-data.csv")
pk <- pk %>% mutate(manner_of_death = as.factor(manner_of_death),
                    armed = as.factor(armed), gender = as.factor(gender),
                    race = as.factor(race), state = as.factor(state),
                    threat_level = as.factor(threat_level),
                    flee = as.factor(flee))

shinyServer(function(input, output, session) {
    reTotal <- reactive({
        if (input$state == "All states") {
            re_data <- pk %>% filter(date >= input$dates[1],
                                     date <= input$dates[2])
        }
        else {
            re_data <- pk %>% filter(
                date >= input$dates[1], date <= input$dates[2],
                state == input$state)
        }
        nrow(re_data)
    })
    output$outDate <- renderText(paste("Total police killings from",
                                       as.character(input$dates[1]), "to",
                                       as.character(input$dates[2])))
    output$outState <- renderText(input$state)
    output$TotalKillings <- isolate(reTotal)
})
