# WM.data=read.csv(file.choose())
library(lme4)

root_dir = "/Users/dojoonyi/Dropbox/Manuscripts/KIM-SSE/SSE/SSE_Data_all/SSE_exp2/"
setwd(root_dir)
WM.data <- read.csv("lmeSSEv5_n64.csv")

WM.data$WMLOAD <- relevel(WM.data$WMLOAD, ref = "low")

## Below, Prof. Jeon.
WM.data$low=1
WM.data$high=1
WM.data$low[which(WM.data$WMLOAD=="high")] <-0 
WM.data$high[which(WM.data$WMLOAD=="low")] <-0 

head(WM.data)
tail(WM.data)
#str(WM.data)
#table(WM.data$WMLOAD)

############ ACCURACY ############
# Chainging optimizer: http://mindingthebrain.blogspot.com/2013/09/new-version-of-lme4.html
acc.m1 <- glmer(CORRECT ~ WMLOAD + (1|ID), data=WM.data, family=binomial, control=glmerControl(optimizer = "bobyqa"))
summary(acc.m1)

# m2 and m3 are testing components in m4, which was recommended by Prof. Jeon.
acc.m2 <- glmer(CORRECT ~ WMLOAD + (0+low|ID) +(0+high|ID), data=WM.data, family=binomial, control=glmerControl(optimizer = "bobyqa"))
summary(acc.m2)

anova(acc.m1, acc.m2)
# No sig different. I chose acc.m1 based on AIC & BIC.

acc.null <- glmer(CORRECT ~ (1|ID), data=WM.data, family=binomial, control=glmerControl(optimizer = "bobyqa"))
anova(acc.null, acc.m1)

# If leaning or some kind of trend is expected, we could consider including 'TRIAL' or 'as.factor(TRIAL)'
# If participants are expected to be worse in, say, 3rd trial, having 'as.factor(TRIAL)' would catch it.
# If participants are expected to be worse and worse, having 'TRIAL' would catch the trend.
# acc.m3 <- glmer(CORRECT ~ WMLOAD + as.factor(TRIAL) + (1|ID), data=WM.data, family=binomial, control=glmerControl(optimizer = "bobyqa"))
# summary(acc.m3)

# Two models below are the same, and also the same as acc.m1
#acc.m5 <- glmer(CORRECT ~ WMLOAD + (1|ID:WMLOAD), data=WM.data, family=binomial, control=glmerControl(optimizer = "bobyqa"))
#acc.m5 <- glmer(CORRECT ~ WMLOAD + (1|WMLOAD:ID), data=WM.data, family=binomial, control=glmerControl(optimizer = "bobyqa"))
#summary(acc.m5)
# Group created by interaction variable are sparce and noisy, so not recommended, See below link
# http://stats.stackexchange.com/questions/31569/questions-about-how-random-effects-are-specified-in-lmer


############ RT ############
rt.m1 <- lmer(RT ~ WMLOAD + (1|ID), data=WM.data, REML=F)
summary(rt.m1)

rt.m2 <- lmer(RT ~ WMLOAD + (0+low|ID) +(0+high|ID), data=WM.data, REML=F)
summary(rt.m2)

anova(rt.m1, rt.m2)

rt.null <- lmer(RT ~ (1|ID), data=WM.data, REML=F)
anova(rt.null, rt.m1)
