######################################################################
### Examples from Time Series Analysis with Applications in R
######################################################################
library(TSA)

# Example 1
win.graph(width=4.875, height=2.5, pointsize=8)
data(larain)
plot(larain, ylab='Inches', xlab='Year', type='o')

win.graph(width=3, height=3, pointsize=8)
plot(y=larain, x=zlag(larain), ylab='Inches', xlab='Previous Year Inches')

fit <- lm(larain ~ zlag(larain))

summary(fit)


# Example 2

win.graph(width=4.875, height=2.5, pointsize=8)
data(color)
plot(color, ylab='Color Property', xlab='Batch', type='o')

win.graph(width=3, height=3, pointsize=8)
plot(y=color, x=zlag(color), ylab='Color Property', xlab='Previous Batch Color Property')
fit <- lm(color ~ zlag(color))

summary(fit)

# Example 3
win.graph(width=4.875, height=2.5, pointsize=8)
data(hare)
plot(hare, ylab='Abundance', xlab='Year', type='o')

win.graph(width=3, height=3, pointsize=8)
plot(y=hare, x=zlag(hare), ylab='Abundance', xlab='Previous Year Abundance')
fit <- lm(hare ~ zlag(hare))
summary(fit)

# Example 4
win.graph(width=4.875, height=2.5, pointsize=8)
data(tempdub)
plot(tempdub, ylab='Temperature', xlab='Year', type='o')

# Example 5

data(oilfilters)
plot(oilfilters, type='o', ylab='Sales')

plot(oilfilters, type='l', ylab='Sales')
points(y=oilfilters, x=time(oilfilters), pch=as.vector(season(oilfilters)))
