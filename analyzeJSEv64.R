# http://www.sthda.com/english/wiki/ggplot2-dot-plot-quick-start-guide-r-software-and-data-visualization
# http://lenkiefer.com/2017/08/03/joyswarm/
# http://emboj.embopress.org/content/early/2016/07/18/embj.201694659.figures-only#fig-data-supplementary-materials
# http://www.sthda.com/english/wiki/print.php?id=180

rm(list=ls())
pacman::p_load(tidyverse, afex, lme4, lmerTest, ggplot2, papaja, psych)

################################################
## 작업기억 과제 정확율
################################################

## 업로드 =====================================
WW = read.csv('~/Dropbox/data/JSE/JSE_exp2/logJSEn64_WMtask.csv', header = TRUE)
str(WW)
head(WW)
unique(WW$Correct)

# Group 요인을 Low -> High 순으로 정리
WW$Group = factor(WW$Group, levels=1:2, labels=c("Low","High"))
head(WW)
tail(WW)

## 요약 =====================================
wAcc1stLev <- WW %>% 
  group_by(Group, SID) %>% # 집단 > 개인 순서로 구분한 후,
  summarise(Accuracy = mean(Correct)) %>% # Correct의 평균을 Accuracy에 넣는다.
  ungroup()
wAcc1stLev

wAcc2ndLev <- wAcc1stLev %>% 
  group_by(Group) %>% 
  summarise(Acc = mean(Accuracy),
            CI = ci(Accuracy)) %>%
  ungroup()
colnames(wAcc2ndLev)[2] <- "Accuracy"
wAcc2ndLev

# 아래는 다른 방식. 그러나 위의 것보다 복잡하다.
# wAcc1stLev <- WW %>% 
#   group_by(Group, SID) %>% 
#   nest() %>% 
#   mutate(AccRate = map(data, ~mean(.$Correct))) %>% 
#   unnest(AccRate) %>% 
#   select(Group, SID, AccRate)

## Plot =====================================
ggplot(wAcc1stLev, aes(x=Group, y=Accuracy)) + 
  geom_violin(trim = TRUE) +
  geom_dotplot(binaxis='y', stackdir='center', dotsize=.7, color='#636363', fill='#636363') +
  geom_point(data = wAcc2ndLev, aes(y=Accuracy), color = "red", size=4) +
  geom_errorbar(data = wAcc2ndLev, aes(ymin=Accuracy-CI, ymax=Accuracy+CI), 
                color = "red", width=0.2) +
  labs(x="Group", y="WM Accuracy") +
  scale_x_discrete(labels=c("Low load", "High load")) +
  coord_cartesian(ylim=c(.5, 1)) +
  theme_bw(base_size = 14) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = .5))

# 연습 
# ggplot(PW, aes(x=Group, y=accWM)) + 
#   geom_violin(fill=NA) +
#   labs(y="Working Memory Accuracy") +
#   scale_x_discrete(limits = rev(levels(PW$Group)),
#                    labels=c("Low Load", "High Load")) +
#   coord_cartesian(ylim=c(0.5, 1)) +
#   geom_dotplot(binaxis='y', 
#                binwidth=1/100, 
#                stackdir='center', 
#                dotsize = 1,
#                aes(color="gray")) +
#   stat_summary(fun.data=mean_se,
#                geom="pointrange", color="red") +
#   scale_fill_discrete(guide=FALSE) +
#   theme_bw(base_size = 14) +
#   theme(panel.grid.major = element_blank(),
#         panel.grid.minor = element_blank(),
#         plot.title = element_text(hjust = .5))
# scale_colour_brewer() +
#   guides(fill = FALSE) +
# 
# irateplot(formula = accWM ~ Group,
#           data = PW,
#           theme = 1,
#           point.cex = 1.3,
#           jitter.val = .05,
#           sortx = "sequential",
#           ylab = "Working Memory Accuracy",
#           ylim = c(0.5, 1),
#           gl.col = gray(.7))

# papaja
apa_beeplot(data=wAcc1stLev, 
            id="SID", dv="Accuracy", factors="Group", 
            ylim = c(.5, 1),
            las=1)



## t-test =====================================

g1 <- wAcc1stLev %>% filter(Group=="Low") # low load 집단만 남김
g2 <- wAcc1stLev %>% filter(Group=="High") # high load 집단만 남김
t.test(g1$Accuracy, g2$Accuracy)

# 아래는 https://purrr.tidyverse.org를 참조했는데 작동 안 함.
# wAcc1stLev %>% 
#   split(.$Group) %>% 
#   map(~shapiro.test(.$Accuracy)) %>% 
#   map(print) %>% 
#   map_dbl(p.value)

shapiro.test(g1$Accuracy)
shapiro.test(g2$Accuracy)

## 비모수검증 =====================================
wilcox.test(Accuracy ~ Group, wAcc1stLev)
kruskal.test(Accuracy ~ Group, wAcc1stLev)  

## ANOVA =====================================
( w1 <- aov_4(Correct ~ Group + (1|SID), WW) )
( w1 <- aov_car(Correct ~ Group + Error(SID), WW) )

## GLMM =====================================
w2 <- glmer(Correct ~ Group + (1|SID), WW, family = binomial)
summary(w2)
# pacman::p_load(lmerTest)
# summary(w2)


################################################
## 작업기억 과제 반응시간
################################################

## 요약 =====================================
cWW <- WW %>% filter(Correct==1) # 정반응만 선별
# nrow(cWW)


aWW <- cWW %>% filter(RT > .15) # anticipatory response 제거
nrow(cWW) - nrow(aWW) # 제거된 반응 없었다.


tWW <- aWW %>% # trimmed RT
  group_by(Group, SID) %>% 
  nest() %>% 
  mutate(lbound = map(data, ~mean(.$RT)-3*sd(.$RT)), # lower/upper bound 계산
         ubound = map(data, ~mean(.$RT)+3*sd(.$RT))) %>% 
  unnest(lbound, ubound) %>% 
  unnest(data) %>% 
  mutate(Outlier = (RT < lbound)|(RT > ubound)) %>% 
  select(Group, SID, Trial, RT, Outlier)
sum(tWW$Outlier) # 3SD를 벗어난 반응도 없었다.


# 1st-level
wRT1stLev <- tWW %>% 
  filter(Outlier==FALSE) %>% 
  group_by(Group, SID) %>% # 집단 > 개인 순서로 구분한 후,
  summarise(RT = mean(RT)) %>% # RT 평균을 RT 넣는다.
  ungroup()
wRT1stLev

# 2nd-level
wRT2ndLev <- wRT1stLev %>% 
  group_by(Group) %>% 
  summarise(gRT = mean(RT),
            CI = ci(RT)) %>%
  ungroup()
colnames(wRT2ndLev)[2] <- "RT"
wRT2ndLev

## Plot =====================================
ggplot(wRT1stLev, aes(x=Group, y=RT)) + 
  geom_violin(trim = TRUE) +
  geom_dotplot(binaxis='y', stackdir='center', dotsize=.7, color='#636363', fill='#636363') +
  geom_point(data = wRT2ndLev, aes(y=RT), color = "red", size=4) +
  geom_errorbar(data = wRT2ndLev, aes(ymin=RT-CI, ymax=RT+CI), 
                color = "red", width=0.2) +
  labs(x="Group", y="WM RT") +
  scale_x_discrete(labels=c("Low load", "High load")) +
  coord_cartesian(ylim=c(.5, 2)) +
  theme_bw(base_size = 14) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = .5))

# papaja
apa_beeplot(data=wRT1stLev, 
            id="SID", dv="RT", factors="Group", 
            ylim = c(.5, 2),
            las=1)


## t-test =====================================

g1 <- wRT1stLev %>% filter(Group=="Low") # low load 집단만 남김
g2 <- wRT1stLev %>% filter(Group=="High") # high load 집단만 남김
t.test(g1$RT, g2$RT)

shapiro.test(g1$RT)
shapiro.test(g2$RT)


################################################
## Go/Nogo 과제 반응시간
################################################

## 업로드 =====================================
TT = read.csv('~/Dropbox/data/JSE/JSE_exp2/logJSEn64_GNGtask.csv', header = TRUE)
str(TT)

unique(TT$Load)
unique(TT$Congruent)
unique(TT$Correct)
unique(TT$Response)

TT$Group = factor(TT$Group, levels=1:2, labels=c("Low","High"))
TT$Load = factor(TT$Load, levels=1:2, labels=c("Absent","Present"))
TT$Congruent = factor(TT$Congruent, levels=0:2, labels=c("notme","congruent","incongruent"))
TT$Target = factor(TT$Target, levels=0:1, labels=c("not","target"))

headTail(TT) # psych 패키지


## 요약 =====================================
cTT <- TT %>% 
  filter(Congruent!="notme", Correct==1) %>% # 표적시행과 정반응만 선별
  droplevels %>% # "notme" level 제거
  mutate(RT = RT*1000) # ms 단위로 변환
unique(cTT$Congruent)


aTT <- cTT %>% filter(RT > 150) # anticipatory response 제거
nrow(cTT) - nrow(aTT) # 4 시행 제거됨
100*(nrow(cTT) - nrow(aTT))/nrow(aTT) # 0.03% 제거된 셈이다.


tTT <- aTT %>% # trimmed RT
  group_by(Group, Load, Congruent, SID) %>% 
  nest() %>% 
  mutate(lbound = map(data, ~mean(.$RT)-3*sd(.$RT)), # lower/upper bound 계산
         ubound = map(data, ~mean(.$RT)+3*sd(.$RT))) %>% 
  unnest(lbound, ubound) %>% 
  unnest(data) %>% 
  mutate(Outlier = (RT < lbound)|(RT > ubound)) %>% 
  select(Group, Load, Congruent, SID, Epoch, Trial, RT, Outlier)
sum(tTT$Outlier) # 3SD를 벗어난 반응도 없었다.
100*sum(tTT$Outlier)/nrow(aTT) # 1.13% 제거되었다.

sTT <- tTT %>% filter(!Outlier) # 가외치 제외한 최종 반응시간 자료

# 1st-level
gRT1stLev <- tTT %>% 
  filter(Outlier==FALSE) %>% 
  group_by(Group, Load, Congruent, SID) %>% # 집단 > 부하 > 일치 > 개인 순서로 구분,
  summarise(RT = mean(RT)) %>% 
  ungroup()
gRT1stLev

gRT1stLev2 <- gRT1stLev %>% # 일치효과 계산
  spread(Congruent, RT) %>% 
  mutate(Congruency = incongruent - congruent) %>% 
  select(Group, Load, SID, Congruency) 
gRT1stLev2

# 2nd-level
gRT2ndLev <- gRT1stLev %>% 
  group_by(Group, Load, Congruent) %>% 
  summarise(gRT = mean(RT),
            CI = ci(RT)) %>%
  ungroup()
colnames(gRT2ndLev)[4] <- "RT"
gRT2ndLev

## Plot =====================================
# papaja
apa_barplot(data=gRT1stLev, 
            id="SID", dv="RT", factors=c("Load","Congruent","Group"), 
            dispersion = wsci,
            ylim = c(300, 400),
            las=1)

# apa_beeplot(data=gRT1stLev, 
#             id="SID", dv="RT", factors=c("Load","Congruent","Group"), 
#             dispersion = wsci,
#             ylim = c(250, 550),
#             las=1)

apa_beeplot(data=gRT1stLev2, 
            id="SID", dv="Congruency", factors=c("Group","Load"), 
            dispersion = wsci,
            intercept = 0,
            # args_swarm = list(col="darkgray"),
            # args_points = list(col="red"),
            # args_error_bars = list(col="red"),
            args_legend = list(x="topright"),
            las=1)


## ANOVA =====================================
# https://cran.r-project.org/web/packages/afex/vignettes/afex_anova_example.html
# https://cran.r-project.org/web/packages/afex/vignettes/afex_mixed_example.html
# See also, http://www.sthda.com/english/wiki/two-way-anova-test-in-r
( m1 <- aov_4(RT ~ Load*Congruent*Group + (Load*Congruent|SID), sTT) )
( m1 <- aov_car(RT ~ Load*Congruent*Group + Error(SID/(Load*Congruent)), sTT) )

m1 <- aov_ez("SID", "RT", sTT, 
                between = "Group", 
                within = c("Load","Congruent"))
knitr::kable(nice(m1))
em_m1 <- emmeans(m1, ~Congruent:Load | Group) # Group을 기준으로 marginal mean 추정
pairs(em_m1) # 쌍별 비교

# 이제 대비를 내 맘대로 정해보자
em_m1 <- emmeans(m1, ~Congruent:Load:Group)
my.posthoc <- list(
  lo.abs  = c(-1, 1, 0, 0, 0, 0, 0, 0),
  lo.pre  = c(0, 0, -1, 1, 0, 0, 0, 0),
  hi.abs  = c(0, 0, 0, 0, -1, 1, 0, 0),
  hi.pre  = c(0, 0, 0, 0, 0, 0, -1, 1)
)
contrast(em_m1, my.posthoc, adjust = "mvt") # ?summary.emmGrid


mycontrast <- list(
  lo.2way = c(.5, -.5, -.5, .5, 0, 0, 0, 0),
  lo.cong  = c(-1, 1,-1, 1, 0, 0, 0, 0),
  lo.load  = c(-1,-1, 1, 1, 0, 0, 0, 0),
  hi.2way = c(0, 0, 0, 0, .5, -.5, -.5, .5),
  hi.cong  = c(0, 0, 0, 0,-1, 1,-1, 1),
  hi.load  = c(0, 0, 0, 0,-1,-1, 1, 1)
)

# contrast(em_m1, mycontrast, adjust = "none") 
# contrast(em_m1, mycontrast, adjust = "bonferroni") 
# contrast(em_m1, mycontrast, adjust = "tukey") # -> sidak으로 바뀜: 참가자내 -> 참가자간 변인 취급하는 듯
# https://stats.stackexchange.com/questions/165125/lsmeans-r-adjust-for-multiple-comparisons-with-interaction-terms
# https://cran.r-project.org/web/packages/emmeans/vignettes/interactions.html
# https://cran.r-project.org/web/packages/emmeans/vignettes/vignette-topics.html

emmip(m1, Congruent ~ Load|Group, CIs = TRUE) +
  ggplot2::theme_light()

emmip(m1, Congruent ~ Load|Group, CIs = FALSE) +
  ggplot2::theme_light()



# https://cran.r-project.org/web/packages/emmeans/vignettes/interactions.html 어렵지만 중요!
# https://cran.r-project.org/web/packages/emmeans/vignettes/comparisons.html
# https://stackoverflow.com/questions/50009112/custom-function-to-compute-contrasts-in-emmeans 내맘대로 대비
emm_m1 <- emmeans(g1, pairwise ~ Congruent*Load | Group)
emm_g1
coef(emm_g1)

emm_g2 <- emmeans(g1, poly ~ Congruent*Load | Group) # ?consec.emmc
coef(emm_g2)

mycont <- data.frame(c1=c(1,-1,1,-1,0,0,0,0), c2=c(0,0,0,0,1,-1,1,-1))
emm_g3 <- emmeans(g1, ~ Congruent*Load | Group, mycont) # not working


# Post-hoc
# http://www.sthda.com/english/wiki/two-way-anova-test-in-r

# http://rcompanion.org/handbook/G_09.html
# https://gribblelab.wordpress.com/2009/03/09/repeated-measures-anova-using-r/
# https://m-clark.github.io/docs/mixedModels/anovamixed.html

# Type I/II/III ANOVA
# https://mcfromnz.wordpress.com/2011/03/02/anova-type-iiiiii-ss-explained/


################################################
## Go/Nogo 과제 정확율
################################################

## 가. 요약: Not me 제외 =====================================

mTT <- TT %>% 
  filter(Congruent!="notme") %>% # 표적시행만 선별
  droplevels %>%  # "notme" level 제거
  select(Group, Load, Congruent, SID, Epoch, Trial, Correct)
headTail(mTT)
unique(mTT$Congruent)

gAcc1stLev <- TT %>% 
  filter(Congruent!="notme") %>% 
  droplevels %>% # "notme" level 제거
  group_by(Group, Load, Congruent, SID) %>% # 집단 > 부하 > 일치 > 개인 순서로 구분,
  summarise(Accuracy = mean(Correct)) %>% # Correct의 평균을 Accuracy에 넣는다.
  ungroup()
gAcc1stLev
unique(gAcc1stLev$Congruent)

gAcc2ndLev <- gAcc1stLev %>% 
  group_by(Group, Load, Congruent) %>% 
  summarise(Acc = mean(Accuracy),
            CI = ci(Accuracy)) %>%
  ungroup()
colnames(gAcc2ndLev)[4] <- "Accuracy"
gAcc2ndLev


## 나. Plotting =====================================
apa_barplot(data=gAcc1stLev, 
            id="SID", dv="Accuracy", factors=c("Load","Congruent","Group"), 
            dispersion = wsci,
            ylim = c(0.9, 1),
            args_legend = list(x="bottomright"),
            las=1)

## 다. ANOVA & Post-hoc =====================================
m2 <- aov_ez("SID", "Correct", mTT, 
             between = "Group", 
             within = c("Load","Congruent"))
knitr::kable(nice(m2))
em_m2 <- emmeans(m2, ~Congruent:Load | Group) # Group을 기준으로 marginal mean 추정
pairs(em_m2) # 쌍별 비교

# 이제 대비를 내 맘대로 정해보자
em_m2 <- emmeans(m2, ~Congruent:Load:Group)
my.posthoc <- list(
  lo.abs  = c(-1, 1, 0, 0, 0, 0, 0, 0),
  lo.pre  = c(0, 0, -1, 1, 0, 0, 0, 0),
  hi.abs  = c(0, 0, 0, 0, -1, 1, 0, 0),
  hi.pre  = c(0, 0, 0, 0, 0, 0, -1, 1)
)
contrast(em_m2, my.posthoc, adjust = "none") # ?summary.emmGrid


## 라. "not me" =====================================

gAcc1stLev2 <- TT %>% 
  filter(Congruent=="notme") %>% 
  droplevels %>% 
  group_by(Group, Load, SID) %>%
  summarise(Accuracy = mean(Correct)) %>%
  select(Group, Load, SID, Accuracy)
gAcc1stLev2

gAcc2ndLev2 <- gAcc1stLev2 %>% 
  group_by(Group, Load) %>% 
  summarise(Acc = mean(Accuracy),
            CI = ci(Accuracy)) %>%
  ungroup()
colnames(gAcc2ndLev2)[2] <- "Accuracy"
gAcc2ndLev2


apa_barplot(data=gAcc1stLev2, 
            id="SID", dv="Accuracy", factors=c("Group","Load"), 
            dispersion = wsci,
            ylim = c(0.9, 1),
            args_legend = list(x="topright"),
            las=1)

apa_beeplot(data=gAcc1stLev2, 
            id="SID", dv="Accuracy", factors=c("Group","Load"), 
            dispersion = wsci,
            intercept = 0,
            ylim = c(0.95, 1),
            args_legend = list(x="topright"),
            las=1)


m3 <- aov_ez("SID", "Accuracy", gAcc1stLev2, 
             between = "Group", 
             within = "Load")
knitr::kable(nice(m3))


###############################################
## Go/Nogo 과제 반응시간 x Epoch
################################################

## 요약 =====================================
eTT <- aTT %>% # trimmed RT
  filter(Block1==1) %>% # 작업기억 없는 epoch 먼저 한 참가자
  group_by(Group, Load, Congruent, Epoch, SID) %>% 
  nest() %>% 
  mutate(lbound = map(data, ~mean(.$RT)-3*sd(.$RT)), # lower/upper bound 계산
         ubound = map(data, ~mean(.$RT)+3*sd(.$RT))) %>% 
  unnest(lbound, ubound) %>% 
  unnest(data) %>% 
  mutate(Outlier = (RT < lbound)|(RT > ubound)) %>% 
  select(Group, Load, Congruent, SID, Epoch, Trial, RT, Outlier)
sum(eTT$Outlier)
100*sum(eTT$Outlier)/nrow(aTT) # 0.25% 제거되었다.

pTT <- eTT %>% filter(!Outlier) # 가외치 제외한 최종 반응시간 자료

# 1st-level
gRT1stLev3 <- pTT %>% 
  group_by(Group, Load, Congruent, Epoch, SID) %>%
  summarise(RT = mean(RT)) %>% 
  ungroup()
gRT1stLev3

gRT1stLev4 <- gRT1stLev3 %>% # 일치효과 계산
  spread(Congruent, RT) %>% 
  mutate(Congruency = incongruent - congruent) %>% 
  select(Group, Load, Epoch, SID, Congruency) 
gRT1stLev4

apa_lineplot(data=gRT1stLev4, 
            id="SID", dv="Congruency", factors=c("Epoch","Load","Group"), 
            intercept = 0,
            dispersion = wsci,
            ylim = c(-20, 50),
            args_legend = list(x="topright"),
            las=1)

# 2nd-level
gRT2ndLev2 <- gRT1stLev4 %>% 
  group_by(Group, Load, Epoch) %>% 
  summarise(gCong = mean(Congruency),
            CI = ci(Congruency)) %>%
  ungroup()
colnames(gRT2ndLev2)[4] <- "Congruency"
gRT2ndLev2

