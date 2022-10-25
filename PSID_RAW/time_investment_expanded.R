

`
#Construct narrow time investment measures:
# Investment time - time spent with a parent actively participating in investment activities (ex: academic investment, health investment, play, arts and crafts, sports, conversations).
#Expanded investment time - time spent with a parent actively participating in investment activities, related travel, playing, and conversation with other household children. 
#Social time - time spent with a parent actively participating in volunteering, eating, religious and socializing activities
#Expanded social time - social time+related travel, and meal preparation.


library(dplyr)
library(tidyr)

T0 <- read.csv("~/Dropbox/Data/PSID_CDS/TD97full.csv") %>%
  mutate(KID=ER30001*1000 + ER30002,year = 1997)  %>%
  select(KID,year,COLA,COLG_B,COLG_C,COLH_B,COLH_C,WDAYWEND,DURATION,COLJ)


T1 <- read.csv("~/Dropbox/Data/PSID_CDS/TD02full.csv") %>%
  mutate(KID=ER30001*1000 + ER30002,year = 2002) %>%
  rename(COLJ=COLJ_02, COLG_B = COLGB_02, COLG_C = COLGC_02 , COLH_B = COLGH_02, COLH_C = COLHC_02, WDAYWEND = DIARY_02, DURATION = DUR_02, COLA = COLA_02) %>%
  select(KID,year,COLA,COLG_B,COLG_C,COLH_B,COLH_C,WDAYWEND,DURATION,COLJ) %>%
  mutate(COLA = floor(COLA/10), COLJ = floor(COLJ/10)) #<- have to round down

T2 <- read.csv("~/Dropbox/Data/PSID_CDS/TD07full.csv")%>%
  mutate(KID=ER30001*1000 + ER30002,year = 2007) %>%
  rename(COLJ=COLJ_07, COLG_B = COLHB_07, COLG_C = COLHC_07 , COLH_B = COLIB_07, COLH_C = COLIC_07, WDAYWEND = DIARY_07, DURATION = DUR_07, COLA = COLA_07) %>%
  select(KID,year,COLA,COLG_B,COLG_C,COLH_B,COLH_C,WDAYWEND,DURATION,COLJ) %>%
  mutate(COLG_B = if_else(COLG_B==5, as.integer(0), as.integer(COLG_B)),COLG_C = if_else(COLG_C==5, as.integer(0), as.integer(COLG_C)),
         COLH_B = if_else(COLH_B==5, as.integer(0), as.integer(COLH_B)), COLH_C = if_else(COLH_C==5, as.integer(0), as.integer(COLH_C)),#<- 5 corresponds to activity being personal, private, school, or work according to the codebook - I make it 0
         COLA = floor(COLA/10), COLJ = floor(COLJ/10)) #<- have to round down

TD <- rbind(T0,T1,T2) %>%
  mutate(time2ind = COLA!=919) %>% #<- is this right?
  #mutate(time2ind = (COLA>=500 & COLA<600) | (COLA>=700 & COLA<900) | (COLA>=939 & COLA<960)) #%>% #<- is this right?
  #mutate(cat = floor(COLA/100))
  mutate(COLG_B = na_if(COLG_B,9), COLG_C = na_if(COLG_C,9),COLH_B = na_if(COLH_B,9), COLH_C = na_if(COLH_C,9)) #<- code in missing categories


TD$wght = 2 + 3*TD$WDAYWEND

#create a dummy variable equal to 1 if parents are engaged into 
#the "investment" activity :
TD$investment=ifelse(TD$COLA==258|TD$COLA==222|TD$COLA==249|TD$COLA==259|TD$COLA==238|
                       TD$COLA==339|TD$COLA==411|TD$COLA==488|TD$COLA==501|TD$COLA==504|
                       TD$COLA==511|TD$COLA==519|TD$COLA==549|TD$COLA==569|
                       (TD$COLA>=709&TD$COLA<=749)|(TD$COLA>=801&TD$COLA<=889)|
                       TD$COLA==939|TD$COLA==941|TD$COLA==959|TD$COLA==942|
                       TD$COLA==943|TD$COLA==962|TD$COLA==967|TD$COLA==979|TD$COLA==963,1,0)

#create an dummy variable equal to 1 if parents are engaged into
#the "socializing" activity
TD$social=ifelse(TD$COLA==439|TD$COLA==448|TD$COLA==449|(TD$COLA>=601&TD$COLA<=689)|
                   TD$COLA==752|TD$COLA==769|TD$COLA==771|TD$COLA==772|TD$COLA==789,1,0)

#create an investment dummy variable equal to 1 if parents are engaged into 
#the "expanded investment" activity (primary or secondary)::


TD$ex_soc=ifelse(TD$COLA==108|TD$COLA==109|TD$COLA==118|TD$COLA==119|TD$COLA==698|TD$COLA==699|TD$COLA==799|TD$social==1,1,0)




TD$ex_inv=ifelse(TD$investment==1|
                   TD$COLA==248|TD$COLA==221|TD$COLA==239|TD$COLA==377|
                   TD$COLA==484|TD$COLA==510|TD$COLA==512|TD$COLA==599|
                   TD$COLA==597|TD$COLA==598|TD$COLA==899,1,0)



TD_agg <- TD %>% 
  group_by(KID,year) %>% 
  summarise(tau_m = sum(DURATION*wght*COLG_B,na.rm = TRUE)/3600, tau_f = sum(DURATION*wght*COLG_C,na.rm=TRUE)/3600, tau_both = sum(DURATION*wght*(COLG_B + (1-COLG_B)*COLG_C),na.rm=TRUE)/3600, tau_m2 = sum(time2ind*DURATION*wght*COLG_B,na.rm = TRUE)/3600, tau_f2 = sum(time2ind*DURATION*wght*COLG_C,na.rm=TRUE)/3600,
            tau_m_investment = sum(DURATION*wght*COLG_B*investment,na.rm = TRUE)/3600,  tau_m_social = sum(DURATION*wght*COLG_B*social,na.rm = TRUE)/3600, tau_m_ex_inv = sum(DURATION*wght*COLG_B*ex_inv,na.rm = TRUE)/3600,  tau_m_ex_soc = sum(DURATION*wght*COLG_B*ex_soc,na.rm = TRUE)/3600, 
            tau_f_investment = sum(DURATION*wght*COLG_C*investment,na.rm = TRUE)/3600,  tau_f_social = sum(DURATION*wght*COLG_C*social,na.rm = TRUE)/3600, tau_f_ex_inv = sum(DURATION*wght*COLG_C*ex_inv,na.rm = TRUE)/3600, tau_f_ex_soc = sum(DURATION*wght*COLG_C*ex_soc,na.rm = TRUE)/3600,
            tau_both_investment = sum(DURATION*wght*(COLG_B + (1-COLG_B)*COLG_C)*investment,na.rm = TRUE)/3600,  tau_both_social = sum(DURATION*wght*(COLG_B + (1-COLG_B)*COLG_C)*social,na.rm = TRUE)/3600, tau_both_ex_inv = sum(DURATION*wght*(COLG_B + (1-COLG_B)*COLG_C)*ex_inv,na.rm = TRUE)/3600, tau_both_ex_soc = sum(DURATION*wght*(COLG_B + (1-COLG_B)*COLG_C)*ex_soc,na.rm = TRUE)/3600)


write.csv(TD_agg,"~/Dropbox/JPE_Child_Devp_2020/PSID/PSID_CLEAN/ActiveTimePanel.csv")



