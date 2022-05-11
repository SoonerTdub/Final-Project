server <- function(input, output,session) {
    #intro
    output$intro_tab<-renderUI("This app depicts tobacco sales in canada from 2004 to current. There are five tabs that will show you different outputs: Base, Seasonality, Auto Correlation, Decomposition, Seasonal Naive. Base, graphs the regular time series of tobacco sales. Seasonal breaks down tobacco sales by year and plots time series of each. Auto is an autocorrelation plot that breaks down our data by lag (i.e. how well an i change in months will predict the next months tobacco sales). Decomp is a classical decomposition model that breaks down our time series into four components: value, trend, seasona, random. Lastly our seasonal naive tab is a seasonal naive model the attempts to predict the future trend of tobacco sales within a confidence interval. The three following tabs contain different forecasting methods.  The Simple methdos are: Naive, Seasonal Naive, Mean, and Drift. The Exponential Models contain the holts and holts/winter's model. And the ARIMA tab depicts both manual and auto arima forecasting.")
    #feature base 
    output$base_ts<-renderPlot({
      autoplot(ts)
    })
    
    
    
    #feature season spicy   
    output$seasonal <-renderPlot({
      gg_season(ts)
    })
    output$seasonal_int<-renderUI("by year tobacco sales have trended downward the past 10 decades. By season it appears that tobacco sales increase through the spring until the fall. This may be a result of respiratory diseases that appear during cold weather.More investigation needed")
    
    
    
    
    #feature autop
    output$auto<-renderPlot({
      gg_lag(ts)
    })
    
    output$auto_int<- renderUI("It appears that predicting tobacco sales has a very strong relationship with the prior month, however; the strength of this prediction decreases the further out your lag is.")
    
    
    #feature decom
    output$decomp_ts<-renderPlot({
      ts%>%
        model(classical_decomposition(type="multiplicative"))%>%
        components()%>%
        autoplot()
    })
    
    output$decomp_int<-renderUI("Our decomposition model depicts a decreasing trend of tobacoo sales that have since leveled out and have remained constant. Variations of trend are more random than seasonal differences")
    
    
  
  
#feature simple models
  
  #NAIVE
  output$plot_naive <- renderPlot({
    NAIVE<-ts%>%
      model(NAIVE(VALUE))
    
    NAIVE %>%
      forecast() %>%
      autoplot(ts) +
      labs(title = "Naive model")
  })
  
  
  #SEASONAL NAIVE
  output$plot_snaive <- renderPlot({
    SNAIVE <- ts %>%
      model(SNAIVE(VALUE))
    
    SNAIVE %>%
      forecast() %>%
      autoplot(ts) +
      labs(title = "Seasonal Naive model")
  })
  
  
  #MEAN
  output$plot_mean <- renderPlot({
    MEAN <- ts %>%
      model(MEAN(VALUE))
    
    MEAN %>%
      forecast() %>%
      autoplot(ts) +
      labs(title = "Mean model")
  })
  
  
  #DRIFT
  output$plot_drift <- renderPlot({
    
    DRIFT <- ts %>%
      model(RW(VALUE ~ drift()))
    
    DRIFT %>%
    forecast() %>%
    autoplot(ts) +
    labs(title = "Drift model")
  })
  
#feature exponential smoothing
  #holts
  output$holts<-renderPlot({
    
    holts<-ts%>%
    model(ETS(~trend("A")+season("N")))
  
    holts%>%
    forecast(h='3 years')%>%
    autoplot(ts)+
    labs(title="3 year Holts model")
  })
  
  #holts/winter
  output$hw<-renderPlot({
  
    winters<-ts%>%
    model(ETS(~trend("A")+season("M")))
  
  winters%>%
    forecast(h='3 years')%>%
    autoplot(ts)+
    labs(title="3 year Holts/Winters model")
  })
  
#feature arima
  #manually selected parameters
  output$manarima<-renderPlot({
    manarima<-ts%>%
      model(ARIMA(VALUE~pdq(0,1,1)+PDQ(0,1,0)))
    manarima%>%
      forecast(h='3 years')%>%
      autoplot(ts)+
      labs(title="Manual Arima")
  })
  #auto selected parameters
  output$autoarima<-renderPlot({
   
     autoarima<-ts%>%
      model(ARIMA(VALUE))
     
     autoarima%>%
       forecast(h='3 years')%>%
       autoplot(ts)+
       labs(title="auto ARIMA")
    
  })
}