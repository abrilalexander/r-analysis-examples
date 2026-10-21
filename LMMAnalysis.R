#SET WORKING DIRECTORY TO PROJECT FOLDER

#Loading required packages
library(lme4)
library(car)
library(DHARMa)
library(emmeans)

#Importing data
data <- read.table("final_proc_data.txt", header = TRUE)
data

#Making categorical variables into factors
data$MATING_SYSTEM <- as.factor(data$MATING_SYSTEM)
data$POP_STRUCTURE <- as.factor(data$POP_STRUCTURE)
data$SEX <- as.factor(data$SEX)
data$LINE_ID <- as.factor(data$LINE_ID)

#Subsetting into male and female data
female_data <- subset(data, SEX=="F")
female_data
dim(female_data)
male_data <- subset(data, SEX=="M")
male_data
dim(male_data)

#Checking data types for each variable
str(data)
str(female_data)
str(male_data)

#Mean centering of covariable (wet weight)
female_data$CENT_WETWEIGHT <- female_data$WET_WEIGHT - mean(female_data$WET_WEIGHT, na.rm = T)
summary(female_data)
male_data$CENT_WETWEIGHT <- male_data$WET_WEIGHT - mean(male_data$WET_WEIGHT, na.rm = T)
summary(male_data)

#Excluding possible outlier from male data
dim(male_data)
male_data_exc <- subset(male_data, REP_WEIGHT < 0.6)
dim(male_data_exc)

# # # # # # # # # # 

#SSD Model
SSD_model <- lmer(WET_WEIGHT ~ SEX*MATING_SYSTEM + (1|LINE_ID), data = data)
summary(SSD_model)
Anova(SSD_model, type=2)

#Evolutionary Pressure Model
EP_model <- lmer(REP_WEIGHT/WET_WEIGHT ~ SEX*MATING_SYSTEM + (1|LINE_ID), data = data)
summary(EP_model)
Anova(EP_model, type=2)

# # # # # # # # # # 

#Female Model 1A FINAL
female_M1A <- lmer(REP_WEIGHT/WET_WEIGHT ~ MATING_SYSTEM*POP_STRUCTURE + (1 | LINE_ID), data = female_data)
summary(female_M1A)
Anova(female_M1A, type=2)

#Female Model 1A residuals
female_M1A_res <- simulateResiduals(female_M1A)
plot(female_M1A_res)

#Female Model 1B (with centered wet weight as a covariate)
female_M1B <- lmer(REP_WEIGHT ~ MATING_SYSTEM*POP_STRUCTURE + CENT_WETWEIGHT + (1 | LINE_ID), data = female_data)
summary(female_M1B)
Anova(female_M1B, type=2)

#Female Model 1B residuals
female_M1B_res <- simulateResiduals(female_M1B)
plot(female_M1B_res)

#Female Model 2 (no covariate, i.e., looking at absolute weights)
female_M2 <- lmer(REP_WEIGHT ~ MATING_SYSTEM*POP_STRUCTURE + (1 | LINE_ID), data = female_data)
summary(female_M2)
Anova(female_M2, type = 2)

#Female Model 2 residuals
female_M2_res <- simulateResiduals(female_M2)
plot(female_M2_res)

#Female Model 3
female_M3 <- lmer(WET_WEIGHT ~ MATING_SYSTEM*POP_STRUCTURE + (1 | LINE_ID), data = female_data)
summary(female_M3)
Anova(female_M3, type = 2)

#Female Model 3 residuals
female_M3_res <- simulateResiduals(female_M3)
plot(female_M3_res)

# # # # # # # # # #

#Male Model 1A FINAL
male_M1A <- lmer(REP_WEIGHT/WET_WEIGHT ~ MATING_SYSTEM*POP_STRUCTURE + (1 | LINE_ID), data = male_data)
summary(male_M1A)
Anova(male_M1A, type=2)

#Male Model 1A residuals
male_M1A_res <- simulateResiduals(male_M1A)
plot(male_M1A_res)

#Male Model 1B (with centered wet weight as a covariate)
male_M1B <- lmer(REP_WEIGHT ~ MATING_SYSTEM*POP_STRUCTURE + CENT_WETWEIGHT + (1 | LINE_ID), data = male_data)
summary(male_M1B)
Anova(male_M1B, type=2)

#Male Model 1B residuals
male_M1B_res <- simulateResiduals(male_M1B)
plot(male_M1B_res)

#Male Model 2 (no covariate, i.e., looking at absolute weights)
male_M2 <- lmer(REP_WEIGHT ~ MATING_SYSTEM*POP_STRUCTURE + (1 | LINE_ID), data = male_data)
summary(male_M2)
Anova(male_M2, type=2)

#Male Model 2 residuals
male_M2_res <- simulateResiduals(male_M2)
plot(male_M2_res)

#Male Model 3
male_M3 <- lmer(WET_WEIGHT ~ MATING_SYSTEM*POP_STRUCTURE + (1 | LINE_ID), data = male_data)
summary(male_M3)
Anova(male_M3, type=2)

#Male Model 3 residuals
male_M3_res <- simulateResiduals(male_M3)
plot(male_M3_res)

# # # # # # # #

#Marginal means for mating_system in female M1A FINAL
data.emm <- emmeans(female_M1A, ~ MATING_SYSTEM)
data.emm
#Effect sizes (using marginal means)
eff_size(data.emm, sigma = sigma(female_M1A), edf = df.residual(female_M1A))

#Marginal means for mating_system in male M1A FINAL
data.emm <- emmeans(male_M1A, ~ MATING_SYSTEM)
data.emm
#Effect sizes (using marginal means)
eff_size(data.emm, sigma = sigma(male_M1A), edf = df.residual(male_M1A))

# # # # # # # # #

#Subsetted Male Model 1
male_M1_exc <- lmer(REP_WEIGHT ~ MATING_SYSTEM*POP_STRUCTURE + CENT_WETWEIGHT + (1 | LINE_ID), data = male_data_exc)
summary(male_M1_exc)
Anova(male_M1_exc, type=2)

#Subsetted Male Model 1 residuals
male_M1_exc_res <- simulateResiduals(male_M1_exc)
plot(male_M1_exc_res)

#Subsetted Male Model 2
male_M2_exc <- lmer(REP_WEIGHT ~ MATING_SYSTEM*POP_STRUCTURE + (1 | LINE_ID), data = male_data_exc)
summary(male_M2_exc)
Anova(male_M2_exc, type=2)

#Subsetted Male Model 2 residuals
male_M2_exc_res <- simulateResiduals(male_M2_exc)
plot(male_M2_exc_res)

#Subsetted Male Model 3
male_M3_exc <- lmer(WET_WEIGHT ~ MATING_SYSTEM*POP_STRUCTURE + (1 | LINE_ID), data = male_data_exc)
summary(male_M3_exc)
Anova(male_M3_exc, type=2)

#Subsetted Male Model 3 residuals
male_M3_exc_res <- simulateResiduals(male_M3_exc)
plot(male_M3_exc_res)