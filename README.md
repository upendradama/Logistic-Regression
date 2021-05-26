# Logistic-Regression


### Problem Statement 1:- 

I have a dataset containing family information of married couples, which have around 10 variables & 600+ observations. 
Independent variables are ~ gender, age, years married, children, religion etc.
I have one response variable which is number of extra marital affairs.
 Now, I want to know what all factor influence the chances of extra marital affair.
Since extra marital affair is a binary variable (either a person will have or not), 
so we can fit logistic regression model here to predict the probability of extra marital affair.

install.packages('AER')
data(Affairs,package="AER")

### Problem Statement 2:- 

Output variable -> y
y -> Whether the client has subscribed a term deposit or not 
Binomial ("yes" or "no")

### Problem Statement 3:-

Suppose we are interested in the factors that influence whether a political candidate wins an election. 
The outcome (response) variable is binary (0/1); win or lose. 
The predictor variables of interest are the amount of money spent on the campaign, 
the amount of time spent campaigning negatively and whether or not the candidate is an incumbent.
