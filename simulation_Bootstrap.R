# Homework 5

set.seed(71468645)
dat = arima.sim(model=list(order=c(0,0,1),ma=-0.7),n=36)
plot(dat)
-arima(dat,order=c(0,0,1),method='CSS')$coef[1]
-arima(dat,order=c(0,0,1),method='ML')$coef[1]

theta = rep(0,31)
for (i in 0:30){
  theta[i+1] = -arima(dat,order=c(0,0,1),method='CSS',optim.control = list(maxit=1000),n.cond=i)$coef[1]
}
plot(0:30,theta,type='o',xlab='n.cond')
abline(h=1,lty=2)
theta

##### Bootstrapping #####


library(TSA)
library(MASS)

data(hare)
plot(hare)
hist(hare)

y = sqrt(hare)
plot(y)
acf(y)
pacf(y)

f = arima(y,order=c(3,0,0))
phi = f$coef

## Bootstrap
set.seed(329)

b1 = y[1:3]
for (i in 4:length(y)){
  b1[i] = sum(phi[1:3]*(b1[(i-1):(i-3)]-phi[4]))+phi[4]+rnorm(1)
}
plot(b1,type='o')

b2 = y[1:3]
for (i in 4:length(y)){
  b2[i] = sum(phi[1:3]*(b1[(i-1):(i-3)]-phi[4]))+phi[4]+sample(f$residuals,1)
}
plot(b2,type='o')

b3 = arima.sim(n=100,model=list(ar=phi[1:3]),sd=sqrt(f$sigma2))+phi[4]
b3 = b3[-(1:(100-31))]
plot(b3,type='o')

b4 = arima.sim(n=100,model=list(ar=phi[1:3]),rand.gen=function(n,r=f$residuals){sample(r,n,replace=TRUE)})+phi[4]
b4 = b4[-(1:(100-31))]
plot(b4,type='o')
