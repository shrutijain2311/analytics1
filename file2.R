my first file
#comment using hash 
women 
#control+enter for excuting a command
?women
#for help-type ? followed by command
?mean
#example
mtcars
?mtcars
mean(mtcars$mpg)
#calculating mean of mpg in mtcars data.write mean() followed by dollar sign.
mean(mtcars$hp)
#mean of horse power
names(mtcars)
#gives names of the variables in data set
colMeans(mtcars)
#gives average of all columns.you could have sum,diff etc
rowMeans(mtcars)
#cars wise avg. rowwise
head(mtcars,1)
#head by default returns 1st six rows.but if put 1 gives only one row
tail(mtcars)
#last six rows
tail(mtcars,1) #last row
hist(mtcars$mpg)
#draw a histogram
hist(mtcars$mpg,breaks=3)
#3 class intervals in histogram


#vectors
x=c(1,2,5,7) #c is variable to join x and data
x
class(x)#created data set,class telling type of object i.e numeric type vector

x1=c(2L,8L)
class(x1)
class(mtcars)
x3=c("a",'b',"dhiraj")#x3 name,c combines them,x3 is character
x3
class(x3)  
x4=c(TRUE,FALSE,T,F)#LOGICAL 
X4     
X5=1:100000  #CREATED SEQUENCE OF DATA.= SYMBOL FOR ASSIGNMENT 
X5
X6<-2 # <- ANOTHER WAY OF ASSIGNMENT BY DEFAULT
(X5=1:100000)
(x7 = rnorm(1000))#rnorm for normal distribution
sd(x7)#standard deviation
plot(density(x7))
hist(x7)#only histogram.
hist(x7,freq=F) #write freq imp. line 53 and 54 together execute one after another.
points(density(x7)) # to overlay the two graphs first execute 53


(x8= rnorm(100, mean=60, sd=10))#draw histogram and overlay the graphs
hist(x8)
hist(x8,freq=F)
points(density(x8))
mean(x8)
sd(x8)

library(e1071)# for kurtosis you need package
kurtosis(x8)
skewness(x8)#left skewness


x9=runif(100, 30, 90)#uniform distribution vector data set
x9
trunc(x9)#remove decimal places
round(x9,1)#round off to one decimal point
floor(x9)
ceiling(x9)
x10= ceiling(x9)#storing the ceiling values of x9
x10
median(x10)
sort(x10)#sorting x10 in ascending by default
sort(x10, decreasing = T)

x10[1:10]#first ten student marks
x10[x10 > 60]#values greater then 60
x10[20:30]
x10[-c(1:20)]#dont give the first 20 numbers so -
x10[c(1,5,7)]#give first,third and fifth no.


#matrices

m1=matrix(1:24 , nrow=6)#create matrix
m1
dim(m1)
m2= matrix(1:56, ncol=8)
m2
m3=matrix(1:24,ncol=6, byrow=T)#change the way data is filled up.by default data gets stored columnwise.
m3
colnames(m3)=month.abb[1:6]#naming the first sex months so month.abbreviate
m3
rownames(m3)=paste('product',1:4,sep='_')#"prouct" sep= does concatinate func. and then use no. 1 to 4
m3
rowMeans(m3)#calculate row mean
colMeans(m3)
rowSums(m3)#sum of rows
m1[ ,1:2]
m3[ ,1:2]
m3[c(1,3), ]#specific rows
colMeans(m3[c(1,3), ])
m3[ ,c('Apr','Jun')]
max(m3)
min(m3)
range(m3)

#question

#date.frame
#combiantion of vectors with same length
n=30
(rollno= paste('S',1:30,sep='-'))#alphanumeric roll no
(sname=paste('student' ,1:30, sep='&'))#student name

set.seed(1234)#generate same pattern of data
(gender= sample(c('M','F'),size=n,replace=T,prob=c(.7,.3)))
#pick up size more than the sample.m picked and then kept back and pick up female and so on.
#prob for ratio distribution males is 70%
(t1=table(gender))
prop.table(t1)#calculate proportion
n1=30
college=sample(c('srcc','fms','iim'), size=n1, replace=T, prob=c(.4, .3, .3))
college
(t2=table(college))
prop.table(t2)




(marks1= round(rnorm(n=n,mean=60,sd=10),0))
(marks2= round(rnorm(n=n,mean=55,sd=15),0))
rollno;sname;gender;college;marks1;marks2;
length(gender)

(students=data.frame(rollno,sname,gender,college,marks1,marks2))
students[,c('sname','marks1')]
str(students)#structure
summary(students)
quantile(students$marks1)#claculate quartile
quantile(students$marks1, probs=seq(0,1,0.1))#calculate decile
seq(1,100,2)#interval of 2
seq(1,100)
quantile(students$marks1, probs=seq(0,1,0.01))#percentile
#seq=(from=1,to=100,by=3)
#in quartile seq=(0,1,0.25, 0.5, 0.75, 1)
str(students)
students$rollno=as.character(students$rollno)
students$sname=as.character(students$snames)
str(students)
summary(students)
head(students)
write.csv(students,'fms.csv',row.names=F)
students2=read.csv('fms.csv')
head(students)
students3=read.csv(file.choose())
head(students3)


students=read.csv('fms.csv')
students






#details of all students1 who got more than 60 

library(dplyr)
head(students)
students[students$marks1 >60, ]
students[students$gender =='F', ]
students[students$gender =='F'| students$college == 'SRCC', ]
#highest from all collges
students %>% filter(gender=='M' )
students %>% group_by(gender) %>% summarise(mean(marks1),mean(marks2))
students %>% group_by(college)%>% summarise(max(marks1),max(marks2))
students %>% filter(college=='fms') %>% select(marks1,marks2)
