library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Hello World!"),

    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(
          selectInput("n_breaks", label = "Number of bins:",
                      choices = c(10, 20, 35, 50), selected = 20),
          sliderInput("bw_adjust", label = "Bandwidth adjustment:",
                      min = 0.2, max = 2, value = 1, step = 0.2)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
