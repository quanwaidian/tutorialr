library(ggplot2)

# create new varaibles 
autodata = mtcars

# summary statistics
summary(autodata)

# recode factor varaible
autodata$trans = factor(autodata$am, labels=c('automatic','manual'))
summary(autodata$trans)

# cross tab
table(autodata$trans, autodata$cyl)
ct = table(autodata$trans, autodata$cyl)
prop.table(ct)
prop.table(ct,1)
prop.table(ct,2)

# histogram
hist_stat =hist(autodata$mpg)
# histogram done right
qplot(data=autodata, x=mpg, geom='histogram')
# histogram overkill
ggplot(data=autodata, aes(x=mpg))+ 
    geom_histogram(binwidth = 5, aes(y=..density..,fill = ..count..))  + 
    geom_density()

# scatter plot
qplot(data=autodata, x=hp, y=mpg)
# + smoothing
qplot(data=autodata, x=hp, y=mpg) + geom_smooth()
