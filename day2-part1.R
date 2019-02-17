#data.frame
n=30
rollno = 1:30
(rollno = paste('F',1:30,sep='-'))
(sname = paste('Student',1:30, sep='&'))

set.seed(1234)
(gender = sample(c('M','F'), size=n, replace=T, prob=c(.7,.3)))
table(gender)
(t1=table(gender))
prop.table(t1)

set.seed(12)
(college = sample(c('SRCC','FMS','IIM'), size=n, replace=T, prob=c(.4,.3,.3)))
(t2=table(college))
prop.table(t2)
n=30
(rollno = paste('F',1:30,sep='-'))
(sname = paste('Student',1:30, sep='&'))
set.seed(1234)
(gender = sample(c('M','F'), size=n, replace=T, prob=c(.7,.3)))
(t1=table(gender))
prop.table(t1)
set.seed(12)
(college = sample(c('SRCC','FMS','IIM'), size=n, replace=T, prob=c(.4,.3,.3)))
(t2=table(college))
prop.table(t2)

(marks1 = round(rnorm(n=n, mean=60,sd=10),0) )
(marks2 = round(rnorm(n=n, mean=55,sd=15),0) )
rollno; sname; gender; college;marks1;marks2
length(gender)
students = data.frame(rollno, sname, gender, college, marks1, marks2)
class(students)
students
head(students)
students$
  students$rollno
students[,5:6]
students[,c(2,5:6)]
students[,c('sname','marks1','marks2')]
str(students)
summary(students)
quantile(students$marks1)
quantile(students$marks1, probs=seq(0,1,.1))
seq(0,1,.1)

quantile(students$marks1)
quantile(students$marks1, probs=c(0,.25,.5,.75,1))
seq(1,100)
seq(1,100,2)
seq(1,100,3)
quantile(students$marks1, probs=seq(0,1,.1))
quantile(students$marks1, probs=seq(0,1,.01))
seq(from=1,to=100,by=3)
quantile(students$marks1, probs=seq(0,1,.25))
summary(students)
str(students)
students$rollno =as.character(students$rollno)
students$sname =as.character(students$sname)
str(students)
summary(students)
str(students)
head(students)
write.csv(students, 'fms.csv', row.names = F)
students2 = read.csv('fms.csv')
head(students2)
students3 = read.csv(file.choose())
head(students3)

#students
head(students)
library(dplyr)
head(students)
students[students$marks1 > 60 , ]
students[students$gender =='F' , ]
students[students$gender =='F' & students$college == 'SRCC' , ]#AFTER COMMA EMPTY MEANS SHOW ALL OTHER DATA AFTER F AS WELL
# |- LOGICAL OR
#&- LOGICAL AND

#highest from all college
#USING DPLYR
# % - PIPE SYMBOL(FILTER COMMAND - %>% ) #== FOR CHECKING EQUALITY. = IS FOR ASSIGNMENT
students %>% filter(gender=='M' & marks1 > 60)#ALL MALES WITH MORE THAN 60 IN MARKS1

#MEAN MARKS OF ALL FEMALES AND MALES SEPARATELY IN TWO SUBJECTS
students %>% group_by(gender) %>% summarise(mean(marks1), mean(marks2))

students %>% group_by(college) %>% summarise(max(marks1), max(marks2))
students %>% filter(college=='FMS') %>% select(marks1, marks2)
students %>% filter(gender=='M' & marks1 > 60 & college=='SRCC')

hist(marks1)
hist(marks2)

#MALES  and females in each college grouped by college and gender
students%>%group_by(gender,college)%>%summarise(countTotal=n(),mean(marks2))

students%>%mutate(totalMarks=marks1+marks2,mean(marks2),mean(marks1))#mutate used to add extra column to existing dataset.its only temporary display no changs in the prev. data

students%>%tally()#total number of students
#only top 5 students based on tot marks
students%>%mutate(totalMarks=marks1+marks2,mean(marks2),mean(marks1))%>%arrange(-totalMarks)
students%>%mutate(totalMarks=marks1+marks2)%>%filter(totalMarks==max(totalMarks))#giving only the name who had the max total marks
students%>%mutate(totalMarks=marks1+marks2)%>%arrange(totalMarks)#for ascending
students%>%mutate(totalMarks=marks1+marks2)%>%arrange(-totalMarks)#- for descending
#arrange marks in decresing order and give me top 3
students%>%mutate(totalMarks=marks1+marks2)%>%arrange(-totalMarks)%>%head(n=3)
students%>%mutate(totalMarks=marks1+marks2)%>%arrange(-totalMarks)%>%head(n=1)
#print alternate rows 
students%>%slice(seq(1,30,2))
students%>%slice(1:5)#print top 5 rows
head(students)

#random any 5 studnets
students%>%sample_n(5)
students%>%sample_frac(.2)#sample by 20% i.e 20% students on random basis
#using sample each time you get seperate data







