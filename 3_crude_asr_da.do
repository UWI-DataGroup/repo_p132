** This is the third *do* file to be called by the master file.

 ******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *                                                              
 *  DO FILE: 		3_crude_asr_da
 *					3rd dofile: Incidence Rates
 *	 							  - crude: all sites
 *	 							  - ASR(ASIR): all sites, world & US(2000) pop
 *	 							  - ASR(ASIR): all sites, by sex (world & US)
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

log using "logfiles\3_crude_asr_2014_da.smcl", replace

** Automatic page scrolling of output
set more off


**************************************************************************************************************
* SECTION 2: INCIDENCE RATES
*	 (2.1) crude, all cancers, all sites (tumours only)
*	 (2.2) IR age-std to world popn ALL cancers (tumours only); and by sex; and std to US (2000) popn
* BELOW NOT DONE FOR 2014 DATA, AS ONLY APPLICABLE TO PREVIOUS DATA COLLECTION YEARS
*	 (2.3) crude and IR age-std to world popn all cancers EXCLUDING non-melanoma skin cancers (tumours only)
*	 (2.4) IR age-std to world popn all cancers by sex (without non-melanoma skin cancers a.k.a. NMSC)
**************************************************************************************************************
** Load the dataset
use "data\2014_cancer_numbers_da.dta", replace

** First, recode sex to match with the IR data
tab sex ,m
rename sex sex_old
gen sex=1 if sex_old==2
replace sex=2 if sex_old==1
drop sex_old
label drop sex_lab
label define sex_lab 1 "female" 2 "male"
label values sex sex_lab
tab sex ,m
** 529 males; 511 females - 465 male 462 female

rename _merge _merge_dc
merge m:m sex age_10 using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\population\bb2010_10-2.dta"
/*
    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                               927  (_merge==3)
    -----------------------------------------
*/

replace case=0 if case==. //0 changes since all cases where matched to pop data
gen pfu=1 // for % year if not whole year collected; not done for cancer


*************************************************
* (2.1a) Crude IR, all TUMOURS with
*       SE and 95% Confidence Interval
*************************************************

** (2.1a) All tumours - in situ & invasive
preserve
	* crude rate: point estimate
	gen cancerpop = 1
	label define crude 1 "cancer events" ,modify
	label values cancerpop crude

	collapse (sum) case (mean) pop_bb , by(pfu cancerpop age_10 sex)
	collapse (sum) case pop_bb , by(pfu cancerpop)
	
	** Weighting for incidence calculation IF period is NOT exactly one year
	** (where it is 1 year, pfu=1)
	rename pop_bb fpop_bb
	gen pop_bb = fpop_bb * pfu
	
	gen ir = (case / pop_bb) * (10^5)
	label var ir "Crude Incidence Rate"

	* Standard Error
	gen se = ( (case^(1/2)) / pop_bb) * (10^5)

	* Lower 95% CI
	gen lower = ( (0.5 * invchi2(2*case, (0.05/2))) / pop_bb ) * (10^5)
	* Upper 95% CI
	gen upper = ( (0.5 * invchi2(2*(case+1), (1-(0.05/2)))) / pop_bb ) * (10^5)

	* Display the results
	label var pop_bb "P-Y"
	label var case "Cases"
	label var ir "IR"
	label var se "SE"
	label var lower "95% lo"
	label var upper "95% hi"
	foreach var in ir se lower upper {
			format `var' %8.2f
			}
	list case pop_bb ir se lower upper , noobs table
** THIS IS FOR ALL TUMOURS
/*
  +--------------------------------------------------+
  | case   pop_bb       ir      se    lower    upper |
  |--------------------------------------------------|
  |  927   277814   333.68   10.96   312.54   355.87 |
  +--------------------------------------------------+
*/
restore


** (2.1b) All tumours - invasive ONLY

** JC added below code for 2014 to match how IARC CI5-XI
** reports (see below link) - they exclude non-invasive tumours
display `"{browse "http://ci5.iarc.fr/CI5-XI/Pages/summary_table_site_sel.aspx":IARC-CI5-XI-Online-Analysis}"'

preserve

	drop if beh!=3 //24 obs deleted
	* crude rate: point estimate
	gen cancerpop = 1
	label define crude 1 "cancer events" ,modify
	label values cancerpop crude

	collapse (sum) case (mean) pop_bb, by(pfu cancerpop age_10 sex)
	collapse (sum) case pop_bb, by(pfu cancerpop)
	
	** Weighting for incidence calculation IF period is NOT exactly one year
	** (where it is 1 year, pfu=1)
	rename pop_bb fpop_bb
	gen pop_bb = fpop_bb * pfu
	
	gen ir = (case / pop_bb) * (10^5)
	label var ir "Crude Incidence Rate"

	* Standard Error
	gen se = ( (case^(1/2)) / pop_bb) * (10^5)

	* Lower 95% CI
	gen lower = ( (0.5 * invchi2(2*case, (0.05/2))) / pop_bb ) * (10^5)
	* Upper 95% CI
	gen upper = ( (0.5 * invchi2(2*(case+1), (1-(0.05/2)))) / pop_bb ) * (10^5)

	* Display the results
	label var pop_bb "P-Y"
	label var case "Cases"
	label var ir "IR"
	label var se "SE"
	label var lower "95% lo"
	label var upper "95% hi"
	foreach var in ir se lower upper {
			format `var' %8.2f
			}
	list case pop_bb ir se lower upper , noobs table
** THIS IS FOR ALL TUMOURS - INVASIVE ONLY
/*
  +--------------------------------------------------+
  | case   pop_bb       ir      se    lower    upper |
  |--------------------------------------------------|
  |  903   259284   348.27   11.59   325.92   371.74 |
  +--------------------------------------------------+
*/

** JC update: Save these results as a dataset to use for DQI
rename ir crude
rename se crude_se
collapse case crude crude_se
save "data\dqi\2014_cancer_dqi_crude.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - All Sites: Crude Rate"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

************************************************************
* 2.2 IR age-standardised to WHO world popn - ALL TUMOURS
************************************************************

** (2.2a) All tumours (M&F) age-std Using WHO World Standard Population
preserve
	drop if age_10==.
	collapse (sum) case (mean) pop_bb, by(pfu age_10 sex)
	collapse (sum) case pop_bb, by(pfu age_10)

	** -distrate is a user written command.
	** type -search distrate,net- at the Stata prompt to find and install this command
	** JC: I typed - ssc install distrate
	** it installed ok as of 08oct2017:
	** checking distrate consistency and verifying not already installed...
	** installing into c:\ado\plus\...
	** installation complete.

sort age_10
total pop_bb

distrate case pop_bb using "data\population\who2000_10-2", 	///	
		         stand(age_10) popstand(pop) mult(100000) format(%8.2f)
** THIS IS FOR ALL TUMOURS - STD TO WHO WORLD POPN
restore

** (2.2b) All INVASIVE tumours (M&F) age-std Using WHO World Standard Population
preserve
	drop if age_10==. //0 obs deleted
	drop if beh!=3 //24 obs deleted
	collapse (sum) case (mean) pop_bb, by(pfu age_10 sex)
	collapse (sum) case pop_bb, by(pfu age_10)
/*	replace pop=54760 if pop==26755
	replace pop=37040 if pop==18530
*/
	** -distrate is a user written command.
	** type -search distrate,net- at the Stata prompt to find and install this command
	** JC: I typed - ssc install distrate
	** it installed ok as of 08oct2017:
	** checking distrate consistency and verifying not already installed...
	** installing into c:\ado\plus\...
	** installation complete.

sort age_10
total pop_bb

distrate case pop_bb using "data\population\who2000_10-2", 	///	
		         stand(age_10) popstand(pop) mult(100000) saving(ASR,replace) format(%8.2f)
** THIS IS FOR ALL INVASIVE TUMOURS - STD TO WHO WORLD POPN

/*
  +-------------------------------------------------------------+
  | case        N    crude   rateadj   lb_gam   ub_gam   se_gam |
  |-------------------------------------------------------------|
  |  903   259284   348.27    230.32   214.93   246.61     8.00 |
  +-------------------------------------------------------------+
*/

** JC update: Save these results as a dataset to use for DQI
use ASR.dta ,clear
rename rateadj asr
rename se_gam asr_se
collapse N asr asr_se
save "data\dqi\2014_cancer_dqi_asr.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - All Sites: Age-Std Incidence Rate"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

tab pop age_10  if sex==1 //female
tab pop age_10  if sex==2 //male

** (2.2c) NEXT: FOR MEN
preserve
    drop if age_10==. //0 obs deleted
	drop if beh!=3 //24 obs deleted
	drop if sex==1 //487 obs deleted
		
    collapse (sum) case (mean) pop_bb, by(age_10 sex)
    
  	collapse (sum) case pop_bb, by(age_10)	

    
    ** -distrate is a user written command.
    ** type -search distrate,net- at the Stata prompt to find and install this command
    sort age_10

    distrate case pop_bb using "data\population\who2000_10-2",     ///    
                 stand(age_10) popstand(pop) mult(100000) saving(ASRM,replace) format(%8.2f)
* THIS IS FOR INVASIVE TUMOURS STD TO WHO WORLD POPN (MEN ONLY) - with reportable tumours
/*
  +-------------------------------------------------------------+
  | case        N    crude   rateadj   lb_gam   ub_gam   se_gam |
  |-------------------------------------------------------------|
  |  465   133011   349.60    265.72   241.81   291.44    12.50 |
  +-------------------------------------------------------------+
*/

** JC update: Save these results as a dataset to use for DQI
use ASRM.dta ,clear
rename case casem
rename N N_male
rename rateadj asrm
rename se_gam asrm_se
collapse casem N_male asrm asrm_se
save "data\dqi\2014_cancer_dqi_asr_male.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - All Sites: Age-Std Incidence Rate(Men)"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

** (2.2d) NEXT: FOR WOMEN
preserve
    drop if age_10==. //0 obs deleted
	drop if beh!=3 //24 obs deleted now missing age_10: 15-24
	drop if sex==2 //529 obs deleted
    collapse (sum) case (mean) pop_bb, by(age_10 sex)
    
  	collapse (sum) case pop_bb, by(age_10)
 	** For missing age group 15-24, updated by JC for 2014 data
	expand 2 in 1
	replace age_10=2 in 9
	replace case=0 in 9
	replace pop_bb=18530 in 9
	sort age_10
	
    ** -distrate is a user written command.
    ** type -search distrate,net- at the Stata prompt to find and install this command
    sort age_10

    distrate case pop_bb using "data\population\who2000_10-2",     ///    
                 stand(age_10) popstand(pop) mult(100000) saving(ASRF,replace) format(%8.2f)
* THIS IS FOR INVSAIVE TUMOURS STD TO WHO WORLD POPN (WOMEN ONLY) - with reportable tumours
/*
  +-------------------------------------------------------------+
  | case        N    crude   rateadj   lb_gam   ub_gam   se_gam |
  |-------------------------------------------------------------|
  |  438   144803   302.48    202.64   183.27   223.61    10.15 |
  +-------------------------------------------------------------+
*/

** JC update: Save these results as a dataset to use for DQI
use ASRF.dta ,clear
rename case casef
rename N N_female
rename rateadj asrf
rename se_gam asrf_se
collapse casef N_female asrf asrf_se
save "data\dqi\2014_cancer_dqi_asr_female.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - All Sites: Age-Std Incidence Rate(Women)"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

** (2.2e) All tumours (M&F) age-std Using US 2000 Standard Population (SEER)
preserve
	drop if age_10==.
	collapse (sum) case (mean) pop_bb, by(pfu age_10 sex)
	collapse (sum) case pop_bb, by(pfu age_10)

	** -distrate is a user written command.
	** type -search distrate,net- at the Stata prompt to find and install this command

sort age_10
total pop_bb

distrate case pop_bb using "data\population\us2000_10-2", 	///	
		         stand(age_10) popstand(pop) mult(100000) format(%8.2f)
** THIS IS FOR ALL TUMOURS - STD TO US 2000 POPN
/*
  +-------------------------------------------------------------+
  | case        N    crude   rateadj   lb_gam   ub_gam   se_gam |
  |-------------------------------------------------------------|
  |  927   277814   333.68    312.02   292.16   332.90    10.31 |
  +-------------------------------------------------------------+
*/
restore

** JC 06dec18: below code not applicable to 2014 data
/*
***************************************************************
* 2.3: INCIDENCE RATES - NO non-melanoma SKIN cancers (NMSC)
***************************************************************
drop if skin==1

*************************************************
* (2.3a) Crude IR, all TUMOURS with
*       SE and 95% Confidence Interval (no NMSC)
*************************************************
preserve
	* crude rate: point estimate
	gen cancerpop = 1
	label define crude 1 "cancer events" ,modify
	label values cancerpop crude

	collapse (sum) case (mean) pop_bb , by(pfu cancerpop age_10 sex)
	collapse (sum) case pop_bb , by(pfu cancerpop)
	
	** Weighting for incidence calculation IF period is NOT exactly one year
	** (where it is 1 year, pfu=1)
	rename pop_bb fpop_bb
	gen pop_bb = fpop_bb * pfu
	
	gen ir = (case / pop_bb) * (10^5)
	label var ir "Crude Incidence Rate"

	* Standard Error
	gen se = ( (case^(1/2)) / pop_bb) * (10^5)

	* Lower 95% CI
	gen lower = ( (0.5 * invchi2(2*case, (0.05/2))) / pop_bb ) * (10^5)
	* Upper 95% CI
	gen upper = ( (0.5 * invchi2(2*(case+1), (1-(0.05/2)))) / pop_bb ) * (10^5)

	* Display the results
	label var pop_bb "P-Y"
	label var case "Cases"
	label var ir "IR"
	label var se "SE"
	label var lower "95% lo"
	label var upper "95% hi"
	foreach var in ir se lower upper {
			format `var' %8.2f
			}
	list case pop_bb ir se lower upper , noobs table
** THIS IS FOR ALL TUMOURS - NO NMSC
restore


*********************************************************************
* (2.3b) IR age-standardised to WHO world popn - ALL TUMOURS NO NMSCs
*********************************************************************
** Using WHO World Standard Population
preserve
	drop if age_10==.
	collapse (sum) case (mean) pop_bb, by(pfu age_10 sex)
	collapse (sum) case pop_bb, by(pfu age_10)

	** -distrate is a user written command.
	** type -search distrate,net- at the Stata prompt to find and install this command

sort age_10
total pop_bb

distrate case pop_bb using "data\population\who2000_10-2", 	///	
		         stand(age_10) popstand(pop) mult(100000) format(%8.2f)
** THIS IS FOR ALL TUMOURS - STD TO WHO WORLD POPN - NO NMSCs
restore

** Using WHO World Standard Population NO NMSC AND NO NON-INVASIVE!
preserve
	drop if age_10==. | beh<3
	collapse (sum) case (mean) pop_bb, by(pfu age_10 sex)
	collapse (sum) case pop_bb, by(pfu age_10)

	** -distrate is a user written command.
	** type -search distrate,net- at the Stata prompt to find and install this command

sort age_10
total pop_bb

distrate case pop_bb using "data\population\who2000_10-2", 	///	
		         stand(age_10) popstand(pop) mult(100000) format(%8.2f)
** THIS IS FOR ALL TUMOURS - STD TO WHO WORLD POPN - NO NMSCs
restore

**************************************
** 2.4 IR BY SEX no NMSC  age-std
** with SE and 95% Confidence Interval  
**************************************

** Using WHO World Standard Population: FIRST FOR MEN
preserve
    drop if age_10==.
	drop if sex==1
    collapse (sum) case (mean) pop_bb, by(age_10 sex)
    
  	collapse (sum) case pop_bb, by(age_10)
    
    ** -distrate is a user written command.
    ** type -search distrate,net- at the Stata prompt to find and install this command
    sort age_10

    distrate case pop_bb using "data\population\who2000_10-2",     ///    
                 stand(age_10) popstand(pop) mult(100000) format(%8.2f)
* THIS IS FOR TUMOURS STD TO WHO WORLD POPN - no NMSC
restore


**************************************
** 2.4 IR BY SEX no NMSC  age-std
** with SE and 95% Confidence Interval  
**************************************
	
** Using WHO World Standard Population: FIRST FOR MEN - ALSO NO NON_INVASIVES
** JC: none in 2013 dataset - so made code defunct as it's causing the dofile not to run
** from this point on
/*preserve
    **drop if age_10==. | beh!=3
	**drop if sex==1
    **collapse (sum) case (mean) pop_bb, by(age_10 sex)
    
  	**collapse (sum) case pop_bb, by(age_10)
    
    ** -distrate is a user written command.
    ** type -search distrate,net- at the Stata prompt to find and install this command
    **sort age_10


    **distrate case pop_bb using "data\population\who2000_10-2",     ///    
                 **stand(age_10) popstand(pop) mult(100000) format(%8.2f)
* THIS IS FOR TUMOURS STD TO WHO WORLD POPN - no NMSC
restore*/


* Using WHO World Standard Population: NEXT FOR WOMEN
preserve
    drop if age_10==.
	drop if sex==2
    collapse (sum) case (mean) pop_bb, by(age_10 sex)
    
  	collapse (sum) case pop_bb, by(age_10)
    
    ** -distrate is a user written command.
    ** type -search distrate,net- at the Stata prompt to find and install this command
    sort age_10

    distrate case pop_bb using "data\population\who2000_10-2",     ///    
                 stand(age_10) popstand(pop) mult(100000) format(%8.2f)
* THIS IS FOR TUMOURS STD TO WHO WORLD POPN - no NMSC & no non-invasives
restore


* Using WHO World Standard Population: NEXT FOR WOMEN - NO NON-INVASIVES AND NO NMSCs
preserve
    drop if age_10==.
	drop if sex==2
	drop if beh<3
    collapse (sum) case (mean) pop_bb, by(age_10 sex)
    
  	collapse (sum) case pop_bb, by(age_10)
	
    ** -distrate is a user written command.
    ** type -search distrate,net- at the Stata prompt to find and install this command
    sort age_10

    distrate case pop_bb using "data\population\who2000_10-2",     ///    
                 stand(age_10) popstand(pop) mult(100000) format(%8.2f)
* THIS IS FOR TUMOURS STD TO WHO WORLD POPN - no NMSC & no non-invasives
restore
*/
