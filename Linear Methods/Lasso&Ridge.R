#--------- CORTEX REGRESSION

setwd("~/Dropbox (Personal)/Autoencoder/")

#--------- Read in Data
data <- read.csv("cortex_df.csv", header=TRUE)
head(data)

#--------- Exploratory analysis
data[!complete.cases(data),]

#--------- Ridge Regression
## Put data into a matrix for ridge regression
data.m <- as.matrix(data)
#View(data.m)

## Setting alpha=0 designates ridge regression
## This function automatically standardizes the explanatory variables
library(glmnet)
s.ridge <- glmnet(data.m[,2:1904], data.m[,1], alpha=0, lambda=0.01)

## Ridge coefficicent estimates
coef(s.ridge)

## Ridge regression can also be done with several lambda values
## This procedure will yield a matrix of coefficients
s.ridge <- glmnet(data.m[,2:1904], data.m[,1], alpha=0)

## Create the ridge trace plot
plot(s.ridge,xvar="lambda",label=TRUE)

## To see the lambda value that was used and the corresponding coefficients
s.ridge$lambda[20]
coef(s.ridge)[,20]

## Lasso regression uses the same function as ridge regression with alpha=1
s.lasso <- glmnet(data.m[,2:1904], data.m[,1], alpha=1)
s.lasso$lambda[20]
coef(s.lasso)[,20]

#--------- HIPPOCAMPUS REGRESSION
