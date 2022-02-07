install.packages('ggplot2')
install.packages('dplyr')
install.packages('tidyverse')
install.packages('reshape2')
install.packages('ggbreak')
install.packages('fmsb')
install.packages('data.table')
install.packages("devtools")
install.packages("rmatio")

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
data = read.csv('meancdfc_yeo.csv')
# delete "Yeo1" = middle surface
###data = data[-c(1),]

## subset dataframes
cdplot <- data.frame(group=rep(c("ASD",
                                 "Control"
                                 ), 
                               each=7),
                    x=rep(c(data$X),
                          2),
                    y=c(data$CD_ASD, data$CD_TDC
                        ))

cdcplot <- data.frame(group=rep(c("ASD",
                                 "Control"
                                 ), 
                                each=7),
                      x=rep(c(data$X),
                            2),
                      y=c(data$CDcham_ASD, data$CDcham_TDC
                          ))


fcplot <- data.frame(group=rep(c("ASD",
                                 "Control"
                                 ), 
                               each=7),
                     x=rep(c(data$X),
                           2),
                     y=c(data$FC_ASD, data$FC_TDC
                         ))


# bar plot
cd <- ggplot(cdplot, aes(x=x, y=y, fill=group)) + 
  geom_bar(stat="identity", width=0.5,position=position_dodge()) +
  coord_cartesian(ylim=c(8,12)) + 
  theme_light() +
  xlab('Yeo Networks') + 
  ylab('Mean Connectivity Distance') +
  labs(title='Connectivity Distance') +
  scale_x_discrete(labels=c("Yeo1" = "DAN",
                            "Yeo2" = "FPN",
                            "Yeo3" = "DMN",
                            "Yeo4" = "Visual",
                            "Yeo5" = "Limbic",
                            "Yeo6" = "SMN",
                            "Yeo7" = "VAN"))

cdc <- ggplot(cdcplot, aes(x=x, y=y, fill=group)) + 
  geom_bar(stat="identity", width=0.5,position=position_dodge()) +
  #coord_cartesian(ylim=c(9,11.5)) + 
  theme_light() +
  xlab('Yeo Networks') + 
  ylab('Mean Connectivity Distance') +
  labs(title='Connectivity Distance - Chamfer Distance') +
  scale_x_discrete(labels=c("Yeo1" = "DAN",
                            "Yeo2" = "FPN",
                            "Yeo3" = "DMN",
                            "Yeo4" = "Visual",
                            "Yeo5" = "Limbic",
                            "Yeo6" = "SMN",
                            "Yeo7" = "VAN"))

fc <- ggplot(fcplot, aes(x=x, y=y, fill=group)) + 
  geom_bar(stat="identity", width=0.5,position=position_dodge()) +
  coord_cartesian(ylim=c(0.7,0.95)) + 
  theme_light() +
  xlab('Yeo Networks') + 
  ylab('Mean Functional Connectivity') +
  labs(title='Functional Connectivity') +
  scale_x_discrete(labels=c("Yeo1" = "DAN",
                            "Yeo2" = "FPN",
                            "Yeo3" = "DMN",
                            "Yeo4" = "Visual",
                            "Yeo5" = "Limbic",
                            "Yeo6" = "SMN",
                            "Yeo7" = "VAN"))
cd | cdc | fc

##### inter network barplots
cdplotinter <- data.frame(group=rep(c("ASD",
                                 "Control"), 
                               each=7),
                     x=rep(c(data$X),2),
                     y=c(data$CD_ASDinter, data$CD_TDCinter))

cdcplotinter <- data.frame(group=rep(c("ASD",
                                      "Control"), 
                                    each=7),
                          x=rep(c(data$X),2),
                          y=c(data$CDcham_ASDinter, data$CDcham_TDCinter))

fcplotinter <- data.frame(group=rep(c("ASD",
                                 "Control"), 
                                 each=7),
                          x=rep(c(data$X),2),
                          y=c(data$FC_ASDinter, data$FC_TDCinter))

cdplotinter <- ggplot(cdplotinter, aes(x=x, y=y, fill=group)) + 
  geom_bar(stat="identity", width=0.5,position=position_dodge()) +
  coord_cartesian(ylim=c(50,70)) + 
  theme_light() +
  xlab('Yeo Networks') + 
  ylab('Mean Connectivity Distance') +
  labs(title='Inter-Network Connectivity Distance') +
  scale_x_discrete(labels=c("Yeo1" = "DAN",
                            "Yeo2" = "FPN",
                            "Yeo3" = "DMN",
                            "Yeo4" = "Visual",
                            "Yeo5" = "Limbic",
                            "Yeo6" = "SMN",
                            "Yeo7" = "VAN"))

cdcplot_inter <- ggplot(cdcplotinter, aes(x=x, y=y, fill=group)) + 
  geom_bar(stat="identity", width=0.5,position=position_dodge()) +
  coord_cartesian(ylim=c(10,20)) + 
  theme_light() +
  xlab('Yeo Networks') + 
  ylab('Mean Connectivity Distance') +
  labs(title='Inter-Network Connectivity Distance - Chamfer Distance') +
  scale_x_discrete(labels=c("Yeo1" = "DAN",
                            "Yeo2" = "FPN",
                            "Yeo3" = "DMN",
                            "Yeo4" = "Visual",
                            "Yeo5" = "Limbic",
                            "Yeo6" = "SMN",
                            "Yeo7" = "VAN"))
cdplotinter
cdcplot_inter

fcplotinter <- ggplot(fcplotinter, aes(x=x, y=y, fill=group)) + 
  geom_bar(stat="identity", width=0.5,position=position_dodge()) +
  coord_cartesian(ylim=c(4.5,5)) + 
  theme_light() +
  xlab('Yeo Networks') + 
  ylab('Mean Functional Connectivity') +
  labs(title='Inter-Network Functional Connectivity') +
  scale_x_discrete(labels=c("Yeo1" = "DAN",
                            "Yeo2" = "FPN",
                            "Yeo3" = "DMN",
                            "Yeo4" = "Visual",
                            "Yeo5" = "Limbic",
                            "Yeo6" = "SMN",
                            "Yeo7" = "VAN"))
fcplotinter

#cdbreak <- cd +scale_y_cut(breaks=c(1), which=c(10,1), scales=c(1, 10), space=.5)+
#cdbreak <- cd + scale_y_break(c(1, 9),scale=10) + 
#  geom_bar(stat="identity", width=0.5,position=position_dodge())  + 
#  theme_minimal()
#cdbreak

##############################################
# spider plot
set.seed(1342)
cd_df <-rbind(data$CD_ASD, data$CD_TDC)
#cd_spidf <- as.data.frame(t(as.matrix(cd_df)))
colnames(cd_df) <- c("DAN", "FPN", "DMN", "Visual", "Limbic","SMN", "VAN")
rownames(cd_df) <- c('ASD', 'Control')
cd_df <- rbind(rep(9) , rep(12) , cd_df)
df <- as.data.frame(cd_df)

colors_border <-c(rgb(80/255,199/255,199/255), rgb(252/255, 119/255, 119/255))
radarchart(df, axistype=1 , 
           #pfcol=colors_in , 
           pcol=colors_border , plwd=3 , plty=1,
           cglcol="grey", cglty=1, axislabcol="white", , cglwd=1,
           vlcex=1 
)

cdc_df <-rbind(data$CDcham_ASD, data$CDcham_TDC)
#cd_spidf <- as.data.frame(t(as.matrix(cd_df)))
colnames(cdc_df) <- c("DAN", "FPN", "DMN", "Visual", "Limbic","SMN", "VAN")
rownames(cdc_df) <- c('ASD', 'Control')
cdc_df <- rbind(rep(0) , rep(8) , cdc_df)
df <- as.data.frame(cdc_df)

colors_border <-c(rgb(80/255,199/255,199/255), rgb(252/255, 119/255, 119/255))
radarchart(df, axistype=1 , 
           #pfcol=colors_in , 
           pcol=colors_border , plwd=3 , plty=1,
           cglcol="grey", cglty=1, axislabcol="white" , cglwd=1,
           vlcex=1 
)


# Add a legend
legend(x=1.5, y=1, legend = rownames(df[-c(1,2),]), bty = "n", pch=10 , col=colors_border , text.col = "grey", cex=1, pt.cex=3)


fc_df <-rbind(data$FC_ASD, data$FC_TDC)
#cd_spidf <- as.data.frame(t(as.matrix(cd_df)))
colnames(fc_df) <- c("DAN", "FPN", "DMN", "Visual", "Limbic","SMN", "VAN")
rownames(fc_df) <- c('ASD', 'Control')
fc_df <- rbind(rep(0.8) , rep(0.95) , fc_df)
df <- as.data.frame(fc_df)

colors_border <-c(rgb(80/255,199/255,199/255), rgb(252/255, 119/255, 119/255))
radarchart(df, axistype=1 , 
           #pfcol=colors_in , 
           pcol=colors_border , plwd=3 , plty=1,
           cglcol="grey", cglty=1, axislabcol="white", cglwd=1,
           vlcex=1 
)
###############################################################
######---- Density plot 
####---- Mean values

##---- Connectivity Distance
# read data - one column ASD/TDC, the other mean CD/FC for whole subject
df_all <- data.frame(Group =character(), Mean=double())
means_asd = read.csv('cd_means_asd.csv')
col_names = colnames(means_asd)
for(i in 5:ncol(means_asd)) {       # for-loop over columns
  subj_mean <- mean(means_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  df_all <- rbind(df_all, subj_df)
}
means_tdc = read.csv('cd_means_con.csv')
con_names = colnames(means_tdc)
for(i in 5:ncol(means_tdc)) {       # for-loop over columns
  subj_mean <- mean(means_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  df_all <- rbind(df_all, subj_df)
}

density <- ggplot(df_all, aes(x=Mean, color=Group)) + 
  geom_density() + 
  theme_light() + 
  xlim(0,20) +
  xlab('Connectivity Distance') + 
  ylab('Density') +
  labs(title='Connectivity Distance') 
density

###---- Connectivity Distance - Chamfer
dfc_all <- data.frame(Group =character(), Mean=double())
meansc_asd = read.csv('cdc_means_asd.csv')
col_names = colnames(meansc_asd)
for(i in 5:ncol(meansc_asd)) {       # for-loop over columns
  subj_mean <- mean(meansc_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfc_all <- rbind(dfc_all, subj_df)
}
meansc_tdc = read.csv('cdc_means_con.csv')
con_names = colnames(meansc_tdc)
for(i in 5:ncol(meansc_tdc)) {       # for-loop over columns
  subj_mean <- mean(meansc_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  dfc_all <- rbind(dfc_all, subj_df)
}

densityc <- ggplot(dfc_all, aes(x=Mean, color=Group)) + 
  geom_density() + 
  theme_light() + 
  xlim(0,10) +
  xlab('Connectivity Distance') + 
  ylab('Density') +
  labs(title='Connectivity Distance - Chamfer') 
density

##---- Functional Connectivity
# read data - one column ASD/TDC, the other mean CD/FC for whole subject
df_all_fc <- data.frame(Group =character(), Mean=double())

fcmeans_asd = read.csv('fc_means_asd.csv')
col_names = colnames(fcmeans_asd)
for(i in 5:ncol(fcmeans_asd)) {       # for-loop over columns
  subj_mean <- mean(fcmeans_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  df_all_fc <- rbind(df_all_fc, subj_df)
}

fcmeans_tdc = read.csv('fc_means_con.csv')
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

####---- z-scores
##---- Connectivity Distance
dfz_all <- data.frame(Group =character(), Mean=double())
zscores_asd = read.csv('cd_zscores_asd2control.csv')
col_names = colnames(zscores_asd)
for(i in 5:ncol(zscores_asd)) {       # for-loop over columns
  subj_mean <- mean(zscores_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfz_all <- rbind(dfz_all, subj_df)
}
zscores_tdc = read.csv('cd_zscores_con2control.csv')
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

##---- Connectivity Distance - Chamfer
dfc_all <- data.frame(Group =character(), Mean=double())
zscores_asd = read.csv('cdc_zscores_asd2control.csv')
col_names = colnames(zscores_asd)
for(i in 5:ncol(zscores_asd)) {       # for-loop over columns
  subj_mean <- mean(zscores_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfc_all <- rbind(dfc_all, subj_df)
}
zscores_tdc = read.csv('cdc_zscores_con2control.csv')
con_names = colnames(zscores_tdc)
for(i in 5:ncol(zscores_tdc)) {       # for-loop over columns
  subj_mean <- mean(zscores_tdc[, con_names[i]])
  subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
  dfc_all <- rbind(dfc_all, subj_df)
}
zdensity <- ggplot(dfc_all, aes(x=Mean, color=Group)) + 
  geom_density() + 
  theme_light() + 
  xlim(-1,1) +
  xlab('Connectivity Distance - z-scored, Chamfer') + 
  ylab('Density') +
  labs(title='Connectivity Distance') 
zdensity

##---- Functional Connectivity
dfz_all_fc <- data.frame(Group =character(), Mean=double()
fczscores_asd = read.csv('fc_zscores_asd2control.csv')
col_names = colnames(fczscores_asd)
for(i in 5:ncol(fczscores_asd)) {       # for-loop over columns
  subj_mean <- mean(fczscores_asd[, col_names[i]])
  subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
  dfz_all_fc <- rbind(dfz_all_fc, subj_df)
}
fczscores_tdc = read.csv('fc_zscores_con2control.csv')
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

###################################
####---- Density Plots for Yeo Regions

# subset dataframes to Yeo Regions
# Yeo Borders are:  [0, 1769, 3957, 6410, 10238, 12992, 14438, 18189, 20484]

singleyeo <- function(number, zscores_asd, zscores_tdc){
  asd <- zscores_asd[zscores_asd$yeo.yeo == number,]
  tdc <- zscores_tdc[zscores_tdc$yeo.yeo == number,]
  dfz_all_singlenetwork = data.frame(Group =character(), Mean=double())
  for(i in 5:ncol(asd)-1) { 
    subj_mean <- mean(asd[, col_names[i]])
    subj_df <- data.frame(Group = 'ASD', Mean = subj_mean)
    dfz_all_singlenetwork <- rbind(dfz_all_singlenetwork, subj_df)
  }
  for(i in 5:ncol(tdc)-1) {
    subj_mean <- mean(tdc[, con_names[i]])
    subj_df <- data.frame(Group = 'CON', Mean = subj_mean)
    dfz_all_singlenetwork <- rbind(dfz_all_singlenetwork, subj_df)
  }
  opth<- ggplot(dfz_all_singlenetwork, aes(x=Mean, fill=Group)) + 
    geom_density(alpha=0.4) + 
    theme_void() + 
    xlim(-3,3) 
  return(opth)
}

yeo_density_subplots <- function(name_of_modality){
  # name_of_modality either fc, cd or cdc (will call data sheet previously computed in python)
  pth_asd <- paste(name_of_modality, '_zscores_asd2control.csv', sep ='')
  pth_tdc <- paste(name_of_modality, '_zscores_con2control.csv', sep ='')
  zscores_asd <- read.csv(pth_asd)
  zscores_tdc <- read.csv(pth_tdc)
  yeo = read.mat('yeo_fsaverage5.mat')
  yeotable <- data.frame(yeo$yeo)
  zscores_asd <- cbind(yeotable, zscores_asd)
  zscores_tdc <- cbind(yeotable, zscores_tdc)
  col_names <- colnames(zscores_asd)
  con_names <- colnames(zscores_tdc)

  y1density <- singleyeo(1,zscores_asd,zscores_tdc)
  y2density <- singleyeo(2,zscores_asd,zscores_tdc)
  y3density <- singleyeo(3,zscores_asd,zscores_tdc)
  y4density <- singleyeo(4,zscores_asd,zscores_tdc)
  y5density <- singleyeo(5,zscores_asd,zscores_tdc)
  y6density <- singleyeo(6,zscores_asd,zscores_tdc)
  y7density <- singleyeo(7,zscores_asd,zscores_tdc)

  ### ggplot syntax for plotting several plots in one window
  y1density /
  y2density /
  y3density /
  y4density /
  y5density /
  y6density /
  y7density 
}

yeo_density_subplots('cd')
yeo_density_subplots('cdc')
yeo_density_subplots('fc')

