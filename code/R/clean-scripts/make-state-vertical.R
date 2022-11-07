
H <- read.csv("../../../data-main/state/State.csv")

index2 <- read.csv("../../../data-main/state/state-labels.csv",header=FALSE)
#index1 <- index1 %>%  filter(!row_number() %in% c(262,263,264,265)) ##removing empty rows at the end of the csv
names(index2) <- c("variable","label","year")
index2$label <- str_c(index2$label,'_',index2$year) 
index2 <- index2[-3]

for (i in 1:length(H)){
  names(H)[i] = as.character(index2[["label"]][i])
}

H <- H %>% select(-contains("relnum")) #dropping release num

H <- H %>%
  pivot_longer(cols=everything(),names_to = c(".value","year"),names_sep = "_") %>%
  filter(!is.na(intnum))

H <- H[,c(2,3,1)]

write.csv(H,"../../../data-main/state/state-vertical.csv")