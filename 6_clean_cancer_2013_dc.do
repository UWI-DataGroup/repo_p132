** This is the sixth *do* file to be called by the master file.

 ******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *                                                              
 *  DO FILE: 		6_clean_cancer_2013_dc
 *					6th dofile: Cancer Data Clean - Missed 2013 Cases
 *
 *	STATUS:			Completed
 *
 *  FIRST RUN:	 	07nov2018
 *
 *	LAST RUN:		03dec2018
 *
 *  ANALYSIS: 		Creating dataset with missed 2013 cases that
 *					were found in 2014 dataset when cleaning
 *					JC to append this dataset to new version of 2013 
 *					annual rpt dataset
 *					JC uses for basis of checkflags for cancer team corrections
 *
 * 	VERSION: 		version02 - 2014 ABSTRACTION PHASE
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
cd "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\"

log using "logfiles\6_clean_cancer_2013_dc.smcl", replace

set more off

**************************************
** DATA PREPARATION  
**************************************
** LOAD the prepared dataset
use "data\clean\2013_cancer_merge_dc.dta" ,clear

count //30

***********************
** Missed 2013 Cases **
***********************

** CREATE variable to identify and keep 'missed' 2013 cases that were discovered while cleaning 2014 data so that these can be added to 2013 dataset
gen miss2013abs=.
label var miss2013abs "Missed 2013 Cases"
label define miss2013abs_lab 1 "Confirmed" 2 "Duplicate" 3 "Ineligible" , modify
label values miss2013abs miss2013abs_lab

** Update any with missing values
tab recstatus ,m //30 confirmed
tab dupsource ,m //30 MS-Conf Tumour Rec
tab topography ,m
tab morph ,m
tab grade ,m
tab beh ,m
tab basis ,m
tab lat ,m
tab staging ,m
tab resident ,m
tab parish ,m
tab deceased ,m
tab eidmp ,m
tab dcostatus ,m

label drop cancer_lab
label define cancer_lab 1 "cancer" 2 "not cancer", modify
label values cancer cancer_lab
label var cancer "cancer diagnoses"
tab cancer ,m

tab ptrectot ,m
tab cod ,m
tab pod if slc==2 ,m
list pid pod deathparish cr5id if pod=="" & slc==2
replace pod="QEH" if pid=="20141542" //1 change
replace deathparish=8 if pid=="20141542" //1 change

tab nftype ,m
tab sourcename ,m
tab dot ,m
tab dotyear ,m
tab dod if deceased==1 ,m
tab dodyear if deceased==1 ,m
tab dlc if deceased==2 ,m
tab age sex ,m 
tab slc ,m
tab dob ,m //145 missing
tab natregno ,m

label drop persearch_lab
label define persearch_lab 0 "Not done" 1 "Done: OK" 2 "Done: MP" 3 "Done: Duplicate/Non-IARC MP", modify
label values persearch persearch_lab
tab persearch ,m
replace persearch=1 if persearch==0|persearch==. //30 changes

** Update miss2013abs variable and use this to identify missed cases in previous 2013 dataset
replace miss2013abs=1 if dxyr==2013 & recstatus==1 //30 changes
replace miss2013abs=2 if dxyr==2013 & recstatus==4 //0 change
replace miss2013abs=3 if dxyr==2013 & recstatus==3 //0 changes

** Create dataset of missed 2013 cases to append onto new version of already analysed 2013 dataset (first merge with national deaths to pick up matches!)
save "data\clean\2013_cancer_clean_nodups_dc.dta" ,replace
label data "BNR-Cancer Missed 2013 Cases"
notes _dta :These data prepared for merge with 2014 ABS phase
