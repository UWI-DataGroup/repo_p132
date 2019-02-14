** This is the ninth *do* file to be called by the master file.

 ******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *                                                              
 *  DO FILE: 		9_dqi_cancer_dc
 *					9th dofile: Data Quality Indicators
 *
 *	STATUS:			Completed
 *
 *  FIRST RUN: 		03dec2018
 *
 *	LAST RUN:		19dec2018
 *
 *  ANALYSIS: 		Producing reports on data quality indicators (DQI)
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

log using "logfiles\9_dqi_cancer_2014_dc.smcl", replace

set more off

*****************************
** Identifying & Reporting **
** 	 Data Quality Index	   **
**	  Multiple Sources     **
**		& Duplicates	   **
*****************************
use "data\clean\2014_cancer_cleaned_dupslabel_cods_dc.dta" ,clear


** Create word doc for NS of duplicates but want to retain this dataset
preserve
** % tumours - Duplicates
gen dupdqi=. //2,553 missing values
replace dupdqi=1 if eidmp==. & dxyr==2014 & (dupsource>1 & dupsource<5) //984 changes
replace dupdqi=2 if eidmp==1 & dupsource==1 & dxyr==2014 //910 changes
replace dupdqi=3 if dxyr!=2014 | (dupsource==5|dupsource==6)
tab dupdqi ,m
tab dxyr dupdqi ,m
replace dupdqi=2 if dupdqi==. //11 changes
label define dupdqi_lab 1 "duplicates" 2 "non-duplicates" 3 "ineligibles" , modify
label values dupdqi dupdqi_lab
tab eidmp ,m
tab dupsource eidmp ,m
tab dupsource eidmp if dxyr==2014 ,m
tab dupdqi ,m
tab dupsource dupdqi ,m
contract dupdqi, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, style(Heading1)
putdocx text ("Duplicates"), bold
putdocx paragraph
putdocx text ("# duplicates: "), bold font(Helvetica,10)
putdocx text ("984"), shading("yellow") bold font(Helvetica,10)
putdocx paragraph
putdocx text ("# non-duplicates: "), bold font(Helvetica,10)
putdocx text ("921"), shading("yellow") bold font(Helvetica,10)
putdocx paragraph
putdocx text ("# ineligibles: "), bold font(Helvetica,10)
putdocx text ("648"), shading("yellow") bold font(Helvetica,10)
putdocx paragraph, halign(center)
putdocx text ("Duplicates (total records/n=2,553)"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename dupdqi Total_Duplicates
rename count Total_Records
rename percentage Pct_Multiple_Duplicates
putdocx table tbl_dups = data("Total_Duplicates Total_Records Pct_Multiple_Duplicates"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_dups(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", replace
putdocx clear

save "data\clean\2014_cancer_dqi_dups.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Duplicates"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

** Create word doc for SAF of sources but want to retain this dataset
** NB: some sources need updating from 7-BNRdb to 4-IPS and 1-QEH
preserve

count if sourcename==7 & length(labnum)<8 //2
replace sourcename=4 if sourcename==7 & length(labnum)<8 //2 changes
count if sourcename==7
replace sourcename=1 if sourcename==7 //1 change

contract sourcename, freq(count) percent(percentage)
gsort -count

putdocx clear
putdocx begin

// Create a paragraph
putdocx paragraph, style(Heading1)
putdocx text ("Sources"), bold
putdocx paragraph, halign(center)
putdocx text ("Sources (total records/n=2,553)"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename sourcename Source
rename count Total_Records
rename percentage Pct_Source
putdocx table tbl_source = data("Source Total_Records Pct_Source"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_source(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_source.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Sources"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

** Need to drop dup sources for multiple sources DQI and to use for upcoming dofiles
drop if eidmp==. //1,638; 1,602 obs deleted

count if cr5cod=="" & slc==2 //4 - 20141263, 20141385, 20141542, 20145082 (correct-cr5cod unk)
list pid dupsource ptrectot recstatus dxyr cr5id if cr5cod=="" & slc==2
count if (cr5cod!="" & cr5cod!="99") & slc!=2 //0

tab pidobstot //includes MPs (see 20140786 using pidobstot==6 to illustrate point for exclusion of MPs when calculating DQI)
/*
  pidobstot |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |        342       35.96       35.96
          2 |        301       31.65       67.61
          3 |        207       21.77       89.38
          4 |         70        7.36       96.74
          5 |         27        2.84       99.58
          6 |          3        0.32       99.89
          8 |          1        0.11      100.00
------------+-----------------------------------
      Total |        951      100.00
*/
tab pidobstot if eidmp==1 //excludes MPs (see 20140786 using pidobstot==6 to illustrate point for exclusion of MPs when calculating DQI)
/*
  pidobstot |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |        342       36.38       36.38
          2 |        300       31.91       68.30
          3 |        206       21.91       90.21
          4 |         67        7.13       97.34
          5 |         22        2.34       99.68
          6 |          2        0.21       99.89
          8 |          1        0.11      100.00
------------+-----------------------------------
      Total |        940      100.00
*/

** JC 14nov18 - need to exclude 2013 cases when running stats for 2014
tab pidobstot if dxyr==2014 //includes MPs (see 20140786 using pidobstot==6 to illustrate point for exclusion of MPs when calculating DQI)
/*
  pidobstot |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |        331       35.94       35.94
          2 |        291       31.60       67.54
          3 |        201       21.82       89.36
          4 |         67        7.27       96.63
          5 |         27        2.93       99.57
          6 |          3        0.33       99.89
          8 |          1        0.11      100.00
------------+-----------------------------------
      Total |        921      100.00
*/
tab pidobstot if eidmp==1 & dxyr==2014 //excludes MPs (see 20140786 using pidobstot==6 to illustrate point for exclusion of MPs when calculating DQI)
/*
  pidobstot |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |        331       36.37       36.37
          2 |        290       31.87       68.24
          3 |        200       21.98       90.22
          4 |         64        7.03       97.25
          5 |         22        2.42       99.67
          6 |          2        0.22       99.89
          8 |          1        0.11      100.00
------------+-----------------------------------
      Total |        910      100.00
*/

** Create pdf for NS of multiple sources but want to retain this dataset
preserve
** % Sources per tumour (no MPs) - need to exclude MPs so sources are not over-counted
drop if eidmp==2 | dxyr!=2014 //41 obs deleted
tab pidobstot
contract pidobstot, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, style(Heading1)
putdocx text ("Multiple Sources"), bold
putdocx paragraph
putdocx text ("# patients: "), bold font(Helvetica,10)
putdocx text ("900"), shading("yellow") bold font(Helvetica,10)
putdocx paragraph
putdocx text ("# tumours: "), bold font(Helvetica,10)
putdocx text ("910"), shading("yellow") bold font(Helvetica,10)
putdocx paragraph
putdocx text ("# (multiple tumours) MPs: "), bold font(Helvetica,10)
putdocx text ("11"), shading("yellow") bold font(Helvetica,10)
putdocx paragraph, halign(center)
putdocx text ("Multiple Sources (# tumours/n=910)"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename pidobstot Total_Sources
rename count Total_Records
rename percentage Pct_Multiple_Sources
putdocx table tbl_ms = data("Total_Sources Total_Records Pct_Multiple_Sources"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_ms(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_ms.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Multiple Sources"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore


*****************************
** Identifying & Reporting **
** 	 Data Quality Index	   **
**	  	NRN/Residency      **
*****************************

use "data\clean\2014_cancer_merge_dqi_dc.dta" , clear

tab natregno patient ,m //116; 3 from national deaths
replace natregno=nrn if ptrectot==2 //109 changes - 7 have blank nrn; 3 changes
tab natregno patient ,m
tab natregno patient if natregno==""|natregno=="999999-9999"|regexm(natregno, "9999") ,m //40; 33
list pid deathid dob natregno if natregno==""|natregno=="999999-9999"|regexm(natregno, "9999")

count if resident==1 & (natregno==""|natregno=="999999-9999"|regexm(natregno, "9999")) //1
** Checked on resident=yes but no nrn in CR5db & electoral list
replace natregno="440724-8030" if pid=="20140975" //1 change

gen nrn_dqi=natregno if natregno!=""|natregno!="999999-9999"
replace nrn_dqi="" if regexm(natregno, "9999")

tab nrn_dqi patient ,m

tab patient ,m
/*
cancer patient |      Freq.     Percent        Cum.
---------------+-----------------------------------
       patient |        912       98.38       98.38
separate event |         15        1.62      100.00
---------------+-----------------------------------
         Total |        927      100.00
*/
tab resident ,m
/*
ResidentSta |
        tus |      Freq.     Percent        Cum.
------------+-----------------------------------
        Yes |        872       94.07       94.07
    Unknown |         55        5.93      100.00 -- 3 national DCOs incl. in resident=unk.
------------+-----------------------------------
      Total |        927      100.00
*/

gen nrndqi=1 if nrn_dqi!=""
replace nrndqi=2 if nrn_dqi=="" //39 changes; 32 changes
label define nrndqi_lab 1 "NRN" 2 "no NRN" , modify
label values nrndqi nrndqi_lab

tab nrndqi ,m

tab nrndqi resident ,m
tab resident nrndqi ,m
/*
ResidentSt |        nrndqi
      atus |       NRN     no NRN |     Total
-----------+----------------------+----------
       Yes |       872          0 |       872 
   Unknown |        23         32 |        55 
-----------+----------------------+----------
     Total |       895         32 |       927 
*/

gen resdqi=1 if resident==1 & nrndqi==1
replace resdqi=2 if resident==1 & nrndqi==2 //0 changes
replace resdqi=3 if resident!=1 & nrndqi==1 //129 changes; 23 changes
replace resdqi=4 if resident!=1 & nrndqi!=1 //39 changes; 32 changes
label define resdqi_lab 1 "resident,NRN" 2 "resident,no NRN" 3 "no resident,NRN" 4 "no resident,no NRN" , modify
label values resdqi resdqi_lab

tab resdqi ,m
/*
            resdqi |      Freq.     Percent        Cum.
-------------------+-----------------------------------
      resident,NRN |        872       94.07       94.07
   no resident,NRN |         23        2.48       96.55
no resident,no NRN |         32        3.45      100.00
-------------------+-----------------------------------
             Total |        927      100.00
*/
** Create .docx for NS of NRNs but want to retain this dataset
preserve
** % tumours - NRN
tab nrndqi
contract nrndqi, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, style(Heading1)
putdocx text ("NRN"), bold
putdocx paragraph
putdocx text ("# patients: "), bold font(Helvetica,10)
putdocx text ("912"), shading("yellow") bold font(Helvetica,10)
putdocx paragraph
putdocx text ("# tumours: "), bold font(Helvetica,10)
putdocx text ("927"), shading("yellow") bold font(Helvetica,10)
putdocx paragraph
putdocx text ("# (multiple tumours) MPs: "), bold font(Helvetica,10)
putdocx text ("15"), shading("yellow") bold font(Helvetica,10)
putdocx paragraph, halign(center)
putdocx text ("NRNs (# tumours/n=927)"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename nrndqi Total_NRNs
rename count Total_Records
rename percentage Pct_NRNs
putdocx table tbl_nrn = data("Total_NRNs Total_Records Pct_NRNs"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_nrn(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_nrn.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - NRNs"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

** Append to above .docx for NS of resident status but want to retain this dataset
preserve
** % tumours - Resident Status
tab resident
contract resident, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx paragraph, style(Heading1)
putdocx text ("Resident Status"), bold
putdocx paragraph, halign(center)
putdocx text ("Resident Status (# tumours/n=927)"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename resident Total_Resident
rename count Total_Records
rename percentage Pct_Resident
putdocx table tbl_res = data("Total_Resident Total_Records Pct_Resident"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_res(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_res.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Resident Status"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

** Append to above .docx for NS of resident status & NRN but want to retain this dataset
preserve
** % tumours - resident and NRN
tab resdqi
contract resdqi, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx paragraph, style(Heading1)
putdocx text ("NRN & Resident Status"), bold
putdocx paragraph, halign(center)
putdocx text ("Resident Status & NRN (# tumours/n=927)"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename resdqi Total_ResidentNRN
rename count Total_Records
rename percentage Pct_ResidentNRN
putdocx table tbl_resnrn = data("Total_ResidentNRN Total_Records Pct_ResidentNRN"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_resnrn(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_resnrn.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Resident Status & NRN"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

*****************************
** Identifying & Reporting **
** 	 Data Quality Index	   **
** MV,DCO,O+U,UnkAge,CLIN  **
*****************************
tab basis ,m
gen boddqi=1 if basis>4 & basis <9 //720 changes; 
replace boddqi=2 if basis==0 //245 changes; 132 changes
replace boddqi=3 if basis>0 & basis<5 //52 changes
replace boddqi=4 if basis==9 //23 changes
label define boddqi_lab 1 "MV" 2 "DCO"  3 "CLIN" 4 "UNK.BASIS" , modify
label var boddqi "basis DQI"
label values boddqi boddqi_lab

gen siteagedqi=1 if siteiarc==61 //51 changes; 45 changes
replace siteagedqi=2 if age==.|age==999 //3 changes
replace siteagedqi=3 if dob==. & siteagedqi!=2 //141 changes; 28 changes
replace siteagedqi=4 if siteiarc==61 & siteagedqi!=1 //9 changes - 9 O&U with missing dob; 3 changes
label define siteagedqi_lab 1 "O&U SITE" 2 "UNK.AGE" 3 "UNK.DOB" 4 "O&U+UNK.AGE/DOB" , modify
label var siteagedqi "site/age DQI"
label values siteagedqi siteagedqi_lab

tab boddqi ,m
generate rectot=_N //1,040; 927
tab boddqi rectot,m

tab siteagedqi ,m
tab siteagedqi rectot,m

** Append to above .docx for NS of basis,site,age but want to retain this dataset
preserve
** % tumours - basis
tab boddqi
contract boddqi, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, style(Heading1)
putdocx text ("Basis"), bold
putdocx paragraph, halign(center)
putdocx text ("Basis (# tumours/n=927)"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename boddqi Total_DQI
rename count Total_Records
rename percentage Pct_DQI
putdocx table tbl_bod = data("Total_DQI Total_Records Pct_DQI"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_bod(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_basis.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Basis"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report
restore

preserve
** % tumours - site,age
tab siteagedqi
contract siteagedqi, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx paragraph, style(Heading1)
putdocx text ("Unknown - Site, DOB & Age"), bold
putdocx paragraph, halign(center)
putdocx text ("Site,DOB,Age (# tumours/n=927)"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename siteagedqi Total_DQI
rename count Total_Records
rename percentage Pct_DQI
putdocx table tbl_site = data("Total_DQI Total_Records Pct_DQI"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_site(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_siteage.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Site,Age"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report
restore


** Append to above .docx for NS of basis,grade,dxtime but want to retain this dataset
** Trying to examine why O&U is high
preserve
drop if siteiarc!=61 //989 obs deleted; 882 obs deleted
contract basis, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, style(Heading1)
putdocx text ("O&U - Basis"), bold
putdocx paragraph, halign(center)
putdocx text ("O&U (total records/n=45)"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename basis Total_BOD
rename count Total_Records
rename percentage Pct_BOD
putdocx table tbl_bod = data("Total_BOD Total_Records Pct_BOD"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_bod(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_bod.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - BOD for O&U"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

preserve
drop if siteiarc!=61 //989 obs deleted; 882 obs deleted
contract grade, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx paragraph, style(Heading1)
putdocx text ("O&U - Grade"), bold
rename grade Total_Grade
rename count Total_Records
rename percentage Pct_Grade
putdocx table tbl_grade = data("Total_Grade Total_Records Pct_Grade"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_grade(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_grade.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Grade for O&U"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

preserve
drop if siteiarc!=61 //989 obs deleted

gen dxtime=dlc-dot //44 changes
replace dxtime=dod-dot if dxtime==. //7 changes

contract dxtime, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx paragraph, style(Heading1)
putdocx text ("O&U - Days Between Dx & DLC"), bold
rename dxtime Total_DaysDxDLC
rename count Total_Records
rename percentage Pct_DaysDxDLC
putdocx table tbl_dxtime = data("Total_DaysDxDLC Total_Records Pct_DaysDxDLC"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_dxtime(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_dxtime.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - DxTime for O&U"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore


** Append to above .docx for NS of site-male but want to retain this dataset
preserve
** % tumours - basis
tab boddqi
tab siteiarc if boddqi==1 & sex==1 //male
contract siteiarc if boddqi==1 & sex==1, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, style(Heading1)
putdocx text ("Sites - Male"), bold
putdocx paragraph, halign(center)
putdocx text ("Sites for Male, all ages (# tumours/n=927)"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename siteiarc Total_Site
rename count Total_Records
rename percentage Pct_Site
putdocx table tbl_sitemale = data("Total_Site Total_Records Pct_Site"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil) layout(autofitcontents)
putdocx table tbl_sitemale(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_sitemale.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Site: Male"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report
restore


** Append to above .docx for NS of site-female but want to retain this dataset
preserve
** % tumours - basis
tab boddqi
tab siteiarc if boddqi==1 & sex==2 //female
contract siteiarc if boddqi==1 & sex==2, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, style(Heading1)
putdocx text ("Sites - Female"), bold
putdocx paragraph, halign(center)
putdocx text ("Sites for Female, all ages (# tumours/n=927)"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename siteiarc Total_Site
rename count Total_Records
rename percentage Pct_Site
putdocx table tbl_sitefemale = data("Total_Site Total_Records Pct_Site"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil) layout(autofitcontents)
putdocx table tbl_sitefemale(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_sitefemale.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Site: Female"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report
restore

** Below no longer needed as 113 of 116 national DCOs have been accounted for (see end of dofile 5 for update)
*************************
** Checking CF sources **
**  116 national DCOs  **
*************************
/*
** Append to above .docx for NS of CF sources for 116 national DCOs but want to retain this dataset
preserve
** % tumours - pod, district
tab pod district if ptrectot==2
drop if ptrectot!=2
contract pod district, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, halign(center)
putdocx text ("CF Sources: National DCOs - POD,District"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("(# tumours/n=116)"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename pod Place_of_Death
rename district Total_DIST
rename count Total_Records
rename percentage Pct_DIST
putdocx table tbl_pod = data("Place_of_Death Total_DIST Total_Records Pct_DIST"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_pod(1,.), bold
putdocx table tbl_pod(23,.), shading("yellow") bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_pod.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - POD,District: National DCOs"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

***********************
** Death Certificate **
**    Casefinding    **
***********************

use "data\clean\2014_cancer_merge_dcostatus_dqi_dc.dta" ,clear

** Append to above .docx for NS of CF sources for 116 national DCOs but want to retain this dataset
preserve
** % tumours (deceased) - dcostatus
drop if slc==1 //430 obs deleted
tab dcostatus ,m
contract dcostatus, freq(count) percent(percentage)

putdocx clear
putdocx begin

// Create a paragraph
putdocx paragraph, halign(center)
putdocx text ("CF Source: Death Certificates"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("(# tumours/n=638[deceased])"), bold font(Helvetica,14,"blue")
putdocx paragraph
rename dcostatus Death_Certificate_Status
rename count Total_Records
rename percentage Pct_DC
putdocx table tbl_dcstat = data("Death_Certificate_Status Total_Records Pct_DC"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil)
putdocx table tbl_dcstat(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_dcostatus.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - DC Status"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore
*/


*****************************
** Identifying & Reporting **
** 	 Data Quality Index	   **
** 	   Top 10 Cancers	   **
*****************************

** Load top10 dataset: all sites
use "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_top10all.dta" ,clear

** Append to above .docx for NS of top10 cancers but want to retain this dataset
preserve

putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, style(Heading1)
putdocx text ("Top 10 Cancers"), bold
putdocx paragraph, halign(center)
putdocx text ("Top 10 Cancers: All Sites"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("(# tumours/n=1,016)"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("(non-invasive tumours excluded)"), bold font(Helvetica,14,"blue")
rename siteiarc Site
rename count Total_Records
rename percentage Pct_AllSites
putdocx table tbl_top10all = data("Site Total_Records Pct_AllSites"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil) layout(autofitcontents)
putdocx table tbl_top10all(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_top10all.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Top 10 Sites: allbO&U"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

** Load top10 dataset: all sites but O&U
use "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_top10allbO&U.dta" ,clear

** Append to above .docx for NS of top10 cancers but want to retain this dataset
preserve

putdocx clear
putdocx begin

// Create a paragraph
putdocx paragraph, style(Heading1)
putdocx text ("Top 10 Cancers excl. O&U"), bold
putdocx paragraph, halign(center)
putdocx text ("Top 10 Cancers: All Sites but O&U"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("(# tumours/n=965)"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("('non-invasive tumours' & 'other/unk site' excluded)"), bold font(Helvetica,14,"blue")
rename siteiarc Site
rename count Total_Records
rename percentage Pct_AllSites
putdocx table tbl_top10allbOU = data("Site Total_Records Pct_AllSites"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil) layout(autofitcontents)
putdocx table tbl_top10allbOU(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_top10allbO&U.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Top 10 Sites: allbO&U"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

*****************************
** Identifying & Reporting **
** 	 Data Quality Index	   **
**  Top 5 Cancers by Sex   **
*****************************

** Load top5 dataset: men
use "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_top5_male.dta" ,clear

** Append to above .docx for NS of top5 cancers but want to retain this dataset
preserve

putdocx clear
putdocx begin

// Create a paragraph
putdocx paragraph, style(Heading1)
putdocx text ("Top 5 Cancers - Male"), bold
putdocx paragraph, halign(center)
putdocx text ("Top 5 Cancers: MEN"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("(# tumours/n=502)"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("('non-invasive tumours', 'other/unk site' & females excluded)"), bold font(Helvetica,14,"blue")
rename siteiarc Site
rename count Total_Records
rename percentage Pct_AllSites
putdocx table tbl_top5m = data("Site Total_Records Pct_AllSites"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil) layout(autofitcontents)
putdocx table tbl_top5m(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_top5_male.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Top 5 Sites: MEN"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

** Load top5 dataset: women
use "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_top5_female.dta" ,clear

** Append to above .docx for NS of top5 cancers but want to retain this dataset
preserve

putdocx clear
putdocx begin

// Create a paragraph
putdocx paragraph, style(Heading1)
putdocx text ("Top 5 Cancers - Female"), bold
putdocx paragraph, halign(center)
putdocx text ("Top 5 Cancers: WOMEN"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("(# tumours/n=463)"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("('non-invasive tumours', 'other/unk site' & males excluded)"), bold font(Helvetica,14,"blue")
rename siteiarc Site
rename count Total_Records
rename percentage Pct_AllSites
putdocx table tbl_top5f = data("Site Total_Records Pct_AllSites"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil) layout(autofitcontents)
putdocx table tbl_top5f(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_top5_female.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Top 5 Sites: WOMEN"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

*****************************
** Identifying & Reporting **
** 	 Data Quality Index	   **
** 	   M:I Ratio(MIR)	   **
*****************************

use "data\clean\2014_cancer_mort_dc.dta" ,clear
tab dodyear if mrcancer==1,m
/*
Taken from dofile 8_mortality_cacner_dc:
    Year of |
      death |      Freq.     Percent        Cum.
------------+-----------------------------------
       2014 |        651      100.00      100.00
------------+-----------------------------------
      Total |        651      100.00
*/
gen deaths=_N if mrcancer==1 //651
save "data\clean\2014_cancer_mort_dqi_dc.dta" ,replace

use "data\clean\2014_cancer_merge_dqi_dc.dta" , clear
gen incidence=_N //927

append using "data\clean\2014_cancer_mort_dqi_dc.dta" ,force

replace deaths=651 if deaths==.
replace incidence=927 if incidence==.
gen mirdqi=deaths/incidence*100
format mirdqi %8.1f

** M:I ratio for top 10 sites
/*
egen deaths39=count(siteiarc) if siteiarc==39 & mrcancer==1 
egen rectot39=count(siteiarc) if siteiarc==39 & mrcancer==.
*/
** PROSTATE
count if siteiarc==39 & mrcancer==1 //150
count if siteiarc==39 & mrcancer==. //198
gen mirdqi39=150/198*100 if siteiarc==39
format mirdqi39 %8.1f

** BREAST
count if siteiarc==29 & mrcancer==1 //72
count if siteiarc==29 & mrcancer==. //159
gen mirdqi29=72/159*100 if siteiarc==29
format mirdqi29 %8.1f

** COLON
count if siteiarc==13 & mrcancer==1 //71
count if siteiarc==13 & mrcancer==. //114
gen mirdqi13=71/114*100 if siteiarc==13
format mirdqi13 %8.1f

** O&U
count if siteiarc==61 & mrcancer==1 //57
count if siteiarc==61 & mrcancer==. //45
gen mirdqi61=57/45*100 if siteiarc==61
format mirdqi61 %8.1f

** CORPUS UTERI
count if siteiarc==33 & mrcancer==1 //21
count if siteiarc==33 & mrcancer==. //39
gen mirdqi33=21/39*100 if siteiarc==33
format mirdqi33 %8.1f

** LUNG
count if siteiarc==21 & mrcancer==1 //41
count if siteiarc==21 & mrcancer==. //32
gen mirdqi21=41/32*100 if siteiarc==21
format mirdqi21 %8.1f

** MM
count if siteiarc==55 & mrcancer==1 //22
count if siteiarc==55 & mrcancer==. //28
gen mirdqi55=22/28*100 if siteiarc==55
format mirdqi55 %8.1f

** RECTUM
count if siteiarc==14 & mrcancer==1 //20
count if siteiarc==14 & mrcancer==. //28
gen mirdqi14=20/28*100 if siteiarc==14
format mirdqi14 %8.1f

** BLADDER
count if siteiarc==45 & mrcancer==1 //13
count if siteiarc==45 & mrcancer==. //24
gen mirdqi45=13/24*100 if siteiarc==45
format mirdqi45 %8.1f

** PANCREAS
count if siteiarc==18 & mrcancer==1 //29
count if siteiarc==18 & mrcancer==. //21
gen mirdqi18=29/21*100 if siteiarc==18
format mirdqi18 %8.1f

** STOMACH
count if siteiarc==11 & mrcancer==1 //20
count if siteiarc==11 & mrcancer==. //21
gen mirdqi11=20/21*100 if siteiarc==11
format mirdqi11 %8.1f


** Append to above .docx for NS of basis,site,age but want to retain this dataset
preserve
tab mirdqi siteiarc ,m
tab siteiarc mirdqi

** M:I ratio
tab mirdqi ,m
gen mirdqisite=mirdqi39 if siteiarc==39
replace mirdqisite=mirdqi29 if siteiarc==29
replace mirdqisite=mirdqi13 if siteiarc==13
replace mirdqisite=mirdqi61 if siteiarc==61
replace mirdqisite=mirdqi33 if siteiarc==33
replace mirdqisite=mirdqi21 if siteiarc==21
replace mirdqisite=mirdqi55 if siteiarc==55
replace mirdqisite=mirdqi14 if siteiarc==14
replace mirdqisite=mirdqi45 if siteiarc==45
replace mirdqisite=mirdqi18 if siteiarc==18
replace mirdqisite=mirdqi11 if siteiarc==11
format mirdqisite %8.2f

contract mirdqi mirdqisite siteiarc, freq(count) percent(percentage)
drop if mirdqisite==. //40 obs deleted
gsort -mirdqisite

putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, style(Heading1)
putdocx text ("M:I Ratio"), bold
putdocx paragraph, halign(center)
putdocx text ("Mortality:Incidence Ratio"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("(# deaths/n=651 and # tumours/n=927)  "), bold font(Helvetica,14,"blue")
putdocx text ("(MIR=deaths/incidence: 70.2%)"), bold font(Helvetica,14,"blue")
rename siteiarc Site
rename mirdqisite Total_MIRDQI
rename count Total_Records
rename percentage Pct_MIRDQI
putdocx table tbl_mir = data("Site Total_MIRDQI Total_Records Pct_MIRDQI"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil) layout(autofitcontents)
putdocx table tbl_mir(1,.), bold
putdocx table tbl_mir(2,.), shading("yellow") bold
putdocx table tbl_mir(3,.), shading("yellow") bold
putdocx table tbl_mir(4,.), shading("yellow") bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_mir.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Mortality:Incidence Ratio"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore


*****************************
** Identifying & Reporting **
** 	 Data Quality Index	   **
** 	   Incidence Rate	   **
*****************************

** Create new site variable with CI5-XI incidence classifications (see chapter 3 Table 3.1. of that volume) based on icd10
display `"{browse "http://ci5.iarc.fr/CI5-XI/Pages/summary_table_site_sel.aspx":IARC-CI5-XI-Online-Analysis}"'

use "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_crude_siteiarc.dta" ,clear
sort siteiarc
expand 2 in 1
replace siteiarc=63 in 49
replace case=0 in 49
total(case)
replace case=903 in 49
replace crude_siteiarc = (case / pop_bb) * (10^5) in 49
replace crudese_siteiarc = ( (case^(1/2)) / pop_bb) * (10^5) in 49
drop pop_bb
** for crude rate with case ir se

preserve
putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, style(Heading1)
putdocx text ("Crude Rates"), bold
putdocx paragraph, halign(center)
putdocx text ("Crude Rate: ALL Sites, Both Sexes"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("(# tumours/n=903)"), bold font(Helvetica,14,"blue")
rename siteiarc Cancer
rename case Cases
rename crude_siteiarc Crude_Rate
rename crudese_siteiarc Crude_Rate_SE
putdocx table tbl_crude = data("Cancer Cases Crude_Rate Crude_Rate_SE"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil) layout(autofitcontents)
putdocx table tbl_crude(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_crude_siteiarc_ALL.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Crude Rate: ALL Sites"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

** Create dataset with Site, Case, Population, Crude, ASR, ASR(SE)
use "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_63all.dta" ,clear
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_63allf.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_63allm.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_39prostate.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_39prostatem.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_29breast.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_29breastf.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_29breastm.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_13colon.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_13colonf.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_13colonm.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_33corpus.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_33corpusf.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_21lung.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_21lungf.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_21lungm.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_55MM.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_55MMf.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_55MMm.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_14rectum.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_14rectumf.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_14rectumm.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_45bladder.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_45bladderf.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_45bladderm.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_11stomach.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_11stomachf.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_11stomachm.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_18pancreas.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_18pancreasf.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_18pancreasm.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_32cervix.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_32cervixf.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_61o&u.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_61o&uf.dta"
append using "L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\dqi\2014_cancer_dqi_asr_61o&um.dta"

** Label necessary variables
label define sex_lab 1 "female" 2 "male" 3 "both sexes" ,modify
label var sex "sex"
label values sex sex_lab

label define siteiarc_lab ///
1 "Lip (C00)" 2 "Tongue (C01-02)" 3 "Mouth (C03-06)" ///
4 "Salivary gland (C07-08)" 5 "Tonsil (C09)" 6 "Other oropharynx (C10)" ///
7 "Nasopharynx (C11)" 8 "Hypopharynx (C12-13)" 9 "Pharynx unspecified (C14)" ///
10 "Oesophagus (C15)" 11 "Stomach (C16)" 12 "Small intestine (C17)" ///
13 "Colon (C18)" 14 "Rectum (C19-20)" 15 "Anus (C21)" ///
16 "Liver (C22)" 17 "Gallbladder etc. (C23-24)" 18 "Pancreas (C25)" ///
19 "Nose, sinuses etc. (C30-31)" 20 "Larynx (C32)" ///
21 "Lung (incl. trachea and bronchus) (C33-34)" 22 "Other thoracic organs (C37-38)" ///
23 "Bone (C40-41)" 24 "Melanoma of skin (C43)" 25 "Other skin (C44)" ///
26 "Mesothelioma (C45)" 27 "Kaposi sarcoma (C46)" 28 "Connective and soft tissue (C47+C49)" ///
29 "Breast (C50)" 30 "Vulva (C51)" 31 "Vagina (C52)" 32 "Cervix uteri (C53)" ///
33 "Corpus uteri (C54)" 34 "Uterus unspecified (C55)" 35 "Ovary (C56)" ///
36 "Other female genital organs (C57)" 37 "Placenta (C58)" ///
38 "Penis (C60)" 39 "Prostate (C61)" 40 "Testis (C62)" 41 "Other male genital organs (C63)" ///
42 "Kidney (C64)" 43 "Renal pelvis (C65)" 44 "Ureter (C66)" 45 "Bladder (C67)" ///
46 "Other urinary organs (C68)" 47 "Eye (C69)" 48 "Brain, nervous system (C70-72)" ///
49 "Thyroid (C73)" 50 "Adrenal gland (C74)" 51 "Other endocrine (C75)" ///
52 "Hodgkin lymphoma (C81)" 53 "Non-Hodgkin lymphoma (C82-86,C96)" ///
54 "Immunoproliferative diseases (C88)" 55 "Multiple myeloma (C90)" ///
56 "Lymphoid leukaemia (C91)" 57 "Myeloid leukaemia (C92-94)" 58 "Leukaemia unspecified (C95)" ///
59 "Myeloproliferative disorders (MPD)" 60 "Myselodysplastic syndromes (MDS)" ///
61 "Other and unspecified (O&U)" ///
62 "All sites(ALL)" 63 "All sites but skin (ALLbC44)" ///
64 "D069: CIN 3"
label var siteiarc "IARC CI5-XI sites"
label values siteiarc siteiarc_lab

sort siteiarc
drop pop_bb

** All sites, sexes, ages
preserve
drop if sex!=3 //both female and male

gen percentcase=case/903*100
format percentcase %8.2f

putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, style(Heading1)
putdocx text ("Incidence Rates - Both Sexes, all ages"), bold
putdocx paragraph, halign(center)
putdocx text ("Incidence Rates: ALL Sites, Both Sexes"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("(# tumours/n=903)"), bold font(Helvetica,14,"blue")
rename siteiarc Cancer
rename case Cases
rename percentcase Pct_Cases
rename crude Crude_Rate
rename asr ASR
rename asr_se ASR_SE
putdocx table tbl_asr_all = data("Cancer Cases Pct_Cases Crude_Rate ASR ASR_SE"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil) layout(autofitcontents)
putdocx table tbl_asr_all(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_asr_siteiarc_ALL.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Incidence Rate: ALL Sites, Both Sexes"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

** All sites, ages - female only
preserve
drop if sex!=1 //female only

gen percentcase=case/438*100
format percentcase %8.2f

putdocx clear
putdocx begin

// Create a paragraph
putdocx pagebreak
putdocx paragraph, style(Heading1)
putdocx text ("Incidence Rates - Female, all ages"), bold
putdocx paragraph, halign(center)
putdocx text ("Incidence Rates: Female, all sites & ages"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("(# tumours/n=438)"), bold font(Helvetica,14,"blue")
rename siteiarc Cancer
rename case Cases
rename percentcase Pct_Cases
rename crude Crude_Rate
rename asr ASR
rename asr_se ASR_SE
putdocx table tbl_asr_all = data("Cancer Cases Pct_Cases Crude_Rate ASR ASR_SE"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil) layout(autofitcontents)
putdocx table tbl_asr_all(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_asr_siteiarc_ALL_female.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Incidence Rate: ALL Sites, Female"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore

** All sites, ages - male only
preserve
drop if sex!=2 //male only

gen percentcase=case/465*100
format percentcase %8.2f

putdocx clear
putdocx begin

// Create a paragraph
putdocx paragraph, style(Heading1)
putdocx text ("Incidence Rates - Male, all ages"), bold
putdocx paragraph, halign(center)
putdocx text ("Incidence Rates: Male, all sites & ages"), bold font(Helvetica,14,"blue")
putdocx paragraph, halign(center)
putdocx text ("(# tumours/n=465)"), bold font(Helvetica,14,"blue")
rename siteiarc Cancer
rename case Cases
rename percentcase Pct_Cases
rename crude Crude_Rate
rename asr ASR
rename asr_se ASR_SE
putdocx table tbl_asr_all = data("Cancer Cases Pct_Cases Crude_Rate ASR ASR_SE"), varnames  ///
        border(start, nil) border(insideV, nil) border(end, nil) layout(autofitcontents)
putdocx table tbl_asr_all(1,.), bold

putdocx save "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_DQI.docx", append
putdocx clear

save "data\clean\2014_cancer_dqi_asr_siteiarc_ALL_male.dta" ,replace
label data "BNR-Cancer 2014 Data Quality Index - Incidence Rate: ALL Sites, Male"
notes _dta :These data prepared for Natasha Sobers - 2014 annual report

restore


** Add in contents, page numbers to Word doc by adding a template to above Word doc
** NB: you will need to open newly created Word doc to update contents then save
putdocx append "data\clean\dqi_contents.docx" "data\clean\2018-12-18_DQI.docx" "data\clean\dqi_template.docx", saving("data\clean\2018-12-19_DQI.docx", replace)


** Now create one dataset using all the DQI datasets
use "data\clean\2014_cancer_dqi_dups.dta" ,clear
append using "data\clean\2014_cancer_dqi_source.dta"
append using "data\clean\2014_cancer_dqi_ms.dta"
append using "data\clean\2014_cancer_dqi_nrn.dta"
append using "data\clean\2014_cancer_dqi_res.dta"
append using "data\clean\2014_cancer_dqi_resnrn.dta"
append using "data\clean\2014_cancer_dqi_basis.dta"
append using "data\clean\2014_cancer_dqi_siteage.dta"
append using "data\clean\2014_cancer_dqi_bod.dta"
append using "data\clean\2014_cancer_dqi_grade.dta"
append using "data\clean\2014_cancer_dqi_dxtime.dta"
append using "data\clean\2014_cancer_dqi_sitemale.dta"
append using "data\clean\2014_cancer_dqi_sitefemale.dta"
append using "data\clean\2014_cancer_dqi_top10all.dta"
append using "data\clean\2014_cancer_dqi_top10allbO&U.dta"
append using "data\clean\2014_cancer_dqi_top5_male.dta"
append using "data\clean\2014_cancer_dqi_top5_female.dta"
append using "data\clean\2014_cancer_dqi_mir.dta"
append using "data\clean\2014_cancer_dqi_crude_siteiarc_ALL.dta"
append using "data\clean\2014_cancer_dqi_asr_siteiarc_ALL.dta"
append using "data\clean\2014_cancer_dqi_asr_siteiarc_ALL_female.dta"
append using "data\clean\2014_cancer_dqi_asr_siteiarc_ALL_male.dta"

save "data\clean\2014_cancer_dqi_all_dc.dta" ,replace
label data "BNR-Cancer Cleaning: Data Quality Indicators"
notes _dta :These data prepared for 2014 ABS phase

