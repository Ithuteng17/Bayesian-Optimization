#Load Air passengers dataset embedded in R
passengers = data.frame(year = rep(1949:1960, each = 12),
                        month = c(1:12,1:12,1:12,1:12,1:12,1:12,1:12,1:12,1:12,1:12,1:12,1:12),
                        fq = c(112, 118, 132, 129, 121, 135, 148, 148, 136, 119, 104, 118,
                               115, 126, 141, 135, 125, 149, 170, 170, 158, 133, 114, 140,
                               145, 150, 178, 163, 172, 178, 199, 199, 184, 162, 146, 166,
                               171, 180, 193, 181, 183, 218, 230, 242, 209, 191, 172, 194,
                               196, 196, 236, 235, 229, 243, 264, 272, 237, 211, 180, 201,
                               204, 188, 235, 227, 234, 264, 302, 293, 259, 229, 203, 229,
                               242, 233, 267, 269, 270, 315, 364, 347, 312, 274, 237, 278,
                               284, 277, 317, 313, 318, 374, 413, 405, 355, 306, 271, 306,
                               315, 301, 356, 348, 355, 422, 465, 467, 404, 347, 305, 336,
                               340, 318, 362, 348, 363, 435, 491, 505, 404, 359, 310, 337,
                               360, 342, 406, 396, 420, 472, 548, 559, 463, 407, 362, 405,
                               417, 391, 419, 461, 472, 535, 622, 606, 508, 461, 390, 432
                        ))
passengers = subset(passengers, select = -c(year))
#Time Series Object
passengers_time = ts(passengers[,-c(1,2)], frequency = 12,start = c(1949,1))
passengers_time

#Variables of interest to store information
best_or = NULL
best_model = NULL
best_bic = Inf


#loops in p,d,q ARIMA model
for(p in 0:4) {
  for (d in 0:1) {
    for (q in 0:4) {
      #Fitting ARIMA(p,d,q) model with Max. Likelihood
      a_model = tryCatch(arima(passengers_time, order = c(p,d,q), method = "ML"),
                         error = function(e) NULL
                         )
      #Checking if model had fit successfully
      if (!is.null(a_model)) {
        bicmod = BIC(a_model)
        
        #Updating model if BIC is lower than best fit
        if (bicmod < best_bic) {
          best_or = c(p,d,q)
          best_model = a_model
          best_bic = bicmod
        }
      }
    }
  }
}
#Print of the best model
cat("The best order model is:", best_or,"\n")
print(best_model)
cat("BIC:", best_bic, "\n")

# Forecast values using the best ARIMA model
forecast_values <- predict(best_model, n.ahead = 12)$pred

# Convert forecast values to time series with appropriate start and frequency
forecast_values_ts <- ts(forecast_values, start = c(1960, 1), frequency = 12)

# Actual values
actual_values <- window(passengers_time, start = c(1960, 1), end = c(1960, 12))

# Calculate the squared differences using intersecting time periods
squared_diff <- (forecast_values_ts - actual_values)^2


# Compute the mean squared error
mse <- mean(squared_diff)

# Print the mean squared error
cat("Mean Squared Error (MSE):", mse, "\n")


