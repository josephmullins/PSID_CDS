D <- readxl::read_excel("../../../data-main/education/grades_completed.xlsx") %>%
  mutate(ID = ER30001*1000 + ER30002)
D1 <- D[,seq(5,158,4)]

# this routine pulls out the most recent education variable, up to the year 2011.
# the data itself go until 2017, but we only go up to 2011 to replicate the data used in first draft of CLMP
D$educ <- -1
D$year_meas <- -1
years <- c(1968,seq(1970,1996),seq(1997,2017,2))

# replace with (i in 1:length(years)) if we want to update using measures from 2013-2017
for (i in 1:36) {
  print(i)
  I_use <- (D1[,i]>0) & (D1[,i]<98)
  D[I_use,"educ"] <- D1[I_use,i]
  D[I_use,"year_meas"] <- years[i]
}

# do some final data cleaning and save the file
D %>%
  mutate(educ = na_if(educ,-1), #<- this is a difference with the old file, we are careful to make note of missing data
         ed=case_when(educ>16 ~ 5,educ == 16 ~ 4, educ>=13 ~ 3, educ>=12 ~ 2, educ<12 ~ 1)) %>%
  select(ID,educ,ed,year_meas) %>%
  mutate(ed = factor(ed,levels = c(1,2,3,4,5),labels=c("<12","12","13-15","16",">16"))) %>%
  write.csv("../../../data-main/education/education.csv") #<- might be that we want to save elsewhere (advantage being we can git ignore everything in that folder)
