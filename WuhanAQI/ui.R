library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("AQI指数"),
    sidebarLayout(
      sidebarPanel(uiOutput("selectVAR")),
      mainPanel(
        tabsetPanel(type = "tabs", 
          tabPanel("Plot", plotOutput("plot")), 
          tabPanel("Summary", verbatimTextOutput("summary")),
          tabPanel("AR", 
            p("AR of selected var's diff: "), 
            verbatimTextOutput("ar")),
          tabPanel("ADF Test", 
            p("ADF test of selected var: "), 
            verbatimTextOutput("adf")),
          tabPanel("Test", verbatimTextOutput("test"))
        )
      )
    )
))
