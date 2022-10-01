ttest_1yeo <- function(number){
  zscores_asd <- read.csv('cd_zscores_asd2control.csv')
  zscores_tdc <- read.csv('cd_zscores_con2control.csv')
  yeo = read.mat('yeo_fsaverage5.mat')
  yeotable <- data.frame(yeo$yeo)
  zscores_asd <- cbind(yeotable, zscores_asd)
  zscores_tdc <- cbind(yeotable, zscores_tdc)
  data_asd <- zscores_asd[zscores_asd$yeo.yeo == number,]
  data_tdc <- zscores_tdc[zscores_tdc$yeo.yeo == number,]
  col_names <- colnames(data_asd)
  con_names <- colnames(data_tdc)
  df_singlenetwork = data.frame(Subj = character(), Group =factor(), Mean=double())
  for(i in 6:ncol(data_asd)) { 
    subj_mean <- mean(data_asd[, col_names[i]])
    subj_df <- data.frame(Subj = col_names[i], Group = 1, Mean = subj_mean)
    df_singlenetwork <- rbind(df_singlenetwork, subj_df)
  }
  for(i in 6:ncol(data_tdc)) {
    subj_mean <- mean(data_tdc[, con_names[i]])
    subj_df <- data.frame(Subj = con_names[i], Group = 0, Mean = subj_mean)
    df_singlenetwork <- rbind(df_singlenetwork, subj_df)
  }
  test <- t.test(Mean~Group, df_singlenetwork, alt="two.sided")
  df_test <- data.frame(number = number, t = test$statistic, p = test$p.value)
  return(df_test)
}


df_statistics = data.frame(number=factor(), t=double(), p=double())
for (network in 2:8){
  df_network <- ttest_1yeo(network)
  df_statistics <- rbind(df_statistics, df_network)
}


# correct pvalues using FDR
p_adj <- p.adjust(df_statistics$p, method = "fdr")
df_statistics$p_adj <- p_adj
