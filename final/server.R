server <- function(input, output,session) {
 #intro
  output$intro_tab<-renderUI("This app depicts tobacco sales in canada from 2004 to current. The three following tabs contain different forecasting methods.  The Simple methdos are: Naive, Seasonal Naive, Mean, and Drift. The Exponential Models contain the holts and holts/winter's model. And the ARIMA tab depicts both manual and auto arima forecasting.")

  
  
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