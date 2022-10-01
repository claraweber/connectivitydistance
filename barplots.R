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

wd = '/'
setwd(wd)

# read data
data = read.csv('meancdfc_yeo.csv') 
# input here is csv file with mean values of functional connectivity and connectivity distance in each yeo network (see python function)

# subset dataframes
cdplot <- data.frame(group=rep(c("ASD",
                                 "Control" ), 
                               each=7),
                    x=rep(c(data$X),2),
                    y=c(data$CD_ASD, data$CD_TDC
                        #data$CD_mean
                        ))

# bar plot
cd <- ggplot(cdplot, aes(x=x, y=y, fill=group)) + 
  geom_bar(stat="identity", width=0.5,position=position_dodge()) +
  coord_cartesian(ylim=c(9,11.5)) + 
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

# inter network barplots
cdplotinter <- data.frame(group=rep(c("ASD",
                                 "Control"), each=7),
                     x=rep(c(data$X),2),
                     y=c(data$CD_ASDinter, data$CD_TDCinter))


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
