#graphs
#linear regression(LR)-simple(S),multiple(M)
#y~ x1(SLR)  y~x1+x2....(MLR)
#y - dependent variable x-independent

head(women)
#y~weight x~height
cor(women$height,women$weight) # strength and direction of relationship
cov(women$height,women$weight) #covariance tells direction of relationship 
plot(women$height,women$weight)#linear relationship

fit1=lm(weight~height,data=women)#lm is a command to do linear modelling.~=weight dependnt on height
summary(fit1)
#F stats Pvalue << 0.005 :linear model exists
#at least one independent variable in predicting the dependent variable
#multiple Rsquare= 0.991 co-eff of determination
#multiple when you have one IV,otherwise take Adj Rsq
#99% of variation in Y is explained by X
#y=mx+c y=-87+3.45*height
range(women$height)
#only do interpolation and not exterpolation
# * =shows if variable is significant or not in predicting Y . no * is not significant
women$weight
women$height
(y= -87+3.45*women$height)#predicted weights for actual heights
fitted(fit1)#same as 25 no. line. though fitted is more accurate.fitted is a builtin command
residuals(fit1)#difference between predicted and actual weights lesser the diff better the model
summary(fit1)#summary of the model
summary(residuals(fit1))
summary(students$marks1)#summary of one column
summary(students[ ,5:6])#summary for marks1 and 2
(newdata1=data.frame(height=c(60.4,56.9)))
(p1=predict(fit1,newdata=newdata1,type='response'))
cbind(newdata1,p1)#combine the columns.similarly you can use for rows



#linear model in three lines
fit2=lm(weight~height,dat=women)
summary(fit2)
(newdata2=data.frame(height=c(72,74)))
(p2=predict(fit1,newdata=newdata2,type='response'))
cbind(newdata2,p2)#combine the columns.similarly you can use for rows

#check for linear regression assumptions
plot(fit1)













