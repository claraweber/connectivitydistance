# activate when needed - packages
#install.packages('ggplot2')
#install.packages('dplyr')
#install.packages('tidyverse')
#install.packages('reshape2')
#install.packages('ggbreak')
#install.packages('fmsb')
#install.packages('data.table')
#install.packages("devtools")
#install.packages("rmatio")


# environment
library(ggplot2)
library(rmatio)
library(dplyr)
library(tidyverse)
library(reshape2)
library(ggbreak)
library(fmsb)
library(data.table)
library(devtools)

wd = '/Users/claraweber/Desktop/mica_distfc'
setwd(wd)

# read data
data = read.csv('meancdfc_yeo.csv') # input here is csv file with mean values of functional connectivity and connectivity distance in each yeo network (see python function)

# density plot 
# mean values

# Connectivity Distance
# read data - one column ASD/TDC, the other mean CD/FC for whole subject
df_all <- data.frame(Group =character(), Mean=double())

means_asd = read.csv('means_asd2control.csv')
col_names = colnames(means_asd)
for(i in 5:ncol(means_asd)) {       # for-loop over columns
  subj_mean <- mean(means_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  df_all <- rbind(df_all, subj_df)
}

means_tdc = read.csv('means_tdc2control.csv')
con_names = colnames(means_tdc)
for(i in 5:ncol(means_tdc)) {       # for-loop over columns
  subj_mean <- mean(means_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  df_all <- rbind(df_all, subj_df)
}

density <- ggplot(df_all, aes(x=Mean, color=Group)) + 
  geom_density() + 
  theme_light() + 
  xlim(4,20) +
  xlab('Connectivity Distance') + 
  ylab('Density') +
  labs(title='Connectivity Distance') 
density

df_all <- data.frame(Group =character(), Mean=double())

means_asd = read.csv('means_asd2control.csv')
col_names = colnames(means_asd)
for(i in 5:ncol(means_asd)) {       # for-loop over columns
  subj_mean <- mean(means_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  df_all <- rbind(df_all, subj_df)
}

means_tdc = read.csv('means_tdc2control.csv')
con_names = colnames(means_tdc)
for(i in 5:ncol(means_tdc)) {       # for-loop over columns
  subj_mean <- mean(means_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  df_all <- rbind(df_all, subj_df)
}

density <- ggplot(df_all, aes(x=Mean, color=Group)) + 
  geom_density() + 
  theme_light() + 
  xlab('Connectivity Distance') + 
  ylab('Density') +
  labs(title='Connectivity Distance') 
density

# Functional Connectivity
# read data - one column ASD/TDC, the other mean CD/FC for whole subject
df_all_fc <- data.frame(Group =character(), Mean=double())

fcmeans_asd = read.csv('fcmeans_asd2control.csv')
col_names = colnames(fcmeans_asd)
for(i in 5:ncol(fcmeans_asd)) {       # for-loop over columns
  subj_mean <- mean(fcmeans_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  df_all_fc <- rbind(df_all_fc, subj_df)
}

fcmeans_tdc = read.csv('fcmeans_tdc2control.csv')
con_names = colnames(fcmeans_tdc)
for(i in 5:ncol(fcmeans_tdc)) {       # for-loop over columns
  subj_mean <- mean(fcmeans_tdc[, con_names[i]])
  print(subj_mean)
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  df_all_fc <- rbind(df_all_fc, subj_df)
}

fcdensity <- ggplot(df_all_fc, aes(x=Mean, color=Group)) + 
  geom_density() + 
  theme_light() + 
  xlab('Functional Connectivity') + 
  ylab('Density') +
  xlim(0,2) +
  labs(title='Functional Connectivity') 
fcdensity

# z-scores
dfz_all <- data.frame(Group =character(), Mean=double())

zscores_asd = read.csv('zscores_asd2control.csv')
col_names = colnames(zscores_asd)
for(i in 5:ncol(zscores_asd)) {       # for-loop over columns
  subj_mean <- mean(zscores_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfz_all <- rbind(dfz_all, subj_df)
}

zscores_tdc = read.csv('zscores_tdc2control.csv')
con_names = colnames(zscores_tdc)
for(i in 5:ncol(zscores_tdc)) {       # for-loop over columns
  subj_mean <- mean(zscores_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  dfz_all <- rbind(dfz_all, subj_df)
}

zdensity <- ggplot(dfz_all, aes(x=Mean, color=Group)) + 
  geom_density() + 
  theme_light() + 
  xlim(-1,1) +
  xlab('Connectivity Distance - z-scored') + 
  ylab('Density') +
  labs(title='Connectivity Distance') 
zdensity

# Functional Connectivity
dfz_all_fc <- data.frame(Group =character(), Mean=double())

fczscores_asd = read.csv('fczscores_asd2control.csv')
col_names = colnames(fczscores_asd)
for(i in 5:ncol(fczscores_asd)) {       # for-loop over columns
  subj_mean <- mean(fczscores_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfz_all_fc <- rbind(dfz_all_fc, subj_df)
}

fczscores_tdc = read.csv('fczscores_tdc2control.csv')
con_names = colnames(fczscores_tdc)
for(i in 5:ncol(fczscores_tdc)) {       # for-loop over columns
  subj_mean <- mean(fczscores_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  dfz_all_fc <- rbind(dfz_all_fc, subj_df)
}

fczdensity <- ggplot(dfz_all_fc, aes(x=Mean, color=Group)) + 
  geom_density() + 
  theme_light() + 
  xlab('Functional Connectivity - z-scored') + 
  ylab('Density') +
  xlim(-3, 4) +
  labs(title='Functional Connectivity') 
fczdensity

# Density Plots for Yeo Regions

# subset dataframes to Yeo Regions
# Yeo Borders are:  [0, 1769, 3957, 6410, 10238, 12992, 14438, 18189, 20484]
yeo = read.mat('yeo_fsaverage5.mat')
yeotable <- data.frame(yeo$yeo)
zscores_asd <- cbind(yeotable, fczscores_asd)
zscores_tdc <- cbind(yeotable, fczscores_tdc)
col_names = colnames(fczscores_asd)
con_names = colnames(fczscores_tdc)


yeo1_asd = zscores_asd[zscores_asd$yeo.yeo == 2,]
yeo1_tdc = zscores_tdc[zscores_tdc$yeo.yeo == 2,]
dfz_all_y1 = data.frame(Group =character(), Mean=double())
for(i in 5:ncol(yeo1_asd)-1) { 
  #print(col_names[i])# for-loop over columns
  subj_mean <- mean(yeo1_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfz_all_y1 <- rbind(dfz_all_y1, subj_df)
}
for(i in 5:ncol(yeo1_tdc)-1) {       # for-loop over columns
  subj_mean <- mean(yeo1_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  dfz_all_y1 <- rbind(dfz_all_y1, subj_df)
}

y1density <- ggplot(dfz_all_y1, aes(x=Mean, fill=Group)) + 
  geom_density(alpha=0.4) + 
  theme_void() + 
  xlim(-3,3) 

# yeo2
yeo2_asd = zscores_asd[zscores_asd$yeo.yeo == 3,]
yeo2_tdc = zscores_tdc[zscores_tdc$yeo.yeo == 3,]
dfz_all_y2 = data.frame(Group =character(), Mean=double())
for(i in 5:ncol(yeo2_asd)-1) {       # for-loop over columns
  subj_mean <- mean(yeo2_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfz_all_y2 <- rbind(dfz_all_y2, subj_df)
}
for(i in 5:ncol(yeo2_tdc)-1) {       # for-loop over columns
  subj_mean <- mean(yeo2_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  dfz_all_y2 <- rbind(dfz_all_y2, subj_df)
}

y2density <- ggplot(dfz_all_y2, aes(x=Mean, fill=Group)) + 
  geom_density(alpha=0.4) + 
  theme_void() + 
  xlim(-3,3) 

# yeo3 
yeo3_asd = zscores_asd[zscores_asd$yeo.yeo == 4,]
yeo3_tdc = zscores_tdc[zscores_tdc$yeo.yeo == 4,]
dfz_all_y3 = data.frame(Group =character(), Mean=double())
for(i in 5:ncol(yeo3_asd)-1) {       # for-loop over columns
  subj_mean <- mean(yeo3_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfz_all_y3 <- rbind(dfz_all_y3, subj_df)
}
for(i in 5:ncol(yeo3_tdc)-1) {       # for-loop over columns
  subj_mean <- mean(yeo3_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  dfz_all_y3 <- rbind(dfz_all_y3, subj_df)
}

y3density <- ggplot(dfz_all_y3, aes(x=Mean, fill=Group)) + 
  geom_density(alpha=0.4) + 
  theme_void() + 
  xlim(-3,3)

# yeo4
yeo4_asd = zscores_asd[zscores_asd$yeo.yeo == 5,]
yeo4_tdc = zscores_tdc[zscores_tdc$yeo.yeo == 5,]
dfz_all_y4 = data.frame(Group =character(), Mean=double())
for(i in 5:ncol(yeo4_asd)-1) {       # for-loop over columns
  subj_mean <- mean(yeo4_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfz_all_y4 <- rbind(dfz_all_y4, subj_df)
}
for(i in 5:ncol(yeo4_tdc)-1) {       # for-loop over columns
  subj_mean <- mean(yeo4_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  dfz_all_y4 <- rbind(dfz_all_y4, subj_df)
}

y4density <- ggplot(dfz_all_y4, aes(x=Mean, fill=Group)) + 
  geom_density(alpha=0.4) + 
  theme_void() + 
  xlim(-3,3)

# yeo 5
yeo5_asd = zscores_asd[zscores_asd$yeo.yeo == 6,]
yeo5_tdc = zscores_tdc[zscores_tdc$yeo.yeo == 6,]
dfz_all_y5 = data.frame(Group =character(), Mean=double())
for(i in 5:ncol(yeo5_asd)-1) {       # for-loop over columns
  subj_mean <- mean(yeo5_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfz_all_y5 <- rbind(dfz_all_y5, subj_df)
}
for(i in 5:ncol(yeo5_tdc)-1) {       # for-loop over columns
  subj_mean <- mean(yeo5_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  dfz_all_y5 <- rbind(dfz_all_y5, subj_df)
}

y5density <- ggplot(dfz_all_y5, aes(x=Mean, fill=Group)) + 
  geom_density(alpha=0.4) + 
  theme_void() + 
  xlim(-3,3)

# yeo 6
yeo6_asd = zscores_asd[zscores_asd$yeo.yeo == 7,]
yeo6_tdc = zscores_tdc[zscores_tdc$yeo.yeo == 7,]
dfz_all_y6 = data.frame(Group =character(), Mean=double())
for(i in 5:ncol(yeo6_asd)-1) {       # for-loop over columns
  subj_mean <- mean(yeo6_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfz_all_y6 <- rbind(dfz_all_y6, subj_df)
}
for(i in 5:ncol(yeo6_tdc)-1) {       # for-loop over columns
  subj_mean <- mean(yeo6_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  dfz_all_y6 <- rbind(dfz_all_y6, subj_df)
}

y6density <- ggplot(dfz_all_y6, aes(x=Mean, fill=Group)) + 
  geom_density(alpha=0.4) + 
  theme_void() + 
  xlim(-3,3)

# yeo 7
yeo7_asd = zscores_asd[zscores_asd$yeo.yeo == 8,]
yeo7_tdc = zscores_tdc[zscores_asd$yeo.yeo == 8,]
dfz_all_y7 = data.frame(Group =character(), Mean=double())
for(i in 5:ncol(yeo7_asd)-1) {       # for-loop over columns
  subj_mean <- mean(yeo7_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfz_all_y7 <- rbind(dfz_all_y7, subj_df)
}
for(i in 5:ncol(yeo7_tdc)-1) {       # for-loop over columns
  subj_mean <- mean(yeo7_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  dfz_all_y7 <- rbind(dfz_all_y7, subj_df)
}

y7density <- ggplot(dfz_all_y7, aes(x=Mean, fill=Group)) + 
  geom_density(alpha=0.4) + 
  theme_void() + 
  xlim(-3,3)

# ggplot plotting several plots in one window

y1density /
y2density /
y3density /
y4density /
y5density /
y6density /
y7density 

