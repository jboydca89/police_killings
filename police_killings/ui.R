library(shiny); library(tidyverse)

pk <- read_csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/fatal-police-shootings-data.csv")

shinyUI(fluidPage(
    titlePanel("Police Killings in the US"),
    sidebarLayout(
        sidebarPanel(
            dateRangeInput("dates", "Date range:",
                           start = "2015-01-01",
                           end = Sys.Date(),
                           min = "2015-01-01",
                           max = Sys.Date()),
            selectInput("state", "State", c("All states",
                                            sort(unique(pk$state))),
                        selected = "All", multiple = FALSE),
        ),
        mainPanel(
            h4("Total Killings"),
            textOutput("TotalKillings"),
            br(),
            p("Select a date range and a US state on the left. The shiny app will return the number of police killings in that date range for that particular state.")
        )
    )
))
