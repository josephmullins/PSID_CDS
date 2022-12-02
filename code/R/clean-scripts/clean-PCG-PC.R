m_pc97 <- read.csv("~/Dropbox/PSID_CDS/PSID_RAW/MotherPC.csv") %>% 
  mutate(KID = ER30001*1000 + ER30002) %>% 
  select(KID,Q1PCSS,Q1PCRAW,PCG)%>%
  rename(m_pc_st= Q1PCSS, m_pc_raw= Q1PCRAW)

m2 <- readxl::read_excel("data-cds/assessments/PCG-PC.xlsx") %>% 
  mutate(KID = ER30001*1000 + ER30002) %>% 
  select(KID,Q1PCSS,Q1PCRAW)%>%
  rename(m_pc_st= Q1PCSS, m_pc_raw= Q1PCRAW)

# load the auxiliary data and create the Kid ID and the PCG ID.
# then merge by Kid ID with the PCG's test score data
# then drop missing observations
cds <- readxl::read_excel("data-cds/CDS-aux-info.xlsx") %>%
  mutate(KID = CDSCUMID68*1000 + CDSCUMPN,MID = ID68PCG97*1000 + PNPCG97) %>%
  select(KID,MID) %>%
  merge(m2) %>%
  filter(m_pc_st>0) %>%
  select(MID,m_pc_st,m_pc_raw) %>%
  unique()

# there are a small handful of observations where the raw score is the same but the conversion to standardized score differs slightly, in this case we just keep the first observation
cds <- cds %>%
  group_by(MID) %>%
  filter(row_number()==1)

write.csv(cds,"data-cds/assessments/PCG-PC-clean.csv")
# NOTE: different from how we did things previously, since this way only links to the mother if they are indeed the PCG
