# ========== File Descriptions ========== #
The structure of each file is vertical, so each row correponds to either a (mother,year) observation or a (child,year) observation, depending on the file.

All files can be merged with each other using the key variables (KID,MID,year) where KID is the child identifier and MID is the mother's identifier.

If you want to know more about the data construction, you can read the notebook "CleaningRawData.html".

# ------ Parent level panels: (obs is mother,year)

- "MotherPanelCDS.csv" is a panel of all mothers of children who show up in the CDS in 1997. Same variables as the file above.

# ------ Child level panels: (obs is child,year)

- "ChildPanelCDS.csv" merges the panel of mothers of cds children, with *all* of their children from the childbirth history file. The variables "KID", "age", and "ybirth_child" are added, corresponding to each child. Use this file to merge mothers and fathers household and labor market variables with the data collected from the CDS.
- "ActiveTimePanel.csv" mother's and father's active time (years 1997 and 2001)
- "Expenditures.csv" - child specific expenditures from the primary caregiver interview in the CDS
- "ChildCarePanel.csv" - child specific expenditures on child care and imputed prices
- "AssessmentPanel.csv" - panel of scores from child assessments, cognitive skills and behavioral problems
- "PPE.csv" - One year's worth of per pupil expenditures for the child's school, collected from the school administrator interview


# =========== Variable Description for Parent Level Panels ====== #
"MID" - Mother's ID number across years
"FID" - "Father's ID number", where father is defined as any current spouse of the mother
"year" - year (CDS 2002 wave matched with 2001 interview data)
"age_mother" - mother's age, using birth years from the marriage history file
"F_age" - "father's age" using previous definition of father, using birth year from childbirth history file
"intnum" - interview number of household
"ever_married" - indicator for whether the mother has married ever, from marriage history file
"mar_ind" - a boolean variable indicating if the mother is either married to or permanently cohabiting with someone. This person is defined as the "father".
"m_wage" - mother's wage, annual earnings divided by annual hours
"f_wage" - "father's" wage, annual earnings divided by annual hours
"m_wage" - mother's wage, annual earnings divided by annual hours
"f_wage" - "father's" wage, annual earnings divided by annual hours
"m_earn" - mother's annual earnings
"f_earn" - father's annual earnings
"m_hrs" - mother's annual work hours
"f_hrs" - father's annual work hours
"house_earn" - household earnings (annual)
"childcare_exp" - total household childcare expenditure, annual, from main interview
"Race" - Race of mother (see codes below)
"m_ed" - mother's education
"f_ed" - father's education
"StFIPS" - FIPS code
"y_first" - year of mother's first birth from childbirth history
"age_youngest" - current age of youngest child from mother's childbirth history 
"age_oldest" - current age of oldest child from mother's childbirth history 
"num_child" - number of children between 0 and 18, from mother's childbirth history
"knum" - number of birth records from childbirth history
"num_0_5" - number of children 0-5 from childbirth history
"num_6_12" - number of children 6-12 from childbirth history

# ============ Variable description for Child Level Panels ======== #
# --- "CDSMainPanel.csv"
- this file includes all the variables above, in addition to:
 "KID" - Kid's ID number across years
 "age" - age of child
 "ybirth_child" - year of birth of child, from childbirth history

# --- "ChildCarePanel.csv"
"KID" - Kid's ID number across years
"year" - year
"Price" - Imputed price of child care
"ChCare" - Expenditure on Child care in $/week (main current arrangement)

# --- "ActiveTimePanel.csv"
"KID" - Kid's ID number across years
"year" - year
"tau_m" - mother's active time (weighted sum of weekday and weekend active time)
"tau_f" - father's active time

# --- "Expenditures.csv"
"KID" - Kid's ID number across years
"year" - year
"SchSupplies" - weekly $ on school supplies for child (02 CDS)
"Toys" - weekly $
"Clothing" - weekly $
"Vacation" - weekly $ on vacation
"Food" - weekly $
"sports" - weekly $ spent on sporting activities
"lessons" - weekly $ spend on lessons (dance, music, other hobbies)
"comm_grps" - weekly $ spent on community group activities
"tutoring" - weekly $ spent on tutoring
"tuition" - weekly $ spent on private school tuition

# --- AssessmentPanel.csv
"KID" - Kid's ID num across years
"year" - year
"LW_x" - Age 3+, Letter Word Score, where x is "std" or "raw" (standardizes vs raw score)
"AP_x" - Age 3+, Applied Problems Score, where x is "std" or "raw" (standardizes vs raw score)
"PC_x" - Age 6+, Passage Comprehension Score, where x is "std" or "raw" (standardizes vs raw score)
"DigSpan" - Age 3+, Digit Span total (sum of the forward and backward test, the highest string of numbers recalled)
"BPE" - Age 3+, Behavioral Problems Score, Externalizing Behaviors
"BPN" - Age 3+, Behavioral Problems Score, Internalizing Behaviors



# ====== Coding of Race Variable ====== # 
1 	  	White
2 	  	Black, African-American, or Negro
3 	  	American Indian or Alaska Native
4 	  	Asian
5 	  	Native Hawaiian or Pacific Islander
7 	  	Other

# ====== Timing of variables ========= #
___Main Interview____
childcare_exp - explicitly in prior calendar year
earnings - totals for prior calendar year
hours - totals for prior calendar year
wages - imputed using earnings and hours

We have converted these to calendar years in the cleaned data files.

___CDS____
- all expenditure variables are for "past 12 months", except for private school tuition, which is "past school year"
- time use variables apply to year of interview
- child care expenditures apply to year of interview

