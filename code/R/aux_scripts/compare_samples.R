# we're having trouble identifying the reasons for differences in sample selection. this script will hopefully figure out why.

# (1) replicate the numbers that Anastasiia reports in her email:

# New and missing IDs relative to the old file are also present  in the MotherPanelCDS (between 1985 and 2002:
#       733 ID/year pairs are in the old file but not in the new file
#     2,567 ID/year pairs are in the new file but not in the old file
#     32,191 ID/year pairs are matched

# new data:
M1 <- read.csv("~/Dropbox/PSID_CDS/PSID_CLEAN/MotherPanelCDS.csv") %>%
  mutate(X=NULL) %>%
  filter(year>=1985,year<=2002)

# old data:                                                                                  
M2 <- read.csv("~/Dropbox/JPE_Child_Devp_2020/PSID/CleanData/MotherPanelCDS.csv") %>%
  mutate(X=NULL) %>%
  filter(year>=1985,year<=2002)

# these three commands replicate Anastasiia's findings
M1 %>%
  select(MID,year) %>%
  merge(M2) %>% 
  nrow()

m1 <- M1 %>%
  select(MID,year) %>%
  anti_join(M2)

m2 <- M2 %>%
  select(MID,year) %>%
  anti_join(M1)

## NOW: let's see if we can find where things go missing. Both M1 and M2 are derived from a larger panel D that is consistent in both scripts.
# We first track the mapping from D to M1, and repeatedly check to see when members of M2 are removed from D.

# I have verified that the creation of the large panel for both groups is fine:

cds <- read.csv("~/Dropbox/PSID_CDS/PSID_RAW/MotherIndex.csv") %>% select(c("MID")) %>% unique() #<- this file contains all the women whose children end up in the CDS

C = read.csv("~/Dropbox/PSID_CDS/PSID_RAW/Childbirth.csv") %>% mutate(X = NULL) %>% #<- load childbirth file
  filter(CAH5==2)  %>% #keep only women
  filter(CAH10!=0) %>% # drop women who have no children according to this file
  filter(CAH7!=9998) %>% # drop women with missing birth year info
  mutate(MID = CAH3*1000 + CAH4, KID = CAH10*1000 + CAH11) %>% #<- create identifier for mother and child
  group_by(MID) %>%
  filter(!any(CAH10 == 9999)) %>% #<- drop women with unknown adoption or birth record
  inner_join(cds)

print("---- Make the panel with the number of dependent kids, age of youngest, etc -----")

MakePanel <- function(d) {
  year <- (d$CAH7[1]+18):2017
  Ny <- length(year)
  knum = d$CAH108[1]
  age_youngest <- integer(Ny) -1
  age_oldest <- integer(Ny) + Inf
  num_0_5 <- integer(Ny)
  num_6_12 <- integer(Ny)
  num_child <- integer(Ny)
  age_mother = year-d$CAH7[1]
  for (i in 1:length(year)) {
    ay = Inf
    ao = -1
    a5 = 0
    a6 = 0
    for (k in 1:nrow(d)) {
      agek = year[i]-d$CAH15[k]
      if (agek>=0 & agek<=18) {
        #print(agek)
        ay = min(ay,agek)
        ao = max(ao,agek)
        num_child[i]  = num_child[i] + 1
      }
      if (agek>=0 & agek<=5) {
        a5 = a5 + 1
      }
      if (agek>5 & agek<=12) {
        a6 = a6 + 1
      }
      
    }
    age_youngest[i] = ay
    age_oldest[i] = ao
    num_0_5[i] = a5
    num_6_12[i] = a6
  }
  data.frame(MID = d$MID[1], age_mother=age_mother, year = year, knum = knum, num_child=num_child,age_youngest=age_youngest,age_oldest=age_oldest, num_0_5 = num_0_5, num_6_12 = num_6_12, y_first = d$CAH15[1])
}


D <- C %>% group_by(MID) %>% do(MakePanel(.))

# verify here that both samples are still contained within this large panel:
print("The number of observations for each M1 and M2 are inside D")
nrow(M1) 
merge(D,M1) %>% nrow()
nrow(M2) 
merge(D,M2) %>% nrow()


D <- D %>%
  filter(year>=1985,year<=2002)

D_init <- D

Ind = read.csv("~/Dropbox/PSID_CDS/PSID_RAW/IndFileVertical.csv") %>% 
  mutate(X = NULL) %>% 
  mutate(MID = intnum68*1000 + pernum,mar_stat = mpair>0)
Ind <- Ind %>% filter(year>=1999) %>% 
  mutate(year = year - 1) %>%
  rbind(Ind)
# this will be useful throughout: create a dataframe that maps mothers to their interview number and sequence number
D_Ind <- D %>%
  inner_join(Ind)
# state codes measures residence for survey year
state_codes = read.csv("~/Dropbox/PSID_CDS/StateCodes.csv") %>% mutate(X=NULL,X.1 = NULL) %>% #<- this is a simple crosswalk of state codes
  select(-state) %>% 
  rename(state = PSID, StFIPS = fips) %>% #<- we rename some things in order to do the merge properly
  select(state,StFIPS,SOI)


# child care expenditures are for previous year, so we have to be careful how we do the merge!
# we merge by survey year then subtract one year to make the reference correct
# then we drop intnum, using only MID and year to link with the main file in the next step
ch_care <- read.csv("~/Dropbox/PSID_CDS/PSID_CLEAN/Main_childcare.csv") %>% 
  mutate(X=NULL) %>%
  inner_join(D_Ind) %>% #<- merge to mother's through the panel file
  mutate(year = year-1) %>% #<- convert survey year to lag year
  select(MID,year,childcare_exp)


D <- read.csv("~/Dropbox/PSID_CDS/PSID_RAW/StateVertical.csv") %>% #<- state of residence panel data
  mutate(X=NULL) %>%
  right_join(Ind) %>% #<- merge with Individual file
  right_join(D) %>% #<- merge with the panel we created (keeping all years)
  arrange(MID,year) %>%
  group_by(MID) %>%
  fill(state,.direction = "downup") %>% #<- fill in missing observations
  merge(state_codes) %>% #<- merge in the cross-walk with FIPS codes and SOI codes
  left_join(ch_care) #<= use only the main file to link

result <- M2 %>%
  select(MID,year) %>%
  anti_join(D) %>% #<- find members of M2 not in D
  #merge(m1) %>% #<- check which of these are those in the final M1 but not in M2
  nrow()

print(paste("Changes so far have accounted for ", result," of ",nrow(m2)," missing observations from M2"))

# LESSON: some ID-year observations get dropped because the state codes 0 and 99 do not get merged with the file state_codes. Not sure what happened in the old version of the file.

D <- D %>%
  select(MID,year,age_mother) %>%
  right_join(Ind) %>% #<- merge with individual file, keep all observations from Ind
  filter(is.na(age_mother)) %>% #<- identify spouses by missing info from the merge
  rename(FID=MID,snF=sn) %>% #<- rename variables for merge
  filter(mpair>0) %>% #<- only keep individuals who are not mothers but who are in a relationship in the same household
  select(FID,year,intnum,mpair,snF) %>%
  right_join(D) %>% #<- do the merge
  mutate(snF = replace_na(snF,-1)) #<- replace missing values.

# #  ---- load marriage info and create some summary variables
M <- read.csv("~/Dropbox/PSID_CDS/PSID_RAW/Marriage.csv") %>%
  mutate(X = NULL) %>%
  rename(MID = ID1) %>% #<- we rename to MID in preparation for a first merge with sample mothers
  rename(ybirth = MH6) %>%
  filter(ybirth<9998) %>% #<- drop individuals with missing birth info
  rename(ymar = MH11) %>%
  filter(ymar!=9998) %>% #<- remove individuals without marriage info
  mutate(record = ymar<9999) %>% #<- ymar==9999 indicates never married
  group_by(MID) %>%
  summarise(ever_married = sum(record)>0,ybirth = ybirth[1])

D = M %>% 
  inner_join(D)

result2 <- M2 %>%
  select(MID,year) %>%
  anti_join(D) %>% #<- find members of M2 not in D
  #merge(m1) %>% #<- check which of these are those in the final M1 but not in M2
  nrow()

print(paste("Differences in the Marriage File account for ", result2 - result," of ",nrow(m2) - result," remaining missing observations from M2"))


D <- D_Ind %>%
  select(MID,year,age_mother) %>%
  right_join(Ind) %>%
  filter(is.na(age_mother)) %>% #<- pick out individuals from the merge who were *not* matched
  rename(FID = MID,snF = sn) %>%
  select(c("FID","year","intnum","mpair","snF")) %>%
  filter(mpair>0) %>%
  right_join(D)

D <- M %>%
  rename(FID=MID,ybirthF = ybirth) %>%
  right_join(D) %>%
  mutate(f_age = year - ybirthF)

result3 <- M2 %>%
  select(MID,year) %>%
  anti_join(D) %>% #<- find members of M2 not in D
  #merge(m1) %>% #<- check which of these are those in the final M1 but not in M2
  nrow()

print(paste("Changes so far have accounted for ", result3 - result2," of ",nrow(m2) - result2," remaining missing observations from M2"))


R <- read.csv("~/Dropbox/PSID_CDS/PSID_RAW/RaceHorizontal.csv") %>% mutate(X = NULL) %>% 
  rename(MID = ID)

educ = read.csv("~/Dropbox/PSID_CDS/PSID_RAW/HGC.csv") %>% 
  mutate(X = NULL,ID = intnum68*1000 + pnum68) %>%
  mutate(ed=case_when(hgc>16 ~ 5,hgc == 16 ~ 4, hgc>=13 ~ 3, hgc>=12 ~ 2, hgc<12 ~ 1)) %>%
  select(ID,ed) %>%
  mutate(ed = factor(ed,levels = c(1,2,3,4,5),labels=c("<12","12","13-15","16",">16")))

cpi = read.csv("~/Dropbox/PSID_CDS/CPI-U.csv") %>% 
  rename(year = YEAR) %>%
  mutate(CPIU = CPIU/CPIU[53])

# this is the real code, but we break it apart to check:
# D <- D %>% #<- drop if mother has missing race or education info
#   inner_join(R) %>% 
#   inner_join(educ,by = c("MID" = "ID")) %>%
#   rename(m_ed = ed) %>%
#   left_join(educ,by = c("FID" = "ID")) %>%
#   rename(f_ed = ed) %>%
#   inner_join(R) %>%
#   inner_join(cpi)

D <- merge(D,R)

result3 <- M2 %>%
  select(MID,year) %>%
  anti_join(D) %>% #<- find members of M2 not in D
  nrow()
# We do an inner_join on Race and this results in some dropped observations (individuals who are missing race info)
print(paste("The merge on Race accounts for ", result3 - result2," of ",nrow(m2) - result2," remaining missing observations from M2"))


# ----------------- Step (2): replicate the creation of M2 and check when members of M1 are dropped:
D <- D_init

state <- read.csv("~/Dropbox/Research Projects/ChildDev_proj1/CleanData/demog_long.csv") %>%
  select(year,intnum,StFIPS)
Ind <- merge(Ind,state) 

# We impute household structure and state in missing years using the year after:
Ind <- Ind %>% filter(year==1999 | year==2001 | year==2003) %>% 
  mutate(year = year - 1) %>%
  rbind(Ind)


D <- merge(D,Ind) %>% mutate(mar_ind = mpair>0) #<- married or permanently cohabiting

result <- M1 %>%
  select(MID,year) %>%
  anti_join(D) %>% #<- find members of M2 not in D
  nrow()

# We do an inner_join on the Ind file and this results in some dropped observations when the individual does not show up in a year
print(paste("The strict merge on IndFile accounts for ", result," of ",nrow(m1)," missing observations from M1"))

Ind_F <- merge(D[,c("MID","year","age_mother")],Ind,all.y = TRUE) %>%
  filter(is.na(age_mother)) %>%
  rename(FID = MID,snF = sn) %>%
  select(c("FID","year","intnum","mpair","snF")) 


D <- merge(D,Ind_F[Ind_F$mpair>0,],all.x = TRUE) %>%
  mutate(snF = replace_na(snF,-1))

# here we see that there is one duplicate, from one year where the wife has two "husbands", which looks like a coding error. We'll drop this observation.
D %>% group_by(MID,year) %>% summarise(dup = n()) %>% group_by(dup) %>% tally() 
D <- D %>% group_by(MID,year) %>% filter(n()==1)

result2 <- M1 %>%
  select(MID,year) %>%
  anti_join(D) %>% #<- find members of M2 not in D
  nrow()

# We do an inner_join on the Ind file and this results in some dropped observations when the individual does not show up in a year
print(paste("Additional changes to here account for ", result2 -result," of ",nrow(m1) - result," remaining missing observations from M1"))



#  ---- load marriage info and create some marriage variables
M = read.csv("~/Dropbox/Data/PSID_MAIN/Marriage.csv") %>% 
  mutate(X = NULL) %>% 
  rename(MID = ID1) %>%
  rename(ybirth = MH5) %>%
  filter(ybirth<9998) %>%
  rename(ymar = MH10) %>%
  filter(ymar!=9998) %>% #<- remove individuals without marriage info
  mutate(record = ymar<9999)


# - Construct a variable if ever married, then merge back in with other data, keeping only the most recent entry, which takes a stand on particular inconsistencies in the year of birth variable
M <- M %>%
  group_by(MID) %>%
  summarise(ever_married = sum(record)>0) %>%
  merge(M[,c("MID","ybirth")]) %>%
  group_by(MID) %>%
  filter(row_number()==n()) #<- take most recent entry, since there will be duplicates

nrow(D)
D <- merge(D,M) #<-  some records lost here, if marriage info missing.
nrow(D)

result2 <- M1 %>%
  select(MID,year) %>%
  anti_join(D) %>% #<- find members of M2 not in D
  nrow()

# We do an inner_join on the Ind file and this results in some dropped observations when the individual does not show up in a year
print(paste("The merge with non-missing marriage data in the marriage file  accounts for ", result2 -result," of ",nrow(m1) - result," remaining missing observations from M1"))

