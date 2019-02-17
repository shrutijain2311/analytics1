women
nrow(women)
sample(1:10, size=.7*10)#example using 10 instead of nrows
sample(1:nrow(women),size=.7*nrow(women))
index=sample(1:nrow(women),size=.7*nrow(women))
index#is a vector where the values are stored
women[index,]
women[-index,]
train=women[index,]
test=women[-index,]

fit1=lm(weight~height,data=train)
summary(fit1)
p4=predict(fit1,newdata=test,type='response')
cbind(predicted=p4,actual=test$weight,height=test$height)

