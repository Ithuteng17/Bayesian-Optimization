#load the libraries
library(forecast)
library(ggplot2)
library(dplyr)



#simulated data for comparison
simulations = rnorm(length(passengers), mean(passengers), sd(passengers))
simulations


#performing an F-test 
f_test = var.test(passengers, simulations)
f_test

#p_value from F-test
p_value = f_test$p.value
print(p_value)


#summary of the air plane passengers dataset, mean, median etc
summary(passengers)


#Creating Time Series object
passengers_time = ts(passengers[,-c(1,2)], frequency = 12,start = c(1949,1))
passengers_time

#plot of Time Series
ggplot(data = data.frame(Date = time(passengers_time),
                         Passengers = passengers_time),
                         aes(x = Date, y = Passengers)) + geom_line() + 
                        labs(title = "Monthly Airline Passengers numbers from 1949-1960",
                             x = "Year",
                             y = "Number of Passengers")
                        
#Finding the trend and seasonal components
dec = decompose(passengers_time)
plot(dec)

#ARIMA(p,q) components
#Autocorrelation function (ACF)
#Partial Autocorrelation function (PACF)
par(mfrow = c(1,2))
acf(passengers_time, main = "ACF of Air Passengers Dataset")
pacf(passengers_time,main = "PACF of Air Passengers Dataset")

#Fit ARIMA model ARIMA(0,1,1)
ar_model = arima(passengers_time, order = c(0,1,1),seasonal = list(order = c(0,1,1) ,period = 12))

#Plotting residuals for ARIMA (0,1,1)
err_mod = resid(ar_model)
plot(err_mod)
acf(err_mod)
pacf(err_mod)

#summary of ARIMA(0,1,1) model
summary(ar_model)

#Fit ARIMA model ARIMA(1,1,1)
ar0_model = arima(passengers_time, order = c(1,1,1),seasonal = list(order = c(1,1,1) ,period = 12))

#Plotting residuals for ARIMA (1,1,1)
err0_mod = resid(ar0_model)
plot(err0_mod)
acf(err0_mod)
pacf(err0_mod)

#summary of ARIMA(1,1,1) model
summary(ar0_model)

#fitting an auto ARIMA model
ar1_model = auto.arima(passengers_time)
ar1_model

#Plotting residuals for auto ARIMA model 
err1_mod = resid(ar1_model)
plot(err1_mod)
acf(err1_mod)
pacf(err1_mod)

#summary of auto ARIMA model
summary(ar1_model)

#forecasting for ARIMA(0,1,1) model
 
forcast_v0 = forecast(object = ar_model, h =12 )
forcast_v0

#Next 12 months
plot(forcast_v0,
     main = "Forecast for the next 12 Months",
     xlab = "Time",
     ylab = "Number of Passengers")


#forecasting for ARIMA(1,1,1) model

forcast_v1 = forecast(object = ar0_model, h =12 )
forcast_v1

#Next 12 months
plot(forcast_v1,
     main = "Forecast for the next 12 Months",
     xlab = "Time",
     ylab = "Number of Passengers")

#forecasting for ARIMA(1,1,1) model

forcast_v2 = forecast(object = ar1_model, h =12 )
forcast_v2

#Next 12 months
plot(forcast_v2,
     main = "Forecast for the next 12 Months",
     xlab = "Time",
     ylab = "Number of Passengers")

