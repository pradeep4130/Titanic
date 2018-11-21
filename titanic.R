library(gdata)
library(dplyr)
library(tidyr)
library(ggplot2)


# 0: Load the data in RStudio

titanic_o <- read.csv("D:/R/Capstone/Titanic/titanic_original.csv", header = TRUE)

data.frame(titanic_o)
View(titanic_o)

# 1: Port of embarkation

#length(titanic_o$embarked)
#titanic_o$embarked[1]
#titanic_o$embarked[1310]

for (x in 1:length(titanic_o$embarked)) {
  if (titanic_o$embarked[x] == "") { titanic_o$embarked[x] <- "S"}
}

View(titanic_o)

# 2: Age

age_mean <- mean(titanic_o$age, na.rm = TRUE)
age_mean

#is.na(titanic_o$age)

for (x in 1:length(titanic_o$age)) {
      if (is.na(titanic_o$age[x])) 
          {titanic_o$age[x] <- age_mean}
}

View(titanic_o)

# 3: Lifeboat

#titanic_o$boat <- replace(titanic_o$boat, which(is.na(titanic_o$boa)), 'NA')
#titanic_o %>% filter(titanic_o,is.na(titanic_o$boat))
#titanic_o$boat[is.na(titanic_o$boat)] <- "NONE"
for (x in 1:length(titanic_o$boat)) {
  if(titanic_o$boat[x] == "") {titanic_o$boat[x] <- "NA"}
}

View(titanic_o)

# Column is filled with NA

# 4: Cabin

colnames(titanic_o)
titanic_o <- titanic_o %>% mutate('has_cabin_number' = ifelse(titanic_o$cabin == "",0,1))

View(titanic_o)

# 5: Submit the project on Github

write.csv(titanic_o, file = 'titanic_clean.csv')
titanic_c <- read.csv(file = 'titanic_clean.csv', header = TRUE)
View(titanic_c)


# 6: ggplot2 tutorial--Copy and paste the R code from the Titanic exercise in the ggplot2 tutorial into a file Titanic.R

# titanic is avaliable in your workspace
# 1 - Check the structure of titanic
str(titanic_c)

# 2 - Use ggplot() for the first instruction
ggplot(titanic_c, aes(x = pclass, fill = sex)) +
  geom_bar(position = "dodge")

# 3 - Plot 2, add facet_grid() layer
ggplot(titanic_c, aes(x = pclass, fill = sex)) +
  geom_bar(position = "dodge") +
  facet_grid(.~survived)

# 4 - Define an object for position jitterdodge, to use below
posn.jd <- position_jitterdodge(0.5, 0, 0.6)

# 5 - Plot 3, but use the position object from instruction 4
ggplot(titanic_c, aes(x = pclass,y=age, color = sex)) +
  geom_point(size= 3,alpha= 0.5,position = posn.jd) +
  facet_grid(.~survived)



