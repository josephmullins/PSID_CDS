# This script loads the data on household childcare expenditures from the main interview and arranges it into a panel.
# To merge the data with individuals, you need to use the identifiers panel.

D <- readxl::read_excel("~/Dropbox/PSID_CDS/data-main/food-stamps/food-stamps.xlsx")

years <- c(seq(1976,1997),seq(1999,2021,2))

d <- data.frame(year = integer(), intnum = integer(), fs = integer(),fs_used=integer())

question_count_original <- 3

for (i in 1:length(years)) {

  question_count_original <- 3
  question_count <- ifelse(years[i] <= 1997, 3, 4)
  
  if (years[i] <= 1997) {
    col_indices <- (i - 1) * question_count_original + 1 + (0:(question_count - 1))
    j=0
  } else {
    col_indices <- (i - 1) * question_count_original + 1 + ((0:(question_count - 1))+j)
    j=j+1
  }
  col_indices
  
  d0 <- data.frame(
    year = years[i],
    intnum = D[, col_indices[2]],  
    fs = D[, tail(col_indices,1)] #after 1997, it's the 4th question that tracks the prior year and the 3rd question that tracks 2 years ago
  )
  
  # Rename columns to match specified names
  colnames(d0) <- c("year", "intnum", "fs")
  
  if(years[i]<1994){
    d0$fs_used[d0$fs > 0 & d0$fs <= 12] <- 1
    d0$fs_used[d0$fs == 0] <- 0
    d0$fs_used[d0$fs == 99] <- NA
    d0 <- d0[!is.na(d0$intnum), ] #drop NA interview numbers
    d <- rbind(d, na.omit(d0))
  }
  
  if(years[i]>=1994){
    d0$fs_used <- NA  # Initialize all values to NA
    d0$fs_used[d0$fs == 1] <- 1  # Set values equal to 1
    d0$fs_used[d0$fs == 5] <- 0  # Set values equal to 5
    d0 <- d0[!is.na(d0$intnum), ] #drop NA interview numbers
    d <- rbind(d, na.omit(d0))
  }
  
  
  # Handle skipped years after 1999
  if (years[i] > 1997 & i < length(years)) {
    skipped_year <- years[i] - 1
    # Construct entry for skipped year
    d_skipped <- data.frame(
      year = skipped_year,
      intnum = D[, col_indices[2]],
      fs = D[, col_indices[3]]
    )
    # Rename columns to match specified names
    colnames(d_skipped) <- c("year", "intnum", "fs")
    
    d_skipped$fs_used <- NA  # Initialize all values to NA
    d_skipped$fs_used[d_skipped$fs == 1] <- 1  # Set values equal to 1
    d_skipped$fs_used[d_skipped$fs == 5] <- 0  # Set values equal to 5
    
    # Append to the main data frame
    d <- rbind(d, d_skipped)
  }
}



##--------TESTING

D <- readxl::read_excel("~/Dropbox/PSID_CDS/data-main/food-stamps/food-stamps.xlsx")


#V10001  	#RELEASE NUMBER
#V10002  	#1984 INTERVIEW NUMBER
#V10241  	# MOS USED FD ST 83(J22)

D<-D %>% 
  select(V10001, V10002, V10241)


years <- c(seq(1976,1997),seq(1999,2021,2))


years<-c(1984)

d <- data.frame(year = integer(), intnum = integer(), fs = integer(),fs_used=integer())

question_count_original <- 3

for (i in 1:length(years)) {
  
  question_count_original <- 3
  question_count <- ifelse(years[i] <= 1997, 3, 4)
  
  if (years[i] <= 1997) {
    col_indices <- (i - 1) * question_count_original + 1 + (0:(question_count - 1))
    j=0
  } else {
    col_indices <- (i - 1) * question_count_original + 1 + ((0:(question_count - 1))+j)
    j=j+1
  }
  col_indices
  
  d0 <- data.frame(
    year = years[i],
    intnum = D[, col_indices[2]],  
    fs = D[, tail(col_indices,1)] #after 1997, it's the 4th question that tracks the prior year and the 3rd question that tracks 2 years ago
  )
  
  # Rename columns to match specified names
  colnames(d0) <- c("year", "intnum", "fs")
  
  if(years[i]<1994){
    d0$fs_used[d0$fs > 0 & d0$fs <= 12] <- 1
    d0$fs_used[d0$fs == 0] <- 0
    d0$fs_used[d0$fs == 99] <- NA
    d0 <- d0[!is.na(d0$intnum), ] #drop NA interview numbers
    d <- rbind(d, na.omit(d0))
  }
  
  #if(years[i]>=1994){
  #  d0$fs_used <- NA  # Initialize all values to NA
  #  d0$fs_used[d0$fs == 1] <- 1  # Set values equal to 1
  #  d0$fs_used[d0$fs == 5] <- 0  # Set values equal to 5
  #  d0 <- d0[!is.na(d0$intnum), ] #drop NA interview numbers
  #  d <- rbind(d, na.omit(d0))
  #}
  
}





snap_use <- d %>%
  group_by(year) %>%
  summarize(
    fs_participation = sum(fs_used == 1, na.rm = TRUE) / sum(!is.na(fs_used))
  )
print(snap_use,n=45)


ggplot(snap_use, aes(x = year, y = fs_participation)) +
  geom_line() +
  labs(title = "SNAP Participation Over Time",
       x = "Year",
       y = "Proportion of Participants") +
  theme_minimal()






snap_use_hold<-snap_use




write.csv(d,"/Users/madisonbozich/Dropbox/PSID_CDS/data-main/food-stamps/food-stamps.csv")
