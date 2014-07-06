APP_DIR = "WuhanAQI"

if (exists("..fixpath")){..fixpath(APP_DIR)}

library(shiny)
library(ggplot2)

aqidf=xlsx::read.xlsx('data/AQI.xlsx',
                      sheetName="Sheet1",
                      encoding='UTF-8')
aqidf = aqidf[!duplicated(aqidf$日期), ]
levels(aqidf$质量等级) = c("优", "良", "轻度污染", "中度污染", "重度污染", "严重污染")

# aqin = subset(aqidf, select=-c(日期, 质量等级))
# aqixts = xts::as.xts(aqin, order.by=aqidf$日期, frequency=1)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # Expression that generates a histogram. The expression is
    # wrapped in a call to renderPlot to indicate that:
    #
    #  1) It is "reactive" and therefore should
    #     re-execute automatically when inputs change
    #  2) Its output type is a plot
    output$selectVAR = renderUI({
      selectInput("var", "Select Var", 
                  names(aqidf)[!names(aqidf) %in% c("日期")],
                  selected="AQI指数")
    })
    
    value = reactive({ as.ts(aqidf[[input$var]]) })
    ar_model = reactive({ ar(value(), method='mle') })
    
    output$plot <- renderPlot({
      gg = ggplot(aqidf, aes_string(x="日期", y=input$var, color="质量等级"))
      gg + geom_point()
    })
    
    output$summary = renderPrint({summary(aqidf)})
    
    output$ar = renderPrint({
      ar_model()
    })
    
    output$adf = renderPrint({
      fUnitRoots::adfTest(value(), lags=ar_model()$order, type=c("c"))
    })
    
#    output$test <- renderPlot({
#      # gg = ggplot(aqidf, aes_string(x="日期", y=input$var, color="质量等级"))
#      # gg + geom_point()
#      qplot(日期, AQI指数, data=aqidf, color=质量等级)
#    })
    output$test = renderPrint({
      xx = system("fc-list :lang=zh-cn", intern=T)
      xx
    })
})
