** This is the fourth *do* file to be called by the master file.

 ******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *                                                              
 *  DO FILE: 		4_deaths_cancer_dc
 *					4th dofile: Death Data Prep
 *
 *	STATUS:			Completed
 *
 *  FIRST RUN: 		14nov2018
 *
 *	LAST RUN:		03dec2018
 *
 *  ANALYSIS: 		Preparing data for merging cancer and death data
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

** LOAD the imported dataset
cd "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\"

log using "logfiles\4_deaths_cancer_2014_dc.smcl", replace

** Automatic page scrolling of screen output
set more off

**************************************
** DATA PREPARATION  
**************************************
** LOAD the cleaned and prepped (for REDCap) national registry deaths 2008-2017 dataset
import excel using "data\raw\Cleaned_DeathData_2008-2017_JC_20180705_excel.xlsx" , firstrow case(lower) clear

count
** 24,188 records

** Format and drop necessary variables
rename record_id deathid
format dod %dD_m_CY
label var dod "Date of death"

** record_id 14116 in death data excel file has incorrect reg date so corrected and now format working
format regdate %dD_m_CY

drop cfdate cfda

** Next we get rid of those who died pre-2013 (since there are previously unmatched 2013 cases in dataset I will drop pre-2013 instead of pre-2014 deaths)
drop if dod<d(01jan2013)

count //12,298

*****************
**  Formatting **
**    Names    **
*****************

** Need to check for duplicate death registrations
** First split full name into first, middle and last names
** Also - code to split full name into 2 variables fname and lname - else can't merge! 
split pname, parse(", "" ") gen(name)
order deathid pname name*

** First, sort cases that contain only a first name and a last name
count if name5=="" & name3=="" & name4=="" //9,162
replace name5=name2 if name5=="" & name3=="" & name4=="" //9,161
replace name2="" if name3=="" & name4=="" //9,161

** Second, sort cases with name in name6 variable
count if name6!="" //1
list deathid *name* if name6!=""
replace name1=name1+" "+name2+" "+name3+" "+name4+" "+name5 if deathid==1790 //1 change
replace name2="" if deathid==1790 //1 change
replace name3="" if deathid==1790 //1 change
replace name4="" if deathid==1790 //1 change
replace name5=name6 if deathid==1790 //1 change

** Third, sort cases with name 'baby' or 'b/o' in name1 variable
count if (regexm(name1,"BABY")|regexm(name1,"B/O")) & deathid!=1790 //35
gen tempvarn=1 if (regexm(name1,"BABY")|regexm(name1,"B/O")) & deathid!=1790
list deathid pname name1 name2 name3 name4 name5 if tempvarn==1
replace name5=name3 if deathid==1707|deathid==1708 //2 changes
replace name3="" if deathid==1707|deathid==1708 //2 changes
replace name5=name4+name5 if deathid==1794 //1 change
replace name1=name1+" "+name2+" "+name3 if tempvarn==1 //35 changes
replace name5=name4 if tempvarn==1 & (deathid!=1707 & deathid!=1708 & deathid!=1794) //32 change
list deathid pname name1 name2 name3 name4 name5 if tempvarn==1
replace name2="" if tempvarn==1 //35 changes
replace name3="" if tempvarn==1 //33 changes
replace name4="" if tempvarn==1 //33 changes

** Fourth, sort cases so that name1, name2, name5 will all contain values
list deathid pname if name2=="" & name4!="" //1 - deathid 1790 already corrected above so ignore
**replace name4=name3+" "+name4 if name2=="" & name4!="" //1 change

list deathid pname name2 name3 name4 if name5!=""
replace name2=name2+" "+name3+" "+name4 if name5!="" //9,174 changes

list deathid pname if name4!="" & name5==""
replace name2=name2+" "+name3 if name4!="" & name5=="" //230 changes

list deathid pname if name4!="" & name5==""
replace name5=name4 if name4!="" & name5=="" //230 changes

list deathid pname if name3!="" & name4=="" & name5==""
replace name5=name3 if name3!="" & name4=="" & name5=="" //2,893 changes

** Names containing 'ST' are being interpreted as 'ST'=name1/fname so correct
count if name1=="ST" | name1=="ST." //16
replace tempvarn=2 if name1=="ST" | name1=="ST."
list deathid pname name1 name2 name5 if tempvarn==2
replace name1=name1+"."+""+name2 if tempvarn==2 //16 changes
list deathid pname name1 name2 name5 if tempvarn==2
** Correct 3 individual cases where name1 and name2 need to be split for 'ST' without using pt names
gen namest=name1 if tempvarn==2
split namest, parse(", "" ") gen(nametempst)
list deathid pname name1 name2 name5 nametempst* if tempvarn==2
replace name2="" if tempvarn==2 //16 changes
replace name1=nametempst1 if deathid==21252
replace name2=nametempst2+" "+nametempst3 if deathid==21252
replace name1=nametempst1 if deathid==21264
replace name2=nametempst2 if deathid==21264
replace name1=nametempst1 if deathid==21268
replace name2=nametempst2+" "+nametempst3 if deathid==21268
list deathid pname name1 name2 name5 if tempvarn==2
** Now remove extra '.' from first name
replace name1 = subinstr(name1, ".", "",1) if deathid==21276|deathid==21278|deathid==21279|deathid==21281|deathid==21285 //5 changes
list deathid pname name1 name2 name5 if tempvarn==2
** Now rename, check and remove unnecessary variables
rename name1 fname
rename name2 mname
rename name5 lname
count if fname=="" //0
count if lname=="" //1
list deathid pname if lname==""
replace lname="99" if deathid==19196 //1 change
drop name3 name4 name6 tempvarn namest nametempst*
** Correct cases where suffix was placed in lname
gen tempmname=mname if deathid==5430|deathid==23661|deathid==3233|deathid==4424|deathid==5431
gen tempnames=mname if deathid==3233
split tempnames, parse(", "" ") gen(tempnames1)
replace mname=tempnames11 if deathid==3233
replace lname=tempnames12+" "+lname if deathid==3233
replace lname=tempmname+" "+lname if deathid==4424
replace lname=tempmname+" "+lname if deathid==5430
replace lname=tempmname+" "+lname if deathid==5431
replace lname=tempmname+" "+lname if deathid==23661
replace mname="" if deathid==4424|deathid==5430|deathid==5431|deathid==23661
drop tempnam* tempmname
** Check for cases where lname is very short as maybe error with splitting
count if (lname!="" & lname!="99") & length(lname)<3 //1 - no correction needed
list deathid pname fname mname lname if (lname!="" & lname!="99") & length(lname)<3

** Convert names to lower case and strip possible leading/trailing blanks
replace fname = lower(rtrim(ltrim(itrim(fname))))
replace mname = lower(rtrim(ltrim(itrim(mname))))
replace lname = lower(rtrim(ltrim(itrim(lname))))

order deathid pname fname mname lname namematch


*************************
** Checking & Removing ** 
**   Duplicate Death   **
**    Registrations    **
*************************
/* 
NB: These deaths were cleaned previously for importing into DeathData REDCapdb 
so the field namematch can be used as a guide for checking duplicates
	1=names match but different person
	2=no name match
*/
label define namematch_lab 1 "deaths only namematch,diff.pt" 2 "no namematch" 3 "cr5 & death namematch,diff.pt" 4 "slc=2/9,not in deathdata", modify
label values namematch namematch_lab
sort lname fname deathid
quietly by lname fname : gen dupname = cond(_N==1,0,_n)
sort lname fname deathid
count if dupname>0 //932
/* 
Check below list for cases where namematch=no match but 
there is a pt with same name then:
 (1) check if same pt and remove duplicate pt;
 (2) check if same name but different pt and
	 update namematch variable to reflect this, i.e.
	 namematch=1
*/
list deathid namematch fname lname nrn dod sex age if dupname>0

preserve
drop if nrn==""
sort nrn 
quietly by nrn : gen dupnrn = cond(_N==1,0,_n)
sort nrn deathid lname fname
count if dupnrn>0 //6
list deathid namematch fname lname nrn dod sex age if dupnrn>0
restore

** Save dataset with dups to use for death data prep (dofile 4)
save "data\raw\2014_cancer_deaths_v1_dc.dta" ,replace
label data "BNR-Cancer Cleaning: Duplicate death registrations"
notes _dta :These data prepared for 2014 ABS phase

** Correct, remove or update duplicates or nrn based on checks from above lists
/*
4424 dup of 4423
18139 dup of 18318
18563 dup of 18562
6167 dup of 6166
7700 dup of 7676 - copy mname of 7700 for 7676 in Data Editor(edit) mode
22170 dup of 22143
15485 dup of 15484
1746 dup of 1709
9516 dup of 9520
11912 dup of 11911
19618 dup of 19619
12213 dup of 12214
*/
use "data\raw\2014_cancer_deaths_v2_dc.dta" ,clear

drop if deathid==4424|deathid==18319|deathid==18563|deathid==6167|deathid==7700 ///
		|deathid==22170|deathid==15485|deathid==1746|deathid==9516|deathid==11912 ///
		|deathid==19618|deathid==12213 //12 obs deleted
replace nrn="341212-0010" if deathid==16307 //1 change
replace namematch=1 if namematch==2 & dupname>0 //360 changes

** Final check for duplicates by name and dod 
sort lname fname dod
quietly by lname fname dod: gen dupdod = cond(_N==1,0,_n)
sort lname fname dod deathid
count if dupdod>0 //2 - diff.pt & namematch already=1
list deathid namematch fname lname nrn dod sex age if dupdod>0
count if dupdod>0 & namematch!=1 //0

count //12,286

** Now generate a new variable which will select out all the potential cancers
gen cancer=.
label define cancer_lab 1 "2014 cancer" 2 "not cancer/not 2014", modify
label values cancer cancer_lab
label var cancer "cancer diagnoses"
label var deathid "Event identifier for registry deaths"

** searching cod1a for these terms
replace cancer=1 if regexm(cod1a, "CANCER") //1,524 changes
replace cancer=1 if regexm(cod1a, "TUMOUR") &  cancer==. //82 changes
replace cancer=1 if regexm(cod1a, "TUMOR") &  cancer==. //35 changes
replace cancer=1 if regexm(cod1a, "MALIGNANT") &  cancer==. //31 changes
replace cancer=1 if regexm(cod1a, "MALIGNANCY") &  cancer==. //138 changes
replace cancer=1 if regexm(cod1a, "NEOPLASM") &  cancer==. //9 changes
replace cancer=1 if regexm(cod1a, "CARCINOMA") &  cancer==. //961 changes
replace cancer=1 if regexm(cod1a, "CARCIMONA") &  cancer==. //1 change
replace cancer=1 if regexm(cod1a, "CARINOMA") &  cancer==. //1 change
replace cancer=1 if regexm(cod1a, "MYELOMA") &  cancer==. //107 changes
replace cancer=1 if regexm(cod1a, "LYMPHOMA") &  cancer==. //85 changes
replace cancer=1 if regexm(cod1a, "LYMPHOMIA") &  cancer==. //0 changes
replace cancer=1 if regexm(cod1a, "LYMPHONA") &  cancer==. //1 change
replace cancer=1 if regexm(cod1a, "SARCOMA") &  cancer==. //33 changes
replace cancer=1 if regexm(cod1a, "TERATOMA") &  cancer==. //0 changes
replace cancer=1 if regexm(cod1a, "LEUKEMIA") &  cancer==. //40 changes
replace cancer=1 if regexm(cod1a, "LEUKAEMIA") &  cancer==. //31 changes
replace cancer=1 if regexm(cod1a, "HEPATOMA") &  cancer==. //0 changes
replace cancer=1 if regexm(cod1a, "CARANOMA PROSTATE") &  cancer==. //0 changes
replace cancer=1 if regexm(cod1a, "MENINGIOMA") &  cancer==. //11 changes
replace cancer=1 if regexm(cod1a, "MYELOSIS") &  cancer==. //0 changes
replace cancer=1 if regexm(cod1a, "MYELOFIBROSIS") &  cancer==. //4 changes
replace cancer=1 if regexm(cod1a, "CYTHEMIA") &  cancer==. //0 changes
replace cancer=1 if regexm(cod1a, "CYTOSIS") &  cancer==. //2 changes
replace cancer=1 if regexm(cod1a, "BLASTOMA") &  cancer==. //9 changes
replace cancer=1 if regexm(cod1a, "METASTATIC") &  cancer==. //26 changes
replace cancer=1 if regexm(cod1a, "MASS") &  cancer==. //97 changes
replace cancer=1 if regexm(cod1a, "METASTASES") &  cancer==. //5 changes
replace cancer=1 if regexm(cod1a, "METASTASIS") &  cancer==. //3 changes
replace cancer=1 if regexm(cod1a, "REFRACTORY") &  cancer==. //0 changes
replace cancer=1 if regexm(cod1a, "FUNGOIDES") &  cancer==. //1 change
replace cancer=1 if regexm(cod1a, "HODGKIN") &  cancer==. //0 changes
replace cancer=1 if regexm(cod1a, "MELANOMA") &  cancer==. //1 change
replace cancer=1 if regexm(cod1a,"MYELODYS") &  cancer==. //8 changes

** Strip possible leading/trailing blanks in cod1a
replace cod1a = rtrim(ltrim(itrim(cod1a))) //0 changes

tab cancer, missing
/*
     cancer |
  diagnoses |      Freq.     Percent        Cum.
------------+-----------------------------------
     cancer |      3,245       26.41       26.41
          . |      9,041       73.59      100.00
------------+-----------------------------------
      Total |     12,286      100.00
*/
tab deathyear cancer,m
/*
           |   cancer diagnoses
 deathyear |    cancer          . |     Total
-----------+----------------------+----------
      2013 |       614      1,796 |     2,410 
      2014 |       692      1,804 |     2,496 
      2015 |       629      1,853 |     2,482 
      2016 |       668      1,820 |     2,488 
      2017 |       642      1,768 |     2,410 
-----------+----------------------+----------
     Total |     3,245      9,041 |    12,286
*/

** Check that all cancer CODs for 2014 are eligible
sort cod1a deathid
order deathid cod1a
list cod1a if cancer==1 & deathyear==2014 //692

** Replace 2014 cases that are not cancer according to eligibility SOP:
/*
	(1) After merge with CR5 data then may need to reassign some of below 
		deaths as CR5 data may indicate eligibility while COD may exclude
		(e.g. see deathid==15458)
	(2) use obsid to check for CODs that incomplete in Results window with 
		Data Editor in browse mode-copy and paste deathid below from here
*/
replace cancer=2 if ///
deathid==16285 |deathid==1292  |deathid==15458 |deathid==11987 |deathid==1552| ///
deathid==23771 |deathid==19815 |deathid==11910 |deathid==23750 |deathid==8118| ///
deathid==3725  |deathid==932   |deathid==3419  |deathid==23473 |deathid==19097| ///
deathid==16546 |deathid==20819 |deathid==20241 |deathid==13572 |deathid==6444| ///
deathid==4644  |deathid==14413 |deathid==16702 |deathid==14249 |deathid==14688| ///
deathid==5469  |deathid==15378 |deathid==2231  |deathid==22807 |deathid==12102| ///
deathid==22127 |deathid==23906 |deathid==6243  |deathid==22248 |deathid==18365| ///
deathid==17054 |deathid==13194 |deathid==19770 |deathid==2742  |deathid==20031| ///
deathid==8574  |deathid==10793 |deathid==20504 |deathid==20634 |deathid==5531| ///
deathid==17077 |deathid==11945 |deathid==19303 |deathid==1429  |deathid==17327| ///
deathid==7925  |deathid==23413 |deathid==5189  |deathid==12137 |deathid==16726| ///
deathid==19979 |deathid==21864 |deathid==2477  |deathid==19620 |deathid==5741| ///
deathid==183
//61 changes

** Check that all 2014 CODs that are not cancer for eligibility
tab deathyear cancer,m
/*
           |         cancer diagnoses
 deathyear |    cancer  not cancer         . |     Total
-----------+---------------------------------+----------
      2013 |       614          0      1,796 |     2,410 
      2014 |       631         61      1,804 |     2,496 
      2015 |       629          0      1,853 |     2,482 
      2016 |       668          0      1,820 |     2,488 
      2017 |       642          0      1,768 |     2,410 
-----------+---------------------------------+----------
     Total |     3,184         61      9,041 |    12,286
*/
count if cancer==. & deathyear==2014 & (deathid>0 & deathid<5000) //376
count if cancer==. & deathyear==2014 & (deathid>5000 & deathid<10000) //374
count if cancer==. & deathyear==2014 & (deathid>10000 & deathid<15000) //368
count if cancer==. & deathyear==2014 & (deathid>15000 & deathid<20000) //374
count if cancer==. & deathyear==2014 & (deathid>20000 & deathid<25000) //311
count if cancer==. & deathyear==2014 & (deathid>25000 & deathid<30000) //0

list cod1a if cancer==. & deathyear==2014 & (deathid>0 & deathid<5000)
list cod1a if cancer==. & deathyear==2014 & (deathid>5000 & deathid<10000)
list cod1a if cancer==. & deathyear==2014 & (deathid>10000 & deathid<15000)
list cod1a if cancer==. & deathyear==2014 & (deathid>15000 & deathid<20000)
list cod1a if cancer==. & deathyear==2014 & (deathid>20000 & deathid<25000)
list cod1a if cancer==. & deathyear==2014 & (deathid>25000 & deathid<30000)

** No updates needed from above list
/*
replace cancer=1 if ///
deathid==|deathid==|deathid==|deathid==|deathid==| ///
*/

replace cancer=2 if cancer==. //9,041 changes

** Create cod variable 
gen cod=.
label define cod_lab 1 "Dead of cancer" 2 "Dead of other cause" 3 "Not known" 4 "NA", modify
label values cod cod_lab
label var cod "COD categories"
replace cod=1 if cancer==1 //3,184 changes
replace cod=2 if cancer==2 //9,102 changes
** one unknown causes of death in 2014 data - deathid 12323
replace cod=3 if regexm(cod1a,"INDETERMINATE")|regexm(cod1a,"UNDETERMINED") //56 changes

** NB: pod was cleaned already
** (see data_cleaning\2008-2017\deaths\versions\version03\dofiles\2_clean_deaths.do)
tab pod ,miss 

tab dod ,m

** label sex
label define sex_lab 1 "male" 2 "female", modify
label values sex sex_lab
label var sex "Patient sex"

** label parish 
label define parish_lab 1 "Christ Church" 2 "St Andrew" 3 "St George" /// 
					    4 "St James" 5 "St John" 6 "St Joseph" 7 "St Lucy" ///
						8 "St Michael" 9 "St Peter" 10 "St Phillip" /// 
						11 "St Thomas" 99 "ND" , modify
label values parish parish_lab
label var parish "parish"

** create vital status to match CR5db
gen slc=2
label var slc "StatusLastContact"
label define slc_lab 1 "Alive" 2 "Deceased" 3 "Emigrated" 9 "Unknown", modify
label values slc slc_lab

order deathid regnum nrn pname fname lname sex age dod cancer cod1a addr parish pod slc

** Age, NRN and Sex checks were already done in death cleaning file where this dataset was first prepared 
** (see data_cleaning\2008-2017\deaths\versions\version03\dofiles\2_clean_deaths.do)


** Corrections so cancer and death datasets for below patients can merge in dofile 5
**    List A	   **
replace sex=2 if deathid==13430 //1 change
replace nrn="" if deathid==13430 //1 change
replace age=28 if deathid==13430 //1 change

replace sex=2 if deathid==22231 //1 change
replace nrn="" if deathid==22231 //1 change
replace age=53 if deathid==22231 //1 change

replace sex=1 if deathid==13748 //1 change
replace nrn="" if deathid==13748 //1 change
replace age=82 if deathid==13748 //1 change

replace dod=d(21jan2017) if deathid==12255 //1 change

replace dod=d(27sep2015) if deathid==8130 //1 change

**    List B	   **
replace lname="dookie" if deathid==23963 //1 change
replace lname="greene" if deathid==16883 //1 change
replace fname="cecilia" if deathid==2992 //1 change
replace fname="eulaline" if deathid==8230 //1 change
replace fname="magdaline" if deathid==15336 //1 change
replace fname="lorna" if deathid==23231 //1 change
replace mname="violet" if deathid==23231 //1 change
replace fname="moretta" if deathid==17249 //1 change
replace fname="alphonso" if deathid==614 //1 change
replace fname="anthia" if deathid==3861 //1 change
replace mname="clemena" if deathid==3861 //1 change
replace lname="yarde" if deathid==2380 //1 change
replace lname="yarde" if deathid==5206 //1 change

**    List C	   **
replace lname="dawood-wilson" if deathid==20766 //1 change
replace fname="gertrude" if deathid==9502 //1 change
replace lname="watson" if deathid==10212 //1 change

tab deathyear if cancer==1,m 

count //12,286

save "data\clean\2014_cancer_deaths_dc.dta" ,replace
label data "BNR-Cancer Cleaning: National Deaths - 2013-2017 "
notes _dta :These data prepared for 2014 ABS phase
