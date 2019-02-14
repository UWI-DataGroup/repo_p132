** This is the fifth *do* file to be called by the master file.

 ******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *                                                              
 *  DO FILE: 		5_rx_outcomes_da
 *					5th dofile: Routine medication (not applicable to 2014 data)
 *								Outcomes
 *								  - % deaths - overall deaths as % and by year
 *	 							  - Survival analysis to 3 years
 *									(correct survival in dofile 8)
 *	 							  - % deaths by main sites & cancer vs non-cancer deaths
 *					The code herein is based on AMC Rose's 2008 analysis code
 *					but, instead of using AR's site classification, IARC's site
 *					classification created by J Campbell in 2014 cleaning 
 *					dofile "5_merge_cancer_dc"
 *
 *	STATUS:			Completed
 *
 *  FIRST RUN: 		20dec2018
 *
 *	LAST RUN:		20dec2018
 *
 *  ANALYSIS: 		Cancer 2014 dataset for annual report
 *
 * 	VERSION: 		version01 - 2014 ABSTRACTION PHASE
 *     
 *  SUPPORT: 		Natasha Sobers/Ian R Hambleton
 *
 ******************************************************************************


** Stata version control
version 15.1
** Initialising the STATA log and allow automatic page scrolling
capture {
    program drop _all
	drop _all
	log close
	}

** Direct Stata to your data-cleaning folder using the -cd- command
cd "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\"

log using "logfiles\5_rx_outcomes_2014_da.smcl", replace

** Automatic page scrolling of output
set more off


* ************************************************************************
* ANALYSIS: SECTION 4 - TREATMENT & OUTCOMES
* Covering
* 4.1 Routine medication - moved to bottom of dofile as rx not collected for 2014
* 4.2 % deaths - overall deaths as % and by year
* 4.3 Survival analysis to 3 years
* 4.4 % deaths by main sites and cancer vs non-cancer deaths
**************************************************************************

** Load the dataset
use "data\2014_cancer_numbers_da.dta", replace


************************************************
** 4.2 overall deaths as % and by year
************************************************
** Note that we cannot here estimate MR or ASMR, as we do not have this information
** (i.e. TOTAL deaths from cancer in 2008 - even those that were not dx in that year)
** so if we did an MR or ASMR it would be an underestimate; that will come after
** several years of the registry

tab slc ,m
/*
StatusLastC |
     ontact |      Freq.     Percent        Cum.
------------+-----------------------------------
      Alive |        422       45.52       45.52
   Deceased |        500       53.94       99.46
    Unknown |          5        0.54      100.00
------------+-----------------------------------
      Total |        927      100.00
*/
tab deceased ,m
/*
   whether patient is |
             deceased |      Freq.     Percent        Cum.
----------------------+-----------------------------------
                 dead |        500       53.94       53.94
alive at last contact |        427       46.06      100.00
----------------------+-----------------------------------
                Total |        927      100.00
*/

** Now we restrict to patients only (as we are dealing with deaths)
drop if patient==2 //15 obs deleted
count //912

sort dot dod
list dot dod basis
tab dod ,m //424 missing
count if dod!=. //488

tab deceased ,m
/*
   whether patient is |
             deceased |      Freq.     Percent        Cum.
----------------------+-----------------------------------
                 dead |        488       53.51       53.51
alive at last contact |        424       46.49      100.00
----------------------+-----------------------------------
                Total |        912      100.00
*/


tab beh  deceased  ,m
/*
           |  whether patient is
           |       deceased
 Behaviour |      dead  alive at  |     Total
-----------+----------------------+----------
   In situ |         0         23 |        23 
 Malignant |       488        401 |       889 
-----------+----------------------+----------
     Total |       488        424 |       912 
*/

tab dodyear ,m

tab dodyear beh ,m
/*
   Year of |       Behaviour
     death |   In situ  Malignant |     Total
-----------+----------------------+----------
      2014 |         0        303 |       303 
      2015 |         0        101 |       101 
      2016 |         0         54 |        54 
      2017 |         0         30 |        30 
         . |        23        401 |       424 
-----------+----------------------+----------
     Total |        23        889 |       912 
*/

tab dodyear deceased ,m
tab dodyear deceased if siteiarc!=25 ,m
/*
           |  whether patient is
   Year of |       deceased
     death |      dead  alive at  |     Total
-----------+----------------------+----------
      2014 |       303          0 |       303 
      2015 |       101          0 |       101 
      2016 |        54          0 |        54 
      2017 |        30          0 |        30 
         . |         0        424 |       424 
-----------+----------------------+----------
     Total |       488        424 |       912 
*/


** 303 died in 2014 - JC: only do 2014-2017 as 2018 was incomplete
cii proportions 921 303
dis 912-(488+1) // by 3yrs from dx (i.e. up to 31dec2017) 488 had died
cii proportions 912 101
cii proportions 912 54
cii proportions 912 30

count if dodyear!=. //488
list dod slc pid if dodyear==. & deceased!=. & slc==2
** none missing dod.
 
tab siteiarc deceased ,m


*********************************************
** Death Info for Top Deaths - Totals by site
*********************************************

** Check for top 10 deaths by IARC site
** include O&U; exclude in-situ
preserve
drop if siteiarc==64|deceased!=1 //424 obs deleted
bysort siteiarc: gen n=_N
bysort n siteiarc: gen tag=(_n==1)
replace tag = sum(tag)
sum tag , meanonly
gen top10 = (tag>=(`r(max)'-9))
sum n if tag==(`r(max)'-9), meanonly
replace top10 = 1 if n==`r(max)'
tab siteiarc top10 if top10!=0
contract siteiarc top10 if top10!=0, freq(count) percent(percentage)
gsort -count
drop top10 percentage
/*
siteiarc									count
Colon (C18)									67
Prostate (C61)								67
Breast (C50)								53
Other and unspecified (O&U)					44
Lung (incl. trachea and bronchus) (C33-34)	28
Corpus uteri (C54)							23
Multiple myeloma (C90)						20
Pancreas (C25)								20
Rectum (C19-20)								20
Stomach (C16)								17
*/
restore

** exclude O&U and in-situ
preserve
drop if siteiarc==61|siteiarc==64|deceased!=1 //468 obs deleted
bysort siteiarc: gen n=_N
bysort n siteiarc: gen tag=(_n==1)
replace tag = sum(tag)
sum tag , meanonly
gen top10 = (tag>=(`r(max)'-9))
sum n if tag==(`r(max)'-9), meanonly
replace top10 = 1 if n==`r(max)'
tab siteiarc top10 if top10!=0
contract siteiarc top10 if top10!=0, freq(count) percent(percentage)
gsort -count
drop top10 percentage
/*
siteiarc									count
Prostate (C61)								67
Colon (C18)									67
Breast (C50)								53
Lung (incl. trachea and bronchus) (C33-34)	28
Corpus uteri (C54)							23
Pancreas (C25)								20
Multiple myeloma (C90)						20
Rectum (C19-20)								20
Stomach (C16)								17
Non-Hodgkin lymphoma (C82-86,C96)			14
*/
restore


** DEATHS OF THOSE WITH COLON CANCER - #1
tab deceased if siteiarc==13 ,m
sort dod
tab dod if deceased==1 & siteiarc==13 ,m
cii proportions 111 67
		
		
** DEATHS OF THOSE WITH PROSTATE CANCER - #2
tab deceased if siteiarc==39 ,m
sort dod
tab dod if deceased==1 & siteiarc==39 ,m
cii proportions 195 67


** DEATHS OF THOSE WITH BREAST CANCER - #3
tab deceased if siteiarc==29 ,m
sort dod
tab dod if deceased==1 & siteiarc==29 ,m
cii proportions 157 53


** DEATHS OF THOSE WITH O&U (ill-defined;unk siteiarc) - #4
tab deceased if siteiarc==61 ,m
sort dod
tab dod if deceased==1 & siteiarc==61 ,m
cii proportions 45 44


** DEATHS OF THOSE WITH LUNG CANCER - #5
tab deceased if siteiarc==21 ,m
sort dod
tab dod if deceased==1 & siteiarc==21 ,m
cii proportions 32 28


** DEATHS OF THOSE WITH CORPUS UTERI CANCER - #6
tab deceased if siteiarc==33 ,m
sort dod
tab dod if deceased==1 & siteiarc==33 ,m
cii proportions 39 23


** DEATHS OF THOSE WITH MULTIPLE MYELOMA - #7
tab deceased if siteiarc==55 ,m
sort dod
tab dod if deceased==1 & siteiarc==55 ,m
cii proportions 28 20

			 
** DEATHS OF THOSE WITH PANCREATIC CANCER - #8
tab deceased if siteiarc==18 ,m
sort dod
tab dod if deceased==1 & siteiarc==18 ,m
cii proportions 21 20


** DEATHS OF THOSE WITH RECTAL CANCER - #9
tab deceased if siteiarc==14 ,m
sort dod
tab dod if deceased==1 & siteiarc==14 ,m
cii proportions 28 20


** DEATHS OF THOSE WITH STOMACH CANCER - #10
tab deceased if siteiarc==11 ,m
sort dod
tab dod if deceased==1 & siteiarc==11 ,m
cii proportions 20 17


** DEATHS OF THOSE WITH NON-HODGKIN LYMPHOMA - #11
tab deceased if siteiarc==53 ,m
sort dod
tab dod if deceased==1 & siteiarc==53 ,m
cii proportions 16 14
	


****************************************************
** Death Info for Top Deaths - Totals by site GROUPS
****************************************************
** Using CR5db groupings found in CI5 editorial tables
gen sitecr5=.
label define sitecr5_lab ///
1 "Lip, oral cavity & pharynx (C00-14)" ///
2 "Digestive organs (C15-26)" ///
3 "Respiratory organs (C30-39)" ///
4 "Bone, cartilage, melanoma (C40-43,45,47,49)" ///
5 "Breast (C50)" ///
6 "Female genital (C51-58)" ///
7 "Male genital (C60-63)" ///
8 "Urinary organs (C64-68)" ///
9 "Eye, brain, thyroid etc (C69-75)" ///
10 "Haematopoietic (C81-96)" ///
11 "Other & unspecified (O&U)" ///
12 "All sites but C44" ///
13 "In-situ/CIN3 (D069)"
label var sitecr5 "CR5 sites"
label values sitecr5 sitecr5_lab

replace sitecr5=1 if (regexm(icd10,"C00")|regexm(icd10,"C01")|regexm(icd10,"C02") ///
					 |regexm(icd10,"C03")|regexm(icd10,"C04")|regexm(icd10,"C05") ///
					 |regexm(icd10,"C06")|regexm(icd10,"C07")|regexm(icd10,"C08") ///
					 |regexm(icd10,"C09")|regexm(icd10,"C10")|regexm(icd10,"C11") ///
					 |regexm(icd10,"C12")|regexm(icd10,"C13")|regexm(icd10,"C14")) //22 changes
replace sitecr5=2 if (regexm(icd10,"C15")|regexm(icd10,"C16")|regexm(icd10,"C17") ///
					 |regexm(icd10,"C18")|regexm(icd10,"C19")|regexm(icd10,"C20") ///
					 |regexm(icd10,"C21")|regexm(icd10,"C22")|regexm(icd10,"C23") ///
					 |regexm(icd10,"C24")|regexm(icd10,"C25")|regexm(icd10,"C26")) //219 changes
replace sitecr5=3 if (regexm(icd10,"C30")|regexm(icd10,"C31")|regexm(icd10,"C32") ///
					 |regexm(icd10,"C33")|regexm(icd10,"C34")|regexm(icd10,"C35") ///
					 |regexm(icd10,"C36")|regexm(icd10,"C37")|regexm(icd10,"C38") ///
					 |regexm(icd10,"C39")) //46 changes
replace sitecr5=4 if (regexm(icd10,"C40")|regexm(icd10,"C41")|regexm(icd10,"C42") ///
					 |regexm(icd10,"C43")|regexm(icd10,"C45")|regexm(icd10,"C47") ///
					 |regexm(icd10,"C49")) //17 changes
replace sitecr5=5 if regexm(icd10,"C50") //157 changes
replace sitecr5=6 if (regexm(icd10,"C51")|regexm(icd10,"C52")|regexm(icd10,"C53") ///
					 |regexm(icd10,"C54")|regexm(icd10,"C55")|regexm(icd10,"C56") ///
					 |regexm(icd10,"C57")|regexm(icd10,"C58")) //68 changes
replace sitecr5=7 if (regexm(icd10,"C60")|regexm(icd10,"C61")|regexm(icd10,"C62")|regexm(icd10,"C63")) //200 changes
replace sitecr5=8 if (regexm(icd10,"C64")|regexm(icd10,"C65")|regexm(icd10,"C66") ///
					 |regexm(icd10,"C67")|regexm(icd10,"C68")) //33 changes
replace sitecr5=9 if (regexm(icd10,"C69")|regexm(icd10,"C70")|regexm(icd10,"C71") ///
					 |regexm(icd10,"C72")|regexm(icd10,"C73")|regexm(icd10,"C74") ///
					 |regexm(icd10,"C75")) //18 changes
replace sitecr5=10 if (regexm(icd10,"C81")|regexm(icd10,"C82")|regexm(icd10,"C83") ///
					 |regexm(icd10,"C84")|regexm(icd10,"C85")|regexm(icd10,"C86") ///
					 |regexm(icd10,"C87")|regexm(icd10,"C88")|regexm(icd10,"C89") ///
					 |regexm(icd10,"C90")|regexm(icd10,"C91")|regexm(icd10,"C92") ///
					 |regexm(icd10,"C93")|regexm(icd10,"C94")|regexm(icd10,"C95") ///
					 |regexm(icd10,"C96")|siteiarc==59|siteiarc==60) //66 changes
replace sitecr5=11 if siteiarc==61 //45 changes
replace sitecr5=13 if siteiarc==64 //23 changes

tab sitecr5 ,m
list pid siteiarc if sitecr5==.

tab siteiarchaem if sitecr5==10 ,m
tab siteiarc if sitecr5==10 ,m

** Check for top 10 deaths by CR5 site
** include O&U; exclude in-situ
preserve
drop if sitecr5==13|deceased!=1 //424 obs deleted
bysort sitecr5: gen n=_N
bysort n sitecr5: gen tag=(_n==1)
replace tag = sum(tag)
sum tag , meanonly
gen top10 = (tag>=(`r(max)'-9))
sum n if tag==(`r(max)'-10), meanonly
replace top10 = 1 if n==`r(max)'
tab sitecr5 top10 if top10!=0
contract sitecr5 top10 if top10!=0, freq(count) percent(percentage)
gsort -count
drop top10 percentage
/*
sitecr5											count
Digestive organs (C15-26)						155
Male genital (C60-63)							69
Breast (C50)									53
Haematopoietic (C81-96)							50
Other & unspecified (O&U)						44
Female genital (C51-58)							38
Respiratory organs (C30-39)						36
Urinary organs (C64-68)							15
Lip, oral cavity & pharynx (C00-14)				13
Bone, cartilage, melanoma (C40-43,45,47,49)		8
Eye, brain, thyroid etc (C69-75)				7
*/
restore


** DEATHS OF THOSE WITH ALL DIGESTIVE CANCERS - #1
tab deceased if sitecr5==2 ,m
sort dod
tab dod if sitecr5==2 ,m
cii proportions 217 155


** DEATHS OF THOSE WITH ALL MALE-RELATED CANCERS - #2
tab deceased if sitecr5==7 ,m
sort dod
tab dod if deceased==1 & sitecr5==7 ,m
cii proportions 200 69


** DEATHS OF THOSE WITH BREAST CANCERS - #3
tab deceased if sitecr5==5 ,m
sort dod
tab dod if deceased==1 & sitecr5==5 ,m
cii proportions 157 53


** DEATHS OF THOSE WITH ALL LYMPH. & HAEM. CANCERS - #4
tab deceased if sitecr5==10 ,m
sort dod
tab dod if deceased==1 & sitecr5==10 ,m
cii proportions 66 50


** DEATHS OF THOSE WITH ALL O&U CANCERS - #5
tab deceased if sitecr5==11 ,m
sort dod
tab dod if deceased==1 & sitecr5==11 ,m
cii proportions 45 44


** DEATHS OF THOSE WITH ALL FEMALE-RELATED CANCERS - #6
tab deceased if sitecr5==6 ,m
sort dod
tab dod if deceased==1 & sitecr5==6 ,m
cii proportions 68 38


** DEATHS OF THOSE WITH ALL RESPIRATORY CANCERS - #7
tab deceased if sitecr5==3 ,m
sort dod
tab dod if deceased==1 & sitecr5==3 ,m
cii proportions 46 36


** DEATHS OF THOSE WITH ALL URINARY CANCERS - #8
tab deceased if sitecr5==8 ,m
sort dod
tab dod if deceased==1 & sitecr5==8 ,m
cii proportions 33 15


** DEATHS OF THOSE WITH ALL LIP/ORAL CAVITY/PHARYNGEAL CANCERS - #9
tab deceased if sitecr5==1 ,m
sort dod
tab dod if deceased==1 & sitecr5==1 ,m
cii proportions 22 13


** DEATHS OF THOSE WITH ALL BONE/CARTILAGE/MELANOMA CANCERS - #10
tab deceased if sitecr5==4 ,m
sort dod
tab dod if deceased==1 & sitecr5==4 ,m
cii proportions 17 8


** DEATHS OF THOSE WITH ALL EYE/BRAIN/THYROID CANCERS - #11
tab deceased if sitecr5==9 ,m
sort dod
tab dod if deceased==1 & sitecr5==9 ,m
cii proportions 18 7



********************************************************************************
** 4.3 Survival analysis - using the DIRECT METHOD
********************************************************************************
** JC 20dec2018: correct method for survival analysis done in 8_survival_da.do
** I didn't update below comments but updated the code to extend to end of 2017
** as it only went up to end of 2016 deaths for 2013 data analysis.

** STEP 1: define a "time to death" variable and keep those with dod in
** 2018 out of the equation
tab dodyear ,m
tab deceased ,m
gen time2death=(dod-dot) if dodyear<2018 //424 missing values generated

tab time2death if deceased==1 & dodyear<2018 ,m
list pid dot dod dodyear if time2death==-5 //JC 20dec18: corrected in dofile 5 of cleaning dofiles
tab basis if time2death==0 ,m
tab basis if time2death==1 ,m
** Note that all those with time2death=0 are those diagnosed at death

sort dod 
tab dod if deceased==1 ,m

** STEP 2: choose date for "end of study" - your interval max being "5 years
** from dx" - get this from a review of date of last contact for living cases:
** JC: for 2013 data interval max would be "3 years from dx" as only have
** death data up to end of 2016
sort dod
list dod deceased 

** Now: all pts seen in 2017 we know were alive on 31-dec-2016 but we do not know 
** if they were still alive on 31-dec-2017. So 31-dec-2016 is selected as the 
** "end date" for the survival analysis. So all patients first seen (dot) before
** (31-dec-2016 - 3), i.e. from 01-jan-2014, should be excluded. As this is a 2013
** dataset, they are indeed excluded.
** The dataset now included people who were AT RISK OF DYING for at least 3 years
** by the end date of the study, which is 31-dec-2016

** STEP 3: estimate the NUMBER AND % of patients who were STILL ALIVE at last
** contact and the number and % who had died by 31-dec-2016
sort dot
list dot dod deceased 

** JC: side note - one (1) pt died in 2017 for 2013 data but pt total remains 
** same at 831
preserve
replace deceased=2 if dod>d(31-dec-2017) //0 changes
count if deceased==2 // 424 survived to 3 years
count if deceased==1 // 488 died within 3 years of dx
count if deceased==1 & ((dod-dot)>((3*365)+1)) // 14
list fname lname dot dod deceased if deceased==1 & ((dod-dot)>((3*365)+1))
** one (1) person who died lived for more than 3 years from their cancer dx
** she only lived 3 yrs + 25 days more from their cancer dx as shown below
** BUT this pt who died lived already 3 years from their cancer dx before death
** Hence the % still alive 3 years from dx was 450/831=54%
** and the % who had died was 381/831=46%

** For 2014, 424/912=46.5% lived already 3yrs from cancer dx before they died
** For 2014, 488/912=53.5% died within 3yrs of cancer dx
restore


** Now looking at 1 year and 2 year survival:
preserve
** for 2 year survival: our end-date will be 31-dec-2015
replace deceased=2 if dod>d(31-dec-2016)
count if deceased==2 // 454 survived to 2 years
count if deceased==1 // 458 died within 2 years of dx
count if deceased==1 & ((dod-dot)>((2*365)+1)) // 24
list fname lname dot dod deceased if deceased==1 & ((dod-dot)>((2*365)+1))
** BUT 12 pts who died lived already 2 years from their cancer dx before death
** Hence the % still alive 2 years from dx was (453+12)/831=56%
** and the % who had died was (378-12)/831=44%

** For 2014, 454/912=49.8% lived already 2yrs from cancer dx before they died
** For 2014, 458/912=50.2% died within 2yrs of cancer dx
restore

preserve
** for 1 year survival: our end-date will be 31-dec-2014
replace deceased=2 if dod>d(31-dec-2015)
count if deceased==2 // 508 survived to 1 year
count if deceased==1 // 404 died within 1 year of dx
count if deceased==1 & ((dod-dot)>((365)+1)) // 34
list fname lname dot dod deceased if deceased==1 & ((dod-dot)>((365)+1))
** BUT 36 pts who died lived already 1 year from their cancer dx before death
** Hence the % still alive 1 year from dx was (490+36)/831=63%
** and the % who had died was (341-36)/831=37%

** For 2014, 508/912=55.7% lived already 1yr from cancer dx before they died
** For 2014, 404/912=44.3% died within 1yr of cancer dx
restore


********************************************************************************
** 4.4 Deaths - numbers and % by site and whether CoD cancer or not
********************************************************************************
tab cod ,m
/*
     COD categories |      Freq.     Percent        Cum.
--------------------+-----------------------------------
     Dead of cancer |        476       52.19       52.19
Dead of other cause |         12        1.32       53.51
                 NA |        424       46.49      100.00
--------------------+-----------------------------------
              Total |        912      100.00
*/
tab cod if deceased==1 & patient==1 ,m
/*
     COD categories |      Freq.     Percent        Cum.
--------------------+-----------------------------------
     Dead of cancer |        476       97.54       97.54
Dead of other cause |         12        2.46      100.00
--------------------+-----------------------------------
              Total |        488      100.00
*/
sort cod1a
tab cod1a if deceased==1 & cod==. ,m
tab cod if deceased==1,m

tab cod if deceased==1 & patient==1 & dodyear<2015 ,m
/*
     COD categories |      Freq.     Percent        Cum.
--------------------+-----------------------------------
     Dead of cancer |        298       98.35       98.35
Dead of other cause |          5        1.65      100.00
--------------------+-----------------------------------
              Total |        303      100.00
*/
tab siteiarc if deceased==1 & patient==1 & dodyear<2015 & cod==1 ,m

** save for graphs in next dofile
save "data\2014_cancer_rx_outcomes_da.dta", replace


** JC: met with AR on 11oct2017 and below code can remain defunct for 2013 ann rpt **
*************** JC: ask AR re below code as I'm not understanding so left in 2008 code **********************
** I used '//' before the code so it's defunct and doesn't run when dofile is executed


********************************************************************************
** Now let's try the actuarial method - the one that gives the survival curve!
********************************************************************************
** STEP 1: calculate the number alive at beginning of year
/*count // 831
tab year deceased ,m
**           |  whether patient is
**   Year of |       deceased
**     death |      dead  alive at  |     Total
**-----------+----------------------+----------
**      2013 |       238          0 |       238 **593
**      2014 |       103          0 |       103 
**      2015 |        37          0 |        37 
**      2016 |         3          0 |         3 
**      2017 |         1          0 |         1 
**         . |         0        449 |       449 
**-----------+----------------------+----------
**     Total |       382        449 |       831 

** JC: ask AR re this code as I don't understand
** below is from 2008 code
dis 1117-252
dis 865-(107+77) 
dis 681-(59+67) 
dis 555-(42+135) 
dis 378-(21+142) 
dis 215-(17+25) 

** JC: below is my own calculation
** at beginning of 2014, 593 (831-238) were alive
** at beginning of 2015, 490 (593-103) were alive
** at beginning of 2016, 453 (490-37) were alive
** at beginning of 2017, 450 (453-3) were alive

** STEP 2: Count number who died during each year
tab year if deceased==1 ,m


** STEP 3: count number seen alive that year
count if dod>d(31-dec-2008) & dod<d(31-dec-2009) & deathdate> d(31-dec-2009)

tab deceased if dod>d(31-dec-2008) & dod<d(31-dec-2009) & deathdate> d(31-dec-2009)
** 5 of this group died - don't include
count if (dod>d(31-dec-2008) & dod<d(31-dec-2009) & deceased==2)
count if dod>d(31-dec-2009) & dod<d(31-dec-2010) & deceased==2
count if dod>d(31-dec-2010) & dod<d(31-dec-2011) & deceased==2
count if dod>d(31-dec-2011) & dod<d(31-dec-2012) & deceased==2
count if dod>d(31-dec-2012) & dod<d(31-dec-2013) & deceased==2
count if dod>d(31-dec-2013) & dod<d(31-dec-2014)

** STEP 4: calculate effective No. exposed to death risk
** this is: No. alive at start of year - (No. last seen alive/2)
dis 1117-(0/2)
dis 865-(77/2)
dis 681-(67/2)
dis 555-(135/2)
dis 378-(142/2)
dis 215-(25/2)

** STEP 5: calculate % dying during year
** This is: No. dying during year / effective No. exposed to death
dis 252/1117.0
dis 107/826.5
dis 59/647.5
dis 42/487.5
dis 21/307.0
dis 17/202.5

** STEP 6: calculate % surviving each year
** This is 1- the % who died (previous step)
dis 1-(252/1117.0)
dis 1-(108/826.5)
dis 1-(59/647.5)
dis 1-(42/487.5)
dis 1-(21/307.0)
dis 1-(17/202.5)

** STEP 7: calculate % surviving from dx to yearend each year
** this is the PRODUCT of the % who survived in each year to that year
dis 0.774*0.871
dis 0.774*0.871*0.909
dis 0.774*0.871*0.909*0.914
dis 0.774*0.871*0.909*0.914*0.932
dis 0.774*0.871*0.909*0.914*0.932*0.916


** Now do the survival curve based on figures from Step 7
** (% surviving from dx to each yearend)
preserve
drop _all
input type year surv 
1	0	77.4
2	1	67.4
3	2	61.3
4	3	56.0
5	4	52.2
6	5	47.8
end

** GRAPHIC
label var surv "Survival from cancer diagnosed in 2008"
#delimit ;
	gr twoway 
		  (line surv year , m(S) mfc(gs0) mlc(gs0) msize(*2) )
		  ,
			/// plotregion(c(gs16) ic(gs16) ilw(thin) lw(thin)) 
			plotregion(color(white) ic(white) ilw(thin) lw(thin)) 
			graphregion(color(white) ic(white) ilw(thin) lw(thin))  
			ysize(2)

			///xline(78.9, lc(red) ///lp("-")
			
			xlab(0(1)5, 
			labs(vlarge) nogrid glc(gs14) angle(0) labgap(1))
			xscale( lw(vthin) lc(blue*0.15)) xtitle("", margin(t=4) size(medium)) 
			xmtick(0(1)5)
			xtitle("Years since diagnosis", margin(r=3) size(large))
			ylab(40(10)100.0,
			labs(vlarge) nogrid glc(gs14) angle(0) format(%9.0f))
			ytitle("Proportion surviving", margin(r=3) size(large))
			ymtick(50(10)100)

			legend(off bexpand size(small) position(12) bm(t=1 b=0 l=0 r=0) colf cols(5)
			region(fcolor(gs16) lw(vthin) margin(l=2 r=2 t=2 b=2)) order(2 1)
			lab(2 "")
			lab(1 "")
			);
#delimit cr	
restore



** mean (403 days) and median (175 days) survival
** there are 5 

ameans time2death
ameans time2death if site==6

gen k=1
table k, c(p50 time2death p25 time2death p75 time2death min time2death max time2death)


preserve
gen k=1
drop if site!=6
table k, c(p50 time2death p25 time2death p75 time2death min time2death max time2death)
restore
********************************************************************************
** Now let's do the actuarial 5-yr survival for each of the main sites
********************************************************************************
** I realised easier way to make code defunct '/**/' lol


** breast (site=14), prostate (site=19), colorectal (site=3+4+5), NMSC (site=12)
** stomach (site=2), cervix & uterus (site=15+16), blood & BM (site=10)

** STEP 1: calculate the number alive at beginning of year
count if site==14 // 142
count if site==19 // 208
count if (site==3 | site==4 | site==5) // 146
count if site==12 // 228
count if site==2 // 32
count if site==15 | site==16 // 93
count if site==10 // 42
count if site==8 // 40

** subtractions all done automatically in Excel
** STEP 2: Count number who died during each year
tab year if deceased==1 & site ==14 ,m
tab year if deceased==1 & site ==19 ,m
tab year if deceased==1 & (site==3 | site==4 | site==5) ,m
tab year if deceased==1 & site ==12 ,m
tab year if deceased==1 & site ==2 ,m
tab year if deceased==1 & (site ==15 | site==16) ,m
tab year if deceased==1 & site ==10 ,m
tab year if deceased==1 & site ==8 ,m


** STEP 3: count number seen alive that year
** here we assume it's those who were not dead! (but they fudge it in a later column)
tab deceased if dod>d(31-dec-2008) & dod<d(31-dec-2009) & deathdate> d(31-dec-2009)
** don't include those of this group who died
count if (dod>d(31-dec-2008) & dod<d(31-dec-2009) & deceased==2) & site==14
count if dod>d(31-dec-2009) & dod<d(31-dec-2010) & deceased==2 & site==14
count if dod>d(31-dec-2010) & dod<d(31-dec-2011) & deceased==2 & site==14
count if dod>d(31-dec-2011) & dod<d(31-dec-2012) & deceased==2 & site==14
count if dod>d(31-dec-2012) & dod<d(31-dec-2013) & deceased==2 & site==14

count if (dod>d(31-dec-2008) & dod<d(31-dec-2009) & deceased==2) & site==19
count if dod>d(31-dec-2009) & dod<d(31-dec-2010) & deceased==2 & site==19
count if dod>d(31-dec-2010) & dod<d(31-dec-2011) & deceased==2 & site==19
count if dod>d(31-dec-2011) & dod<d(31-dec-2012) & deceased==2 & site==19
count if dod>d(31-dec-2012) & dod<d(31-dec-2013) & deceased==2 & site==19

count if (dod>d(31-dec-2008) & dod<d(31-dec-2009) & deceased==2) &(site==3 | site==4 | site==5) 
count if dod>d(31-dec-2009) & dod<d(31-dec-2010) & deceased==2 & (site==3 | site==4 | site==5) 
count if dod>d(31-dec-2010) & dod<d(31-dec-2011) & deceased==2 & (site==3 | site==4 | site==5) 
count if dod>d(31-dec-2011) & dod<d(31-dec-2012) & deceased==2 & (site==3 | site==4 | site==5) 
count if dod>d(31-dec-2012) & dod<d(31-dec-2013) & deceased==2 & (site==3 | site==4 | site==5) 

count if (dod>d(31-dec-2008) & dod<d(31-dec-2009) & deceased==2) & site==12
count if dod>d(31-dec-2009) & dod<d(31-dec-2010) & deceased==2 & site==12
count if dod>d(31-dec-2010) & dod<d(31-dec-2011) & deceased==2 & site==12
count if dod>d(31-dec-2011) & dod<d(31-dec-2012) & deceased==2 & site==12
count if dod>d(31-dec-2012) & dod<d(31-dec-2013) & deceased==2 & site==12

count if (dod>d(31-dec-2008) & dod<d(31-dec-2009) & deceased==2) & site==2
count if dod>d(31-dec-2009) & dod<d(31-dec-2010) & deceased==2 & site==2
count if dod>d(31-dec-2010) & dod<d(31-dec-2011) & deceased==2 & site==2
count if dod>d(31-dec-2011) & dod<d(31-dec-2012) & deceased==2 & site==2
count if dod>d(31-dec-2012) & dod<d(31-dec-2013) & deceased==2 & site==2

count if (dod>d(31-dec-2008) & dod<d(31-dec-2009) & deceased==2) & (site==15 | site==16)
count if dod>d(31-dec-2009) & dod<d(31-dec-2010) & deceased==2 & (site==15 | site==16)
count if dod>d(31-dec-2010) & dod<d(31-dec-2011) & deceased==2 & (site==15 | site==16)
count if dod>d(31-dec-2011) & dod<d(31-dec-2012) & deceased==2 & (site==15 | site==16)
count if dod>d(31-dec-2012) & dod<d(31-dec-2013) & deceased==2 & (site==15 | site==16)

count if (dod>d(31-dec-2008) & dod<d(31-dec-2009) & deceased==2) & site==10
count if dod>d(31-dec-2009) & dod<d(31-dec-2010) & deceased==2 & site==10
count if dod>d(31-dec-2010) & dod<d(31-dec-2011) & deceased==2 & site==10
count if dod>d(31-dec-2011) & dod<d(31-dec-2012) & deceased==2 & site==10
count if dod>d(31-dec-2012) & dod<d(31-dec-2013) & deceased==2 & site==10

count if (dod>d(31-dec-2008) & dod<d(31-dec-2009) & deceased==2) & site==8
count if dod>d(31-dec-2009) & dod<d(31-dec-2010) & deceased==2 & site==8
count if dod>d(31-dec-2010) & dod<d(31-dec-2011) & deceased==2 & site==8
count if dod>d(31-dec-2011) & dod<d(31-dec-2012) & deceased==2 & site==8
count if dod>d(31-dec-2012) & dod<d(31-dec-2013) & deceased==2 & site==8



************************************************************************************
** This is what I did before - not right I don't think - too simplistic for survival
************************************************************************************
/*
* DEATH
gen stat1 = deceased if year<2014
replace stat1=0 if stat1==.
tab stat1 ,m
label var stat1 "Failure = death"

** STATUS (1=dead)
label define stat 0 "alive" 1 "dead",modify
label values stat1 stat

** Set as one survival dataset

** Set using death as the "failure"
stset time2death, fail(stat1)
stdes
stsum
sts gen s1 = s
sts gen lb1 = lb(s)
sts gen ub1 = ub(s)
** List to get median + 95% CI
sort _t
list _t s1 lb1 ub1

/*
** Set with failure as discharge
stset time2death, fail(stat0)
stdes
stsum
sts gen s0 = s
sts gen lb0 = lb(s)
sts gen ub0 = ub(s)
sort _t
list _t s0 lb0 ub0
*/

** GRAPHIC
label var s1 "Death from cancer"
#delimit ;
	sts graph, ploto(lp("l") lc(gs0) lw(thin))
		graphregion(fcolor(gs16) )
		xtitle("Days of survival", color(gs0) margin(t=3) size(medlarge))
		addplot(line s1 _t, sort c(J) lp("-") lc(gs0) lw(thin))
		title("")
		ylab(,angle(0) nogrid)
		xmtick(0(100)2000)
		legend(off);
#delimit cr
*/



************
** Note: on checking time2death for pancreatic cancer I noticed a discepancy
** which has since been corrected...
tab time2death if deceased==1 ,m
tab time2death if deceased==1 & site==6 ,m
list if time2death>100 & deceased==1 & site==6 

** I checked the outlier (tumourid 200809390101: exactly a year on from dx to death) - seemed odd as it
** was a DCO so got SAF to check and it was an error - has now been removed
*/



**************************************
** 4.1 Treatment (all types)
**************************************
** JC 20dec2018: below treatment code disused for 2014 data as rx was not collected.

/*
save "data\2013_updated_cancer_dataset_site.dta", replace

list eid treatment2 date_rx2 if treatment2==0 & date_rx2!=. //none as of 09oct2017
list eid treatment3 date_rx3 if treatment3==0 & date_rx3!=. //none as of 09oct2017
list eid treatment4 date_rx4 if treatment4==0 & date_rx4!=. //none as of 09oct2017

tab treatment1 ,m
tab treatment1 if site==14 ,m // BC treatment

tab treatment1 if (treatment1<9)

tab treatment1 if (treatment1<9 & treatment1!=0)

** AR to JC: better to use 581 as denominator as those are all for whom we have
** Rx info. - the rest we don't know if they had Rx or not, so hard to tell and
** therefore we exclude from denominator
dis 581/846 // Rx info. available
dis 458/581 //had treatment (of all those with info. available) 
dis 265/846 //unknown if had treatment 
dis 123/846 //had no treatment 

** other treatment received from usual list above (choices)
tab othertreatment1 if treatment1==8 ,m

dis 32/458 //palliative 7.0% as of 09oct2017
dis 6/458 //treated abroad 1.3% as of 09oct2017

** other treatment received from usual list above (text)
tab othertreatment2 ,m

sort treatment1 othertreatment1 treatment2 treatment3 treatment4 othertreatment2
list treatment1 othertreatment1 treatment2 treatment3 treatment4 othertreatment2 ///
	 if (treatment1!=9 & treatment1!=0)


** reasons for having no treatment
tab notreatment1 notreatment2 if treatment1==0 ,m

** reasons for having no treatment
tab notreatment2 ,m

** other treatments
tab treatment2 if (treatment2<9 & treatment2!=0)

tab treatment3 if (treatment3<9 & treatment3!=0)

tab treatment4 if (treatment4<9 & treatment4!=0)

** No-one in this dataset had 5 rounds of treatment
tab treatment5 ,m

** to find the frequency of any number of treatments (1-4)
gen any_surg=1 if (treatment1==1 | treatment2==1 | treatment3==1 | treatment4==1)
tab any_surg 

gen any_rt=1 if (treatment1==2 | treatment2==2 | treatment3==2 | treatment4==2)
tab any_rt

gen any_chemo=1 if (treatment1==3 | treatment2==3 | treatment3==3 | treatment4==3)
tab any_chemo

gen any_it=1 if (treatment1==4 | treatment2==4 | treatment3==4 | treatment4==4) 
tab any_it

gen any_ht=1 if (treatment1==5 | treatment2==5 | treatment3==5 | treatment4==5)
tab any_ht

gen any_oth=1 if (treatment1==8 | treatment2==8 | treatment3==8 | treatment4==8)
tab any_oth

tab othertreatment1 if any_oth==1 ,m

tab1 any* if (treatment1 !=0 & treatment1!=. & treatment1!=9)

** # with 4 treatments
count if ((treatment1>0 & treatment1<9) & (treatment2>0 & treatment2<9) & ///
		 (treatment3>0 & treatment3<9) & (treatment4>0 & treatment4<9))
		 
** # with 3 treatments		 
count if ((treatment1>0 & treatment1<9) & (treatment2>0 & treatment2<9) & ///
		 (treatment3>0 & treatment3<9) & (treatment4==.))

** # with 2 treatments		 
count if ((treatment1>0 & treatment1<9) & (treatment2>0 & treatment2<9) & ///
		 (treatment3==.) & (treatment4==.))	 
		 
sort treatment*		 
list treatment*		 
		 
		 
*************************************************
** The % of pts who had Rx1 within 4 months of dx
*************************************************

gen rx1_time=date_rx1-dot if (treatment1!=. & treatment1!=9 & treatment1!=0) //389 missing values generated as of 09oct2017
tab rx1_time if (treatment1!=. & treatment1!=9 & treatment1!=0) ,m

** Note that we have some negative values... need to be checked:
sort eid dot
count if rx1_time<0 //19 as of 09oct2017; corrections done in '2_section1.do'
list eid date_rx1 date_rx2 date_rx3 date_rx4 dot dod if rx1_time<0
** 55 of these are incidental so rx1_time==0

** First check how many were DCOs
sort basis
list  eid date_rx1 basis histol treatment1 dot dod if rx1_time<0
tab date_rx1 ,m
** Now just exclude the incidentals from the analyses
tab rx1_time ,m

** NOTE: IARC rules state that DCOs without further info should take incidence date
** as deathdate NOT histology report date...
sort basis
count if rx1_time==0 //55 as of 09oct2017
list eid dot treatment1 date_rx1 treatment2 date_rx2 dod basis if rx1_time==0
** Good - none of these 55 are DCOs

replace rx1_time=date_rx1-dot if (treatment1!=. & treatment1!=9 & treatment1!=0 & rx1_time==.)


save "data\2013_updated_cancer_dataset_site_cod.dta", replace

use "data\2013_updated_cancer_dataset_site_cod.dta",clear


** OK here is the plan:
** (1) exclude all those with rx1_time<0 
** (2) also exclude all those with rx1_time=0 and estimate
**	   median time to Rx1 for all
** all below figures are as of 09oct2017

preserve
** (1) exclude all with time<0
count if rx1_time!=. // 458
drop if (rx1_time==. & treatment1>0 & treatment1<9) 
drop if rx1_time<0 

** (2) also drop if time==0
drop if rx1_time==0 

** now drop all missing times
drop if rx1_time==. 
count // 403

** For ALL cancers
count // 403
tab site ,m
ameans rx1_time
gen k=1
table k, c(p50 rx1_time p25 rx1_time p75 rx1_time min rx1_time max rx1_time) // 50 days

** For BC
drop if site!=14 
count // 95
ameans rx1_time
table k, c(p50 rx1_time p25 rx1_time p75 rx1_time min rx1_time max rx1_time) // 50 days

** Now for % being treated within first 4 months:
count if rx1_time<(30*4) // 76
count // 95
dis 76/95 
cii 95 76

** Now for % being treated within first 4 weeks:
count if rx1_time<(7*4) // 24
count // 95
dis 24/95 
cii 95 24
restore


preserve
** (1) exclude all with time<0
count if rx1_time!=. // 458
drop if (rx1_time==. & treatment1>0 & treatment1<9) 
drop if rx1_time<0 

** (2) also drop if time==0
drop if rx1_time==0 

** now drop all missing times
drop if rx1_time==. 
count // 403

** For PC
drop if site!=19
count // 52
ameans rx1_time
gen k=1
table k, c(p50 rx1_time p25 rx1_time p75 rx1_time min rx1_time max rx1_time) 

** Now for % being treated within first 4 months:
count if rx1_time<(30*4) // 32
count // 52
dis 32/52 
cii 52 32
restore


preserve
** (1) exclude all with time<0
count if rx1_time!=. // 458
drop if (rx1_time==. & treatment1>0 & treatment1<9) 
drop if rx1_time<0 

** (2) also drop if time==0 
drop if rx1_time==0 

** now drop all missing times
drop if rx1_time==. 
count // 403

** For Colorectal (site=3 & 4 & 5)
drop if (site<3  | site>5)
count // 100
ameans rx1_time 
gen k=1
table k, c(p50 rx1_time p25 rx1_time p75 rx1_time min rx1_time max rx1_time)

** Now for % being treated within first 4 months:
count if rx1_time<(30*4) // 91
count // 100
dis 91/100 
cii 100 91

** Now for % being treated within first 4 weeks colorectal:
/*count if rx1_time<(30) // 53
count // 100
dis 53/100 // 53%!!!
cii 100 53
** Now for % being treated within first 4 weeks just colon:
drop if site==5
count if rx1_time<(30) // 51
count // 83
dis 51/83 // 61%!!!
cii 83 51
*/
restore


preserve
** (1) exclude all with time<0
count if rx1_time!=. // 458
drop if (rx1_time==. & treatment1>0 & treatment1<9) 
drop if rx1_time<0 

** (2) also drop if time==0 
drop if rx1_time==0 

** now drop all missing times
drop if rx1_time==. 
count // 403

** For lymphoid & blood (site=10)
drop if (site!=10)
count // 30
ameans rx1_time
gen k=1
table k, c(p50 rx1_time p25 rx1_time p75 rx1_time min rx1_time max rx1_time)

** Now for % being treated within first 4 months:
count if rx1_time<(30*4) // 27
count // 30
dis 27/30 
cii 30 27
restore


preserve
** (1) exclude all with time<0
count if rx1_time!=. // 458
drop if (rx1_time==. & treatment1>0 & treatment1<9) 
drop if rx1_time<0 

** (2) also drop if time==0 
drop if rx1_time==0 

** now drop all missing times
drop if rx1_time==. 
count // 403

** For urinary (site=20)
drop if (site!=20)
count // 13
ameans rx1_time
gen k=1
table k, c(p50 rx1_time p25 rx1_time p75 rx1_time min rx1_time max rx1_time)

** Now for % being treated within first 4 months:
count if rx1_time<(30*4) // 10
count // 13
dis 10/13 
cii 13 10
restore


preserve
** (1) exclude all with time<0
count if rx1_time!=. // 458
drop if (rx1_time==. & treatment1>0 & treatment1<9) 
drop if rx1_time<0 

** (2) also drop if time==0 
drop if rx1_time==0 

** now drop all missing times
drop if rx1_time==. 
count // 403

** For  cervix & uterus (site=15 & 16)
drop if (site<15 | site>16)
count // 49
ameans rx1_time
gen k=1
table k, c(p50 rx1_time p25 rx1_time p75 rx1_time min rx1_time max rx1_time)

** Now for % being treated within first 4 months:
count if rx1_time<(30*4) // 30
count // 49
dis 30/49
cii 49 30

** now just cervix
drop if (site<15 | site>15)
count // 30
ameans rx1_time
table k, c(p50 rx1_time p25 rx1_time p75 rx1_time min rx1_time max rx1_time)

** Now for % being treated within first 4 months:
count if rx1_time<(30*4) // 14
count // 30
dis 14/30 
cii 30 14
restore

preserve
** now just uterus
** (1) exclude all with time<0
count if rx1_time!=. // 458
drop if (rx1_time==. & treatment1>0 & treatment1<9) 
drop if rx1_time<0 

** (2) also drop if time==0 
drop if rx1_time==0 

** now drop all missing times
drop if rx1_time==. 
count // 403

** For  uterus (site=16)
drop if (site<16 | site>16)
count // 19
ameans rx1_time 
gen k=1
table k, c(p50 rx1_time p25 rx1_time p75 rx1_time min rx1_time max rx1_time) 

** Now for % being treated within first 4 months:
count if rx1_time<(30*4) // 16
count // 19
dis 16/19 
cii 19 16
restore


preserve
** (1) exclude all with time<0
count if rx1_time!=. // 458
drop if (rx1_time==. & treatment1>0 & treatment1<9) 
drop if rx1_time<0 

** (2) also drop if time==0 
drop if rx1_time==0 

** now drop all missing times
drop if rx1_time==. 
count // 403

** For respiratory (site=8)
drop if (site!=8)
count // 10
ameans rx1_time
gen k=1
table k, c(p50 rx1_time p25 rx1_time p75 rx1_time min rx1_time max rx1_time)

** Now for % being treated within first 4 months:
count if rx1_time<(30*4) // 8
count // 10
dis 8/10
cii 10 8
restore


preserve
** (1) exclude all with time<0
count if rx1_time!=. // 458
drop if (rx1_time==. & treatment1>0 & treatment1<9) 
drop if rx1_time<0 

** (2) also drop if time==0
drop if rx1_time==0 

** now drop all missing times
drop if rx1_time==. 
count // 403

** For lip, oral cavity & pharynx (site==1)
drop if site!=1
count // 52
ameans rx1_time
gen k=1
table k, c(p50 rx1_time p25 rx1_time p75 rx1_time min rx1_time max rx1_time) 

restore


preserve
** (1) exclude all with time<0
count if rx1_time!=. // 458
drop if (rx1_time==. & treatment1>0 & treatment1<9) 
drop if rx1_time<0 

** (2) also drop if time==0 
drop if rx1_time==0

** now drop all missing times
drop if rx1_time==. 
count // 403

** For all other sites
drop if (site==1 | (site>2 & site<6) | site==8 | site==10 | (site>13 & site<17) | site==19 | site==20)
count // 54
ameans rx1_time
gen k=1
table k, c(p50 rx1_time p25 rx1_time p75 rx1_time min rx1_time max rx1_time)

** Now for % being treated within first 4 months:
count if rx1_time<(30*4) // 43
count // 54
dis 43/54
cii 54 43
restore

** JC: I added in the below 'save' and 'use' as the next set of code deletes the 15 MPs
save "data\2013_updated_cancer_dataset_site_rx.dta", replace

use "data\2013_updated_cancer_dataset_site_rx.dta",clear
*/



