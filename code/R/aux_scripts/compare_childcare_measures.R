library(tidyverse)

C <- read.csv("~/Dropbox/PSID_CDS/PSID_CLEAN/ChildPanelCDS.csv") %>% 
  mutate(X=NULL) %>%
  filter(year==2002) %>%
  select(KID,state,chcare,m_wage,tau_m)


price_ext <- read.csv("~/Dropbox/JPE_Child_Devp_2020/Prices/childcare_prices2002.csv") %>%
  mutate(state = stateid,
    pc_infant = p_icent_e_cps_cpkt,
    pf_infant = p_ifcc_e_cps_cpkt,
    pc_four = p_yocent_e_cps_cpkt,
    pf_four = p_yofcc_e_cps_cpkt)

price_good <- read.csv("~/Dropbox/JPE_Child_Devp_2020/Prices/RelativePricesGoods.csv") %>% 
  mutate(state = GeoFips, price_good = X2002) %>%
  select(state, price_good)

price_serv <- read.csv("~/Dropbox/JPE_Child_Devp_2020/Prices/RelativePricesGoods.csv") %>% 
  mutate(state = GeoFips, price_serv = X2002) %>%
  select(state, price_serv)


time_inv <- read.csv("~/Dropbox/PSID_CDS/data-cds/time-diary/ActiveTimePanel.csv") %>%
  filter(year == 2002) %>%
  select(KID, formal, informal, relative)

D <- C %>%
  merge(price_ext) %>%
  merge(price_good) %>%
  merge(price_serv) %>%
  mutate(pg = 1 / 3 * price_serv + 2 / 3 * price_good) %>%
  merge(time_inv) %>%
  mutate(chcare2 = formal * pc_four / 52 + informal * pf_four / 52,
    chcare3 = chcare2 + pc_four * relative / 52) %>%
  mutate(chcare_inp = chcare / pc_four)


D %>%
  ggplot(aes(x = log(chcare), y = log(chcare2))) + geom_point() + theme_minimal()

D %>%
  filter(chcare > 0, chcare2 > 0) %>%
  lm(log(chcare) ~ log(chcare2), data = .) %>%
  summary()

D %>%
  lm(chcare ~ chcare2, data = .) %>%
  summary()


D %>%
  filter(chcare_inp > 0, tau_m > 0, m_wage > 0) %>%
  lm(log(chcare_inp / tau_m) ~ log(pc_four / m_wage), data = .) %>%
  summary()

D %>%
  filter(informal>0,tau_m>0,m_wage>0) %>%
  lm(log((informal)/tau_m) ~ log(pf_four/m_wage),data=.) %>%
  summary()

D %>%
  mutate(care_inp = case_when(chcare_inp==0 ~ formal,chcare_inp>0 ~ chcare_inp)) %>%
  filter(care_inp>0,tau_m>0,m_wage>0) %>%
  lm(log(care_inp/tau_m) ~ log(pc_four/m_wage),data=.) %>%
  summary()

D %>%
  mutate(care_inp = case_when(chcare_inp==0 ~ formal,chcare_inp>0 ~ chcare_inp)) %>%
  filter(care_inp>0,informal>0) %>%
  lm(log(care_inp/informal) ~ log(pc_four/pf_four),data=.) %>%
  summary()

D %>%
  filter(formal>0,informal>0) %>%
  lm(log(formal/informal) ~ log(pc_four/pf_four),data=.) %>%
  summary()


# Based on this quick look, the results are not encouraging!
# TODO: return to this when we have reconstructed the data properly