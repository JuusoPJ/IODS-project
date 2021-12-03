# Juuso Jalasto 1.12.2021
# data wrangling for week 5, continuing to work on the human development index data

# read the human.csv created in last weeks data wrangling
human = read.csv("human.csv", as.is = TRUE, head = TRUE)
summary(human)

# remove the first extra column x and check that the right column is removed and nothing else
human = human[c(2:20)]
summary(human)
head(human$GNI)

# transform the GNI variable to numeric. Problem with GNI is that it uses the american style of notation with a comma marking thousands
# We can use the gsub-function to remove the comma and then use as.numeric to transform it to numeric as the transform alone doesn't understand the comma marking as thousands

human$GNI = as.numeric(gsub(",", "", human$GNI))

# recheck everything worked out
summary(human)
head(human$GNI)

# next we remove unneeded columns and we start by creating a vector of the columns we want to keep (names used are the names picked in last wrangling session)
# the names were  "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"
# in this data these columns are "Country", "edu2F_edu2M", "labf_labm", "Edu_exp", "Life_exp", "GNI", "MAt_mortr", "Adol_birthr", "Femperc_in_parl"

keep_columns = c("Country", "edu2F_edu2M", "labf_labm", "Edu_exp", "Life_exp", "GNI", "MAt_mortr", "Adol_birthr", "Femperc_in_parl")
human2 = select(human, one_of(keep_columns))

# check that just the columns we want are there
summary(human2)

# remove empty rows with na.omit
human2 = na.omit(human2)
summary(human2)

# lets check for region names
human2$Country


# remove regions "Sub-Saharan Africa", "World", "East Asia and the Pacific", "Europe and Central Asia", "Latin America and the Caribbean", "Asia", "South Asia", "Arab States"

human2 = human2[!(human2$Country == "Sub-Saharan Africa"),]
human2 = human2[!(human2$Country == "World"),]
human2 = human2[!(human2$Country == "East Asia and the Pacific"),]
human2 = human2[!(human2$Country == "Europe and Central Asia"),]
human2 = human2[!(human2$Country == "Latin America and the Caribbean"),]
human2 = human2[!(human2$Country == "Asia"),]
human2 = human2[!(human2$Country == "South Asia"),]
human2 = human2[!(human2$Country == "Arab States"),]

# check countries again
human2$Country

# make countries into rownames and remove country column
rownames(human2) = human2$Country
human2 = human2[c(2:9)]

#summary of human 2 now
summary(human2)

#saving the data, by default write.csv saves the row names into the first column
write.csv(human2, "human2.csv")
