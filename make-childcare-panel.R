D <- readxl::read_excel("../../../data-main/expenditures/Main_childcare.xlsx")

index <- read.csv("../../../data-main/expenditures/childcare-labels.csv",header=FALSE)

names(index) <- c("variable","label","year")
index$label <- str_c(index$label,'_',index$year) 
index <- index[-3]

for (i in 1:length(D)){
  names(D)[i] = as.character(index[["label"]][i])
}

D <- D %>% select(-contains("relnum")) #dropping the relnum columns

D <- D %>%
  pivot_longer(cols=everything(),names_to = c(".value","year"),names_sep = "_") %>%
  filter(!is.na(intnum))

#these pieces of code should remove the DK and NA observations
D <- D[(D$carecost != 99999 & D$year < 1999) | (D$carecost < 999998 & D$year > 1997) , ] 
D <- D[!(D$year==1994 & D$carecost==99998),] 
D <- D[!(D$year==1995 & D$carecost==99998),]
D <- D[!(D$year==1996 & D$carecost==99998),]
D <- D[!(D$year==1997 & D$carecost==99998),]

write.csv(D,"../../../data-main/labor-market/childcare-panel.csv")








