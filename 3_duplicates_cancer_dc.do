** This is the third *do* file to be called by the master file.

 ******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *                                                              
 *  DO FILE: 		3_duplicates_cancer_dc
 *					3rd dofile: Duplicate Data Prep
 *
 *	STATUS:			Completed
 *
 *  FIRST RUN: 		07nov2018
 *
 *	LAST RUN:		03dec2018
 *
 *  ANALYSIS: 		Identifying duplicates (multiple sources, multiple tumours)
 *					Preparing data for merging cancer and death data
 *					JC uses for basis of checkflags for cancer team corrections
 *					Also used for producing data quality indicators (DQI)
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

log using "logfiles\3_duplicates_cancer_2014_dc.smcl", replace

set more off

**************************************
** DATA PREPARATION  
**************************************
** LOAD the prepared dataset
use "data\clean\2014_cancer_clean_dups_dc.dta" ,clear

count //2,554; 2,555; 2,554; 2,553

*****************************
** Identifying & Labelling **
** 		  Duplicate		   **
**	 Tumours and Sources   **
*****************************

/* 
Each multiple sources from CR5 dataset is imported into Stata as 
a separate observation and some tumour records are multiple sources for the abstracted tumour
so need to differentiate between 
multiple (duplicate) sources (MSs) for same pt vs multiple (primary) tumours (MPs) for same pt:
(1) The MSs will assessed for data quality index then dropped before death merge;
(2) The MPs will be kept throughout datasets.
*/
gen dupsource=0 //2,554; 2,553
label var dupsource "Multiple Sources"
label define dupsource_lab  1 "MS-Conf Tumour Rec" 2 "MS-Conf Source Rec" ///
							3 "MS-Dup Tumour Rec" 4 "MS-Dup Tumour & Source Rec" ///
							5 "MS-Ineligible Tumour 1 Rec" 6 "MS-Ineligible Tumour 2~ & Source Rec" , modify
label values dupsource dupsource_lab

replace dupsource=1 if recstatus==1 & regexm(cr5id,"S1") //916; 955; 951 changes - this is the # eligible non-duplicate tumours
replace dupsource=2 if recstatus==1 & !strmatch(strupper(cr5id), "*S1") //774; 805; 808; 807 changes
replace dupsource=3 if recstatus==4 & regexm(cr5id,"S1") //196 changes
replace dupsource=4 if recstatus==4 & !strmatch(strupper(cr5id), "*S1") //19 changes
replace dupsource=5 if recstatus==3 & cr5id=="T1S1" //463; 425 changes
replace dupsource=6 if recstatus==3 & cr5id!="T1S1" //186; 155 changes

** Now identify MPs (multiple tumours for same pt) among eligible non-duplicate tumours (921; 955)
tab pid if dupsource==1

sort pid
bysort pid: gen duppid = _n if dupsource==1 //1,638; 1,600; 1,603; 1,602 missing values so 921; 955; 951 changes

sort pid
bysort pid: gen duppid_all = _n

tab duppid_all ,m
sort lname fname pid
** Now check list of only eligible non-duplicate tumours for 'true' and 'false' MPs by first & last names
count if dupsource==1 //921; 955; 951
list pid duppid fname lname natregno sex age cr5id if dupsource==1 //921; 955; 951 - corrections made to '2_clean_cancer_dc.do' so totals different now
/*
List of 'true' MPs (i.e. same pt, diff. tumour according to IARC MP rules) from above check list:
(1) 20140077 - colon
(2) 20140176 - breast, rectum 
(3) 20140474 - kidney, breast 
(4) 20140555 - breast
(5) 20140566 - pharynx, oesophagus
(6) 20140570 - bm, prostate
(7) 20140690 - cervix, ovary, breast
(8) 20140786 - ln, spine
(9) 20140887 - colon
(10) 20141351 - colon

List of 'false' (i.e. same name, diff. pts) MPs from above check list:
(1) 20140882 & 20145025
(2) 20140553 & 20140613
(3) 20140170 & 20141505
(4) 20140997 & 20141362
(5) 20140451 & 20141415
(6) 20141406 & 20141446
*/

** Now double-check list of only eligible non-duplicate tumours for MPs but by NRN
preserve
drop if natregno=="" | natregno=="999999-9999" | regexm(natregno, "9999-9999")
drop if dupsource!=1
sort natregno lname fname pid
quietly by natregno :  gen dupnrn = cond(_N==1,0,_n)
sort natregno
count if dupnrn>0 //36; 21 - corrections made to '2_clean_cancer_dc.do' so totals different now - only shows 10 MPs
list pid fname lname natregno sex age dupnrn duppid if dupnrn>0
restore

** Now double-check list of only eligible non-duplicate tumours for MPs but by hospital #
preserve
drop if hospnum=="" | hospnum=="99"
drop if dupsource!=1
sort hospnum lname fname pid
quietly by hospnum :  gen duphosp = cond(_N==1,0,_n)
sort hospnum
count if duphosp>0 //18; 16
list pid fname lname hospnum natregno sex age duphosp duppid if duphosp>0
restore

** Based on above list, create variable to identify MPs
gen eidmptxt = substr(eid,-1,1)
destring eidmptxt ,replace
gen eidmp=1 if eidmptxt==1 & dupsource==1 //1,659; 1,621; 1,623 missing values generated
replace eidmp=2 if eidmptxt>1 & dupsource==1 //21 changes
label var eidmp "CR5 tumour events"
label define eidmp_lab 1 "single tumour" 2 "multiple tumour" ,modify
label values eidmp eidmp_lab
** Check if eidmp below match with MPs identified on hardcopy list
count if dupsource==1 //916; 955; 951
sort pid lname fname
list pid eidmp dupsource duppid cr5id fname lname if dupsource==1 
**replace eidmp=2 if pid=="20141551" & cr5id=="T2S1" //1 change - no longer on updated list as of 14nov18 this pt inelgibile & not a MP
replace eidmp=2 if pid=="20140474" & cr5id=="T3S1" //1 change
replace eidmp=2 if pid=="20140570" & cr5id=="T2S1" //1 change
replace eidmp=2 if pid=="20140786" & cr5id=="T2S1" //1 change

** Create variable to identify patient records
gen ptrectot=. //2,554; 2,553 missing values
replace ptrectot=1 if eidmp==1 //893; 927 changes
replace ptrectot=3 if eidmp==2 //23; 24 changes
label define ptrectot_lab 1 "CR5 pt with single event" 2 "DCO with single event" 3 "CR5 pt with multiple events" ///
						  4 "DCO with multiple events" 5 "CR5 pt: single event but multiple DC events" , modify
label values ptrectot ptrectot_lab
/*
Now check:
	(1) patient record with T1 are included in category 3 of ptrectot but leave eidmp=single tumour so this var can be used to count MPs
	(2) patient records with only 1 tumour but maybe labelled as T2 are not included in eidmp and are included in category 1 of ptrectot
*/
count if eidmp==2 & dupsource==1 //23; 24
list pid eidmp dupsource duppid cr5id fname lname if eidmp==2 & dupsource==1

replace ptrectot=1 if pid=="20080196" & cr5id=="T2S1" //1 change
replace eidmp=1 if pid=="20080196" & cr5id=="T2S1" //1 change
replace ptrectot=1 if pid=="20141021" & cr5id=="T2S1" //1 change
replace eidmp=1 if pid=="20141021" & cr5id=="T2S1" //1 change
replace ptrectot=1 if pid=="20130162" & cr5id=="T2S1" //1 change
replace eidmp=1 if pid=="20130162" & cr5id=="T2S1" //1 change
replace ptrectot=1 if pid=="20080690" & cr5id=="T3S1" //1 change
replace eidmp=1 if pid=="20080690" & cr5id=="T3S1" //1 change
replace ptrectot=1 if pid=="20080677" & cr5id=="T2S1" //1 change
replace eidmp=1 if pid=="20080677" & cr5id=="T2S1" //1 change
replace ptrectot=1 if pid=="20080242" & cr5id=="T2S1" //1 change
replace eidmp=1 if pid=="20080242" & cr5id=="T2S1" //1 change
replace ptrectot=1 if pid=="20080401" & cr5id=="T2S1" //1 change
replace eidmp=1 if pid=="20080401" & cr5id=="T2S1" //1 change
replace ptrectot=1 if pid=="20080607" & cr5id=="T2S1" //1 change
replace eidmp=1 if pid=="20080607" & cr5id=="T2S1" //1 change
replace ptrectot=1 if pid=="20090016" & cr5id=="T2S1" //1 change
replace eidmp=1 if pid=="20090016" & cr5id=="T2S1" //1 change
replace ptrectot=1 if pid=="20140966" & cr5id=="T2S1" //1 change
replace eidmp=1 if pid=="20140966" & cr5id=="T2S1" //1 change
replace ptrectot=1 if pid=="20130275" & cr5id=="T3S1" //1 change
replace eidmp=1 if pid=="20130275" & cr5id=="T3S1" //1 change
replace ptrectot=1 if pid=="20130294" & cr5id=="T2S1" //1 change
replace eidmp=1 if pid=="20130294" & cr5id=="T2S1" //1 change
replace ptrectot=1 if pid=="20130175" & cr5id=="T2S1" //1 change
replace eidmp=1 if pid=="20130175" & cr5id=="T2S1" //1 change

replace ptrectot=3 if pid=="20140555" & cr5id=="T1S1" //1 change
**replace ptrectot=3 if pid=="20141551" & cr5id=="T1S1" //1 change - no longer on updated list as of 14nov18 this pt inelgibile & not a MP
replace ptrectot=3 if pid=="20140887" & cr5id=="T1S1" //1 change
replace ptrectot=3 if pid=="20140690" & cr5id=="T1S1" //1 change
replace ptrectot=3 if pid=="20140566" & cr5id=="T1S1" //1 change
replace ptrectot=3 if pid=="20140176" & cr5id=="T1S1" //1 change
replace ptrectot=3 if pid=="20141351" & cr5id=="T1S1" //1 change
replace ptrectot=3 if pid=="20140786" & cr5id=="T1S1" //1 change
replace ptrectot=3 if pid=="20140077" & cr5id=="T1S1" //1 change
** as of 14nov18 - below new ones added to updated list
replace ptrectot=3 if pid=="20140474" & cr5id=="T1S1" //1 change
replace ptrectot=3 if pid=="20140570" & cr5id=="T1S1" //1 change

** Count # of patients with eligible non-dup tumours
count if ptrectot==1 //897; 930

** Count # of eligible non-dup tumours
count if eidmp==1 //906; 940

** Count # of eligible non-dup MPs
count if eidmp==2 //10; 11

** JC 14nov18 - I forgot about missed 2013 cases in dataset so stats for 2014 only:
** Count # of patients with eligible non-dup tumours
count if ptrectot==1 & dxyr==2014 //900

** Count # of eligible non-dup tumours
count if eidmp==1 & dxyr==2014 //910

** Count # of eligible non-dup MPs
count if eidmp==2 & dxyr==2014 //11

/* 
Count # of multiple source records per tumour:
(1)Create variables based on built-in Stata variables (_n, _N) to calculate obs count:
		(a) _n is Stata notation for the current observation number (varname: pidobsid)
		(b) _N is Stata notation for the total number of observations (varname: pidobstot)
(2)Create variables to store overall obs # and obs total (obsid, obstot) for DQI
*/

sort pid
by pid: generate pidobsid=_n //gives sequence id for each pid that appears in dataset
by pid: generate pidobstot=_N //give total count for each pid that is duplicated in dataset


tab pidobstot ,m //all tumours - need to drop dup sources records to assess DQI for multiple sources per tumour
/*
  pidobstot |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |        642       25.15       25.15
          2 |        832       32.59       57.74
          3 |        669       26.20       83.94
          4 |        280       10.97       94.91
          5 |        110        4.31       99.22
          6 |         12        0.47       99.69
          8 |          8        0.31      100.00
------------+-----------------------------------
      Total |      2,553      100.00
*/

/* JC 08nov18 - was checking built-in Stata duplicate command but not specific enough for DQI
duplicates list pid, nolabel sepby(pid)
duplicates tag pid, gen(dup_id)
list pid cr5id if dup_id == 1, nolabel sepby(pid)

list pid cr5id if dup_id == 5 & eidmp==1, nolabel sepby(pid)
list pid cr5id if dup_id == 5 & eidmp==2, nolabel sepby(pid)
*/

** Save dataset with dups to use for death data prep (dofile 4)
save "data\clean\2014_cancer_cleaned_dupslabel_dc.dta" ,replace
label data "BNR-Cancer Cleaning: Duplicate sources"
notes _dta :These data prepared for 2014 ABS phase


************************
**  Copying COD info  **
** into source record **
**  to use for merge  **
************************
** Before dropping duplicates, need to ensure cr5cod is retained in main dataset for when matching with national death data
** Note to self: Need to research for the future if there is a way in Stata to transfer data from one observation to another
count if eidmp!=. & cr5cod=="" & slc==2 //112; 111
list pid cr5id dxyr if eidmp!=. & cr5cod=="" & slc==2

duplicates tag pid, gen(dup_pid)
count if dup_pid>1 & slc==2 //732; 736
count if dup_pid>1 & slc==2 & (nftype==8|nftype==9) //292; 294
list pid eidmp nftype cr5id if dup_pid>1 & slc==2 & (nftype==8|nftype==9), nolabel sepby(pid)
list cr5cod if dup_pid>1 & slc==2 & (nftype==8|nftype==9), nolabel sepby(pid)

order pid cr5id cr5cod eidmp
/*
14nov18 JC: this method of updating cr5cod variable with values from duplicate source records is 
time-consuming so I decided to use Data Editor in Edit mode and filtered by pid and manually 
copied and pasted cr5cod from one pid to the other. I used list above with 111 results.

For cases where the death info source had a dxyr<2014 and was dropped at beginning of dofile 2,
I've copied and pasted from CR5db.

SAVE DATASET UNDER DIFFERENT NAME SO IT'S NO OVERWRITTEN WHEN DOFILES ARE RE-RUN!!
** Save dataset with dups to use for death data prep (dofile 4)
save "data\clean\2014_cancer_cleaned_dupslabel_cods_dc.dta" ,replace
label data "BNR-Cancer Cleaning: Duplicate sources Identified & CODs copied to eligible non-duplicate tumour"
notes _dta :These data prepared for 2014 ABS phase

replace cr5cod="N CARCINOMA OF THE ASCENDING COLON" if pid=="20080401" & cr5id=="T2S1"
replace cr5cod="N METASTATIC OVARIAN CARCINOMA" if pid=="20130275" & cr5id=="T3S1"
replace cr5cod="N ASPHYXIA PRE-VERTEBRAL TUMOUR" if pid=="20140047" & cr5id=="T1S1"
replace cr5cod="N METASTATIC BREAST CANCER" if pid=="20140555" & cr5id=="T2S1"
replace cr5cod="N ADVANCED CANCER OF PHARYNX AND OESOPHAGUS" if pid=="20140566" & cr5id=="T2S1"
replace cr5cod="CARCINOMA OF THE COLON DIABETES MELLITUS" if pid=="20141248" & cr5id=="T1S1"
*/
/* 
NB: I dropped variable bas in below dataset in prep for dofile 4 dataset;
	Since this dataset was manually created, any corrections done to earlier dofiles
	after this dataset was created (14nov18) will need to be re-done in this or later dofiles.
*/
use "data\clean\2014_cancer_cleaned_dupslabel_cods_dc.dta" ,clear

count if eidmp!=. & cr5cod=="" & slc==2 //6; 4 - 20141364, 20141553 not on list so updated in Data Editor(Edit) mode
list pid cr5id if eidmp!=. & cr5cod=="" & slc==2

count if slc==2 & recstatus==3 //406
list pid dupsource eidmp cr5id if slc==2 & recstatus==3

count //2,553

gen dod=dlc if slc==2
format dod %dD_m_CY

** Corrections so cancer and death datasets for below patients can merge in dofile 5
**    List A	   **
replace slc=2 if pid=="20150175" //2 changes
replace dod=d(02apr2015) if pid=="20150175" //2 changes

replace slc=2 if pid=="20140854" //1 change
replace dod=d(05aug2017) if pid=="20140854" //1 change

replace slc=2 if pid=="20141320" //1 change
replace dod=d(22mar2017) if pid=="20141320" //1 change

replace slc=2 if pid=="20141336" //2 changes
replace dod=d(28mar2017) if pid=="20141336" //2 changes

replace slc=2 if pid=="20141341" //2 changes
replace dod=d(01sep2017) if pid=="20141341" //2 changes

replace slc=2 if pid=="20141145" //4 changes
replace dod=d(30dec2017) if pid=="20141145" //4 changes

replace slc=2 if pid=="20140892" //3 changes
replace dod=d(16apr2017) if pid=="20140892" //3 changes

replace slc=2 if pid=="20141240" //4 changes
replace dod=d(28jul2017) if pid=="20141240" //4 changes

replace sex=2 if pid=="20160029" //2 changes
replace slc=2 if pid=="20160029" //2 changes
replace dod=d(14jul2017) if pid=="20160029" //2 changes

replace slc=2 if pid=="20141300" //1 change
replace dod=d(22jan2017) if pid=="20141300" //1 change

replace slc=2 if pid=="20141308" //3 changes
replace dod=d(17mar2017) if pid=="20141308" //3 changes

replace slc=2 if pid=="20141027" //1 change
replace dod=d(07aug2017) if pid=="20141027" //1 change

replace slc=2 if pid=="20141064" //3 changes
replace dod=d(11dec2017) if pid=="20141064" //3 changes

replace sex=1 if pid=="20145107" //2 changes

replace slc=2 if pid=="20140681" //2 changes
replace dod=d(16aug2017) if pid=="20140681" //2 changes

replace slc=2 if pid=="20141115" //1 change
replace dod=d(04aug2016) if pid=="20141115" //1 change

replace sex=2 if pid=="20140695" //1 change

replace slc=2 if pid=="20141298" //1 change
replace dod=d(19feb2017) if pid=="20141298" //1 change

**    List B	   **
replace fname="ellis" if pid=="20145153" //2 changes
replace slc=2 if pid=="20141064" //1 change

**    List C	   **
replace fname="st.clair" if pid=="20140154" //1 change
replace lname="dawood-wilson" if pid=="20140465" //1 change



** Save dataset with dups to use for death data prep (dofile 4) & merge (dofile 5)
save "data\clean\2014_cancer_cleaned_dupslabel_cods_dod_dc.dta" ,replace
label data "BNR-Cancer Cleaning: Duplicate sources with T1S1=COD"
notes _dta :These data prepared for 2014 ABS phase


use "data\clean\2014_cancer_cleaned_dupslabel_cods_dc.dta" ,clear

** Need to drop dup sources for multiple sources DQI and to use for upcoming dofiles
drop if eidmp==. //1,638; 1,602 obs deleted

count if cr5cod=="" & slc==2 //4 - 20141263, 20141385, 20141542, 20145082 (correct-cr5cod unk)
list pid dupsource ptrectot recstatus dxyr cr5id if cr5cod=="" & slc==2
count if (cr5cod!="" & cr5cod!="99") & slc!=2 //0


*****************************
**   Final Clean and Prep  **
**  to merge with national **
**	      death data       **
*****************************

** Convert names to lower case and strip possible leading/trailing blanks
replace fname = lower(rtrim(ltrim(itrim(fname))))
replace init = lower(rtrim(ltrim(itrim(init))))
replace lname = lower(rtrim(ltrim(itrim(lname))))
	  
** replace deathdate with dod to allow merge IF PATIENT IS DEAD
gen dod=dlc if slc==2
format dod %dD_m_CY

gen cr5dodyear = year(dod)
label var cr5dodyear "Year of CR5 death"

count if slc==2 & recstatus==3 //0


** Put variables in order they are to appear	  
order pid cr5id dot fname lname init age sex dob natregno resident slc dlc dod /// 
	  parish cr5cod primarysite morph top lat beh hx grade eid sid


save "data\clean\2014_cancer_clean_nodups_dc.dta" ,replace
label data "BNR-Cancer Cleaning: No duplicate sources - 2013 & 2014"
notes _dta :These data prepared for 2014 ABS phase
