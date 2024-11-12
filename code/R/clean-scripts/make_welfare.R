# This script loads the data on household childcare expenditures from the main interview and arranges it into a panel.
# To merge the data with individuals, you need to use the identifiers panel.
library(tidyverse)
D <- readxl::read_excel("data-main/afdc/afdc.xlsx")
years <- c(seq(1986,1997),seq(1999,2021,2))
d <- data.frame(year = integer(), intnum = integer(), afdc_hd = integer(), afdc_sp = integer(), afdc_hh = integer())

#------TESTING

for (i in 1:length(years)) {
  # Count the number of questions asked each year

  question_count_original <- 4
  question_count <- ifelse(years[i] <= 1997 | years[i] > 2015, 4, 5)
  
  
  if (years[i] <= 1997) {
    col_indices <- (i - 1) * question_count_original + 1 + (0:(question_count - 1))
    j = 0
  } else if (years[i] > 1997 & years[i] < 2017) {
    col_indices <- (i - 1) * question_count_original + 1 + ((0:(question_count - 1)) + j)
    j = j + 1
  } else {
    k=9
    col_indices <- (i - 1) * question_count_original + 1 + (0:(question_count - 1)+k)
    k=k+1
  }

  d0 <- data.frame(
    year = years[i],
    intnum = D[, col_indices[2]],  # Start indexing at 2
    afdc_hd = D[, col_indices[3]],
    afdc_sp = D[, col_indices[4]]
  )
  
  # Rename columns to match specified names
  colnames(d0) <- c("year", "intnum", "afdc_hd", "afdc_sp")
  
  if(years[i]<1994){
    d0$afdc_hd <- ifelse(d0$afdc_hd > 0 & d0$afdc_hd != 99, 1, d0$afdc_hd)
    d0$afdc_sp <- ifelse(d0$afdc_sp > 0 & d0$afdc_sp != 99, 1, d0$afdc_sp)
    d0$afdc_hh <- ifelse(d0$afdc_sp == 1 | d0$afdc_hd == 1, 1, NA) #should maintain NAs
    d0$afdc_hh <- ifelse(d0$afdc_sp == 0 & d0$afdc_hd == 0, 0, d0$afdc_hh)
    d0 <- d0[!is.na(d0$intnum), ]
    d <- rbind(d, na.omit(d0))
  }
  
  if(years[i]>=1994) {
    d0$afdc_hd[d0$afdc_hd == 1] <- 1
    d0$afdc_hd[d0$afdc_hd == 5] <- 0
    d0$afdc_sp[d0$afdc_sp == 1] <- 1
    d0$afdc_sp[d0$afdc_sp == 5] <- 0
    
    d0$afdc_hh <- ifelse(d0$afdc_sp == 1 | d0$afdc_hd == 1, 1, NA) #should maintain NAs
    d0$afdc_hh <- ifelse(d0$afdc_sp == 0 & d0$afdc_hd == 0, 0, d0$afdc_hh)
    
    d0 <- d0[!is.na(d0$intnum), ]
    d <- rbind(d, na.omit(d0))
  }
  if (years[i] > 1997 & years[i] < 2017 & i < length(years)) {
    skipped_year <- years[i] - 1
    # Construct entry for skipped year
    d_skipped <- data.frame(
      year = skipped_year,
      intnum = D[, col_indices[2]],
      afdc_hd = NA,
      afdc_sp = NA,
      afdc_hh = D[, col_indices[5]]
    )

    # Rename columns to match specified names
    colnames(d_skipped) <- c("year", "intnum", "afdc_hd", "afdc_sp", "afdc_hh")
    
    d_skipped$afdc_hh <- ifelse(d_skipped$afdc_hh == 1, 1,
                      ifelse(d_skipped$afdc_hh == 5, 0, NA))
    
    # Append to the main data frame
    d <- rbind(d, filter(d_skipped, !is.na(intnum)))
  }

}

welfare_use <- d %>%
  group_by(year) %>%
  summarize(
    afdc_hh = mean(afdc_hh,na.rm = TRUE),
    afdc_hd = mean(afdc_hd,na.rm = TRUE)
  ) %>%
  pivot_longer(cols=c("afdc_hd","afdc_hh")) %>%
  filter(!is.nan(value))

ggplot(welfare_use, aes(x = year, y = value, color=name)) +
  geom_line(size=2) +
  labs(title = "AFDC Household Participation Over Time",
       x = "Year",
       y = "Proportion of AFDC Households") +
  theme_minimal()


write.csv(d,"data-main/afdc/afdc.csv")
