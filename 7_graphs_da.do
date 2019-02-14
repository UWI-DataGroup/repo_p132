** This is the seventh *do* file to be called by the master file.

 ******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *                                                              
 *  DO FILE: 		7_graphs_da
 *					7th dofile:  Graphs for annual report
 *								  - Fig.1: Tumours by month and sex
 *	 							  - Fig 2: los/survival already done in 5_rx_outcomes.do
 *	 							  - Fig 3: COD as bar chart (cancer vs non-cancer vs NK)
 *	 							  - Fig 4: death by site
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

log using "logfiles\7_graphs_2014_da.smcl", replace

** Automatic page scrolling of output
set more off


* ************************************************************************
* ANALYSIS: GRAPHS: ALL for Annual Report
* Covering
* Fig 1: Tumours by month and sex 
** EXTRA FOR TM PRESENTATION CARPHA 2015: Tumours by age-group and sex
** also do patients by age-group and sex as not sure which she prefers
* Note: Fig 2: los/survival already done in 5_section4
* Fig 3: CoD as bar chart (cancer vs non-cancer vs NK)
* Fig 4: death by site
*
***********************************************************************
** Fig 1: Graph of numbers of tumours by month (men and women combined)
***********************************************************************
** Change dataset to one without population data

** Fig. 1.: Graph of numbers of events by month (men and women combined)
** For this chart, we need the dataset without population data
use "data\2014_cancer_rx_outcomes_da.dta", clear

preserve
collapse (sum) case , by(monset sex)
rename monset month

** New month variable with shifted columns for men
** Shift is one-half the width of the bars (which has been set at 0.5 in graph code)
gen monthnew = month
replace monthnew = month+0.25 if sex==2
label define monthnew_lab 1 "Jan" 2 "Feb" 3 "Mar" 4 "Apr" 5 "May" 6 "Jun" 7 "Jul" /// 
				  8 "Aug" 9 "Sep" 10 "Oct" 11 "Nov" 12 "Dec" ,modify
label values monthnew monthnew_lab

sort sex monthnew
** JC: see line 93: changed highest number from 85 to 50, as fewer cases here (graph looks better!)
#delimit ;
graph twoway 	(bar case monthnew if sex==2, yaxis(1) col(lavender) barw(0.5) )
				(bar case monthnew if sex==1, yaxis(1) col(magenta*0.5)  barw(0.5) ),
			/// Making background completely white
			plotregion(c(gs16) ic(gs16) ilw(thin) lw(thin)) 
			graphregion(color(gs16) ic(gs16) ilw(thin) lw(thin)) 
			/// and insist on a long thin graphic
			ysize(2)
			
	       	xlabel(1 2 3 4 5 6 7 8 9 10 11 12, valuelabel
	       	labs(large) nogrid glc(gs12) angle(45))
	       	xtitle("Month", size(large) margin(t=3)) 
			xscale(range(1(1)12))
			xmtick(1(1)12)

			ylab(0(10)50, labs(large) nogrid glc(gs12) angle(0) format(%9.0f))
	       	ytitle("Number of tumours", size(large) margin(r=3)) 
			ymtick(0(5)50)
			
			/// Legend information
			legend(size(medlarge) nobox position(11) colf cols(2)
			region(color(gs16) ic(gs16) ilw(thin) lw(thin)) order(1 2)
			lab(1 "Number of tumours (men)") 
			lab(2 "Number of tumours (women)")
			);
#delimit cr
restore

**********************
** Now repeat but with age-group as x-axis instead of month
preserve
collapse (sum) case , by(age_10 sex)
rename age_10 agegrp

** New agegrp variable with shifted columns for men
** Shift is one-half the width of the bars (which has been set at 0.5 in graph code)
gen agenew = agegrp
replace agenew = agegrp+0.25 if sex==2
label define agenew_lab 1 "0-14" 2 "15-24" 3 "25-34" 4 "35-44" 5 "45-54" 6 "55-64" 7 "65-74" /// 
				  8 "75-84" 9 "85 & over" ,modify
label values agenew agenew_lab

sort sex agenew

#delimit ;
graph twoway 	(bar case agenew if sex==2, yaxis(1) col(orange) barw(0.5) )
				(bar case agenew if sex==1, yaxis(1) col(blue*1.5)  barw(0.5) ),
			/// Making background completely white
			plotregion(c("231 231 240") ic("231 231 240") ilw(thin) lw(thin)) 
			graphregion(color("231 231 240") ic("231 231 240") ilw(thin) lw(thin)) 
			/// and insist on a long thin graphic
			ysize(2)
			
	       	xlabel(1 2 3 4 5 6 7 8 9, valuelabel
	       	labs(large) nogrid glc(gs12) angle(45))
	       	xtitle("Age-group (years)", size(large) margin(t=3)) 
			xscale(range(1(1)9))
			xmtick(1(1)9)

			ylab(0(30)180, labs(large) nogrid glc(gs12) angle(0) format(%9.0f))
	       	ytitle("Number of tumours", size(large) margin(r=3)) 
			ymtick(0(15)180)
			
			/// Legend information
			legend(size(medlarge) nobox position(11) colf cols(2)
			region(color("231 231 240") ic("231 231 240") ilw(thin) lw(thin)) order(1 2)
			lab(1 "Number of tumours (men)") 
			lab(2 "Number of tumours (women)")
			);
#delimit cr
restore


**********************
** Now repeat but with age-group but using PATIENTS not tumours
preserve
drop if patient==2
collapse (sum) case , by(age_10 sex)
rename age_10 agegrp

** New agegrp variable with shifted columns for men
** Shift is one-half the width of the bars (which has been set at 0.5 in graph code)
gen agenew = agegrp
replace agenew = agegrp+0.25 if sex==2
label define agenew_lab 1 "0-14" 2 "15-24" 3 "25-34" 4 "35-44" 5 "45-54" 6 "55-64" 7 "65-74" /// 
				  8 "75-84" 9 "85 & over" ,modify
label values agenew agenew_lab

sort sex agenew

#delimit ;
graph twoway 	(bar case agenew if sex==2, yaxis(1) col(lavender) barw(0.5) )
				(bar case agenew if sex==1, yaxis(1) col(magenta*0.5)  barw(0.5) ),
			/// Making background completely white
			plotregion(c(gs16) ic(gs16) ilw(thin) lw(thin)) 
			graphregion(color(gs16) ic(gs16) ilw(thin) lw(thin)) 
			/// and insist on a long thin graphic
			ysize(2)
			
	       	xlabel(1 2 3 4 5 6 7 8 9, valuelabel
	       	labs(large) nogrid glc(gs12) angle(45))
	       	xtitle("Age-group (years)", size(large) margin(t=3)) 
			xscale(range(1(1)9))
			xmtick(1(1)9)

			ylab(0(30)180, labs(large) nogrid glc(gs12) angle(0) format(%9.0f))
	       	ytitle("Number of tumours", size(large) margin(r=3)) 
			ymtick(0(15)180)
			
			/// Legend information
			legend(size(medlarge) nobox position(11) colf cols(2)
			region(color(gs16) ic(gs16) ilw(thin) lw(thin)) order(1 2)
			lab(1 "Number of patients (men)") 
			lab(2 "Number of patients (women)")
			);
#delimit cr
restore

*** 
** Now do breast and prostate cancer by age-group - just for tumours
preserve
drop if siteiarc!=29 // BC
collapse (sum) case , by(age_10)
rename age_10 agegrp
sort agegrp

#delimit ;
graph twoway (bar case agegrp , yaxis(1) col(magenta*0.5)  barw(0.5) ),
			/// Making background completely white
			plotregion(c(gs16) ic(gs16) ilw(thin) lw(thin)) 
			graphregion(color(gs16) ic(gs16) ilw(thin) lw(thin)) 
			/// and insist on a long thin graphic
			ysize(2)
			
	       	xlabel(1 2 3 4 5 6 7 8 9, valuelabel
	       	labs(large) nogrid glc(gs12) angle(45))
	       	xtitle("Age-group (years)", size(large) margin(t=3)) 
			xscale(range(1(1)9))
			xmtick(1(1)9)

			ylab(0(5)30, labs(large) nogrid glc(gs12) angle(0) format(%9.0f))
	       	ytitle("Number of tumours", size(large) margin(r=3)) 
			ymtick(0(5)30)
			
			/// Legend information
			legend(size(medlarge) nobox position(11) colf cols(1)
			region(color(gs16) ic(gs16) ilw(thin) lw(thin)) order(1)
			lab(1 "Number of tumours (women)")
			);
#delimit cr
restore

preserve
drop if siteiarc!=39 // PC
collapse (sum) case , by(age_10)
rename age_10 agegrp
sort agegrp

#delimit ;
graph twoway (bar case agegrp , yaxis(1) col(lavender)  barw(0.5) ),
			/// Making background completely white
			plotregion(c(gs16) ic(gs16) ilw(thin) lw(thin)) 
			graphregion(color(gs16) ic(gs16) ilw(thin) lw(thin)) 
			/// and insist on a long thin graphic
			ysize(2)
			
	       	xlabel(1 2 3 4 5 6 7 8 9, valuelabel
	       	labs(large) nogrid glc(gs12) angle(45))
	       	xtitle("Age-group (years)", size(large) margin(t=3)) 
			xscale(range(1(1)9))
			xmtick(1(1)9)

			ylab(0(10)80, labs(large) nogrid glc(gs12) angle(0) format(%9.0f))
	       	ytitle("Number of tumours", size(large) margin(r=3)) 
			ymtick(0(5)80)
			
			/// Legend information
			legend(size(medlarge) nobox position(11) colf cols(1)
			region(color(gs16) ic(gs16) ilw(thin) lw(thin)) order(1)
			lab(1 "Number of tumours (men)")
			);
#delimit cr
restore



********************************************************************************
** Fig. 3 causes of death as bar chart: cancer, non-cancer, NK
********************************************************************************

preserve
use "data\2014_cancer_rx_outcomes_da.dta", clear
sort sex cod
keep if deceased==1 & dodyear<2018
collapse (sum) case , by(cod)
recode cod 9=3
label define cod2_lab 1 "cancer" 2 "non-cancer" 3 "unknown"
label values cod cod2_lab

#delimit ;
graph twoway 	(bar case cod , yaxis(1) col("255 150 30") barw(0.5) ),
			/// Making background grey
			plotregion(c("231 231 240") ic("231 231 240") ilw(thin) lw(thin)) 
			graphregion(color("231 231 240") ic("231 231 240") ilw(thin) lw(thin)) 
			/// and insist on a long thin graphic
			ysize(2)
			
	       	xlabel(1 2 3 , valuelabel
		
	       	labs(large) nogrid glc("231 231 240") angle(0))
	       	xtitle("Cause of death", size(vlarge) margin(t=3)) 
			//xscale(range(1(1)3))
			//xmtick(1(1)3)

			ylab(0(100)400, labs(large) nogrid glc(gs12) angle(0) format(%9.0f))
	       	ytitle("Number of tumours", size(large) margin(r=3)) 
			ymtick(0(50)400)
			
			/// Legend information
			legend(off size(medlarge) nobox position(11) colf cols(2)
			region(color(gs16) ic(gs16) ilw(thin) lw(thin)) order(1 2)
			lab(1 "Number of tumours (men)") 
			lab(2 "Number of tumours (women)")
			);
#delimit cr

restore


********************************************************************************
** Fig. 4 death by specific site
********************************************************************************

preserve
use "data\2014_cancer_rx_outcomes_da.dta", clear
sort sex siteiarc
keep if deceased==1 & dodyear<2018
drop if cod!=1
collapse (sum) case , by(siteiarc)
sort siteiarc

** These will be difficult to show on a chart so let's re-input into more
** amenable names

drop _all
input id site2 case
1	1	85	// colorectal (colon 65, rectum 19, anus 1)
2	2	37  // uterus (1), cervix (7), corpus (22), other female genital organs (7)
3   3   50	// lymphoid/blood (50)
4	4	66	// prostate (64), msg (2)
5	5	46  // stomach (17), other digestive organs (29)
6	6	51	// breast (51)
7   7   35  // respiratory and intra-thoracic (35)
8   8   20  // pancreas (20)
9   9   13  // head & neck (lip etc.)(13)
10  10  15  // urinary tract (15)
11  11  15  // brain (4) bone/skin/tissue (8) thyroid (3)
12  12  43  // o&u (43)
end

sort site2
label define site2_lab 1 "Colorectal" 2 "Uterus, OFG" 3 "Prostate, OMG" 4 "Lymph/blood" ///
					   5 "Stomach+other GI" 6 "Breast" 7 "Respiratory" ///
					   8 "Pancreas" 9 "Head & Neck"  10 "Urinary tract" ///
					   11 "Brain/Bone/Skin/Thyroid" 12 "O&U"
label values site2 site2_lab

#delimit ;
graph twoway 	(bar case site if site<7 , yaxis(1) col(lavender) barw(0.5) ),
			/// Making background completely white
			plotregion(c(gs16) ic(gs16) ilw(thin) lw(thin)) 
			graphregion(color(gs16) ic(gs16) ilw(thin) lw(thin)) 
			/// and insist on a long thin graphic
			ysize(2)
			
	       	xlabel(1 2 3 4 5 6, valuelabel
		
	       	labs(large) nogrid glc(gs12) angle(0))
	       	xtitle("", size(vlarge) margin(t=3)) 
			//xscale(range(1(1)3))
			//xmtick(1(1)3)

			ylab(0(20)80, labs(large) nogrid glc(gs12) angle(0) format(%9.0f))
	       	ytitle("Number of tumours", size(large) margin(r=3)) 
			ymtick(0(10)80)
			
			/// Legend information
			legend(off size(medlarge) nobox position(11) colf cols(2)
			region(color(gs16) ic(gs16) ilw(thin) lw(thin)) order(1 2)
			lab(1 "Number of tumours (men)") 
			lab(2 "Number of tumours (women)")
			);
#delimit cr



#delimit ;
graph twoway 	(bar case site if site>6 , yaxis(1) col(lavender) barw(0.5) ),
			/// Making background completely white
			plotregion(c(gs16) ic(gs16) ilw(thin) lw(thin)) 
			graphregion(color(gs16) ic(gs16) ilw(thin) lw(thin)) 
			/// and insist on a long thin graphic
			ysize(2)
			
	       	xlabel(7 8 9 10 11 12, valuelabel
		
	       	labs(large) nogrid glc(gs12) angle(0))
	       	xtitle("Site of tumour", size(vlarge) margin(t=3)) 
			//xscale(range(1(1)3))
			//xmtick(1(1)3)

			ylab(0(20)80, labs(large) nogrid glc(gs12) angle(0) format(%9.0f))
	       	ytitle("Number of tumours", size(large) margin(r=3)) 
			ymtick(0(10)80)
			
			/// Legend information
			legend(off size(medlarge) nobox position(11) colf cols(2)
			region(color(gs16) ic(gs16) ilw(thin) lw(thin)) order(1 2)
			lab(1 "Number of tumours (men)") 
			lab(2 "Number of tumours (women)")
			);
#delimit cr

restore


********************************************************************************
** Looking at causes of death: cancer vs heart-related vs other
********************************************************************************
/*
preserve
use "data\2013_updated_cancer_dataset_site_cod.dta", clear
sort sex cod
keep if deceased==1 & year<2017 //457 deleted 
** JC: one (1) pt died in 2017 with cod=3 (NK) incl. in deletions above

keep eid deathid case age* sex year cod causeofdeath treatment*
** Now generate a new variable which will select out all the potential acute MIs
gen hrt=.  // 390 missing values generated
label var hrt "Heart-related deaths"

** searching causeofdeath for these terms
replace hrt=1 if regexm(causeofdeath, "SUDDEN CARDIAC") &  hrt==.  //1 replaced
replace hrt=1 if regexm(causeofdeath, "MYOCARDIAL INFARCT") &  hrt==. //2 replaced
replace hrt=1 if regexm(causeofdeath, "ACUTE MYOCARDIAL") &  hrt==. //1 replaced
replace hrt=1 if regexm(causeofdeath, "HEART") &  hrt==. //2 replaced

tab hrt, miss //as of 10oct2017
**Heart-relat |
**  ed deaths |      Freq.     Percent        Cum.
**------------+-----------------------------------
**          1 |          6        1.54        1.54
**          . |        384       98.46      100.00
**------------+-----------------------------------
**      Total |        390      100.00


sort causeofdeath
list eid deathid causeofdeath cod if hrt==1 & (treatment1==3 | treatment2==3 | treatment3==3 | treatment4==3)
**     +------------------------------------------------------------------------------------+
**     |          eid   deathid                               causeofdeath              cod |
**     |------------------------------------------------------------------------------------|
** 28. | 201302220101      7104   N ACUTE MYOCARDIAL LEUKEMIA HYPERTENSION   Dead of cancer |
**     +------------------------------------------------------------------------------------+

** 1 had chemo - so possibly could have had MI due to chemo side-effects
count if hrt==1 //6 as of 10oct2017
list eid deathid causeofdeath treatment3 treatment4 cod if hrt==1
count if hrt==. & cod==1 & (treatment1==3 | treatment2==3 | treatment3==3 | treatment4==3) //69 as of 10oct2017
list eid deathid causeofdeath treatment1 treatment2 cod if hrt==. & cod==1 & (treatment1==3 | treatment2==3 | treatment3==3 | treatment4==3)

count if hrt==. & cod==2 //4 as of 10oct2017
list causeofdeath cod if hrt==. & cod==2
count if hrt==. & cod==9 //0 as of 10oct2017
list causeofdeath cod if hrt==. & cod==9
*/


