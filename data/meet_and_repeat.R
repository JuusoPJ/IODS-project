# Juuso Jalasto 09.12.2021
# data wrangling for week 6

# libraries needed
library(dplyr)
library(tidyr)


# First we load up the datasets from the repository
BPRS = read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS = read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T, sep = '\t')

# check the data
str(BPRS)
str(RATS)

summary(BPRS)
summary(RATS)

#BPRS has 40 observations with two treatment categories followed up weekly for 8 weeks (8 variables after week 0)
#RATS has 16 observations with 3 groups followed every week for 64 days = 10 weeks (10 variables after WD1)

# both datasets have integer variables for treatment and group that need to be changed to factorial
BPRS$subject = as.factor(BPRS$subject)
BPRS$treatment = as.factor(BPRS$treatment)

RATS$ID = as.factor(RATS$ID)
RATS$Group = as.factor(RATS$Group)

# lets change the BPRS data to long data with a new variable called weeks
# this creates 360 new observations as in the longitudinal data each ID now has 9 observations (1st is week0) while the variable count goes down to 4 (id, treatment, weeks, bprs)
BPRSL =  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# add a new integer week variable to long data of BPRS
BPRSL =  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# next we change the RATS data to long form as well as add an time variable to the long dataset derived from the weekday variable
# this crates a 176 observation data where each id now has 11 observations with time variable starting from day 1 this time and ending in day 64
RATSL = RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD,3,4))) 

# lets look at the data again
str(BPRSL)
str(RATSL)

summary(BPRSL)
summary(RATSL)
# we no have a lot fewer variables because the measurement points are now instead new observations for the same id's
# within these data it also now gives us a time/week variable which corresponds to the measured observation of bprs or weight at that point
# this gives us a way to observe how the values change during time for different groups

# finally let's write the data into csv files
write.csv(BPRSL, "BPRSL.csv", row.names = FALSE)
write.csv(RATSL, "RATSL.csv", row.names = FALSE)

