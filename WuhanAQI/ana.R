Sys.setlocale("LC_ALL", "Chinese")

aqidf=xlsx::read.xlsx('data/AQI.xlsx', 
              sheetName="Sheet1", 
              encoding='UTF-8')
aqidf = aqidf[!duplicated(aqidf$日期), ]
levels(aqidf$质量等级) = c("优", "良", "轻度污染", "中度污染", "重度污染", "严重污染")

whetherdf=xlsx::read.xlsx('whether.xlsx', 
                  sheetName="Sheet1", 
                  encoding='UTF-8')
whetherdf = whetherdf[!duplicated(whetherdf$日期), ]
whetherdf = subset(whetherdf, select=-c(年,月, 日))

library(ggplot2)
p = qplot(日期, AQI指数, data=aqidf)

aqin = subset(aqidf, select=-c(日期, 质量等级))
aqixts = xts::as.xts(aqin, order.by=aqidf$日期, frequency=1)
aqi_idx = aqixts$AQI指数
ar(diff(as.ts(aqi_idx)), method='mle')

fUnitRoots::adfTest(aqi_idx,lags=12,type=c("c"))
