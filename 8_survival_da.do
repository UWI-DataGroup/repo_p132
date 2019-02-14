** This is the eighth *do* file to be called by the master file.

******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *                                                              
 *  DO FILE: 		8_survival_da
 *					8th dofile:  Survial analysis to 3 years
 *					The code herein is based on AMC Rose's 2008 analysis code
 *					but, instead of using AR's site classification, IARC's site
 *					classification created by J Campbell in 2014 cleaning 
 *					dofile "5_merge_cancer_dc"
 * 					(first version for this analysis of survival as per Bristol),
 *					noted by AR 02-jun-2015
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

log using "logfiles\8_survival_2014_da.smcl", replace

** Automatic page scrolling of output
set more off


* ************************************************************************
* ANALYSIS: SECTION 6 - SURVIVAL ANALYSIS
* Covering
* 6.1 Survival analysis to 3 years
**************************************************************************

** Load the dataset
use "data\2014_cancer_rx_outcomes_da.dta", clear

** Of note,
** dod==deathdate (all deceased pts have dod)
** dlc==date last contact (all alive pts have dlc)
** dot==date of tumour (a.k.a. incidence date)
** some pts have both since canreg5 abs only had dlc but
** when merged with death data, the matches were assigned
** dod and vstatus was changed to died

** first we have to restrict dataset to patients not tumours
drop if patient!=1 // 0 deleted
count // 912

summ

** failure is defined as deceased==1
codebook deceased
recode deceased 2=0
tab deceased ,m

tab dod ,m
count if dod!=. // 488

** check all patients have a dot (incidence date)
tab dot ,m // none missing dot

** set study end date variable as 3 years from dx date IF PT HAS NOT DIED
gen end_date=(dot+(365.25*3)) if dot!=. // note 2008 was a leap year so pt dx on 01 jan 2008
                              //  actually has an end date on 31dec2012!						  
							  // 2014 was NOT a leap year so ignore above
format end_date %dD_m_CY

** check all patients have an end_date
tab end_date ,m // none missing end dates

** check that all who died have a dod
tab dod if deceased==1 ,m //all dod <2018

** (1) Check if there are any who died >3yrs from dx even if died in 2017

** any with dod >3 years from dx even if dod still in 2017,
** needs to be reset as alive
count if dod!=. & dod>dot+(365.25*3) // 14
list pid deathid dot dod if dod!=. & dod>dot+(365.25*3)
/*
     +------------------------------------------------+
     |      pid   deathid           dot           dod |
     |------------------------------------------------|
805. | 20145055     19754   05 Mar 2014   10 Sep 2017 |
809. | 20145066      6668   17 Mar 2014   12 Nov 2017 |
822. | 20140681     22483   25 Mar 2014   16 Aug 2017 |
829. | 20141486     21208   13 May 2014   01 Oct 2017 |
835. | 20140854      9479   19 Feb 2014   05 Aug 2017 |
     |------------------------------------------------|
842. | 20141448     15652   13 May 2014   24 Nov 2017 |
857. | 20141064     10166   04 Apr 2014   11 Dec 2017 |
861. | 20141145      9566   10 Jan 2014   30 Dec 2017 |
867. | 20141561      9046   19 Sep 2014   20 Sep 2017 |
891. | 20141425     16730   30 Jul 2014   08 Oct 2017 |
     |------------------------------------------------|
892. | 20141463     10815   07 Jul 2014   15 Nov 2017 |
898. | 20140700      9144   30 May 2014   04 Jul 2017 |
899. | 20140841     12173   30 Jun 2014   17 Sep 2017 |
907. | 20141240     20030   08 Jul 2014   28 Jul 2017 |
     +------------------------------------------------+
*/

replace deceased=0 if dod!=. & dod>dot+(365.25*3) // 14 changes
	
tab deceased ,m //dead=474, "alive"=438

** set to missing those who have dod>3 years from incidence date - but
** first create new variable for time to death/date last seen, called "time"

** (2) use dod to define time to death if died within 3 yrs
gen time=dod-dot if (dod!=. & deceased==1 & dod<dot+(365.25*3)) 
** 438 missing values generated

** (3) next use 3 yrs as time, if died >3 yrs from incidence
replace time=end_date-dot if (end_date<dod & dod!=. & deceased==1) 
** 0 changes

** (4) next use dlc as end date, if alive and have date last seen (dlc)
count if dlc<end_date & deceased==0 // 422
list pid dot dlc if dlc<end_date & deceased==0
replace time=dlc-dot if (dlc<end_date & deceased==0) // 422 changes

tab time ,m
count if time!=. // at this point we are missing 16 for time... why?

list time dot dlc dod end_date deceased slc dcostatus if time==.
** these have date last seen > end_date - so here make dlc the end_date
count if (end_date<dlc & deceased==0) & time==. & dlc!=. & slc==1 //7
replace time=end_date-dot if (end_date<dlc & deceased==0) & time==. & dlc!=. & slc==1
** 7 changes
tab time ,m // 9 missing
** these had 'deceased' reset to '0' since
** they died after their 3-yr end_date so reset time=0
replace time=0 if time==. //9 changes


list pid deathid dot end_date dod deceased dlc if end_date<dod & dod!=.
/*
     +---------------------------------------------------------------------------------------+
     |      pid   deathid           dot      end_date           dod   deceased           dlc |
     |---------------------------------------------------------------------------------------|
805. | 20145055     19754   05 Mar 2014   04 Mar 2017   10 Sep 2017          0   10 Sep 2017 |
809. | 20145066      6668   17 Mar 2014   16 Mar 2017   12 Nov 2017          0   12 Nov 2017 |
822. | 20140681     22483   25 Mar 2014   24 Mar 2017   16 Aug 2017          0   25 Mar 2014 |
829. | 20141486     21208   13 May 2014   12 May 2017   01 Oct 2017          0   01 Oct 2017 |
835. | 20140854      9479   19 Feb 2014   18 Feb 2017   05 Aug 2017          0   19 Feb 2014 |
     |---------------------------------------------------------------------------------------|
842. | 20141448     15652   13 May 2014   12 May 2017   24 Nov 2017          0   24 Nov 2017 |
857. | 20141064     10166   04 Apr 2014   03 Apr 2017   11 Dec 2017          0   16 May 2014 |
861. | 20141145      9566   10 Jan 2014   09 Jan 2017   30 Dec 2017          0   01 Apr 2014 |
867. | 20141561      9046   19 Sep 2014   18 Sep 2017   20 Sep 2017          0   20 Sep 2017 |
891. | 20141425     16730   30 Jul 2014   29 Jul 2017   08 Oct 2017          0   08 Oct 2017 |
     |---------------------------------------------------------------------------------------|
892. | 20141463     10815   07 Jul 2014   06 Jul 2017   15 Nov 2017          0   15 Nov 2017 |
898. | 20140700      9144   30 May 2014   29 May 2017   04 Jul 2017          0   04 Jul 2017 |
899. | 20140841     12173   30 Jun 2014   29 Jun 2017   17 Sep 2017          0   17 Sep 2017 |
907. | 20141240     20030   08 Jul 2014   07 Jul 2017   28 Jul 2017          0   15 Sep 2014 |
     +---------------------------------------------------------------------------------------+
*/
** change dod to missing (deceased already set to 0 above) 
** as they did not die within 3 years
count if end_date<dod & dod!=. //14
replace dod=. if end_date<dod & dod!=. //14 changes; 14 to missing

tab deceased ,m // now 474 (used to be 488 but 14 died >3 years)

sort end_date   // death from comments so changed from alive to dead
tab end_date ,m // none missing

** just check median time to death within the 3 year period
preserve
tab deceased ,m
replace deceased=0 if deceased==1 & dod>d(31dec2016)
gen k=1
table k, c(p50 time p25 time p75 time min time max time)
/*
----------------------------------------------------------------------
        k |  med(time)   p25(time)   p75(time)   min(time)   max(time)
----------+-----------------------------------------------------------
        1 |         14           0       124.5           0     1095.75
----------------------------------------------------------------------
*/
restore

** Now to set up dataset for survival analysis, we need each patient's date of
** entry to study (incidence date, or dot), and exit date from study which is end_date
** UNLESS they died before end_date or were last seen before end_date in which case
** they should be censored... so now we create a NEW end_date as a combination of
** the above
sort dot 
sort pid

list pid dot deceased dod dlc end_date

count if (end_date>dod & dod!=. & deceased==1) // 474
gen newend_date=dod if (end_date>dod & dod!=. & deceased==1) // 438 missing values generated

count if (dlc<end_date) & dod==. & deceased==0 // 422
list eid deathid dlc dod end_date deceased if (dlc<end_date) & dod==. & deceased==0
replace newend_date=dlc if (dlc<end_date) & dod==. & deceased==0
** 422 changes

count if newend_date==. // 16
sort pid
list pid deathid dot deceased dlc dod end_date newend_date if newend_date==.
/*
     +------------------------------------------------------------------------------------------+
     |      pid   deathid           dot   deceased           dlc   dod      end_date   newend~e |
     |------------------------------------------------------------------------------------------|
309. | 20140700      9144   30 May 2014          0   04 Jul 2017     .   29 May 2017          . |
328. | 20140745         .   14 Apr 2014          0   08 May 2018     .   13 Apr 2017          . |
355. | 20140781         .   02 Sep 2014          0   19 Mar 2018     .   01 Sep 2017          . |
383. | 20140839         .   17 Feb 2014          0   15 May 2018     .   16 Feb 2017          . |
384. | 20140841     12173   30 Jun 2014          0   17 Sep 2017     .   29 Jun 2017          . |
     |------------------------------------------------------------------------------------------|
660. | 20141339         .   16 Oct 2014          0   30 Jun 2018     .   15 Oct 2017          . |
733. | 20141425     16730   30 Jul 2014          0   08 Oct 2017     .   29 Jul 2017          . |
750. | 20141448     15652   13 May 2014          0   24 Nov 2017     .   12 May 2017          . |
763. | 20141463     10815   07 Jul 2014          0   15 Nov 2017     .   06 Jul 2017          . |
778. | 20141486     21208   13 May 2014          0   01 Oct 2017     .   12 May 2017          . |
     |------------------------------------------------------------------------------------------|
818. | 20141561      9046   19 Sep 2014          0   20 Sep 2017     .   18 Sep 2017          . |
824. | 20141573         .   27 Aug 2014          0   23 Mar 2018     .   26 Aug 2017          . |
832. | 20145007         .   06 Jan 2014          0   05 Apr 2018     .   05 Jan 2017          . |
867. | 20145055     19754   05 Mar 2014          0   10 Sep 2017     .   04 Mar 2017          . |
875. | 20145066      6668   17 Mar 2014          0   12 Nov 2017     .   16 Mar 2017          . |
     |------------------------------------------------------------------------------------------|
906. | 20145171         .   30 Sep 2014          0   26 Jun 2018     .   29 Sep 2017          . |
     +------------------------------------------------------------------------------------------+
*/

** date last seen is after (>) than end_date
replace newend_date=end_date if newend_date==. // 16 changes
format newend_date %dD_m_CY

describe dot newend_date

sort dot
list pid dot dlc dod end_date newend_date

tab time ,m // 0 missing values; 402 have 0 values
sort pid
list pid deathid deceased dot dlc dod end_date newend_date time if time==0
** there are 402 records with time=0 (ie either DCO, abstracted from cfdb or defaulted as not seen after dx date)
tab dcostatus if time==0
tab slc if time==0
count if time==0 & basis==0 //125
** 125 of 402 were abstracted from bnr database i.e. no pt notes seen
** 125 of 402 were DCOs
list pid deathid dcostatus if time==0 & deceased==0
** honestly those who did not die (ie no death certificate) should have at least a
** value of 1 day... while those DCOs are understandably at time=0
count if (time==0 & deceased==0) // 247
count if (time==0 & deceased==1) // 155
list pid deathid basis slc if (time==0 & deceased==0)
replace newend_date=newend_date+1 if (time==0 & deceased==0) // 247 changes
count if (time==0 & deceased==0)
replace time=1 if (time==0 & deceased==0) // 247 changes

list pid deathid dot dod end_date newend_date dcostatus if time==0 & deceased==1
** AR: after meeting RH 26-aug-2016: CHANGE THOSE WITH DOT>DOD SO DOT=DOD

** Now survival time set the dataset using newend_date as the time variable and deceased
** as the failure variable

stset newend_date , failure(deceased) origin(dot) scale(365.25)

tab _st // 757 observations contribute to analysis

stdes

sts graph 

sts graph , by(sex)

** just for main sites
preserve
gen newsite=1 if siteiarc==39 // prostate
replace newsite=2 if siteiarc==29 // breast
replace newsite=3 if siteiarc>9 & siteiarc<19 // GI
replace newsite=4 if siteiarc>51 & siteiarc<61 // blood & lymph
keep if newsite<5
label define newsite_lab 1 "prostate" 2 "breast" 3 "GI"  4 "lymphoid and blood" 
label values newsite newsite_lab

sts graph , by(newsite)
restore

gen newtime=int(time/365.25) // 0 missing values generated
tab newtime deceased ,m
