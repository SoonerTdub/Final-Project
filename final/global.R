library(fpp3)
library(readr)
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(tidyquant)
library(plotly)
library(regclass)
library(tidyr)
library(lubridate)
library(seasonal)
#url
#https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1610004401&pickMembers%5B0%5D=3.1&cubeTimeFrame.startMonth=01&cubeTimeFrame.startYear=2004&cubeTimeFrame.endMonth=02&cubeTimeFrame.endYear=2022&referencePeriods=20040101%2C20220201

#dataset formation/cleanup
tobacco<-read.csv("canadaTData.csv")
tobacco$date<-yearmonth(tobacco$REF_DATE)

tobacco$sales<-tobacco$Production..sales.and.inventories.activities

midtermdf<-tobacco[c(12,17,18)]

ts<-tsibble(midtermdf,index=date,key=sales)

ts<-subset(ts,
           sales=="Total sales")

#autoplot(ts)

#feature 1
#gg_season(ts)
#by year tobacco sales have trended downward the past 10 decades.
#by season it appears that tobacco sales increase through the spring until the fall
# this may be a result of respiratory diseases that appear during cold weather.
#more investigation needed
#feature 2
#gg_lag(ts)
#it appears that predicting tobacco sales has a very strong relationship with the prior month
#however; the strength of this prediction decreases the further out your lag is.
#feature 3
#ts%>%
 # model(classical_decomposition(type="multiplicative"))%>%
  #components()%>%
  #autoplot()
#Our decomposition model depicts a decreasing trend of tobacoo sales that have since 
#leveled out and have remained constant. Variations of trend are more random than seasonal differences
#feature 4
#snav<-ts%>%
  #model(SNAIVE())

#snav%>%
 # forecast()%>%
  #autoplot(ts)+
  #labs(title="Seasonal Naive")
