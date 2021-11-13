#Juuso Jalasto 13.11.2021
#Script for reading the first data

lrn14 = read.table("JYTOPKYS3-data.txt", as.is = TRUE, header = TRUE)
library(dplyr)

dim(lrn14) #displays the observation (183) and variable count (60)
str(lrn14) 
#displays internal structure of data with variable types and names
#59 integer variables with one character variable (gender)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

#new data frame from the 7 variables
learning2014 = select(lrn14, one_of(c("gender", "Age", "Attitude", "deep", "stra", "surf", "Points")))

# change the name of the second and third column
colnames(learning2014)[2] <- "age"
colnames(learning2014)[3] <- "attitude"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0)

#structure of the new data frame
str(learning2014)

#saving the new data
write.csv(learning2014, "learning2014.csv")

#testing the saved file
pr = read.csv("learning2014.csv", header = TRUE)
head(pr)
str(pr)

