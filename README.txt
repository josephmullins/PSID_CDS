# ========== Guide to folder structure ========= #
PSID_RAW contains most of the data downloaded directly from PSID's website. It also contains the code used to clean each of these datasets and arrange them into a panel format with consistent ID codes. In principle, you do not need to look here unless you are interested in how the raw data are cleaned.

PSID_CLEAN contains the cleaned versions of the data contained above.

# Option 2:

data-derived (?)

data-main-interview:
 identifiers
 labor-market
 state
 childbirth
 marriage
 savings
 education
	
data-cds:
 identifiers (?)
 expenditures -> home, school, childcare

** BIG QUESTION: wear do we keep the scripts to clean the code? In the same directory as the raw data, or elsewhere??? **
 
