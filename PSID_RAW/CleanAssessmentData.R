library(dplyr)
library(tidyr)

D <- readxl::read_excel("~/Dropbox/JPE_Child_Devp_2020/PSID/ChildAssessments.xlsx") %>% 
  mutate(KID = ER30001*1000 + ER30002)

# first we want to arrange the data nicely. We have the same scores for each year. They are:
col_names <- c("LW_std","LW_raw","PC_std","PC_raw","AP_std","AP_raw","DigSpan","BPE","BPN")

# 3 vectors with the corresponding variable names for each year
names97 <- c("Q3LW_SS","Q3LWRAW","Q3PC_SS","Q3PCRAW","Q3AP_SS","Q3APRAW","Q3DSTOT","BPI_E97","BPI_N97")

names02 <- c("Q24LWSS","Q24LWRAW","Q24PCSS","Q24PCRAW","Q24APSS","Q24APRAW","Q24DSTO","BPI_E02","BPI_N02")


names07 <- c("Q34LWSS","Q34LWRAW","Q34PCSS","Q34PCRAW","Q34APSS","Q34APRAW","Q34DSTO","BPI_E07","BPI_N07")

# separate and recombine files in a panel
D97 <- D[,c("KID",names97)]
names(D97)[2:10] <- col_names
D97$year <- 1997

D02 <- D[,c("KID",names02)]
names(D02)[2:10] <- col_names
D02$year <- 2002

D07 <- D[,c("KID",names07)]
names(D07)[2:10] <- col_names
D07$year <- 2007

D <- rbind(D97,D02,D07)

# Finally, replace missing values
missvals <- c(999,99,999,99,999,99,99,99,99)
for (i in 1:9) {
  D[,col_names[i]] <- na_if(D[,col_names[i]],missvals[i])
}

write.csv(D,"~/Dropbox/JPE_Child_Devp_2020/PSID/CleanData/AssessmentPanel.csv")

#library(ggplot2)
#library(reshape)
