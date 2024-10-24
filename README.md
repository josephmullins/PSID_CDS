# Repository of PSID and CDS data

This repo contains raw and cleaned data from the Panel Study of Income Dynamics(PSID) and the the Child Development Supplement.

The various folders in [`data-main`](/data-main) [`data-cds`](/data-cds/) contain both raw and cleaned data. The folder [`code/R/clean-scripts`](/code/R/clean-scripts/) contains R scripts used to clean the data. Most often this cleaning process creates a panel dataset at the household level. Of particular use is the [identifiers panel](/data-main/identifiers/identifiers-panel.csv) which links PSID individuals (identified by a 1968 interview number and a person number) to households in each year. This can be used to link individuals to household level variables, while the sequence numbers (`sn`) can be used to link individuals to variables relating to the "head" or the "spouse" in the household.

## TODO

- Create some example code for using the identifiers panel to create linkages.
- Write some example code for using the marriage and childbirth file