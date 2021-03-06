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


# spider plot
set.seed(1342)
cd_df <-rbind(data$CD_ASD, data$CD_TDC)
#cd_spidf <- as.data.frame(t(as.matrix(cd_df)))
colnames(cd_df) <- c("DAN", "FPN", "DMN", "Visual", "Limbic","SMN", "VAN")
rownames(cd_df) <- c('ASD', 'Control')
cd_df <- rbind(rep(9) , rep(12) , cd_df)
df <- as.data.frame(cd_df)

colors_border <-c(rgb(80/255,199/255,199/255), rgb(252/255, 119/255, 119/255)) # colors similar to ggplot default colors used for ASD/Control in bar plots
radarchart(df, axistype=1 , 
           #pfcol=colors_in , 
           pcol=colors_border , plwd=3 , plty=1,
           cglcol="grey", cglty=1, axislabcol="white", , cglwd=1,
           vlcex=1 
)

# Add a legend
legend(x=1.5, y=1, legend = rownames(df[-c(1,2),]), bty = "n", pch=10 , col=colors_border , text.col = "grey", cex=1, pt.cex=3)
