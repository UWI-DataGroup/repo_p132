** CLOSE ANY OPEN LOG FILE AND OPEN A NEW LOG FILE
capture log close
cd C:\statistics\analysis\a000\01_bros\versions\version01
log using logfiles\bros_01_01, replace

**  GENERAL DO-FILE COMMENTS
//  program:      bros_01_01.do
//  project:      BROS dataset preparation
//  author:       HAMBLETON \ 22-APR-2011
//  task:         Barbados Registry of Strokes 
//  description:  Organising the BROS dataset

** DO-FILE SET UP COMMANDS
version 11
clear all
macro drop _all
set more 1
set linesize 80

** LOAD DATASET
use data\bros_apr_2011, clear

** Prepare a minimal dataset fpr met-analysis
** To be performed by the Centre for Medical Statistics (Oxford Univ)
** Data transmitted to Jacqueline Birks (08-MAR-2012)
** Copied to Professor David Corbin

** Keep minimal dataset
** -------------------------
** eid         unique identifier
** s1_dob      date of birth 
** s1_dos      date of stroke
** s1_dod      date of death
** s1_sex      sex
** s1_ethnic   ethnicity
** s2_subtype  stroke subtype
** -------------------------

** ONE DATE OF DEATH ERROR
replace s1_dod=d(03mar2004) if eid==771 

** Age at stroke (to nearest year)
gen s1_aas_t1 = (s1_dos-s1_dob)/365.25
gen s1_aas = int(s1_aas_t1)
label var s1_aas "Age at stroke (year only)"

** Age at death (to nearest year)
gen s1_aad_t1 = (s1_dod-s1_dob)/365.25
gen s1_aad = int(s1_aad_t1)
label var s1_aad "Age at death (year only)"

** Days between stroke and death
gen s1_dsurv = (s1_dod-s1_dos)
label var s1_dsurv "Days between stroke and death"

** Status at 3-months
rename s1_status3m s1_status
tab s1_status, miss 
mvencode s1_status, mv(.=4)
recode s1_status 2=1 4=3
recode s1_status 3=2

replace s1_status=0 if s1_status==2 & s1_dsurv<95
replace s1_status=0 if s1_status==1 & s1_dsurv<95
replace s1_status=1 if s1_status==0 & s1_dsurv>95

label define s1_status 0 "died by 3m" 1 "alive at 3m" 2 "lost at 3m",modify
label values s1_status s1_status 
label var s1_status "Status at 3m visit"


** Checking numbers against CORBIN 2004
** In first t=year N=288 (TACI, PACI, POCI, LACI)
mark is if s2_subtype<=4
gen year1 = .
replace year1 = 1 if s1_dos>d(14oct2001) & s1_dos<d(15oct2002)



/*

keep eid s1_aas s1_aad s1_dsurv s1_status s1_sex s1_ethnic s2_subtype
order eid s1_aas s1_aad s1_dsurv s1_status s1_sex s1_ethnic s2_subtype

sort eid
label data "BROS for CMS. March-2012"
datasignature set, reset
save data\bros_cms, replace
label data "BROS for CMS. Formatted for Stata10. March-2012"
saveold data\bros_cms_10, replace





