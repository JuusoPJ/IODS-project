# Juuso Jalasto 26.11.2021
# script for reading the human data

# read two datasets
hd = read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii = read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# check human development data
str(hd)
summary(hd)

# check gender inequality data
str(gii)
summary(gii)

# renaming human development data
colnames(hd)
names(hd)[1] = "HDIRank"
names(hd)[3] = "HDIvalue"
names(hd)[4] = "Life_exp"
names(hd)[5] = "Edu_exp"
names(hd)[6] = "Eduyears_mean"
names(hd)[7] = "GNI"
names(hd)[8] = "GNI_per_cap"
colnames(hd)

# renaming gender inequality data
colnames(gii)
names(gii)[3] = "GIIvalue"
names(gii)[4] = "MAt_mortr"
names(gii)[5] = "Adol_birthr"
names(gii)[6] = "Femperc_in_parl"
names(gii)[7] = "Fem_secondedu"
names(gii)[8] = "Mal_secondedu"
names(gii)[9] = "Fem_Lab_partr"
names(gii)[10] = "Mal_lab_partr"
colnames(gii)

# create two new variables for gii
edu2peredu2m = (gii$Fem_secondedu/gii$Mal_secondedu)
labfperlabm = (gii$Fem_Lab_partr/gii$Mal_lab_partr)

# add the variables to gii and check the data
gii = mutate(gii, edu2F_edu2M = edu2peredu2m)
gii = mutate(gii, labf_labm = labfperlabm)
colnames(gii)
summary(gii)

# join the datasets with country as id using merge function and look through the summaries
gii_hd = merge(gii, hd, by = "Country")
summary(hd)
summary(gii)
summary(gii_hd)

# save the newly made data
write.csv(gii_hd, "human.csv")
