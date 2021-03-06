---
  title: "Decision trees - rpart"
author: "Nikhlesh Daga"
date: "2/21/2019"
output: html_document
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Decision trees

Decision trees are supervised leraning algorithms i.e. they have a response variable to train the model as compared to unsupervised learning techniques like kmeans clustering which do not have a response variable. They work on the concept of splitting data in order to define homogeneous groups of data and then define the class based on majority vote. 

### Advantages 

1. Easy to understand
2. Can handle both numeric and categorical variable.
2. Can be used to highlight relationship between two variables and quickly identify important variables.
3. Not influenced by outliers and missing values.
4. Non-parametric method or does not depend on the underlying distribution.

### Disadvantages 

1. Prone to overfitting.
2. Might lose information as it tries to bin numeric variables.

### Which variable to split on?

1. Gini index

- used by default in rpart and can be changed within the parms function.
- performs only binary split
- higher the gini value, higher the homogenity
- calculated as (p^2 + q^2) where p is the probability of scuccess and q is the probability of failure
- calculate gini for split using weighted Gini score for each node. If the Gini value after split for one variable is higher than the second variable, first variable would be chosen for split.

2. Chi square

- calculates statistical significance for split with different variables
- higher the value of chi-square, higher the statistical difference between the child and parent node
- generates trees which ar ecalled CHAID(Chi-square automatic interaction detector)

3. Entropy or information gain

- if we have a pure node, the entropy is zero while if we have a node with 50-50% distribution of two classes, the entropy is 1.
- lesser the entropy due to split from parent to child node, better is the split.
- 1 - entropy is defined as information gain



## Required libraries

```{r,warning=FALSE}
library(rpart)#for the cart
library(rpart.plot)#to create libraries from plot
library(caret)#machine learning excercise like finding missing values
library(randomForest)#next version of decision trees  
```

## Read in the data

Read in the data. The model needs to be trained on the training data and the results need to be checked on the test data. 

```{r}
path = 'https://raw.githubusercontent.com/nikhlesh17/Training/master/titanic.csv'
titanic <- read.csv(path)
str(titanic)
```

## Data subset and train-test split

```{r}
data = titanic[,c(2,3,5,6)]
table(data$survived)#looking for frequency of those whose survived- 0 or 1
# the response variable needs to be a categorical variable for classification
data$survived <- as.factor(data$survived)#converting numeric column to categorical column
data$pclass <- as.factor(data$pclass)
set.seed(123)
indx <- createDataPartition(y = data$survived,   #splitting data into data set into train and test
                            p = 0.8,
                            list = FALSE)
train <- data[ indx,]
test <- data[-indx,]
# Counts for suvived column
```




### Prepruning parameters

rpart.control(minsplit = 20, minbucket = round(minsplit/3), cp = 0.01, 
              maxcompete = 4, maxsurrogate = 5, usesurrogate = 2, xval = 10,
              surrogatestyle = 0, maxdepth = 30, ...)

**minsplit**	
  the minimum number of observations that must exist in a node in order for a split to be attempted.

**minbucket**	
  the minimum number of observations in any terminal <leaf> node. If only one of minbucket or minsplit is specified, the code either sets minsplit to minbucket*3 or minbucket to minsplit/3, as appropriate.

**cp**	
  complexity parameter. Any split that does not decrease the overall lack of fit by a factor of cp is not attempted. Essentially,the user informs the program that any split which does not improve the fit by cp will likely be pruned off by cross-validation, and that hence the program need not pursue it.

**maxcompete**	
  the number of competitor splits retained in the output. It is useful to know not just which split was chosen, but which variable came in second, third, etc.

**maxsurrogate**	
  the number of surrogate splits retained in the output. If this is set to zero the compute time will be reduced, since approximately half of the computational time (other than setup) is used in the search for surrogate splits.

**usesurrogate**	
  how to use surrogates in the splitting process. 0 means display only; an observation with a missing value for the primary split rule is not sent further down the tree. 1 means use surrogates, in order, to split subjects missing the primary variable; if all surrogates are missing the observation is not split. For value 2 ,if all surrogates are missing, then send the observation in the majority direction. A value of 0 corresponds to the action of tree, and 2 to the recommendations of Breiman et.al (1984).

**xval**	
  number of cross-validations.

**surrogatestyle**	
  controls the selection of a best surrogate. If set to 0 (default) the program uses the total number of correct classification for a potential surrogate variable, if set to 1 it uses the percent correct, calculated over the non-missing values of the surrogate. The first option more severely penalizes covariates with a large number of missing values.

**maxdepth**	
  Set the maximum depth of any node of the final tree, with the root node counted as depth 0. Values greater than 30 rpart will give nonsense results on 32-bit machines.

```{r}
set.seed(123)
fit <- rpart(survived ~ ., data = train, method = 'class',control = rpart.control(cp = .0001))  
fit # .  after ~ is to include all the variables which are independent
rpart.plot(fit,cex=.8,nn=T, extra=104)# fit is to avoid overfitting
printcp(fit)# cp to control #complexity parameter. Any split that does not decrease the overall lack of fit by a factor of cp is not attempted
test$pred <- predict(fit, test, type = "class")
table(test$pred,test$survived) 
accuracy1 <- mean(test$pred == test$survived)
plotcp(fit)
```


### Prune the tree

We initially grow the tree using a very low value of cp. The tree fully grows and then we prune it back to avoid overfitting. We use the lowest value of cp.      

```{r}
prunetree2 = prune(fit, cp=0.005)# cut the tree based on ideal cp value
printcp(prunetree2)
rpart.plot(prunetree2, cex=.8,nn=T, extra=104)#rpart.plot to plot decision tree (command) # to pruen tree.
test$pred <- predict(prunetree2, test, type = "class")#test is dataframe and we are making the new frame predict
accuracy1 <- mean(test$pred == test$survived)
table(test$pred,test$survived)#calculate the frequency #it gives the confusion matrix diagnol elements will give the correct answers rest are misfits.row is predict, column is actual
```

## CHAID #kind of decision tree used in marketing. 

Chi-square automatic interaction detector

Both are decision tree kind of algorithms but have a different way of deciding splits.

While CART can only handle binary response variable, CHAID can produce multiple branches of a single root/parent node. 
While CART(supervised learning) uses training data to train the model and then checks the accuracy on test data, CHAID(?unsupervised learning) runs on one dataset only. 
In CART, the entire tree is grown and then its pruned back to get the ideal tree while CHAID uses statistical significance(Chi square test of idependence) to decide where to stop.Using a pre-specified significance level, if the test shows that the splitted variable and the response are independent, the algorithm stops the tree growth.

```{r}
install.packages("CHAID", repos="http://R-Forge.R-project.org")
#you may need partykit from CRAN also
library(CHAID)  #library for performing CHAID decision tree
data(USvote)  #from lib CHAID
head(USvote)
str(USvote)
#Quick CHAID analysis
set.seed(101)
sample1 = USvote[sample(1:nrow(USvote), 1000),]
head(sample1)
str(sample1)
chaidModel <- chaid(vote3 ~ ., data = sample1, control=chaid_control(minbucket = 10, minsplit=20, minprob=0))
print(chaidModel)
plot(chaidModel)
```



## Random forest (next step for(collection) decision trees)(average of  all the decision trees. Same data is not used in all trees its random. so better as use multiple trees to give one solid answer)

Random forests are tree based algorithms and fall under the category called ensemble learning. They work on the concept of building lots of weak learners and then combining them to get the final output. They are based on bagging algorithm and uses a random set of rows and columns for each tree to avoid overfitting. The trees are allowed to grow deep and then the results from various trees are combined to give the final output.

```{r}
fit <- randomForest(survived ~ ., data = train,ntree=500,na.action = na.omit)#building randomforest model with all x variables,ntree is no of decision trees, na.action=na.omit na=missing value so if you find a missing value you ignore it.
predicted= predict(fit,test)
table(predicted,test$survived
varImpPlot(fit)#find in all machine learning algorithms.Its gives the dot chart of variable importance.
```


