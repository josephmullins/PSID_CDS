# NOTE: CreateEducationVariable.py in Dropbox/PSID_MAIN shows how the file HGC is created

library(tidyverse)


educ = read.csv("~/Dropbox/PSID_CDS/PSID_RAW/HGC.csv") %>%
  mutate(X=NULL,MID=intnum68*1000+pnum68)

educ2 = read.csv("~/Dropbox/Data/PSID_MAIN/Education/grades_completed.csv") %>%
  mutate(X=NULL) %>%
  rename(MID=ID)

#educ3 = read.csv("~/Dropbox/Data/PSID_MAIN/educ.csv")

ID <- read.csv("../../../PSID_CLEAN/MotherPanelCDS.csv") %>%
  select(MID,m_ed) %>%
  unique() %>%
  merge(educ) %>%
  merge(educ2) %>%
  mutate(ed2=case_when(educ>16 ~ 5,educ == 16 ~ 4, educ>=13 ~ 3, educ>=12 ~ 2, educ<12 ~ 1)) %>%
  mutate(ed2 = factor(ed2,levels = c(1,2,3,4,5),labels=c("<12","12","13-15","16",">16")))

# Can we explain the difference just with the updated years?

D <- readxl::read_excel("~/Dropbox/Data/PSID_MAIN/Education/grades_completed.xlsx") %>%
  mutate(ID = ER30001*1000 + ER30002)
D1 <- D[,seq(5,158,4)]

# this routine pulls out the most recent education variable
# we want the age at which it's measured, too?
D$educ2 <- 0
D$year_meas <- 0
years <- c(1968,seq(1970,1996),seq(1997,2017,2))

for (i in 1:36) {
  print(i)
  I_use <- (D1[,i]>0) & (D1[,i]<98)
  D[I_use,"educ2"] <- D1[I_use,i]
  D[I_use,"year_meas"] <- years[i]
}

# now the next block verifies that this replicates the numbers from HGC.csv:
D %>%
  rename(MID = ID) %>%
  select(MID,educ2) %>%
  merge(educ) %>%
  filter(hgc!=educ2)

D %>%
  rename(MID = ID) %>%
  select(MID,educ2) %>%
  merge(ID) %>%
  filter(hgc!=educ) %>%
  select(MID,hgc,educ,educ2)

# OK! This piece of code shows us the difference!!!

