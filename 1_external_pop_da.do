** This is the first *do* file to be called by the master file.

 ******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *                                                              
 *  DO FILE: 		1_external_pop_da
 *					1st dofile: External Population Prep for Incidence Analysis
 *					The code herein was done by AMC Rose for 2008 analysis
 *					and updated by J Campbell for 2013 & 2014 analyses
 *
 *	STATUS:			Completed
 *
 *  FIRST RUN: 		06dec2018
 *
 *	LAST RUN:		06dec2018
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

log using "logfiles\1_external_pop_2014_da.smcl", replace

** Automatic page scrolling of output
set more off

** (1) Barbados population figures (Census 2010)
** Data from Trevor David at Barbados Statistical Services
** April 2007

** Load the dataset: note first we use 2000 census data then change to 2010
use "data\population\barbados_adjusted_population_2000.dta", clear

** rename variable atotal to pop_bb
rename atotal pop_bb

** ADDITION IN MARCH 2014: update to 2010 BSS census data (already adjusted for undercount by BSS)
** Basically, the 2010 census only gave 5-year age-groups with undercount (not individual ages)
** so I have done the folllowing: in each 5-year age-group, divided the total by 5 and made that
** the popn total, so that the sums make the 5-year total that we were given

** Next we create the age5 groupings

** age5 (to be saved as dataset bb2010_5)
********************************
** EIGHTEEN age groups in FIVE-year bands. 
** This is the standard for all standard population distributions
gen age5 = recode(age,4,9,14,19,24,29,34,39,44,49,54,59,64,69,74,79,84,200)
recode age5 4=1 9=2 14=3 19=4 24=5 29=6 34=7 39=8 44=9 49=10 54=11 59=12 64=13 69=14 74=15 79=16 84=17 200=18
label define age5_lab 	1 "0-4"	   2 "5-9"    3 "10-14"		///
						4 "15-19"  5 "20-24"  6 "25-29"		///
						7 "30-34"  8 "35-39"  9 "40-44"		///
						10 "45-49" 11 "50-54" 12 "55-59"	///
						13 "60-64" 14 "65-69" 15 "70-74"	///
						16 "75-79" 17 "80-84" 18 "85 & over", modify
label values age5 age5_lab

** Now we change those 2000 numbers to 2010
replace pop_bb=8479 if sex==1 & age5==1
replace pop_bb=9155 if sex==1 & age5==2
replace pop_bb=9122 if sex==1 & age5==3
replace pop_bb=9418 if sex==1 & age5==4
replace pop_bb=9108 if sex==1 & age5==5
replace pop_bb=9775 if sex==1 & age5==6
replace pop_bb=9635 if sex==1 & age5==7
replace pop_bb=10632 if sex==1 & age5==8
replace pop_bb=10450 if sex==1 & age5==9
replace pop_bb=11303 if sex==1 & age5==10
replace pop_bb=10639 if sex==1 & age5==11
replace pop_bb=8782 if sex==1 & age5==12
replace pop_bb=7160 if sex==1 & age5==13
replace pop_bb=5640 if sex==1 & age5==14
replace pop_bb=4876 if sex==1 & age5==15
replace pop_bb=4074 if sex==1 & age5==16
replace pop_bb=3167 if sex==1 & age5==17
replace pop_bb=3388 if sex==1 & age5==18


replace pop_bb=8873 if sex==2 & age5==1
replace pop_bb=9683 if sex==2 & age5==2
replace pop_bb=9445 if sex==2 & age5==3
replace pop_bb=9452 if sex==2 & age5==4
replace pop_bb=9061 if sex==2 & age5==5
replace pop_bb=9313 if sex==2 & age5==6
replace pop_bb=9150 if sex==2 & age5==7
replace pop_bb=9884 if sex==2 & age5==8
replace pop_bb=9663 if sex==2 & age5==9
replace pop_bb=10062 if sex==2 & age5==10
replace pop_bb=9411 if sex==2 & age5==11
replace pop_bb=7871 if sex==2 & age5==12
replace pop_bb=6326 if sex==2 & age5==13
replace pop_bb=4511 if sex==2 & age5==14
replace pop_bb=3804 if sex==2 & age5==15
replace pop_bb=2863 if sex==2 & age5==16
replace pop_bb=1968 if sex==2 & age5==17
replace pop_bb=1660 if sex==2 & age5==18

replace pop_bb=round(pop_bb/5) if age5<18
** There were 14 M and 14 F ages in the top age-group (85 & over)
replace pop_bb=round(pop_bb/14) if age5==18


**age10 (to be saved as dataset bb2010_10-1)
************************************
** TEN age groups in TEN-year bands. 
** This is the standard for all standard population distributions
gen age10 = recode(age,9,19,29,39,49,59,69,79,200)
recode age10 9=1 19=2 29=3 39=4 49=5 59=6 69=7 79=8 200=9
label define age10_lab  1 "0-9"    2 "10-19"  3 "20-29"	///
						4 "30-39"  5 "40-49"  6 "50-59"	///
						7 "60-69"  8 "70-79"  9 "80 & over" , modify
label values age10 age10_lab
				   
**age_10 (to be saved as dataset bb2010_10-2)
*************************************
** TEN age groups in TEN-year bands with 'adults' from age 15 upwards.
** This is the standard for BROS and we have changed BNR-S to match this.
gen age_10 = recode(age,14,24,34,44,54,64,74,84,200)
recode age_10 14=1 24=2 34=3 44=4 54=5 64=6 74=7 84=8 200=9
label define age_10_lab 1 "0-14"   2 "15-24"  3 "25-34"	///
						4 "35-44"  5 "45-54"  6 "55-64"	///
						7 "65-74"  8 "75-84"  9 "85 & over"	, modify
label values age_10 age_10_lab


**age45 (to be saved as dataset bb2010_45)
**********************************
** Two age bands (adult <45, older adult 45+)
gen age45 = recode(age,44,200)
recode age45 44=1 200=2
label define age45_lab  1 "0-44"	 2 "45 & over" , modify
label values age45 age45_lab

**age55 (to be saved as dataset bb2010_55)
**********************************
** Two age bands (adult <55, elderly adult 55+)
gen age55 = recode(age,54,200)
recode age55 54=1 200=2
label define age55_lab  1 "0-54"	 2 "55 & over" , modify
label values age55 age55_lab

**age60 (to be saved as dataset bb2010_60)
**********************************
** Two age bands (adult <60, elderly adult 60+)
gen age60 = recode(age,59,200)
recode age60 59=1 200=2
label define age60  1 "0-59"	 2 "60+" , modify
label values age60 age60

** Sex
******
label define sex_lab 1 "female" 2 "male",modify
label values sex sex_lab

** Barbados population denominator file
***************************************
collapse (sum) pop_bb, by(age5 age10 age_10 age45 age55 age60 sex)
label var age45 "Age in 2 groups (<45, 45 & over)"
label var age55 "Age in 2 groups (<55, 55 & over)"
label var age60 "Age in 2 groups (<60, 60+)"
label var age5 "Age in 5-year age bands (18 groups)"
label var age10 "Age in 10-year age bands (10 groups)"
label var age_10 "Age in 10-year age bands from 15 (10 groups)"
label var pop_bb "barbados population from 2010 census"
sort age5
label data "Barbados census 2010: 5-year age bands"


** Save the dataset
save "data\population\bb2010_5" , replace

preserve
collapse (sum) pop_bb, by(age10 age60 sex)
label data "Barbados census 2010: 10-year age bands1"
** Save the dataset
save "data\population\bb2010_10-1" , replace

collapse (sum) pop_bb, by(age60 sex)	
	label data "Barbados census 2010: 2 age groups. <60 and 60 & over"
save "data\population\bb2010_60" , replace
restore

collapse (sum) pop_bb, by(age_10 age45 age55 sex)
	label data "Barbados census 2010: 10-year age bands2"
save "data\population\bb2010_10-2" , replace

collapse (sum) pop_bb, by(age45 age55 sex)
	label data "Barbados census 2010: 2 age groups. <45 and 45 & over"
save "data\population\bb2010_45" , replace

collapse (sum) pop_bb, by(age55 sex)
	label data "Barbados census 2010: 2 age groups. <55 and 55 & over"
save "data\population\bb2010_55" , replace


**********************************
** WHO WORLD STANDARD POPULATION
**********************************

** (2) Standard World population (WHO 2002 standard)
** REFERENCE
** Age-standardization of rates: A new WHO-standard, 2000
** Ahmad OB, Boschi-Pinto C, Lopez AD, Murray CJL, Lozano R, Inoue M.
** GPE Discussion paper Series No: 31
** EIP/GPE/EBD. World Health Organization

** An important practical reason for choosing the WHO world standard population over other standards 
** (eg. US Standard Population 2000) is that this is the only standard population to be offered
** in 21 categories - and so adequately covering the elderly in fine detail
** The US/European oldest age category = 85+
** The World population offers 85-89, 90-94, 95-99, 100+ 
** More appropriate for this elderly disease, perhaps?
		drop _all
		input age5 pop
		1	8860
		2	8690
		3	8600
		4	8470
		5	8220
		6	7930
		7	7610
		8	7150
		9	6590
		10	6040
		11	5370
		12	4550
		13	3720
		14	2960
		15	2210
		16	1520
		17	910
		18	635
		end

** International Standard dataset Number
gen intdn = 001
label var intdn "World Std Million (21 age groups)"

** NOTE THAT IN ORDER TO MERGE WITH BB POPN DATA AS OF 2010 CENSUS DATA
** We need to break these higher age groups down to one (18 total age-groups
** instead of 21)

** Age labelling
label define whoage5_lab  	1 "0-4"    2 "5-9"	  3 "10-14"	///
		            4 "15-19"  5 "20-24"  6 "25-29"	///
					7 "30-34"  8 "35-39"  9 "40-44"	///
		           10 "45-49" 11 "50-54" 12 "55-59"	///
				   13 "60-64" 14 "65-69" 15 "70-74"	///
		           16 "75-79" 17 "80-84" 18 "85 & over", modify
label values age5 whoage5_lab
label var age5 "WHO standard 5-year age-grouping (18 groups)"

** TEN age groups in TEN-year bands. 
** This is the standard for all standard population distributions
gen age10 = recode(age5,2,4,6,8,10,12,14,16,17)
recode age10 2=1 4=2 6=3 8=4 10=5 12=6 14=7 16=8 17=9
label define age10_lab  1 "0-9"	   2 "10-19"  3 "20-29"	///
		            	4 "30-39"  5 "40-49"  6 "50-59"	///
						7 "60-69"  8 "70-79"  9 "80 & over" , modify
label values age10 age10_lab

** TEN age groups in TEN-year bands with <15 as first group. 
** This is another standard for population distributions
gen age_10 = recode(age5,3,5,7,9,11,13,15,17,18)
recode age_10 3=1 5=2 7=3 9=4 11=5 13=6 15=7 17=8 18=9
label define age_10_lab 	1 "0-14"   2 "15-24"  3 "25-34"	///
				4 "35-44"  5 "45-54"  6 "55-64"	///
				7 "65-74"  8 "75-84"  9 "85 & over" , modify
label values age_10 age_10_lab

gen age45 = recode(age5,9,18)
recode age45 9=1 18=2
label define age45_lab  1 "0-44"   2 "45 & over" , modify
label values age45 age45_lab

gen age55 = recode(age5,11,18)
recode age55 11=1 18=2
label define age55_lab  1 "0-54"   2 "55 & over" , modify
label values age55 age55_lab

gen age60 = recode(age5,12,18)
recode age60 12=1 18=2
label define age60  1 "0-59"   2 "60 & over" , modify
label values age60 age60

sort age5
label data "WHO world standard million: 5-year age bands"

save "data\population\who2000_5.dta", replace

preserve
collapse (sum) pop , by(age10 age60 intdn)
	label data "WHO world standard million: 10-year age bands1"
	sort age10
save "data\population\who2000_10-1.dta", replace

collapse (sum) pop , by(age60 intdn)
	label data "WHO world standard million: 2 age groups. <60 and 60+"
	sort age60
save "data\population\who2000_60.dta", replace
restore

collapse (sum) pop , by(age_10 age45 age55 intdn)
	label data "WHO world standard million: 10-year age bands2"
	sort age_10
save "data\population\who2000_10-2.dta", replace

** JC: created the below pop dataset to be used in 4_section3.do
** as it was missing here
** Now realised it wasn't used for annual rpt so made this defunct
/*collapse (sum) pop , by(age_10 age45 age55 intdn)
	label data "WHO world standard million: 10-year age bands2"
	sort age_10
	drop if age_10>7
save "data\population\who2000_10-2_PC.dta", replace
*/

collapse (sum) pop , by(age45 age55 intdn)
	label data "WHO world standard million: 2 age groups. <45 and 45 & over"
	sort age45
save "data\population\who2000_45.dta", replace

collapse (sum) pop , by(age55 intdn)
	label data "WHO world standard million: 2 age groups. <55 and 55 & over"
	sort age55
save "data\population\who2000_55.dta", replace




**********************************
** US STANDARD POPULATION (SEER)
**********************************

** US STANDARD POPULATION

** (2) Standard US population (SEER US 2000 standard)
** REFERENCE
** Surveillance, epidemiology, and end results (SEER). US Standard Population 
** 2000 Census). SEER; Available from:
** http://seer.cancer.gov/stdpopulations/stdpop.19ages.html

		drop _all
		input age5 pop
1	69135
2	72533
3	73032
4	72169
5	66478
6	64529
7	71044
8	80762
9	81851
10	72118
11	62716
12	48454
13	38793
14	34264
15	31773
16	26999
17	17842
18	15508
		end

** International Standard dataset Number
gen intdn = 001
label var intdn "US Std Million (18 age groups)"

** Age labelling
label define age5_lab  	1 "0-4"    2 "5-9"	  3 "10-14"	///
		            4 "15-19"  5 "20-24"  6 "25-29"	///
					7 "30-34"  8 "35-39"  9 "40-44"	///
		           10 "45-49" 11 "50-54" 12 "55-59"	///
				   13 "60-64" 14 "65-69" 15 "70-74"	///
		           16 "75-79" 17 "80-84" 18 "85 & over", modify
label values age5 age5_lab
label var age5 "US standard 5-year age-grouping (18 groups)"

** TEN age groups in TEN-year bands. 
** This is the standard for all standard population distributions
gen age10 = recode(age5,2,4,6,8,10,12,14,16,17)
recode age10 2=1 4=2 6=3 8=4 10=5 12=6 14=7 16=8 17=9
label define age10_lab  1 "0-9"	   2 "10-19"  3 "20-29"	///
		            	4 "30-39"  5 "40-49"  6 "50-59"	///
						7 "60-69"  8 "70-79"  9 "80 & over" , modify
label values age10 age10_lab

** TEN age groups in TEN-year bands with <15 as first group. 
** This is another standard for population distributions
gen age_10 = recode(age5,3,5,7,9,11,13,15,17,18)
recode age_10 3=1 5=2 7=3 9=4 11=5 13=6 15=7 17=8 18=9
label define age_10_lab 	1 "0-14"   2 "15-24"  3 "25-34"	///
				4 "35-44"  5 "45-54"  6 "55-64"	///
				7 "65-74"  8 "75-84"  9 "85 & over" , modify
label values age_10 age_10_lab

gen age45 = recode(age5,9,18)
recode age45 9=1 18=2
label define age45_lab  1 "0-44"   2 "45 & over" , modify
label values age45 age45_lab

gen age55 = recode(age5,11,18)
recode age55 11=1 18=2
label define age55_lab  1 "0-54"   2 "55 & over" , modify
label values age55 age55_lab

gen age60 = recode(age5,12,18)
recode age60 12=1 18=2
label define age60  1 "0-59"   2 "60 & over" , modify
label values age60 age60

sort age5
label data "US standard population: 5-year age bands"

save "data\population\us2000_5.dta", replace

preserve
collapse (sum) pop , by(age10 age60 intdn)
	label data "US standard population: 10-year age bands1"
	sort age10
save "data\population\us2000_10-1.dta", replace

collapse (sum) pop , by(age60 intdn)
	label data "US standard population: 2 age groups. <60 and 60+"
	sort age60
save "data\population\us2000_60.dta", replace
restore

collapse (sum) pop , by(age_10 age45 age55 intdn)
	label data "US standard population: 10-year age bands2"
	sort age_10
save "data\population\us2000_10-2.dta", replace

collapse (sum) pop , by(age45 age55 intdn)
	label data "US standard population: 2 age groups. <45 and 45 & over"
	sort age45
save "data\population\us2000_45.dta", replace

collapse (sum) pop , by(age55 intdn)
	label data "US standard population: 2 age groups. <55 and 55 & over"
	sort age55
save "data\population\us2000_55.dta", replace



