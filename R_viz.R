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

