G <- readxl::read_excel("../../../data-main/labor-market/earnings-hours.xlsx")

index1 <- read.csv("../../../data-main/labor-market/earnings_labels_clean.csv",header=FALSE)
index1 <- index1 %>%  filter(!row_number() %in% c(262,263,264,265)) ##removing empty rows at the end of the csv
names(index1) <- c("variable","label","year")
index1$label <- str_c(index1$label,'_',index1$year) 
index1 <- index1[-3]

#everything should be renamed
for (i in 1:length(G)){
  names(G)[i] = as.character(index1[["label"]][i])
}

G <- G %>% select(-contains("relnum")) #dropping the relnum columns

G <- G %>% pivot_longer(
  cols=everything(),
  names_to = c("variable","year"),
  names_sep = "_",
  values_to="value")

G <- G %>% 
  group_by(variable) %>% 
  mutate(row=row_number()) %>% 
  pivot_wider(names_from=variable,values_from=value) %>% 
  select(-row)
#duplicate values caused some issues with pivoting back to wide
#to remedy this, I created unique row identifiers

G <- G[!with(G,is.na(intnum) & is.na(hourshead) & is.na(hoursspouse) & 
               is.na(earnhead) & is.na(earnspouse) &is.na(earnspousebusiness)),]
#the unique row identifiers/the code itself had a lot of entirely NA rows, with the exception of year variables
#this block removes empty observations

G[c("earnspousebusiness")][is.na(G[c("earnspousebusiness")])] <- 0
#replaces NA business earnings with 0

names(G) <- c("year","intnum","hours_head","hours_spouse",
              "earn_head","earn_spouse","earn_spouseBusiness")

G <- G[,c(2,1,5,6,3,4,7)]

write.csv(G,"../../../data-main/labor-market/earnings-panel.csv")


