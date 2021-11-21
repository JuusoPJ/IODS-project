# Juuso Jalasto, 19.11.2021, script file for data wrangling for week 3 logistic regression
# data used, downloaded from https://archive.ics.uci.edu/ml/datasets/Student+Performance

# reading the two data files
math = read.table("student-mat.csv", sep = ";", head = TRUE)
math_por = read.table("student-por.csv", sep = ";", head = TRUE)

# structures of the data files
str(math)
str(math_por)
# math has 395 observations and 33 variables while math-por has 649 observations and 33 variables

# Define own id for both datasets
library(dplyr)
por_id = math_por %>% mutate(id=1000+row_number()) 
math_id = math %>% mutate(id=2000+row_number())

# Which columns are NOT used for the joining
free_cols = c("id","failures","paid","absences","G1","G2","G3")
 
# columns that are common identifiers used for joining the datasets
join_cols = setdiff(colnames(por_id),free_cols)
pormath_free = por_id %>% bind_rows(math_id) %>% select(one_of(free_cols))

# combining data sets from Reijo Sund's code https://raw.githubusercontent.com/rsund/IODS-project/master/data/create_alc.R
pormath <- por_id %>% 
  bind_rows(math_id) %>%
  group_by(.dots=join_cols) %>%  
  summarise(                                                           
    n=n(),
    id.p=min(id),
    id.m=max(id),
    failures=round(mean(failures)),     
    paid=first(paid),                   
    absences=round(mean(absences)),
    G1=round(mean(G1)),
    G2=round(mean(G2)),
    G3=round(mean(G3))    
  ) %>%
  filter(n==2, id.m-id.p>650) %>% 
  
  inner_join(pormath_free,by=c("id.p"="id"),suffix=c("",".p")) %>%
  inner_join(pormath_free,by=c("id.m"="id"),suffix=c("",".m")) %>%  
  
  #alcohol use columns for high use
  ungroup %>% mutate(
    alc_use = (Dalc + Walc) / 2,
    high_use = alc_use > 2,
    cid=3000+row_number()
  )

str(pormath)
# combined data now has 370 observations and 51 variables
glimpse(pormath)

# saving the data to a new file for use in chapter 3 r markdown file
write.csv(pormath, "pormath.csv")

#testing save file

pormath.test = read.csv("pormath.csv", header = TRUE)
head(pormath.test)
str(pormath.test)
# writing seems to be correct with the extra x id column created