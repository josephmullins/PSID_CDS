library(dplyr)
library(tidyr)

D <- readxl::read_excel("../../../data-main/identifiers/CrossYearIndex.xlsx")
D <- D[-1]

index <- read.csv("../../../data-main/identifiers/CrossYearIndex_labels.csv")
names(index) <- c("variable","label","year")
index$label <- str_c(index$label,'_',index$year) 
index <- index[-3]

#everything should be renamed #<- names
for (i in 1:length(D)){
  names(D)[i] = as.character(index[["label"]][i])
}

D <- D %>% pivot_longer(
  cols=!c(in_1968,pn_1968),
  names_to = c("variable","year"),
  names_sep = "_",
  values_to="value")

D <- D %>%
  pivot_wider(names_from=variable,values_from=value) %>%
  mutate(year = as.integer(year))

names(D) <- c("intnum68","pernum","year","relhead",
               "mpair","intnum","sn")

D <- D[,c(1,2,3,6,7,4,5)] %>%
  filter(!is.na(intnum),intnum>0) #<- drop observations where an individual cannot be merged to an interview. We don't need those.

write.csv(D,"../../../data-main/identifiers/identifiers-panel.csv")



