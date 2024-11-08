library(tidyverse)
# this script loads the TAS data downloaded from the PSID website and has two parts:
# PART 1: arranges the basic variables into a short panel dataset
# PART 2: creates a summary level dataset for crime and a panel with earnings and cpi

###### PART 1: load and rename the data into a file called dat

# ---- create a file of cds kids with birth file info
# get birth years for all kids
ch = read.csv("data-main/childbirth/Childbirth.csv") %>% 
  mutate(X=NULL) %>% #<- childbirth info
  mutate(KID=CAH10*1000 + CAH11) %>%
  rename(ybirth = CAH15,sex = CAH12) %>%
  select(KID,ybirth,sex) %>%
  unique()


# # merge with index of cds kids
cds <- read.csv("data-cds/CDSIndex.csv") %>% 
  mutate(KID=ER30001*1000+ER30002) %>%
  merge(ch) %>%
  select(KID,ybirth,sex)

# --- Read in and clean TAS variables
dat <- read.csv("data-cds/adult-outcomes/J297358.csv")
vnames <- read.csv("data-cds/adult-outcomes/vnames.csv")

# systematically rename variables
for (i in 1:14) {
  for (r in 2:8) {
    vname = vnames[i,r]
    year = substring(names(vnames)[r],2)
    new_name = paste(vnames[i,1],"_",year,sep="")
    ind_change = which(names(dat)==vname)
    names(dat)[ind_change] = new_name
  }
}

# drop unneeded variables and create identifier
dat <- dat %>%
  mutate(KID = ER30001*1000+ER30002) %>%
  select(-starts_with(c("TA","ER"))) #<- drop unneeded variables

# now let's create an earnings variable from the ones we have
yrs = seq(2005,2017,2)
for (y in yrs) {
  vname = paste("earn_",y-2,sep="")
  v2 = paste("EarnYearBefore_",y,sep="")
  if (sum(names(dat)==v2)>0) {
    #print("test 1")
    dat[,vname] = dat[,v2]
  }
  vname = paste("earn_",y-1,sep="")
  v2 = paste("EarnLastYear_",y,sep="")
  if (sum(names(dat)==v2)>0) {
    #print("test 2")
    dat[,vname] = dat[,v2]
  }
}

# now reshape the data into a panel by year:
dat <- dat %>%
  select(-starts_with(c("EarnLast","EarnYear"))) %>% #<- we don't need these variables anymore
  pivot_longer(cols = -c("KID"),names_to = c(".value","YEAR"),names_sep = "_") %>%
  mutate(YEAR = as.integer(YEAR)) 

write.csv(dat,"data-cds/adult-outcomes/AdultOutcomes_panel.csv") #<- write this panel

###### PART 2: create crime and earnings data
## CRIME:
# summary variables for crime: ever arrested, ever arrested for a violent crime, ever arrested for a non-violent crime, and same for jail
# NOTE: this is observed behavior. There is a subset of individuals in here who simply do not report either way and we count that as non-recorded crime
# -- crime
crime <- dat %>%
  group_by(KID) %>%
  summarise(arrest = sum(ArrestedOnceMore==2 | ArrestedOnceMore==3,na.rm = TRUE)>0,arrest_violent = (sum(OffenseFirstOnlyArrest==1,na.rm = TRUE)+sum(OffenseLastArrest==1,na.rm = TRUE))>0,arrest_severe = (sum(OffenseFirstOnlyArrest==2,na.rm = TRUE)+sum(OffenseLastArrest==2,na.rm = TRUE))>0,jail = sum(JailOnceMore==2 | JailOnceMore==3,na.rm = TRUE)>0,jail_violent = (sum(OffenseFirstOnlyJail==1,na.rm = TRUE)+sum(OffenseLastJail==1,na.rm = TRUE))>0,jail_severe = (sum(OffenseFirstOnlyJail==2,na.rm = TRUE)+sum(OffenseLastJail==2,na.rm = TRUE))>0)

# create a crude summary for number of arrests
crime <- dat %>%
  filter(!is.na(ArrestedOnceMore),ArrestedOnceMore<8) %>%
  group_by(KID) %>%
  summarise(NumArrest = 1*(sum(ArrestedOnceMore>=2)>0)+sum(unique(AgeLastArrest)>0)) %>%
  merge(crime) 


write.csv(crime,"data-cds/adult-outcomes/crime_summary.csv")

# -- income
# - load cpi
cpi <- read.csv("CPI-U.csv") %>%
  mutate(CPIU = CPIU/CPIU[54]) #<- create a year 2000 base index


income <- dat %>%
  select(KID,YEAR,earn) %>%
  mutate(earn = na_if(na_if(earn,9999999),9999998)) %>%
  merge(cds) %>%
  merge(cpi) %>%
  mutate(earn = earn/CPIU,def_flag = "2000") %>%
  mutate(age = YEAR-ybirth) 

write.csv(income,"data-cds/adult-outcomes/income_panel.csv")

income %>%
  mutate(earn = earn/CPIU) %>%
  drop_na() %>%
  group_by(KID) %>%
  summarise(age = age[n()],earn = earn[n()]) %>%
  mutate(def_flag = "2000") %>%
  write.csv("data-cds/adult-outcomes/income_latest.csv")
