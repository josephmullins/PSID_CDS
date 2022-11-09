m_pc97 <- read.csv("~/Dropbox/PSID_CDS/PSID_RAW/MotherPC.csv") %>% 
  mutate(KID = ER30001*1000 + ER30002) %>% 
  select(KID,Q1PCSS,Q1PCRAW,PCG)%>%
  rename(m_pc_st= Q1PCSS, m_pc_raw= Q1PCRAW)

m2 <- readxl::read_excel("../../../data-cds/assessments/PCG-PC.xlsx") %>% 
  mutate(KID = ER30001*1000 + ER30002) %>% 
  select(KID,Q1PCSS,Q1PCRAW)%>%
  rename(m_pc_st= Q1PCSS, m_pc_raw= Q1PCRAW)

cds <- readxl::read_excel("../../../data-cds/CDS-aux-info.xlsx") %>%
  mutate(KID = CDSCUMID68*1000 + CDSCUMPN,MID = ID68PCG97*1000 + PNPCG97)

cds %>%
  select(KID,MID) %>%
  merge(m2)

#Replace missing values to NA and keep only scores reported by mothers of the child
var <- c("m_pc_st", "m_pc_raw")
missing <- c(0, 99)
for (i in 1:2) {
  m_pc97[,var[i]] = na_if(m_pc97[,var[i]],missing[i])
  m_pc97[,var[i]] = ifelse(m_pc97$PCG==1,m_pc97[,var[i]],NA)
}
m_pc97<-m_pc97 %>% select(KID,m_pc_st,m_pc_raw)
write.csv(m_pc97,"~/Dropbox/PSID_CDS/PSID_CLEAN/AssessmentMother.csv")
