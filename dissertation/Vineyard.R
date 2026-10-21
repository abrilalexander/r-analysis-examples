#SET WORKING DIRECTORY TO PROJECT FOLDER

#Loading required packages
library(lme4)
library(car)
library(DHARMa)
library(emmeans)
library(ggplot2)
library(ggpubr)
library(dunn.test)
library(Hmisc)
library(rstatix)

#Importing data
data <- read.table("Vineyard_Data.txt", header = TRUE)
head(data)

#Making categorical variables into factors
data$Plot_N <- as.factor(data$Plot_N)
data$Treatment <- as.factor(data$Treatment)
data$Depth <- as.factor(data$Depth)
str(data)

#Checking that my data is balanced
with(data,
     table(Treatment, Depth))

#-----------------------------------------------------------------------------

#pH LMM
pH_lmer <- lmer(pH ~ Treatment*Depth + (1 | Plot_N), data = data)
summary(pH_lmer)

#pH linear model (i.e., without random effects)
pH_lm <- lm(pH ~ Treatment*Depth, data = data)
summary(pH_lm)

#Likelihood Ratio Test
anova(pH_lmer, pH_lm)

#lm is better model (p>0.05)
#pH lm residuals
pH_res <- simulateResiduals(pH_lm)
plot(pH_res)

#emmeans anova
joint_tests(emmeans(pH_lm, ~ Treatment*Depth))

#pairwise tests
emmeans(pH_lm, pairwise ~ Treatment*Depth)

#Effect sizes of depth
data.emm <- emmeans(pH_lm, ~Depth)
data.emm
eff_size(data.emm, sigma = sigma(pH_lm), edf = df.residual(pH_lm))

#Effect sizes of interaction
data.emm <- emmeans(pH_lm, ~Treatment*Depth)
data.emm
eff_size(data.emm, sigma = sigma(pH_lm), edf = df.residual(pH_lm))

#-----------------------------------------------------------------------------------

#MC (Moisture Content) LMM
MC_lmer <- lmer(MC ~ Treatment*Depth + (1|Plot_N), data = data)
summary(MC_lmer)

#MC LM
MC_lm <- lm(MC ~ Treatment*Depth, data = data)
summary(MC_lm)

#Likelihood Ratio Test
anova(MC_lmer, MC_lm)

#Best model is the LMM (p-value < 0.05)
#MC lmer residuals
MC_res <- simulateResiduals(MC_lmer)
plot(MC_res)

#emmeans anova
joint_tests(emmeans(MC_lmer, ~ Treatment*Depth))

#pairwise tests
emmeans(MC_lmer, pairwise ~ Treatment*Depth)

#--------------------------------------------------------------------------------
  
#OM (Organic Matter) lmer
OM_lmer <- lmer(OM ~ Treatment*Depth + (1|Plot_N), data = data)
summary(OM_lmer)

#OM lm
OM_lm <- lm(OM ~ Treatment*Depth, data = data)
summary(OM_lm)

#Likelihood Ratio Test
anova(OM_lmer, OM_lm)

#Best model is the LMM (p-value < 0.05)
#OM lmer residuals
OM_res <- simulateResiduals(OM_lmer)
plot(OM_res)

#emmeans anova
joint_tests(emmeans(OM_lmer, ~ Treatment*Depth))

#pairwise tests
emmeans(OM_lmer, pairwise ~ Treatment*Depth)

#Effect sizes of depth
data.emm <- emmeans(OM_lmer, ~Depth)
data.emm
eff_size(data.emm, sigma = sigma(OM_lmer), edf = df.residual(OM_lmer))

#--------------------------------------------------------------------------------
  
#N (Nitrogen) LMM
N_lmer <- lmer(N ~ Treatment*Depth + (1|Plot_N), data = data)
summary(N_lmer)

#N lm
N_lm <- lm(N ~ Treatment*Depth, data = data)
summary (N_lm)

#Likelihood Ratio Test
anova(N_lmer, N_lm)

#Best model is the LM (p = 1)
#N lm residuals
N_res <- simulateResiduals(N_lm)
plot(N_res)

#emmeans anova
joint_tests(emmeans(N_lm, ~ Treatment*Depth))

#pairwise tests
emmeans(N_lm, pairwise ~ Treatment*Depth)

#Effect sizes of depth
data.emm <- emmeans(N_lm, ~Depth)
data.emm
eff_size(data.emm, sigma = sigma(N_lm), edf = df.residual(N_lm))

#Effect sizes of treatment
data.emm <- emmeans(N_lm, ~Treatment)
data.emm
eff_size(data.emm, sigma = sigma(N_lm), edf = df.residual(N_lm))

#-------------------------------------------------------------------------------
  
#C (Carbon) LMM
C_lmer <- lmer(C ~ Treatment*Depth + (1|Plot_N), data = data)
summary(C_lmer)

#C lm
C_lm <- lm(C ~ Treatment*Depth, data = data)
summary(C_lm)

#Likelihood Ratio Test
anova(C_lmer, C_lm)

#Best model is the LM (p = 1)
#C lm residuals
C_res <- simulateResiduals(C_lm)
plot(C_res)

#emmeans anova
joint_tests(emmeans(C_lm, ~ Treatment*Depth))

#pairwise tests
emmeans(C_lm, pairwise ~ Treatment*Depth)

#Effect sizes of depth
data.emm <- emmeans(C_lm, ~Depth)
data.emm
eff_size(data.emm, sigma = sigma(C_lm), edf = df.residual(C_lm))

#Effect sizes of treatment
data.emm <- emmeans(C_lm, ~Treatment)
data.emm
eff_size(data.emm, sigma = sigma(C_lm), edf = df.residual(C_lm))

#--------------------------------------------------------------------------------
  
#C.N (C:N ratio) LMM
C.N_lmer <- lmer(C.N ~ Treatment*Depth + (1|Plot_N), data = data)
summary(C.N_lmer)

#C.N lm
C.N_lm <- lm(C.N ~ Treatment*Depth, data = data)
summary(C.N_lm)

#Likelihood Ratio Test
anova(C.N_lmer, C.N_lm)

#Best model is the LM (p = 1)
#C.N lm residuals
C.N_res <- simulateResiduals(C.N_lm)
plot(C.N_res)

#emmeans anova
joint_tests(emmeans(C.N_lm, ~ Treatment*Depth))

#pairwise tests
emmeans(C.N_lm, pairwise ~ Treatment*Depth)

#--------------------------------------------------------------
  
#BasalResp LMM
BasalResp_lmer <- lmer(BasalResp ~ Treatment*Depth + (1|Plot_N), data = data)
summary(BasalResp_lmer)

#BasalResp LM
BasalResp_lm <- lm(BasalResp ~ Treatment*Depth, data = data)
summary(BasalResp_lm)

#Likelihood Ratio Test
anova(BasalResp_lmer, BasalResp_lm)

#Best model is the LM (p-value > 0.05)
#BasalResp lm residuals
BasalResp_res <- simulateResiduals(BasalResp_lm)
plot(BasalResp_res)

#emmeans anova
joint_tests(emmeans(BasalResp_lm, ~ Treatment*Depth))

#pairwise tests
emmeans(BasalResp_lm, pairwise ~ Treatment*Depth)

#Effect sizes of depth
data.emm <- emmeans(BasalResp_lm, ~Depth)
data.emm
eff_size(data.emm, sigma = sigma(BasalResp_lm), edf = df.residual(BasalResp_lm))

#Effect sizes of treatment
data.emm <- emmeans(BasalResp_lm, ~Treatment)
data.emm
eff_size(data.emm, sigma = sigma(BasalResp_lm), edf = df.residual(BasalResp_lm))

#--------------------------------------------------------------
#RootBiomass LMM
RootBiomass_lmer <- lmer(RootBiomass ~ Treatment*Depth + (1|Plot_N), data = data)
summary(RootBiomass_lmer)

#RootBiomass LM
RootBiomass_lm <- lm(RootBiomass ~ Treatment*Depth, data = data)
summary(RootBiomass_lm)

#Likelihood Ratio Test
anova(RootBiomass_lmer, RootBiomass_lm)

#Best model is the LM (p-value > 0.05)
#RootBiomass lm residuals
RootBiomass_res <- simulateResiduals(RootBiomass_lm)
plot(RootBiomass_res)
#Quantile deviation --> do non-parametric tests on raw data

#Kruskal-Wallis Test (non-parametric alternative to ANOVA)
kruskal.test(RootBiomass ~ Treatment, data = data)
kruskal.test(RootBiomass ~ Depth, data = data)

#pairwise tests
data$Treatment_Depth <- interaction(data$Treatment, data$Depth)
dunn.test(data$RootBiomass, data$Treatment_Depth, kw = TRUE, label = TRUE)

#Effect size 
effect_size <- kruskal_effsize(data = data, RootBiomass ~ Treatment)
print(effect_size)
effect_size <- kruskal_effsize(data = data, RootBiomass ~ Depth)
print(effect_size)

#--------------------------------------------------------------

#Creating the correlation matrix
numeric_data <- data[, sapply(data, is.numeric)] #Subsetting data into only numeric variables (not ID, Treatment, etc)
res <- cor(numeric_data)
res
res2 <- rcorr(as.matrix(numeric_data), type = c("pearson"))
res2

#Correlation Analysis between OM and pH (grouped by treatment)
ggscatter(data = data, x = "OM", y = "pH", add = "reg.line",
                      conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson", cor.coef.size = 8,
                      xlab = "Organic Matter Content (%)", ylab = "pH",
                      cor.coeff.args = list(color = "red", label.x = 8.0, label.y = 7.8),
          shape = "Treatment") +
      scale_shape_manual(values = c(0, 16, 8)) +
        theme(
              axis.title.x = element_text(size = 22), 
              axis.title.y = element_text(size = 22),
              axis.text = element_text(size = 18)
          )

#Correlation Analysis between OM and pH (grouped by depth)
ggscatter(data = data, x = "OM", y = "pH", add = "reg.line",
          conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson", cor.coef.size = 8,
          xlab = "Organic Matter Content (%)", ylab = "pH",
          cor.coeff.args = list(color = "red", label.x = 8.0, label.y = 7.8),
          shape = "Depth") +
  scale_shape_manual(values = c(0, 16, 8)) +
  theme(
    axis.title.x = element_text(size = 22), 
    axis.title.y = element_text(size = 22),
    axis.text = element_text(size = 18)
  )
        
#Correlation Analysis between BR and N
ggscatter(data = data, x = "N", y = "BasalResp", add = "reg.line",
          conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson", cor.coef.size = 8,
          xlab = "Nitrogen Content (%)", ylab = "Basal Respiration Rate (μl CO2 g-1 h-1)",
          cor.coeff.args = list(color = "red", label.x = 0.47, label.y = 0.98),
          shape = "Depth") +
  scale_shape_manual(values = c(0,16,8)) +
  xlim(0.35,0.5) +
  ylim(0.2,1.0) +
  theme(
    axis.title.x = element_text(size = 16), 
    axis.title.y = element_text(size = 16),
    axis.text = element_text(size = 12)
  )

#Correlation Analysis between pH and N
ggscatter(data = data, x = "pH", y = "N", add = "reg.line",
          conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson", cor.coef.size = 8,
          xlab = "pH", ylab = "Nitrogen Content (%)",
          cor.coeff.args = list(color = "red", label.x = 7.65, label.y = 0.49),
          shape = "Depth") +
  scale_shape_manual(values = c(0,16,8)) +
  xlim(7.30,7.80) +
  ylim(0.35, 0.50) +
  theme(
    axis.title.x = element_text(size = 16), 
    axis.title.y = element_text(size = 16),
    axis.text = element_text(size = 12)
  )

#-------------------------------------------------------------------------------

#Correlation Analysis between C and N
ggscatter(data = data, x = "C", y = "N", add = "reg.line",
          conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson", cor.coef.size = 8,
          size = 3,
          xlab = "Carbon Content (%)", ylab = "Nitrogen Content (%)",
          cor.coeff.args = list(color = "red", label.x = 3.3, label.y = 0.58),
          shape = "Depth") +
  scale_shape_manual(values = c(0,16,8)) +
  xlim(2.5,3.5) +
  ylim(0.3,0.6) +
  theme(
    axis.title.x = element_text(size = 20, vjust = -0.3), 
    axis.title.y = element_text(size = 20, vjust = 1.4),
    axis.text = element_text(size = 16),
    legend.title = element_text(size = 16),
    legend.text = element_text(size = 16)
  )

#Correlation between BR and RB
ggscatter(data = data, x = "RootBiomass", y = "BasalResp", add = "reg.line",
          conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson", cor.coef.size = 8,
          size = 3,
          xlab = "Dry Root Biomass (g)", ylab = "Basal Respiration Rate (μl CO2 g-1 h-1)",
          cor.coeff.args = list(color = "red", label.x = 0.6, label.y = 1),
          shape = "Depth") +
  scale_shape_manual(values = c(0,16,8)) +
  xlim(0, 0.8) +
  ylim(0.3,1.0) +
  theme(
    axis.title.x = element_text(size = 20, vjust = -0.3), 
    axis.title.y = element_text(size = 20, vjust = 1.4),
    axis.text = element_text(size = 16),
    legend.title = element_text(size = 16),
    legend.text = element_text(size = 16)
  )





