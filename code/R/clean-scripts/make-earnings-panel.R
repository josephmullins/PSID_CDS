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

G <- G %>% select(-contains("relnum")) #dropping the relnum columns

#*** Alternative lines of code for Maddi that I think will do the same thing **** #
G %>%
  pivot_longer(cols=everything(),names_to = c(".value","year"),names_sep = "_") %>%
  filter(!is.na(intnum))


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


# A line of code here for Maddi to show missing variable codes in each year
G %>%
  group_by(year) %>%
  summarize(h = max(earn_head,na.rm = TRUE),s=max(earn_spouse,na.rm = TRUE)) %>%
  print.AsIs()

G %>%
  group_by(year) %>%
  summarize(h = mean(earn_head,na.rm = TRUE),s=mean(earn_spouse,na.rm = TRUE)) %>%
  print.AsIs()
  ggplot(aes(x=as.integer(year),y=s)) + geom_line()



# A line of code here to show some differences with the old file for Maddi to look into:
D <- read.csv("../../../PSID_RAW/LaborFile.csv") %>%
  merge(G) %>%
  filter(earn_spouse!=w_earn)

unique(D$year) #<- specific to 1997 and 1999
D %>%
  select(intnum,year,h_earn,earn_head,w_earn,earn_spouse)# seem to be some big differences in earnings for 1997 and 1999

# TASK: look over the old data cleaning file to try and find discrepancies here


