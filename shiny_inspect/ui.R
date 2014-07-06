library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Inspect runtime env"),
        # Show a plot of the generated distribution
        mainPanel(
            textOutput("wd"),
            br(),
            textOutput("locale")
        )
))
