library(tidyverse)

G <- readxl::read_excel("../../../data-main/labor-market/earnings-hours.xlsx")

index1 <- read.csv("../../../data-main/labor-market/earnings_labels_clean.csv",header=FALSE)
names(index1) <- c("variable","label","year")
index1$label <- str_c(index1$label,'_',index1$year) 
index1 <- index1[-3]

#everything should be renamed
for (i in 1:length(G)){
  names(G)[i] = as.character(index1[["label"]][i])
}

G <- G %>% select(-contains("relnum")) %>% #dropping the relnum columns
  pivot_longer(cols=everything(),names_to = c(".value","year"),names_sep = "_") %>%
  filter(!is.na(intnum))

G[c("earnspousebusiness")][is.na(G[c("earnspousebusiness")])] <- 0
#replaces NA business earnings with 0

names(G) <- c("year","intnum","hours_head","hours_spouse",
              "earn_head","earn_spouse","earn_spouseBusiness")

G <- G[,c(2,1,5,6,3,4,7)]

##crude way to remove the variables we don't want, I was checking sequentially
G <- G[!(G$year==1993 & G$hours_head==9999),] 
G <- G[!(G$year==1993 & G$hours_spouse==6730),]
G <- G[!(G$year==1993 & G$hours_spouse==9999),] 
G <- G[!(G$year==1993 & G$earn_head==99999999),] 
G <- G[!(G$year==1994 & G$hours_head==9999),]
G <- G[!(G$year==1994 & G$hours_spouse==9999),]
G <- G[!(G$year==1994 & G$earn_head==9999999),]
G <- G[!(G$year==1994 & G$earn_spouseBusiness==999999),]
G <- G[!(G$year==1994 & G$earn_spouse==9999999),]
G <- G[!(G$year==1995 & G$hours_head==7800),]
G <- G[!(G$year==1995 & G$earn_head==9999999),]
G <- G[!(G$year==1995 & G$earn_spouse==9999999),]
G <- G[!(G$year==1996 & G$hours_spouse==999999),]

write.csv(G,"../../../data-main/labor-market/earnings-panel.csv")



