# This script loads the data on household childcare expenditures from the main interview and arranges it into a panel.
# To merge the data with individuals, you need to use the identifiers panel.

D <- readxl::read_excel("../../../data-main/expenditures/childcare/Main_childcare.xlsx")

# these are all the years that the question is available
years <- c(seq(1988,1997),seq(1999,2017,2))

d <- data.frame(year = integer(), intnum = integer(), childcare_exp = double())

for (i in 1:length(years)) {
  d0 <- data.frame(year = years[i], intnum = D[[(i-1)*3+2]], childcare_exp = D[[(i-1)*3+3]])
  d <- rbind(d,na.omit(d0))
}

# code up missing values
d$childcare_exp[(d$childcare_exp>=99998) & d$year<1999] <- NA
d$childcare_exp[(d$childcare_exp>=999998)] <- NA

write.csv(d,"../../../data-main/expenditures/childcare/Main_childcare.csv")
