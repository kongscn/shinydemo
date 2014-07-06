library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # Expression that generates a histogram. The expression is
    # wrapped in a call to renderPlot to indicate that:
    #
    #  1) It is "reactive" and therefore should
    #     re-execute automatically when inputs change
    #  2) Its output type is a plot

    output$distPlot <- renderPlot({
      hist(faithful$eruptions, probability = TRUE, breaks = as.numeric(input$n_breaks),
           xlab = "Duration (minutes)", main = "Geyser eruption duration")
      
      dens <- density(faithful$eruptions, adjust = input$bw_adjust)
      lines(dens, col = "blue")
    })
})
