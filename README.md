# Bayesian Optimization: Comparison of Optimization Methods

## Overview

This project compares optimization methods for time series modeling using the classic airline passengers dataset. The repository focuses on ARIMA forecasting, statistical testing, and model selection techniques to determine the most suitable predictive model.

**Author:** Ithuteng Ntakhwana (ID: 201801847)

## Project Description

The project explores how different optimization and model-selection approaches behave when applied to the monthly airline passengers dataset from 1949 to 1960. The analysis includes:

- Data preprocessing and exploratory analysis
- Time series decomposition
- ACF and PACF analysis
- F-test comparison against simulated data
- ARIMA model fitting and comparison
- Optimization using BIC-based model selection
- Forecast generation and performance evaluation

## Repository Structure

- `ARIMA.Rmd` — ARIMA analysis report with exploratory analysis and forecasting
- `ARIMA.pdf` — Generated PDF output for the ARIMA report
- `AirpassEDA.R` — Script for EDA, decomposition, residual analysis, and model fitting
- `BICAR.Rmd` — Report using BIC to select the best ARIMA model
- `BICAR.pdf` — Generated PDF output for the BIC model selection report
- `BICAir.R` — R script for comparing ARIMA models using Bayesian Information Criterion (BIC)
- `FtestR.Rmd` — F-test report and statistical comparison
- `FtestR.pdf` — Generated PDF output for the F-test analysis
- `ARIMA BIC.Rproj` — R project configuration file

## Dataset

The repository uses the airline passengers dataset, which contains monthly passenger counts from 1949 to 1960. This series is well suited for time series modeling because it shows:

- A clear upward trend
- Strong seasonality
- Non-stationary behavior that requires differencing

## Methods Used

### Exploratory Data Analysis
The scripts inspect the dataset structure, summary statistics, and missing values before transforming it into a time series object.

### Time Series Analytics
The analysis includes:

- Plotting the monthly passenger series
- Decomposing trend and seasonal components
- Computing ACF and PACF to assess model behavior
- Fitting ARIMA(p, d, q) models
- Comparing seasonal ARIMA variants

### Model Selection
The project compares several approaches:

- Manual fitting of ARIMA(0,1,1) and ARIMA(1,1,1)
- Auto ARIMA using the `forecast` package
- BIC-based grid search to select the best model order

### Forecasting
After fitting candidate models, the project generates 12-month forecasts and evaluates model quality through residual plots and error measures such as MSE.

## Key Libraries

```r
library(forecast)
library(ggplot2)
library(dplyr)
library(zoo)
```

## Example Workflow

```r
# Run exploratory analysis
source("AirpassEDA.R")

# Render the ARIMA report
rmarkdown::render("ARIMA.Rmd")

# Run BIC-based optimization
source("BICAir.R")

# Render the BIC report
rmarkdown::render("BICAR.Rmd")
```

## Output

The repository generates PDF and HTML reports from the R Markdown files to communicate results for:

- ARIMA forecasting
- BIC-based optimization
- F-test statistical validation

## Summary

This repository is a practical project for comparing optimization methods in time series modeling. It combines statistical testing, ARIMA modeling, and model selection criteria to identify the most appropriate forecasting approach for airline passenger data.

---

Project on comparison of optimization methods.
