library(tidyverse)

raw_data <-read_csv(file="practice_assignment_1_data.csv")

str(raw_data)

#view data as a table
View(raw_data)

#change any 999s etc. to missing variables in R which is N/A
raw_data <- read_csv(file="rawData.csv" ,na=c("","NA","-999" ,"-888"))

categorical_variables <- select(raw_data, group, gender)
categorical_variables$group <- as.factor(categorical_variables$group)

#create new data set with single set of items (ex. scale for extroversion)
affective_commitment_items <- select (raw_data, AC1, AC2, AC3, AC4, AC5)
agreeableness_items <- select (raw_data, A1, A2, A3, A4, A5)
extroversion_items <- select (raw_data, E1, E2, E3, E4, E5)

#check for out of value ranges (any responses outside of what range should be)
psych::describe(extroversion_items)
psych::describe(agreeableness_items)
psych::describe(affective_commitment_items)

#make values outside of range into N/A
##check the range of the scale first!!
is_bad_value <- agreeableness_items<1 | agreeableness_items>5
is_bad_value <- affective_commitment_items<1 | affective_commitment_items>7

#to reverse key items
View(agreeableness_items)
agreeableness_items <- mutate(agreeableness_items,A5=6-A5)
##notice it's different depending on what point scale it is!!
affective_commitment_items <- mutate(affective_commitment_items,AC4=8-AC4)
affective_commitment_items <- mutate(affective_commitment_items,AC5=8-AC5)

#create a single score for each participant
agreeableness <- psych::alpha(as.data.frame(agreeableness_items) ,check.keys=FALSE)$scores
extroversion <- psych::alpha(as.data.frame(extroversion_items) ,check.keys=FALSE)$scores
affective_commitment_items <- psych::alpha(as.data.frame(affective_commitment_items) ,check.keys=FALSE)$scores

#combine all columns into new data frame called analytic_data
analytic_data <- cbind(categorical_variables,agreeableness,extroversion,affective_commitment_items)
## to view the data frame
analytic_data

#Saving the data
##.RData
save(analytic_data,file="study1_analytic_data.RData")
##.CSV
write_csv(analytic_data,path="study1_analytic_data.csv")
##.SAV
library(haven)
write_sav(analytic_data,path="study1_analytic_data.csv")