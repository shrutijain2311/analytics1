#graphs

mtcars
names(mtcars)
table(mtcars$cyl)
table(mtcars$cyl,mtcars$am)
mtcars$mpg
#continuous data-histogram,boxplot
hist(mtcars$mpg)
boxplot(mtcars$mpg,horizontal=T)
boxplot(mpg~gear,data=mtcars,col=1:3)
t1=table(mtcars$gear)
t1
barplot(t1,col=1:3)#category type data
barplot(c(10,3,5))#10,3,5 are static values
pie(c(10,3,5))
students
(t2=table(students$college))
barplot(t2)
(t3=table(students$gender))
barplot(t3)
title('this is the barplot',sub='subtitle')
pie(t3)
