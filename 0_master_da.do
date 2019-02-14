** This is the master *do* file for data analysis of the 2014 BNR-Cancer dataset 
** for the 2014 Annual Report
** This version01 was prepared by J Campbell on 06dec2018 based on AMC Rose's 2008 version03 for 2013 Annual Report
** Dofile running accurately as of 06dec18

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

log using "logfiles\0_master_2014_da.smcl", replace

** Automatic page scrolling of screen output
set more off

 *************************************************************************
 *     C D R C         A N A L Y S I S         C O D E
 *                                                              
 *     DO FILE: 	0_master_da
 *					The code herein was done by AMC Rose for 2008 analysis
 *					and updated by J Campbell for 2013 & 2014 analyses
 *
 *	   STATUS:		Completed
 *
 *     FIRST RUN:	06sep2018
 *
 *	   LAST RUN:	20dec2018
 *
 *     ANALYSIS: 	Cancer 2014 dataset for annual report
 *
 *     PRODUCT: 	STATA SE Version 15.1
 *
 *     DATA: 		Datasets prepared by J Campbell		
 *		
 * 	   VERSION: 	version01 - 2014 ABSTRACTION PHASE
 *     
 *     SUPPORT: 	Natasha Sobers/Ian R Hambleton        
 *	
 *************************************************************************

 **************************************************
 ** 1_external_pop_da
 ** Preparing the external population files for incidence analysis
 ** (1) Barbados population from 2010 census (not inflated for population growth)
 ** (2) Standard World population (WHO 2002 standard)
 ** (3) Standard US population (SEER US 2000 Census)
 **************************************************
do "dofiles\1_external_pop_da.do"


************************************************************************* 
* SECTION 1: NUMBERS 
* 1: Numbers
*	 - multiple events
*	 - DCOs
*	 - tumours by month
*************************************************************************
do "dofiles\2_numbers_da.do"

************************************************************************* 
* SECTION 2: INCIDENCE RATES
* 2.1 crude, all cancers, all sites
* 2.2 top 5 sites
* 2.3 age-std to world popn ALL cancers
* 2.4 age-std to world popn cancers excluding skin
* 2.5 age-std to world popn by sex excluding skin
**************************************************************************
do "dofiles\3_crude_asr_da.do"

* *************************************************************************
* SECTION 3: CLASSIFICATION BY SITE
* Covering:
*  3.1  number, % by site and top 5 10 sites by sex
* *************************************************************************
do "dofiles\4_sites_da.do"


* *****************************************************
* ANALYSIS: SECTION 4 - TREATMENT & OUTCOMES
* Covering
* 4a Routine treatment (not collected in 2014)
* 4b Mortality
* 	-	4b.1: No. & % deaths for the year 
* 	-	4b.2: Survival to 5 years for 2014 case cohort
* *****************************************************
do "dofiles\5_rx_outcomes_da.do"

* *****************************************************
* ANALYSIS: SECTION 5 - MORTALITY RATES
* Covering MR
* 4.1 Crude MR overall
* 4.2 Crude MR by site
* 4.3 ASMR (WHO World population) overall & by sex
* 4.4 ASMR (world) by site & by sex
* *****************************************************
do "dofiles\6_mort_da.do"


* *********************************************
** CREATION OF GRAPHS
*  Covering
* Fig 1: Tumours by month and sex 
* (Note: Fig 2: los/survival already done in 5_section4)
* Fig 3: CoD as bar chart (cancer vs non-cancer vs NK)
* Fig 4: death by site
* *********************************************
do "dofiles\7_graphs_da.do"

* **********************************************
* SURVIVAL ANALYSIS - BRISTOL COURSE
* DONE BY A. ROSE AFTER 2008 DATA WAS PUBLISHED
* **********************************************
do "dofiles\8_survival_da.do"
