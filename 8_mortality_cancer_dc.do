** This is the eighth *do* file to be called by the master file.

 ******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *
 *  DO FILE: 		8_mortality_cancer_dc
 *					8th dofile: Mortality Data Prep
 *
 *	STATUS:			Completed
 *
 *  FIRST RUN: 		03dec2018
 *
 *	LAST RUN:		06dec2018
 *
 *  ANALYSIS: 		Preparing data for mortality section of annual report
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

** The working directory
cd "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\"
log using "logfiles\8_mort_cancer_2014_dc.smcl", replace

set more off

**************************************
** DATA PREPARATION
**************************************
** LOAD the national registry deaths 2011-2016 dataset
import excel using "data\raw\Cleaned_DeathData_2008-2017_JC_20180705_excel.xlsx" , firstrow case(lower) clear

count //24,188

** Format and drop necessary variables
rename record_id deathid
format dod %dD_m_CY
label var dod "Date of death"
rename deathyear dodyear
label var dodyear "Year of death"

** record_id 14116 in death data excel file has incorrect reg date so corrected and now format working
format regdate %dD_m_CY

drop cfdate cfda

** Remove irrelevant CODs e.g "unnatural" causes of death (cod1a starts with a lone "E")
drop if regexm(cod1a, "^E") //736 obs deleted


tab dodyear ,m //none missing, 2,446 in 2014
count if dod==. //0

count //23,452 - drop all not in 2014
drop if (dod<d(01jan2014) | dod>d(31dec2014)) //21,006 obs deleted
count //2,446

** Strip possible leading/trailing blanks in cod1a
** Create another cause field so that lists can be done alphabetically when checking below field 'mrcancer'
replace cod1a = rtrim(ltrim(itrim(cod1a))) //0 changes
count if regexm(cod1a,"^N ") //2,428
gen tempcod1a=1 if regexm(cod1a,"^N ")
list deathid if tempcod1a==. //deathid 810 is unnatural so remove
drop if deathid==810 //1 obs deleted

count //2,445

gen cod1a_orig=cod1a
drop cod1a
gen cod1a=substr(cod1a_orig, 2, .) if regexm(cod1a,"^N ") //2,428 changes so 17 missing
list deathid cod1a if cod1a==""
list cod1a_orig if cod1a==""
replace cod1a=cod1a_orig if cod1a=="" //17 changes

** Now generate a new variable which will select out all the potential cancers
gen mrcancer=.
label define mrcancer_lab 1 "cancer" 2 "not cancer", modify
label values mrcancer mrcancer_lab
label var mrcancer "cancer patients"
label var deathid "Event identifier for registry deaths"

** searching cod1a for these terms
replace mrcancer=1 if regexm(cod1a, "CANCER") //345 changes
replace mrcancer=1 if regexm(cod1a, "TUMOUR") &  mrcancer==. //25 changes
replace mrcancer=1 if regexm(cod1a, "TUMOR") &  mrcancer==. //6 changes
replace mrcancer=1 if regexm(cod1a, "MALIGNANT") &  mrcancer==. //4 changes
replace mrcancer=1 if regexm(cod1a, "MALIGNANCY") &  mrcancer==. //20 changes; 21
replace mrcancer=1 if regexm(cod1a, "NEOPLASM") &  mrcancer==. //3 changes
replace mrcancer=1 if regexm(cod1a, "CARCINOMA") &  mrcancer==. //185 changes; 187
replace mrcancer=1 if regexm(cod1a, "CARCIMONA") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "CARINOMA") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "MYELOMA") &  mrcancer==. //21 changes
replace mrcancer=1 if regexm(cod1a, "LYMPHOMA") &  mrcancer==. //24 changes
replace mrcancer=1 if regexm(cod1a, "LYMPHOMIA") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "LYMPHONA") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "SARCOMA") &  mrcancer==. //6 changes
replace mrcancer=1 if regexm(cod1a, "TERATOMA") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "LEUKEMIA") &  mrcancer==. //2 changes
replace mrcancer=1 if regexm(cod1a, "LEUKAEMIA") &  mrcancer==. //8 changes
replace mrcancer=1 if regexm(cod1a, "HEPATOMA") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "CARANOMA PROSTATE") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "MENINGIOMA") &  mrcancer==. //4 changes
replace mrcancer=1 if regexm(cod1a, "MYELOSIS") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "MYELOFIBROSIS") &  mrcancer==. //1 change
replace mrcancer=1 if regexm(cod1a, "CYTHEMIA") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "CYTOSIS") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "BLASTOMA") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "METASTATIC") &  mrcancer==. //7 changes
replace mrcancer=1 if regexm(cod1a, "MASS") &  mrcancer==. //26 changes
replace mrcancer=1 if regexm(cod1a, "METASTASES") &  mrcancer==. //1 change
replace mrcancer=1 if regexm(cod1a, "METASTASIS") &  mrcancer==. //1 change
replace mrcancer=1 if regexm(cod1a, "REFRACTORY") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "FUNGOIDES") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "HODGKIN") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a, "MELANOMA") &  mrcancer==. //0 changes
replace mrcancer=1 if regexm(cod1a,"MYELODYS") &  mrcancer==. //0 changes

tab mrcancer, m
** Check that all cancer CODs for 2014 are eligible
sort cod1a deathid
order deathid cod1a
list cod1a if mrcancer==1 //689; 692

** Replace 2014 cases that are not cancer according to eligibility SOP:
/*
	(1) below list with deathid taken from dofile 4 so re-check then update
		mrcancer var as need be
	(2) use obsid to check for CODs that incomplete in Results window with
		Data Editor in browse mode-copy and paste deathid below from here
*/
sort deathid
list cod1a if ///
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

replace mrcancer=2 if ///
deathid==16285 |deathid==1292  |deathid==15458 |deathid==11987 |deathid==1552| ///
deathid==23771 |deathid==19815 |deathid==11910 |deathid==8118| ///
deathid==3725  |deathid==932   |deathid==3419  |deathid==23473 |deathid==19097| ///
deathid==16546 |deathid==20819 |deathid==20241 |deathid==13572 | ///
deathid==14413 |deathid==16702 |deathid==14249 |deathid==14688 | ///
deathid==5469  |deathid==15378 |deathid==2231  |deathid==22807 |deathid==12102| ///
deathid==22127 |deathid==23906 |deathid==6243  |deathid==22248 |deathid==18365| ///
deathid==17054 |deathid==13194 |deathid==19770 |deathid==2742  | ///
deathid==10793 |deathid==20504 |deathid==20634 |deathid==5531  | ///
deathid==17077 |deathid==11945 |deathid==19303 |deathid==17327 | ///
deathid==7925  |deathid==23413 |deathid==5189  |deathid==12137 |deathid==16726| ///
deathid==19979 |deathid==21864 |deathid==2477  |deathid==19620 |deathid==5741| ///
deathid==183
//55 changes

** Check that all 2014 CODs that are not cancer for eligibility
count if mrcancer==. & (deathid>0 & deathid<5000) //361
count if mrcancer==. & (deathid>5000 & deathid<10000) //373; 370
count if mrcancer==. & (deathid>10000 & deathid<15000) //356
count if mrcancer==. & (deathid>15000 & deathid<20000) //366
count if mrcancer==. & (deathid>20000 & deathid<25000) //299
count if mrcancer==. & (deathid>25000 & deathid<30000) //0

list cod1a if mrcancer==. & (deathid>0 & deathid<5000)
list cod1a if mrcancer==. & (deathid>5000 & deathid<10000)
list cod1a if mrcancer==. & (deathid>10000 & deathid<15000)
list cod1a if mrcancer==. & (deathid>15000 & deathid<20000)
list cod1a if mrcancer==. & (deathid>20000 & deathid<25000)
list cod1a if mrcancer==. & (deathid>25000 & deathid<30000)

** No updates needed from above list
/*
replace mrcancer=1 if ///
deathid==|deathid==|deathid==|deathid==|deathid==| ///
*/

replace mrcancer=2 if mrcancer==. //1,756 changes; 1,753

drop if mrcancer!=1 //1,811 obs deleted; 1,808
count //634; 637

********************
**   Formatting   **
** Place of Death **
********************
rename pod placeofdeath
gen pod=.

label define pod_lab 1 "QEH" 2 "At Home" 3 "Geriatric Hospital" ///
					 4 "Con/Nursing Home" 5 "Other" 6 "District Hospital" ///
					 7 "Psychiatric Hospital" 8 "Bayview Hospital" ///
					 9 "Sandy Crest" 10 "Bridgetown Port" ///
					 11 "Other/Hotel" 99 "ND", modify
label values pod pod_lab
label var pod "Place of Death from National Register"

replace pod=1 if regexm(placeofdeath, "ELIZABETH HOSP") & pod==. //0 changes
replace pod=1 if regexm(placeofdeath, "QUEEN ELZ") & pod==. //0 changes
replace pod=1 if regexm(placeofdeath, "QEH") & pod==. //386 changes; 387
replace pod=3 if regexm(placeofdeath, "GERIATRIC") & pod==. //15 changes
replace pod=5 if regexm(placeofdeath, "CHILDRENS HOME") & pod==. //0 chagnes
replace pod=4 if regexm(placeofdeath, "HOME") & pod==. //10 changes
replace pod=4 if regexm(placeofdeath, "ELDERLY") & pod==. //0 changes
replace pod=4 if regexm(placeofdeath, "SERENITY MANOR") & pod==. //0 changes
replace pod=4 if regexm(placeofdeath, "ADULT CARE") & pod==. //0 changes
replace pod=4 if regexm(placeofdeath, "AGE ASSIST") & pod==. //1 change
replace pod=4 if regexm(placeofdeath, "SENIOR") & pod==. //0 changes
replace pod=5 if regexm(placeofdeath, "PRISON") & pod==. //0 changes
replace pod=5 if regexm(placeofdeath, "POLYCLINIC") & pod==. //0 changes
replace pod=5 if regexm(placeofdeath, "MINISTRIES") & pod==. //0 changes
replace pod=6 if regexm(placeofdeath, "STRICT HOSP") & pod==. //1 change
replace pod=6 if regexm(placeofdeath, "GORDON CUMM") & pod==. //0 changes
replace pod=7 if regexm(placeofdeath, "PSYCHIATRIC HOSP") & pod==. //2 changes
replace pod=8 if regexm(placeofdeath, "BAYVIEW") & pod==. //8 changes
replace pod=9 if regexm(placeofdeath, "SANDY CREST") & pod==. //0 changes
replace pod=10 if regexm(placeofdeath, "BRIDGETOWN PORT") & pod==. //0 changes
replace pod=11 if regexm(placeofdeath, "HOTEL") & pod==. //0 changes
replace pod=99 if placeofdeath=="" & pod==. //0 changes

count if pod==. //212; 213
list deathid placeofdeath if pod==.
replace pod=2 if pod==. //211; 213

drop placeofdeath
tab pod ,m

*****************
**  Formatting **
**    Names    **
*****************

** Need to check for duplicate death registrations
** First split full name into first, middle and last names
** Also - code to split full name into 2 variables fname and lname - else can't merge!
split pname, parse(", "" ") gen(name)
order deathid pname name*

** First, sort cases that contain a value in name4
count if name3=="" & name4=="" //470; 472
count if name4!="" //6 - look at these in Stata data editor
replace name2=name2+" "+name3 if name4!="" //6 changes
replace name3=name4 if name4!="" //6 changes
drop name4

** Second, sort cases that do not contain a value in name3
count if name3=="" //470; 472 - look at these in Stata data editor
replace name3=name2 if name3=="" //470 changes; 472
replace name2="" if name3==name2 //470 changes; 472

** Third, check for cases with name 'baby' or 'b/o' in name1 variable
count if (regexm(name1,"BABY")|regexm(name1,"B/O")) //0

** Fourth, check for cases with name1=ST.
count if regexm(name1,"^ST") //3
list deathid name* if regexm(name1,"^ST")
replace name1=name1+""+name2 if deathid==21276 //1 change
replace name2="" if deathid==21276 //1 change

** Now rename, check and remove unnecessary variables
rename name1 fname
rename name2 mname
rename name3 lname
count if fname=="" //0
count if lname=="" //0

** Check for cases where lname is very short as maybe error with splitting
count if (lname!="" & lname!="99") & length(lname)<3 //0

** Convert names to lower case and strip possible leading/trailing blanks
replace fname = lower(rtrim(ltrim(itrim(fname)))) //634 changes; 637
replace mname = lower(rtrim(ltrim(itrim(mname)))) //164 changes
replace lname = lower(rtrim(ltrim(itrim(lname)))) //634 changes; 637

order deathid pname fname mname lname namematch

sort deathid

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
label define namematch_lab 1 "deaths only namematch,diff.pt" 2 "no namematch", modify
label values namematch namematch_lab
sort lname fname deathid
quietly by lname fname : gen dupname = cond(_N==1,0,_n)
sort lname fname deathid
count if dupname>0 //6
/*
Check below list for cases where namematch=no match but
there is a pt with same name then:
 (1) check if same pt and remove duplicate pt;
 (2) check if same name but different pt and
	 update namematch variable to reflect this, i.e.
	 namematch=1
*/
list deathid namematch fname lname nrn dod sex age if dupname>0
replace namematch=1 if dupname>0 //6 changes

preserve
drop if nrn==""
sort nrn
quietly by nrn : gen dupnrn = cond(_N==1,0,_n)
sort nrn deathid lname fname
count if dupnrn>0 //0
list deathid namematch fname lname nrn dod sex age if dupnrn>0
restore

** Final check for duplicates by name and dod
sort lname fname dod
quietly by lname fname dod: gen dupdod = cond(_N==1,0,_n)
sort lname fname dod deathid
count if dupdod>0 //2 - diff.pt & namematch already=1
list deathid namematch fname lname nrn dod sex age if dupdod>0
count if dupdod>0 & namematch!=1 //0

** Visual check for duplicates by name
sort lname fname
list deathid namematch nrn dod fname lname
** No duplicates found but need to correct lname for below deathid
replace lname= subinstr(lname,"0","o",.) if deathid==10212 //1 change


*******************
** Check for MPs **
**   in CODs     **
*******************
list deathid
list cod1a

** Updates found incidentally from above list
replace mrcancer=2 if deathid==19857 //1 change
replace mrcancer=2 if deathid==14526 //1 change
list deathid mrcancer if mrcancer!=1
drop if mrcancer!=1 //2 obs deleted

count //632; 635

** Create duplicate observations for MPs in CODs
expand=2 if deathid==15481, gen (dupobs1do8)
expand=2 if deathid==14708, gen (dupobs2do8)
expand=2 if deathid==19431, gen (dupobs3do8)
expand=2 if deathid==23539, gen (dupobs4do8)
expand=2 if deathid==23315, gen (dupobs5do8)
expand=2 if deathid==19104, gen (dupobs6do8)
expand=2 if deathid==19119, gen (dupobs7do8)
expand=2 if deathid==5446, gen (dupobs8do8)
expand=2 if deathid==6398, gen (dupobs9do8)
expand=2 if deathid==14955, gen (dupobs10do8)
expand=2 if deathid==4368, gen (dupobs11do8)
expand=2 if deathid==4965, gen (dupobs12do8)
expand=2 if deathid==14323, gen (dupobs13do8)
expand=2 if deathid==620, gen (dupobs14do8)
expand=2 if deathid==15588, gen (dupobs15do8)
expand=2 if deathid==20806, gen (dupobs16do8)

count //648

** Create variables to identify patients vs tumours
gen ptrectot=.
replace ptrectot=1 if dupobs1do8==0|dupobs2do8==0|dupobs3do8==0|dupobs4do8==0 ///
					 |dupobs5do8==0|dupobs6do8==0|dupobs7do8==0|dupobs8do8==0 ///
					 |dupobs9do8==0|dupobs10do8==0|dupobs11do8==0|dupobs12do8==0 ///
					 |dupobs13do8==0|dupobs14do8==0|dupobs15do8==0|dupobs16do8==0 //647
replace ptrectot=2 if dupobs1do8>0|dupobs2do8>0|dupobs3do8>0|dupobs4do8>0 ///
					 |dupobs5do8>0|dupobs6do8>0|dupobs7do8>0|dupobs8do8>0 ///
					 |dupobs9do8>0|dupobs10do8>0|dupobs11do8>0|dupobs12do8>0 ///
					 |dupobs13do8>0|dupobs14do8>0|dupobs15do8>0|dupobs16do8>0 //15
label define ptrectot_lab 1 "DCO with single event" 2 "DCO with multiple events" , modify
label values ptrectot ptrectot_lab

tab ptrectot ,m
/*
                ptrectot |      Freq.     Percent        Cum.
-------------------------+-----------------------------------
   DCO with single event |        635       97.54       97.54
DCO with multiple events |         16        2.46      100.00
-------------------------+-----------------------------------
                   Total |        651      100.00
*/

** Now create id in this dataset so when merging icd10 for siteiarc variable at end of this dofile
gen did="T1" if ptrectot==1
replace did="T2" if ptrectot==2


*******************
** Grouping CODs **
**    by site    **
*******************

** These groupings are based on AR's 2008 code but for 2014, in addition to this,
** I have added another grouping, at end of this dofile, which is used by IARC in CI5 Vol XI
sort cod1a

gen site=1 if (regexm(cod1a, "LIP")	| regexm(cod1a, "MOUTH") | ///
			   regexm(cod1a, "PHARYNX") | regexm(cod1a, "TONSIL") | ///
			   regexm(cod1a, "TONGUE") | regexm(cod1a, "VOCAL CORD") | ///
			   regexm(cod1a, "PHARNYX") | regexm(cod1a, "OF THE SOFT PALATE") | ///
			   regexm(cod1a, "PHARYNGEAL CARCINOMA") | regexm(cod1a, "PAROTIDSALIVARY GLAND") | ///
			   regexm(cod1a, "EPIGLOTTIS LATERAL PHARYNGEAL WALL") | ///
			   regexm(cod1a, "NASOPHARYN")| regexm(cod1a, "THROAT CANCER") | ///
			   regexm(cod1a, "CANCER OF THE THROAT") | regexm(cod1a, "OMA OF THROAT") | ///
			   regexm(cod1a, "CANCER OF SUBMANDIBULAR GLAND") | regexm(cod1a, "OMA OF SOFT PALATE") | ///
			   regexm(cod1a, "PHARYNGEAL CANCER"))
** 23 changes; 24

replace site=2 if regexm(cod1a, "STOMACH")
** 9 changes

replace site=3 if (regexm(cod1a, "COLON") | regexm(cod1a, "OF BOWEL") | ///
				  regexm(cod1a, "OF THE BOWEL") | ///
				  regexm(cod1a, "CAECAL CARCINOMA") | regexm(cod1a, "CARCINOMA OF THE CAECUM") | ///
				  regexm(cod1a, "OMA OF THE SIGMOID") | regexm(cod1a, "APPENDIX") | ///
				  regexm(cod1a, "SIGMOID CANCER") | regexm(cod1a, "CANCER CAECUM") | ///
				  regexm(cod1a, "CAECAL TUMOUR") | regexm(cod1a, "OMA OF CAECUM") | ///
				  regexm(cod1a, "SIGMOID ADENOCAR")) & site==.
** 73

replace site=4 if (regexm(cod1a, "COLORECTAL") | regexm(cod1a, "RECTOSIGMOID CANCER") | ///
				  regexm(cod1a, "RECTO SIGMOID CARCINOMA")) & site==.
** 4 changes

replace site=5 if (regexm(cod1a, "RECTUM") | regexm(cod1a, "RECTAL CARCINOMA") | ///
				   regexm(cod1a, "OF THE ANAL CANAL") | regexm(cod1a, "RECTAL CANCER") | ///
				   regexm(cod1a, "RECTAL ADENOCARCINOMA") | regexm(cod1a, "ANUS")) & site==.
** 21 changes

replace site=6 if regexm(cod1a, "PANCREA") & site==.
** 30 changes

replace site=7 if (regexm(cod1a, "GASTRIC CARCINOMA") | regexm(cod1a, "GASTRIC CANCER") | ///
				  regexm(cod1a, "GASTRIC ADENO") | regexm(cod1a, "CANCER OF THE LIVER")  | ///
				  regexm(cod1a, "LIVER CARCIN") | regexm(cod1a, "CARCINOMA OF LIVER") | ///
				  regexm(cod1a, "GALL BLADDER") | regexm(cod1a, "GALLBLADDER") |  ///
				  regexm(cod1a, "GASTROINTESTINAL MALIGN") | regexm(cod1a, "HEPATIC CARCIN") | ///
				  regexm(cod1a, "OESOPHAGEAL CANCER") | regexm(cod1a, "GASTRO-ESOPHAGEAL JUNC") | ///
				  regexm(cod1a, "CARCINOMA OF OESOPHA") | regexm(cod1a, "OF THE ESOPHAGUS") | ///
				  regexm(cod1a, "CARCINOMA OF THE OESOPHAG") | regexm(cod1a, "JEJUNUM") | ///
				  regexm(cod1a, "HEPATIC CYST") | regexm(cod1a, "CHOLANGIO") | ///
				  regexm(cod1a, "TUMOUR OF ILEUM") | regexm(cod1a, "OESOPHAGEAL CARCINO") | ///
				  regexm(cod1a, "SMALL BOWEL") | regexm(cod1a, "DUODENAL CARCIN") | ///
				  regexm(cod1a, "LIVER MALIGNANCY") | regexm(cod1a, "HEPATOCELLULAR CARCINOMA") | ///
				  regexm(cod1a, "GASTRO OESOPHAGEAL JUNCTION") | ///
				  regexm(cod1a, "GASTROINTESTINAL STROMAL TUMOUR") | regexm(cod1a, "GASTROINTESTINAL CARCIN") | ///
				  regexm(cod1a, "ESOPHAGEAL CANCER") | regexm(cod1a, "CARCINOMA OF THE LIVER") | ///
				  regexm(cod1a, "OESOPHAGEAL ADENOCAR") | regexm(cod1a, "DUODENAL ULCER WITH LIVER METAS") | ///
				  regexm(cod1a, "CANCER OF OESOPHA") | regexm(cod1a, "OMA OF HEPATOBILIARY") | ///
				  regexm(cod1a, "LIVER CANCER") | regexm(cod1a, "HEPATIC ADENOCARCIN") | ///
				  regexm(cod1a, "PERIAMPULLARY MALIGN") | regexm(cod1a, "CANCER OF GASTRO-OESOPHAGEAL JUNC") | ///
				  regexm(cod1a, "CANCER OF THE OESOPHA")) & site==.
** 46 changes

replace site=8 if (regexm(cod1a, "LUNG") | regexm(cod1a, "PLEURA") | ///
				  regexm(cod1a, "LARYNX") | regexm(cod1a, "BRONCHOGENIC") | ///
				  regexm(cod1a, "BRONCHOALVEOLAR CARCIN") | regexm(cod1a, "LARYNGEAL CANCER") | ///
				  regexm(cod1a, "LARYNGEAL CARCINOMA") | regexm(cod1a, "SINONASAL CARCINOMA") | ///
				  regexm(cod1a, "CANCER ETHMOID SINUS")) & site==.
** 53 changes

replace site=9 if (regexm(cod1a, "BONE") | regexm(cod1a, "OMA OF SKULL") | ///
				  regexm(cod1a, "CANCER RIGHT MAXILLA")) & site==.
** 11 changes

replace site=10 if (regexm(cod1a, "MYELOMA") | regexm(cod1a, "MYELODYSPLASTIC") | ///
				    regexm(cod1a, "LEUKAEMIA") | regexm(cod1a, "LEUKEMIA") | ///
					regexm(cod1a, "HAEMA") | regexm(cod1a, "LYMPHO") | ///
					regexm(cod1a, "HODGKIN") | regexm(cod1a, "MYELOFIBROSIS") | ///
					regexm(cod1a, "MYELOPROLIFERATIVE")) & site==.
** 58 changes
** JC 08oct2017: lymphomas & haem cancers are generally reported together so I've grouped these for 2013 since they were separate for 2008

replace site=11 if regexm(cod1a, "MELANOMA")
** 1 change

replace site=12 if regexm(cod1a, "SKIN") & site==.
** 4 changes

replace site=13 if regexm(cod1a, "MESOTHE") & site==.
** 1 change

replace site=14 if regexm(cod1a, "BREAST") & site==.
** 64 changes

replace site=15 if regexm(cod1a, "CERVI") & site==.
** 13 changes

replace site=16 if (regexm(cod1a, "UTER") | regexm(cod1a, "OMA OF THE VULVA") | ///
				    regexm(cod1a, "CHORIOCARCIN") | regexm(cod1a, "ENDOMETRIAL CARCINOMA") | ///
					regexm(cod1a, "ENDOMETRIAL CANC") | regexm(cod1a, "OF ENDOMETRIUM") | ///
					regexm(cod1a, "OF THE ENDOMETRIUM")) & site==.
** 20 changes

replace site=17 if (regexm(cod1a, "OVARY") | regexm(cod1a, "OVARIAN") | ///
				   regexm(cod1a, "GERM CELL")|regexm(cod1a, "VAGINAL CANCER") | ///
				   regexm(cod1a, "VULVA CARCINOMA") | regexm(cod1a, "VULVAL CANCER") | ///
				   regexm(cod1a, "VAGINAL CARCINOMA") | regexm(cod1a, "ENDOMETRIUM")) & site==.
** 4 changes

replace site=18 if (regexm(cod1a, "PENILE") | regexm(cod1a, "OF THE TESTES") | ///
					regexm(cod1a, "GERM CELL")) & site==.
** 3 changes

replace site=19 if regexm(cod1a, "PROSTAT") & site==.
** 137 changes; 139

replace site=20 if (regexm(cod1a, "URIN") | regexm(cod1a, "BLADDER") | ///
					regexm(cod1a, "KIDNEY") | regexm(cod1a, "RENAL CELL CARCIN") | ///
					regexm(cod1a, "RENAL CARCIN") | regexm(cod1a, "WILMS") | ///
					regexm(cod1a, "TRANSITIONAL CELL") | regexm(cod1a, "RENAL CELL CANCER") | ///
					regexm(cod1a, "OMA OF THE URETHRA")) & site==.
** 16 changes; 17

replace site=21 if (regexm(cod1a, "EYE") | regexm(cod1a, "BRAIN") | regexm(cod1a, "CEREBRO") | ///
				   regexm(cod1a, "MENINGIO")  | regexm(cod1a, "INTRA-CRANIAL TUMOR") | ///
				   regexm(cod1a, "OITUTARY") | regexm(cod1a, "CEREBRAL NEOPLASM") | ///
				   regexm(cod1a, "GLIOSARCOMA") | regexm(cod1a, "INTRACEREBRAL TUMOUR") | ///
				   regexm(cod1a, "CEREBRAL ASTROCYTOMA") | regexm(cod1a, "GLIOBLASTOMA MULTIFORME") | ///
				   regexm(cod1a, "NEUROBLASTOMA")) & site==.
** 2 changes

replace site=22 if (regexm(cod1a, "THYROID") | regexm(cod1a, "ENDOCRIN") ) & site==.
** 5 changes

** site 23 is ill-defined sites which can be assigned when checking the unassigned (i.e. site==.) in below list

replace site=24 if (regexm(cod1a, "LYMPH NODE")) & site==.
** Lymph - Secondary and unspecified malignant neoplasm of lymph nodes
**Excl.:malignant neoplasm of lymph nodes, specified as primary (C81-C86, C96.-)
** 0 changes

replace site=25 if (regexm(cod1a, "OCCULT") | regexm(cod1a, "OMA OF UNKNOWN ORIGIN")) & site==.
** 14 changes

label define site_lab 1 "C00-C14: lip, oral cavity & pharynx" 2 "C16: stomach"  3 "C18: colon" ///
  					  4 "C19: colon and rectum"  5 "C20-C21: rectum & anus" 6 "C25: pancreas" ///
					  7 "C15, C17, C22-C24, C26: other digestive organs" ///
					  8 "C30-C39: respiratory and intrathoracic organs" 9 "C40-41: bone and articular cartilage" ///
					  10 "C42,C77: haem & lymph systems" ///
					  11 "C43: melanoma" 12 "C44: skin (non-reportable cancers)" ///
					  13 "C45-C49: mesothelial and soft tissue" 14 "C50: breast" 15 "C53: cervix" ///
					  16 "C54,C55: uterus" 17 "C51-C52, C56-58: other female genital organs" ///
					  18 "C60, C62, C63: male genital organs" 19 "C61: prostate" ///
					  20 "C64-C68: urinary tract" 21 "C69-C72: eye, brain, other CNS" ///
					  22 "C73-C75: thyroid and other endocrine glands"  ///
					  23 "C76: other and ill-defined sites" ///
					  24 "C77: lymph nodes" 25 "C80: unknown primary site"
label var site "site of tumour"
label values site site_lab

** Check if site not assigned and update groupings above
tab site ,m

sort deathid
order deathid cod1a
count if site==. //61 - use below filter in Stata editor
list deathid ptrectot if site==.
list cod1a if site==.

** Update missing sites based on above list
replace site=12 if deathid==3849|deathid==7726|deathid==8574|deathid==23750
** 4 changes

replace site=23 if deathid==1658|deathid==3964|deathid==16127|deathid==18877|deathid==21971
** 5 changes

replace site=25 if deathid==1247|deathid==1330|deathid==4356|deathid==4900 ///
				  |deathid==5655|deathid==9950|deathid==10130|deathid==10153 ///
				  |deathid==11928|deathid==12401|deathid==13180|deathid==13230 ///
				  |deathid==16076|deathid==16263|deathid==16544|deathid==18850 ///
				  |deathid==19083|deathid==19145|deathid==19674|deathid==19834 ///
				  |deathid==20860|deathid==21971|deathid==23490|deathid==23904 ///
				  |deathid==5184
** 25 changes


tab site ,m
list deathid cod1a if site==.

** Update sites of MPs
sort deathid
list deathid did site if ptrectot==2
list cod1a if ptrectot==2

replace site=6 if deathid==620 & did=="T1" //0 changes
replace site=19 if deathid==620 & did=="T2" //1 change

replace site=7 if deathid==4368 & did=="T1" //0 changes
replace site=5 if deathid==4368 & did=="T2" //1 change

replace site=20 if deathid==4965 & did=="T1" //1 change
replace site=3 if deathid==4965 & did=="T2" //0 changes

replace site=20 if deathid==5446 & did=="T1" //1 change
replace site=19 if deathid==5446 & did=="T2" //0 changes

replace site=18 if deathid==6398 & did=="T1" //0 changes
replace site=19 if deathid==6398 & did=="T2" //1 change

replace site=7 if deathid==14323 & did=="T1" //1 change
replace site=5 if deathid==14323 & did=="T2" //0 changes

replace site=19 if deathid==14708 & did=="T1" //1 change
replace site=10 if deathid==14708 & did=="T2" //0 changes

replace site=20 if deathid==14955 & did=="T1" //1 change
replace site=3 if deathid==14955 & did=="T2" //0 changes

replace site=7 if deathid==15481 & did=="T1" //0 changes
replace site=19 if deathid==15481 & did=="T2" //1 change

replace site=14 if deathid==15588 & did=="T1" //1 change
replace site=2 if deathid==15588 & did=="T2" //0 changes

replace site=20 if deathid==19104 & did=="T1" //1 change
replace site=14 if deathid==19104 & did=="T2" //1 change

replace site=14 if deathid==19119 & did=="T1" //1 change
replace site=5 if deathid==19119 & did=="T2" //0 changes

replace site=19 if deathid==19431 & did=="T1" //1 change
replace site=1 if deathid==19431 & did=="T2" //0 changes

replace site=1 if deathid==20806 & did=="T1" //0 changes
replace site=7 if deathid==20806 & did=="T2" //1 change

replace site=12 if deathid==23315 & did=="T1" //0 changes
replace site=19 if deathid==23315 & did=="T2" //1 change

replace site=10 if deathid==23539 & did=="T1" //1 change
replace site=19 if deathid==23539 & did=="T2" //1 change

** Last check to ensure MPs have different sites
duplicates list deathid, nolabel sepby(deathid)
duplicates tag deathid, gen(mpsite)
list deathid site if mpsite>0 ,sepby(deathid)


count if site==. //0

count //648(16 MPs); 651(16 MPs)
tab site ,m

***************
** Labelling **
** Variables **
***************

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

******************************************************
** Final cleaning checks using some checks from dofile 5 **
******************************************************
** Creating dob variable as none in national death data
** perform data cleaning on the age variable
preserve
order deathid nrn age
rename nrn natregno
count if natregno==""
drop if natregno==""
gen yr = substr(natregno,1,1)
gen yr1=.
replace yr1 = 20 if yr=="0"
replace yr1 = 19 if yr!="0"
replace yr1 = 99 if natregno=="99"
order deathid nrn age yr yr1
** Initially need to run this code separately from entire dofile to determine which nrnyears should be '19' instead of '20' depending on age, e.g. for age 107 nrnyear=19
replace yr1 = 19 if deathid==16127
gen nrn = substr(natregno,1,6)
destring nrn, replace
format nrn %06.0f
nsplit nrn, digits(2 2 2) gen(dyear month day)
format dyear month day %02.0f
tostring yr1, replace
gen year2 = string(dyear,"%02.0f")
gen nrnyr = substr(yr1,1,2) + substr(year2,1,2)
destring nrnyr, replace
sort nrn
gen nrn1=mdy(month, day, nrnyr)
format nrn1 %dD_m_CY
rename nrn1 dob
drop day month dyear nrnyr yr yr1 nrn
gen age2 = (dod - dob)/365.25
gen ageyrs=int(age2)
sort deathid
list deathid age ageyrs nrn dod if age!=ageyrs
count if age!=ageyrs //0
drop age2
restore

** Check 31 - invalid length
count if length(nrn)<11 & nrn!="" //0

** Check 32 - missing
count if sex==. | sex==9 //0

** Check 33 - possibly invalid (first name, NRN and sex check: MALES)
gen nrnid=substr(nrn, -4,4)
count if sex==2 & nrnid!="9999" & regex(substr(nrn,-2,1), "[1,3,5,7,9]") //5 - no changes, all correct
list deathid fname lname sex nrn did if sex==2 & nrnid!="9999" & regex(substr(nrn,-2,1), "[1,3,5,7,9]")

** Check 34 - possibly invalid (sex=M; site=breast)
count if sex==1 & regexm(cod1a, "BREAST") //1 - no change; all correct
list deathid fname lname sex nrn did if sex==1 & regexm(cod1a, "BREAST")

** Check 35 - invalid (sex=M; site=FGS)
count if sex==1	& (regexm(cod1a, "VULVA") | regexm(cod1a, "VAGINA") | regexm(cod1a, "CERVIX") | regexm(cod1a, "CERVICAL") ///
								| regexm(cod1a, "UTER") | regexm(cod1a, "OVAR") | regexm(cod1a, "PLACENTA")) //0

** Check 36 - possibly invalid (first name, NRN and sex check: FEMALES)
count if sex==1 & nrnid!="9999" & regex(substr(nrn,-2,1), "[0,2,4,6,8]") //6 - no changes, all correct
list deathid fname lname sex nrn did if sex==1 & nrnid!="9999" & regex(substr(nrn,-2,1), "[0,2,4,6,8]")

** Check 37 - invalid (sex=F; site=MGS)
count if sex==2 & (regexm(cod1a, "PENIS")|regexm(cod1a, "PROSTAT") ///
		|regexm(cod1a, "TESTIS")|regexm(cod1a, "TESTIC")) //0

** Check 58 - missing
count if age==. & dod!=. //0

** Check 59 - invalid (age<>dod-dob); checked no errors
** Age (at DEATH - to nearest year)
gen dobnrn = substr(nrn,1,6) if nrn!=""
destring dobnrn, replace
format dobnrn %06.0f
nsplit dobnrn, digits(2 2 2) gen(year month day)
format year month day %02.0f
tostring dobnrn ,replace
gen yr = substr(dobnrn,1,1)
gen yr1=.
replace yr1 = 20 if yr=="0"
replace yr1 = 19 if yr!="0"
replace yr1 = 99 if nrn=="99"
replace yr1 = 19 if deathid==16127
tostring yr1, replace
gen year2 = string(year,"%02.0f")
gen dobyr = substr(yr1,1,2) + substr(year2,1,2)
destring dobyr, replace
sort dobnrn
gen dob=mdy(month, day, dobyr)
format dob %dD_m_CY
drop day month year year2 dobyr yr yr1 dobnrn
gen ageyrs2 = (dod - dob)/365.25 //
gen checkage=int(ageyrs2)
drop ageyrs2
label var checkage "Age in years at DEATH"
count if dob!=. & dod!=. & age!=checkage //0

** Check 103 - Date of death missing
count if dod==. //0


***********************************
** 1.4 Number of cases by age-group
***********************************
** Age labelling
gen age5 = recode(age,4,9,14,19,24,29,34,39,44,49,54,59,64,69,74,79,84,200)
recode age5 4=1 9=2 14=3 19=4 24=5 29=6 34=7 39=8 44=9 49=10 54=11 59=12 64=13 ///
			69=14 74=15 79=16 84=17 200=18
label define age5_lab 	1 "0-4"	   2 "5-9"    3 "10-14"		///
						4 "15-19"  5 "20-24"  6 "25-29"		///
						7 "30-34"  8 "35-39"  9 "40-44"		///
						10 "45-49" 11 "50-54" 12 "55-59"	///
						13 "60-64" 14 "65-69" 15 "70-74"	///
						16 "75-79" 17 "80-84" 18 "85 & over", modify
label values age5 age5_lab

gen age_10 = recode(age5,3,5,7,9,11,13,15,17,200)
recode age_10 3=1 5=2 7=3 9=4 11=5 13=6 15=7 17=8 200=9
label define age_10_lab 	1 "0-14"   2 "15-24"  3 "25-34"	///
							4 "35-44"  5 "45-54"  6 "55-64"	///
							7 "65-74"  8 "75-84"  9 "85 & over" , modify
label values age_10 age_10_lab
sort sex age_10

tab age_10 sex ,m
** None missing age or sex


** convert sex from string to numeric with labelled values
** 1=F and 2=M to match population dataset (NOTE: different from BNR-Cancer!)
gen numsex=1 if sex==2
replace numsex=2 if sex==1
label define numsex_lab 1 "female" 2 "male", modify
label values numsex numsex_lab
label var numsex "Patient sex"
drop sex
rename numsex sex


************************
** Creating IARC Site **
************************
count //648; 651

rename ptrectot ptrectotmort
sort deathid did
count if mpsite>0 //32
list deathid did site if mpsite>0 ,sepby(deathid)
list cod1a if mpsite>0

gen noexcelimp=1

** Create Stata dataset to merge icd10 codes with current dataset
preserve
save "data\clean\2014_deaths_preicd10_dc.dta" ,replace
clear

import excel using "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-05_deaths_icd10.xlsx", firstrow
count //1,040
drop if deathid==. //431 obs deleted
drop if dodyear!=2014 //187 obs deleted
duplicates list deathid, nolabel sepby(deathid)
duplicates tag deathid, gen(mpicd10)
sort deathid cr5id
list deathid topography morph ptrectot cr5id icd10 if mpicd10>0 ,sepby(deathid)
//need to update these 'did' variable to match import so merge below will not swap icd10 codes for MPs: deathid 5446, 14323, 19104, 19119, 19431
drop if deathid==13088 & cr5id=="T2S1" //1 obs deleted - MP from cr5db not from cod1a
sort deathid cr5id

gen did="T1" if regexm(cr5id,"T1")
replace did="T1" if (deathid==5446 & icd10=="C64" )|(deathid==14323 & icd10=="C160") ///
					|(deathid==19104 & icd10=="C64")|(deathid==19119 & icd10=="C509") ///
					|(deathid==19431 & icd10=="C61")|(deathid==20806 & icd10=="C130")
** 5 changes
replace did="T2" if (deathid==5446 & icd10=="C61")|(deathid==14323 & icd10=="C20") ///
		|(deathid==19104 & icd10=="C509")|(deathid==19119 & icd10=="C20") ///
		|(deathid==19431 & icd10=="C139")|(deathid==20806 & icd10=="C153")
** 6 changes

//need to update 'did' variable for those whose cr5id!="T1S1" and not a MP
sort deathid cr5id
list deathid cr5id icd10 if cr5id!="T1S1" & mpicd10>0 & did==""
replace did="T2" if did=="" & (deathid==4965|deathid==6398|deathid==23539) //3 changes

tab did ,m
list deathid cr5id icd10 mpicd10 if did==""
replace did="T1" if did=="" //4 changes
tab did ,m
/*
        did |      Freq.     Percent        Cum.
------------+-----------------------------------
         T1 |        412       97.86       97.86
         T2 |          9        2.14      100.00
------------+-----------------------------------
      Total |        421      100.00
*/
drop ptrectot
rename siteiarc siteiarc1
rename siteiarchaem siteiarchaem1
count //421
gen excelimp=1
//used to compare with noexcelimp=1 as there are 15 cases with no cod1a after merge as these from dofile 5 are either
//(1)not cancer (2)cancer with ptrectot=DCO with single event i.e. national DCO in dofile 5
drop if deathid==1146|deathid==6700|deathid==9699|deathid==11945|deathid==13009 ///
		|deathid==15458|deathid==19815|deathid==20241|deathid==20504 ///
		|deathid==21532|deathid==23771|deathid==14526
** 12 obs deleted
count //421; 409

save "data\clean\2014_deaths_icd10_dc.dta" ,replace
restore

** Merge IARC ICD-10 coded dataset with this one using deathid
list deathid did mrcancer if deathid==8621|deathid==8711|deathid==6944
list cod1a if deathid==8621|deathid==8711|deathid==6944
** kidney(1), prostate(2)
count //648; 651
merge m:m deathid did using "data\clean\2014_deaths_icd10_dc.dta"
/*
1st merge attempt
    Result                           # of obs.
    -----------------------------------------
    not matched                           257
        from master                       242  (_merge==1)
        from using                         15  (_merge==2)

    matched                               406  (_merge==3)
    -----------------------------------------

2nd merge attempt
    Result                           # of obs.
    -----------------------------------------
    not matched                           242
        from master                       242  (_merge==1)
        from using                          0  (_merge==2)

    matched                               409  (_merge==3)
    -----------------------------------------

*/
count //663; 648; 651

** Check 15 from using that did not merge - none to check after 2nd attempt
list deathid topography morph dodyear siteiarc1 siteiarchaem1 cr5id icd10 if _merge==2
list cod1a if _merge==2

duplicates tag deathid, gen(unmatched)
sort deathid cr5id

** Assign topography and icd10 codes to unmatched/unmerged deaths that are MPs
** Assign morphology and icd10 codes to haem & lymph. cancers for unmatched deaths that are MPs
**(use excel '2018-12-05_iarccrg_icd10_conversion code.xlsx' in raw data to filter by top to assign icd10)
list deathid did topography morph cr5id site _merge icd10 if unmatched>0 & icd10=="" ,sepby(deathid)
list cod1a if unmatched>0 & icd10==""

replace topography=259 if deathid==620 & did=="T1" //1 change
replace topography=619 if deathid==620 & did=="T2" //1 change

replace topography=159 if deathid==4368 & did=="T1" //1 change
replace topography=210 if deathid==4368 & did=="T2" //1 change

replace topography=619 if deathid==14708 & did=="T1" //1 change
replace topography=779 if deathid==14708 & did=="T2" //1 change
replace morph=9590 if deathid==14708 & did=="T2" //1 change

replace topography=649 if deathid==14955 & did=="T1" //1 change
replace topography=189 if deathid==14955 & did=="T2" //1 change

replace topography=169 if deathid==15481 & did=="T1" //1 change
replace topography=619 if deathid==15481 & did=="T2" //1 change

replace topography=509 if deathid==15588 & did=="T1" //1 change
replace topography=169 if deathid==15588 & did=="T2" //1 change

replace topography=449 if deathid==23315 & did=="T1" //1 change
replace topography=619 if deathid==23315 & did=="T2" //1 change


replace icd10="C159" if topography==159 & icd10=="" //1 change
replace icd10="C169" if topography==169 & icd10=="" //2 changes
replace icd10="C189" if topography==189 & icd10=="" //1 change
replace icd10="C210" if topography==210 & icd10=="" //1 change
replace icd10="C259" if topography==259 & icd10=="" //1 change
replace icd10="C449" if topography==449 & icd10=="" //1 change
replace icd10="C61" if topography==619 & icd10=="" //4 changes
replace icd10="C64" if topography==649 & icd10=="" //1 change

replace icd10="C859" if morph==9590 & icd10=="" //1 change

** Now check how many missing topography codes
tab topography ,m
tab morph ,m
tab icd10 ,m

list deathid did topography morph cr5id _merge icd10 if unmatched>0 & _merge!=3 ,sepby(deathid)

** Assign topography codes unmatched/unmerged deaths
sort deathid did
count if icd10=="" //229
list deathid did site if icd10==""
list cod1a if icd10==""

replace topography=29 if (regexm(cod1a,"TONGUE") & regexm(cod1a,"CARCIN") & icd10=="")|(regexm(cod1a,"TONGUE") & regexm(cod1a,"CANCER") & icd10=="")
** 1 change
replace topography=119 if (regexm(cod1a,"NASOPHARYNX") & regexm(cod1a,"CARCIN")& icd10=="")|(regexm(cod1a,"NASOPHARYNX") & regexm(cod1a,"CANCER") & icd10=="")
** 1 change
replace topography=169 if (regexm(cod1a,"CANCER STOMATCH")|regexm(cod1a,"OMA OF STOMACH")|regexm(cod1a,"OMA OF THE STOMACH")|regexm(cod1a,"GASTRIC CARCIN")|regexm(cod1a,"GASTRIC CANCER")) & icd10==""
** 2 changes
replace topography=180 if (regexm(cod1a,"CAECUM") & regexm(cod1a,"CANCER")& icd10=="")|(regexm(cod1a,"CAECUM") & regexm(cod1a,"CARCIN") & icd10=="")
** 1 change
replace topography=189 if (regexm(cod1a,"COLON") & regexm(cod1a,"CANCER")& icd10=="")|(regexm(cod1a,"COLON") & regexm(cod1a,"CARCIN") & icd10=="")
** 17 changes
replace topography=209 if (regexm(cod1a,"CANCER RECTUM")|regexm(cod1a,"OMA OF RECTUM")|regexm(cod1a,"OMA OF THE RECTUM")|regexm(cod1a,"RECTAL CARCIN")) & icd10==""
** 5 changes
replace topography=239 if (regexm(cod1a,"GALL") & regexm(cod1a,"CARCIN")& icd10=="")|(regexm(cod1a,"GALL") & regexm(cod1a,"CANCER") & icd10=="")
** 1 change
replace topography=249 if regexm(cod1a,"CHOLANGIO-CARCINOMA") & icd10==""
** 1 change
replace topography=259 if (regexm(cod1a,"PANCREA") & regexm(cod1a,"CARCIN")& icd10=="")|(regexm(cod1a,"PANCREA") & regexm(cod1a,"CANCER") & icd10=="")
** 8 changes
replace topography=269 if regexm(cod1a,"GASTROINTESTINAL CARCIN") & icd10==""
** 1 change
replace topography=349 if (regexm(cod1a,"LUNG CANCER")|regexm(cod1a,"CANCER OF THE RIGHT LUNG")|regexm(cod1a,"CANCER OF THE LUNG")) & icd10==""
** 5 changes
replace topography=509 if (regexm(cod1a,"BREAST") & regexm(cod1a,"CARCIN")& icd10=="")|(regexm(cod1a,"BREAST") & regexm(cod1a,"CANCER") & icd10=="")
** 37 changes
replace topography=539 if (regexm(cod1a,"CERVI") & regexm(cod1a,"CARCIN")& icd10=="")|(regexm(cod1a,"CERVI") & regexm(cod1a,"CANCER") & icd10=="")
** 5 changes
replace topography=541 if (regexm(cod1a,"ENDOMETRI") & regexm(cod1a,"CARCINOMA")& icd10=="")|(regexm(cod1a,"ENDOMETRI") & regexm(cod1a,"CANCER") & icd10=="")
** 3 changes
replace topography=619 if (regexm(cod1a,"PROSTAT") & regexm(cod1a,"CARCINOMA")& icd10=="")|(regexm(cod1a,"PROSTAT") & regexm(cod1a,"CANCER") & icd10=="")
** 81 changes
replace topography=649 if (regexm(cod1a,"RENAL CELL") & regexm(cod1a,"CARCINOMA")& icd10=="")|(regexm(cod1a,"RENAL CELL") & regexm(cod1a,"CANCER") & icd10=="")
** 2 changes
replace topography=679 if (regexm(cod1a,"BLADDER") & regexm(cod1a,"CARCINOMA")& icd10=="")|(regexm(cod1a,"BLADDER") & regexm(cod1a,"CANCER") & icd10=="")
** 4 changes
replace topography=739 if (regexm(cod1a,"CANCER THYROID")|regexm(cod1a,"THYROID CANCER")) & icd10==""
** 2 changes
replace topography=809 if regexm(cod1a,"OCCULT") & icd10==""
** 3 changes
** 180 changes in total so 49 still missing

replace icd10="C029" if topography==29 & icd10=="" & site!=10 //1 change
replace icd10="C119" if topography==119 & icd10=="" & site!=10 //1 change
replace icd10="C159" if topography==159 & icd10=="" & site!=10 //0 changes
replace icd10="C169" if topography==169 & icd10=="" & site!=10 //2 changes
replace icd10="C180" if topography==180 & icd10=="" & site!=10 //1 change
replace icd10="C189" if topography==189 & icd10=="" & site!=10 //17 changes
replace icd10="C20" if topography==209 & icd10=="" & site!=10 //4 changes
replace icd10="C210" if topography==210 & icd10=="" & site!=10 //0 changes
replace icd10="C23" if topography==239 & icd10=="" & site!=10 //0 changes
replace icd10="C249" if topography==249 & icd10=="" & site!=10 //1 change
replace icd10="C259" if topography==259 & icd10=="" & site!=10 //8 changes
replace icd10="C269" if topography==269 & icd10=="" & site!=10 //1 change
replace icd10="C349" if topography==259 & icd10=="" & site!=10 //0 changes
replace icd10="C449" if topography==449 & icd10=="" & site!=10 //0 changes
replace icd10="C509" if topography==509 & icd10=="" & site!=10 //38 changes
replace icd10="C539" if topography==539 & icd10=="" & site!=10 //5 changes
replace icd10="C541" if topography==541 & icd10=="" & site!=10 //3 changes
replace icd10="C61" if topography==619 & icd10=="" & site!=10 //80 changes
replace icd10="C64" if topography==649 & icd10=="" & site!=10 //2 changes
replace icd10="C679" if topography==679 & icd10=="" & site!=10 //4 changes
replace icd10="C73" if topography==739 & icd10=="" & site!=10 //2 changes
replace icd10="C800" if topography==809 & icd10=="" & site!=10 //3 changes
** 170 changes in total so 59 still missing

count if icd10=="" //59; 56
list deathid did site if icd10==""
list cod1a if icd10==""
** Assign top & morph for lymphomas
list deathid cod1a if icd10=="" & regexm(cod1a,"LYMPHOMA")

replace topography=779 if deathid==516 & icd10=="" //1 change
replace morph=9650 if deathid==516 & icd10=="" //1 change

replace topography=779 if deathid==678 & icd10=="" //1 change
replace morph=9591 if deathid==678 & icd10=="" //1 change

replace topography=779 if deathid==5475 & icd10=="" //1 change
replace morph=9591 if deathid==5475 & icd10=="" //1 change

replace topography=779 if deathid==5643 & icd10=="" //1 change
replace morph=9650 if deathid==5643 & icd10=="" //1 change

replace topography=779 if deathid==7947 & icd10=="" //1 change
replace morph=9591 if deathid==7947 & icd10=="" //1 change

replace topography=779 if deathid==16653 & icd10=="" //1 change
replace morph=9591 if deathid==16653 & icd10=="" //1 change

replace topography=779 if deathid==20760 & icd10=="" //1 change
replace morph=9591 if deathid==20760 & icd10=="" //1 change

replace topography=779 if deathid==21858 & icd10=="" //1 change
replace morph=9827 if deathid==21858 & icd10=="" //1 change

replace topography=779 if deathid==22371 & icd10=="" //1 change
replace morph=9591 if deathid==22371 & icd10=="" //1 change

replace topography=779 if deathid==23966 & icd10=="" //1 change
replace morph=9591 if deathid==23966 & icd10=="" //1 change

** Assign top & morph for myelomas
list deathid cod1a if icd10=="" & regexm(cod1a,"MYELOMA")

replace topography=421 if deathid==6905 & icd10=="" //1 change
replace morph=9732 if deathid==6905 & icd10=="" //1 change

replace topography=421 if deathid==15349 & icd10=="" //1 change
replace morph=9732 if deathid==15349 & icd10=="" //1 change

replace topography=421 if deathid==15507 & icd10=="" //1 change
replace morph=9732 if deathid==15507 & icd10=="" //1 change

replace topography=421 if deathid==20823 & icd10=="" //1 change
replace morph=9732 if deathid==20823 & icd10=="" //1 change

replace topography=421 if deathid==22354 & icd10=="" //1 change
replace morph=9732 if deathid==22354 & icd10=="" //1 change

** Assign top & morph for myelomas
list deathid cod1a if icd10=="" & regexm(cod1a,"LEUK")

replace topography=421 if deathid==3208 & icd10=="" //1 change
replace morph=9823 if deathid==3208 & icd10=="" //1 change

replace topography=421 if deathid==4714 & icd10=="" //1 change
replace morph=9823 if deathid==4714 & icd10=="" //1 change

replace topography=421 if deathid==19903 & icd10=="" //1 change
replace morph=9863 if deathid==19903 & icd10=="" //1 change

replace topography=421 if deathid==21209 & icd10=="" //1 change
replace morph=9863 if deathid==21209 & icd10=="" //1 change

** Assign icd10 codes to haem & lymph. cancers
replace icd10="C819" if morph==9650 & icd10=="" //2 changes
replace icd10="C859" if (morph==9590|morph==9591) & icd10=="" //7 changes
replace icd10="C900" if morph==9732 & icd10=="" //5 changes
replace icd10="C911" if morph==9823 & icd10=="" //2 changes
replace icd10="C915" if morph==9827 & icd10=="" //1 changes
replace icd10="C921" if morph==9863 & icd10=="" //2 changes

** Assign remaining missing icd10 cases
count if icd10=="" //37
list deathid cod1a if icd10==""

replace topography=159 if deathid==4007 & icd10=="" //1 change
replace icd10="C159" if deathid==4007 & icd10=="" //1 change

replace topography=160 if deathid==22928 & icd10=="" //1 change
replace icd10="C160" if deathid==22928 & icd10=="" //1 change

replace topography=169 if deathid==10423 & icd10=="" //1 change
replace icd10="C169" if deathid==10423 & icd10=="" //1 change

replace topography=181 if deathid==19926 & icd10=="" //1 change
replace icd10="C181" if deathid==19926 & icd10=="" //1 change

replace topography=209 if (deathid==10371|deathid==18867) & icd10=="" //2 changes
replace icd10="C20" if (deathid==10371|deathid==18867) & icd10=="" //2 changes

replace topography=220 if deathid==21909 & icd10=="" //1 change
replace icd10="C227" if deathid==21909 & icd10=="" //1 change

replace topography=269 if deathid==3964 & icd10=="" //1 change
replace icd10="C269" if deathid==3964 & icd10=="" //1 change

replace topography=311 if deathid==10809 & icd10=="" //1 change
replace icd10="C311" if deathid==10809 & icd10=="" //1 change

replace topography=349 if (deathid==1955|deathid==4926|deathid==4946|deathid==5478|deathid==14378|deathid==16656) & icd10=="" //2 changes
replace icd10="C349" if (deathid==1955|deathid==4926|deathid==4946|deathid==5478|deathid==14378|deathid==16656) & icd10=="" //6 changes

replace topography=410 if deathid==8061 & icd10=="" //1 change
replace icd10="C410" if deathid==8061 & icd10=="" //1 change

replace topography=441 if deathid==5807 & icd10=="" //1 change
replace icd10="C441" if deathid==5807 & icd10=="" //1 change

replace topography=443 if deathid==8574 & icd10=="" //1 change
replace icd10="C443" if deathid==8574 & icd10=="" //1 change

replace topography=444 if (deathid==3849|deathid==23750) & icd10=="" //2 changes
replace icd10="C444" if (deathid==3849|deathid==23750) & icd10=="" //2 changes

replace topography=445 if deathid==7726 & icd10=="" //1 change
replace icd10="C445" if deathid==7726 & icd10=="" //1 change

replace topography=449 if deathid==20031 & icd10=="" //1 change
replace icd10="C449" if deathid==20031 & icd10=="" //1 change

replace topography=559 if deathid==12150 & icd10=="" //1 change
replace icd10="C55" if deathid==12150 & icd10=="" //1 change

replace topography=619 if (deathid==8401|deathid==6313) & icd10=="" //1 change
replace icd10="C61" if (deathid==8401|deathid==6313) & icd10=="" //2 changes

replace topography=649 if deathid==11614 & icd10=="" //1 change
replace icd10="C64" if deathid==11614 & icd10=="" //1 change

replace topography=765 if deathid==16127 & icd10=="" //1 change
replace icd10="C765" if deathid==16127 & icd10=="" //1 change

replace topography=809 if (deathid==1690|deathid==5543|deathid==8665|deathid==9950|deathid==10565|deathid==14778|deathid==16076|deathid==16544|deathid==13062) & icd10=="" //9 changes
replace icd10="C800" if (deathid==1690|deathid==5543|deathid==8665|deathid==9950|deathid==10565|deathid==14778|deathid==16076|deathid==16544|deathid==13062) & icd10=="" //9 changes

replace topography=421 if deathid==12478 & icd10=="" //1 change
replace morph=9961 if deathid==12478 & icd10=="" //1 change
replace icd10="D474" if deathid==12478 & icd10=="" //1 change

tab icd10 ,m

** Check for duplicate pid identified above using ptrectot to ensure icd10 codes not swapped
count if ptrectot==2 //16 - all correct
list deathid did icd10 top morph if ptrectot==2


** Create new site variable with CI5-XI incidence classifications (see chapter 3 Table 3.1. of that volume) based on icd10
display `"{browse "http://ci5.iarc.fr/CI5-XI/Pages/Chapter3.aspx":IARC-CI5-XI-3}"'

gen siteiarc=.
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

replace siteiarc=1 if regexm(icd10,"C00") //0 changes
replace siteiarc=2 if (regexm(icd10,"C01")|regexm(icd10,"C02")) //4 changes
replace siteiarc=3 if (regexm(icd10,"C03")|regexm(icd10,"C04")|regexm(icd10,"C05")|regexm(icd10,"C06")) //2 changes
replace siteiarc=4 if (regexm(icd10,"C07")|regexm(icd10,"C08")) //1 change
replace siteiarc=5 if regexm(icd10,"C09") //1 change
replace siteiarc=6 if regexm(icd10,"C10") //5 changes
replace siteiarc=7 if regexm(icd10,"C11") //3 changes
replace siteiarc=8 if (regexm(icd10,"C12")|regexm(icd10,"C13")) //4 changes
replace siteiarc=9 if regexm(icd10,"C14") //1 change
replace siteiarc=10 if regexm(icd10,"C15") //10 changes
replace siteiarc=11 if regexm(icd10,"C16") //20 changes
replace siteiarc=12 if regexm(icd10,"C17") //2 changes
replace siteiarc=13 if regexm(icd10,"C18") //71 changes
replace siteiarc=14 if (regexm(icd10,"C19")|regexm(icd10,"C20")) //20 changes
replace siteiarc=15 if regexm(icd10,"C21") //1 change
replace siteiarc=16 if regexm(icd10,"C22") //9 changes
replace siteiarc=17 if (regexm(icd10,"C23")|regexm(icd10,"C24")) //9 changes
replace siteiarc=18 if regexm(icd10,"C25") //29 changes
replace siteiarc=19 if (regexm(icd10,"C30")|regexm(icd10,"C31")) //1 change
replace siteiarc=20 if regexm(icd10,"C32") //1 change
replace siteiarc=21 if (regexm(icd10,"C33")|regexm(icd10,"C34")) //41 changes
replace siteiarc=22 if (regexm(icd10,"C37")|regexm(icd10,"C38")) //0 changes
replace siteiarc=23 if (regexm(icd10,"C40")|regexm(icd10,"C41")) //2 changes
replace siteiarc=24 if regexm(icd10,"C43") //1 change
replace siteiarc=25 if regexm(icd10,"C44") //7 change
replace siteiarc=26 if regexm(icd10,"C45") //1 change
replace siteiarc=27 if regexm(icd10,"C46") //0 changes
replace siteiarc=28 if (regexm(icd10,"C47")|regexm(icd10,"C49")) //0 changes
replace siteiarc=29 if regexm(icd10,"C50") //72 changes
replace siteiarc=30 if regexm(icd10,"C51") //0 changes
replace siteiarc=31 if regexm(icd10,"C52") //2 changes
replace siteiarc=32 if regexm(icd10,"C53") //12 changes
replace siteiarc=33 if regexm(icd10,"C54") //21 changes
replace siteiarc=34 if regexm(icd10,"C55") //3 changes
replace siteiarc=35 if regexm(icd10,"C56") //1 change
replace siteiarc=36 if regexm(icd10,"C57") //0 changes
replace siteiarc=37 if regexm(icd10,"C58") //0 changes
replace siteiarc=38 if regexm(icd10,"C60") //2 changes
replace siteiarc=39 if regexm(icd10,"C61") //150 changes
replace siteiarc=40 if regexm(icd10,"C62") //0 changes
replace siteiarc=41 if regexm(icd10,"C63") //0 changes
replace siteiarc=42 if regexm(icd10,"C64") //11 changes
replace siteiarc=43 if regexm(icd10,"C65") //0 changes
replace siteiarc=44 if regexm(icd10,"C66") //0 changes
replace siteiarc=45 if regexm(icd10,"C67") //13 changes
replace siteiarc=46 if regexm(icd10,"C68") //0 changes
replace siteiarc=47 if regexm(icd10,"C69") //0 changes
replace siteiarc=48 if (regexm(icd10,"C70")|regexm(icd10,"C71")|regexm(icd10,"C72")) //0 changes
replace siteiarc=49 if regexm(icd10,"C73") //3 changes
replace siteiarc=50 if regexm(icd10,"C74") //0 changes
replace siteiarc=51 if regexm(icd10,"C75") //0 changes
replace siteiarc=52 if regexm(icd10,"C81") //2 changes
replace siteiarc=53 if (regexm(icd10,"C82")|regexm(icd10,"C83")|regexm(icd10,"C84")|regexm(icd10,"C85")|regexm(icd10,"C86")|regexm(icd10,"C96")) //18 changes
replace siteiarc=54 if regexm(icd10,"C88") //1 change
replace siteiarc=55 if regexm(icd10,"C90") //22 changes
replace siteiarc=56 if regexm(icd10,"C91") //5 changes
replace siteiarc=57 if (regexm(icd10,"C92")|regexm(icd10,"C93")|regexm(icd10,"C94")) //4 changes
replace siteiarc=58 if regexm(icd10,"C95") //3 changes
replace siteiarc=59 if (morph>9949 & morph<9970)|(morph>9969 & morph<9980) //2 changes
replace siteiarc=60 if morph>9979 & morph<9999 //1 change
replace siteiarc=61 if (regexm(icd10,"C26")|regexm(icd10,"C39")|regexm(icd10,"C48")|regexm(icd10,"C76")|regexm(icd10,"C80")) //57 changes
**replace siteiarc=62 if siteiarc<62
**replace siteiarc=63 if siteiarc<62 & siteiarc!=25
replace siteiarc=64 if morph==8077 //0 changes - no CIN 3 in death data

tab siteiarc ,m //none missing

gen allsites=1 if siteiarc<62 //651 changes
label var allsites "All sites (ALL)"

gen allsitesnoC44=1 if siteiarc<62 & siteiarc!=25 //7 missing so 7=C44
label var allsitesnoC44 "All sites but skin (ALLbC44)"

** Create site variable for lymphoid and haematopoietic diseases for conversion of these from ICD-O-3 1st edition (M9590-M9992)
** (see chapter 3 Table 3.2 of CI5-XI)
gen siteiarchaem=.
label define siteiarchaem_lab ///
1 "Malignant lymphomas,NOS or diffuse" ///
2 "Hodgkin lymphoma" ///
3 "Mature B-cell lymphomas" ///
4 "Mature T- and NK-cell lymphomas" ///
5 "Precursor cell lymphoblastic lymphoma" ///
6 "Plasma cell tumours" ///
7 "Mast cell tumours" ///
8 "Neoplasms of histiocytes and accessory lymphoid cells" ///
9 "Immunoproliferative diseases" ///
10 "Leukemias, NOS" ///
11 "Lymphoid leukemias" ///
12 "Myeloid leukemias" ///
13 "Other leukemias" ///
14 "Chronic myeloproliferative disorders" ///
15 "Other hematologic disorders" ///
16 "Myelodysplastic syndromes"
label var siteiarchaem "IARC CI5-XI lymphoid & haem diseases"
label values siteiarchaem siteiarchaem_lab

** Note that morphcat is based on ICD-O-3 edition 3.1. so e.g. morphcat54
replace siteiarchaem=1 if morph>9589 & morph<9650 //14 changes
replace siteiarchaem=2 if morph>9649 & morph<9670 //2 changes
replace siteiarchaem=3 if morph>9669 & morph<9700 //4 changes
replace siteiarchaem=4 if morph>9699 & morph<9727 //0 changes
replace siteiarchaem=5 if morph>9726 & morph<9731 //1 change
replace siteiarchaem=6 if morph>9730 & morph<9740 //22 changes
replace siteiarchaem=7 if morph>9739 & morph<9750 //0 changes
replace siteiarchaem=8 if morph>9749 & morph<9760 //0 changes
replace siteiarchaem=9 if morph>9759 & morph<9800 //0 changes
replace siteiarchaem=10 if morph>9799 & morph<9820 //3 changes
replace siteiarchaem=11 if morph>9819 & morph<9840 //5 changes
replace siteiarchaem=12 if morph>9839 & morph<9940 //4 changes
replace siteiarchaem=13 if morph>9939 & morph<9950 //0 changes
replace siteiarchaem=14 if morph>9949 & morph<9970 //1 change
replace siteiarchaem=15 if morph>9969 & morph<9980 //1 change
replace siteiarchaem=16 if morph>9979 & morph<9999 //1 change

tab siteiarchaem ,m //593 missing - correct!
count if (siteiarc>51 & siteiarc<59) & siteiarchaem==. //0

** Create ICD-10 groups according to analysis tables in CR5 db (added after analysis dofiles 4,6)
gen sitecr5db=.
label define sitecr5db_lab ///
1 "Mouth & pharynx (C00-14)" ///
2 "Oesophagus (C15)" ///
3 "Stomach (C16)" ///
4 "Colon, rectum, anus (C18-21)" ///
5 "Liver (C22)" ///
6 "Pancreas (C25)" ///
7 "Larynx (C32)" ///
8 "Lung, trachea, bronchus (C33-34)" ///
9 "Melanoma of skin (C43)" ///
10 "Breast (C50)" ///
11 "Cervix (C53)" ///
12 "Corpus & Uterus NOS (C54-55)" ///
13 "Ovary & adnexa (C56)" ///
14 "Prostate (C61)" ///
15 "Testis (C62)" ///
16 "Kidney & urinary NOS (C64-66,68)" ///
17 "Bladder (C67)" ///
18 "Brain, nervous system (C70-72)" ///
19 "Thyroid (C73)" ///
20 "O&U (C26,39,48,76,80)" ///
21 "Lymphoma (C81-85,88,90,96)" ///
22 "Leukaemia (C91-95)" ///
23 "Other digestive (C17,23-24)" ///
24 "Nose, sinuses (C30-31)" ///
25 "Bone, cartilage, etc (C40-41,45,47,49)" ///
26 "Other skin (C44)" ///
27 "Other female organs (C51-52,57-58)" ///
28 "Other male organs (C60,63)" ///
29 "Other endocrine (C74-75)" ///
30 "Myeloproliferative disorders (MPD)" ///
31 "Myselodysplastic syndromes (MDS)" ///
32 "D069: CIN 3" ///
33 "All sites but C44"
label var sitecr5db "CR5db sites"
label values sitecr5db sitecr5db_lab

replace sitecr5db=1 if (regexm(icd10,"C00")|regexm(icd10,"C01")|regexm(icd10,"C02") ///
					 |regexm(icd10,"C03")|regexm(icd10,"C04")|regexm(icd10,"C05") ///
					 |regexm(icd10,"C06")|regexm(icd10,"C07")|regexm(icd10,"C08") ///
					 |regexm(icd10,"C09")|regexm(icd10,"C10")|regexm(icd10,"C11") ///
					 |regexm(icd10,"C12")|regexm(icd10,"C13")|regexm(icd10,"C14")) //21 changes
replace sitecr5db=2 if regexm(icd10,"C15") //10 changes
replace sitecr5db=3 if regexm(icd10,"C16") //20 changes
replace sitecr5db=4 if (regexm(icd10,"C18")|regexm(icd10,"C19")|regexm(icd10,"C20")|regexm(icd10,"C21")) //92 changes
replace sitecr5db=5 if regexm(icd10,"C22") //9 changes
replace sitecr5db=6 if regexm(icd10,"C25") //29 changes
replace sitecr5db=7 if regexm(icd10,"C32") //1 change
replace sitecr5db=8 if (regexm(icd10,"C33")|regexm(icd10,"C34")) //41 changes
replace sitecr5db=9 if regexm(icd10,"C43") //1 change
replace sitecr5db=10 if regexm(icd10,"C50") //72 changes
replace sitecr5db=11 if regexm(icd10,"C53") //12 changes
replace sitecr5db=12 if (regexm(icd10,"C54")|regexm(icd10,"C55")) //24 changes
replace sitecr5db=13 if regexm(icd10,"C56") //1 change
replace sitecr5db=14 if regexm(icd10,"C61") //150 changes
replace sitecr5db=15 if regexm(icd10,"C62") //0 changes
replace sitecr5db=16 if (regexm(icd10,"C64")|regexm(icd10,"C65")|regexm(icd10,"C66")|regexm(icd10,"C68")) //11 changes
replace sitecr5db=17 if regexm(icd10,"C67") //13 changes
replace sitecr5db=18 if (regexm(icd10,"C70")|regexm(icd10,"C71")|regexm(icd10,"C72")) //0 changes
replace sitecr5db=19 if regexm(icd10,"C73") //3 changes
replace sitecr5db=20 if siteiarc==61 //57 changes
replace sitecr5db=21 if (regexm(icd10,"C81")|regexm(icd10,"C82")|regexm(icd10,"C83")|regexm(icd10,"C84")|regexm(icd10,"C85")|regexm(icd10,"C88")|regexm(icd10,"C90")|regexm(icd10,"C96")) //43 changes
replace sitecr5db=22 if (regexm(icd10,"C91")|regexm(icd10,"C92")|regexm(icd10,"C93")|regexm(icd10,"C94")|regexm(icd10,"C95")) //12 changes
replace sitecr5db=23 if (regexm(icd10,"C17")|regexm(icd10,"C23")|regexm(icd10,"C24")) //11 changes
replace sitecr5db=24 if (regexm(icd10,"C30")|regexm(icd10,"C31")) //1 change
replace sitecr5db=25 if (regexm(icd10,"C40")|regexm(icd10,"C41")|regexm(icd10,"C45")|regexm(icd10,"C47")|regexm(icd10,"C49")) //3 changes
replace sitecr5db=26 if siteiarc==25 //7 changes
replace sitecr5db=27 if (regexm(icd10,"C51")|regexm(icd10,"C52")|regexm(icd10,"C57")|regexm(icd10,"C58")) //2 changes
replace sitecr5db=28 if (regexm(icd10,"C60")|regexm(icd10,"C63")) //2 changes
replace sitecr5db=29 if (regexm(icd10,"C74")|regexm(icd10,"C75")) //0 changes
replace sitecr5db=30 if siteiarc==59 //2 changes
replace sitecr5db=31 if siteiarc==60 //1 change
replace sitecr5db=32 if siteiarc==64 //0 changes

tab sitecr5db ,m


** Create ICD-10 groups according to Angie's previous site labels but more standardized site assignment based on all ICD-10 not mixtured of ICD-10 & ICD-O-3 (added after analysis dofiles 4,6)
tab icd10 ,m
gen sitear=.
label define sitear_lab 1 "C00-C14: lip, oral cavity & pharynx" 2 "C16: stomach"  3 "C18: colon" ///
  					  4 "C19: colon and rectum"  5 "C20-C21: rectum & anus" 6 "C25: pancreas" ///
					  7 "C15, C17, C22-C24, C26: other digestive organs" ///
					  8 "C30-C39: respiratory and intrathoracic organs" 9 "C40-41: bone and articular cartilage" ///
					  10 "C42,C77: haem & lymph systems" ///
					  11 "C43: melanoma & reportable skin cancers" 12 "C44: skin (non-reportable)" ///
					  13 "C45-C49: mesothelial and soft tissue" 14 "C50: breast" 15 "C53: cervix" ///
					  16 "C54,55: uterus" 17 "C51-C52, C56-58: other female genital organs" ///
					  18 "C60, C62, C63: male genital organs" 19 "C61: prostate" ///
					  20 "C64-C68: urinary tract" 21 "C69-C72: eye, brain, other CNS" ///
					  22 "C73-C75: thyroid and other endocrine glands"  ///
					  23 "C76: other and ill-defined sites" ///
					  24 "C77: lymph nodes" 25 "C80: unknown primary site"
label var sitear "site of tumour"
label values sitear site_lab

replace sitear=1 if (regexm(icd10,"C00")|regexm(icd10,"C01")|regexm(icd10,"C02") ///
					 |regexm(icd10,"C03")|regexm(icd10,"C04")|regexm(icd10,"C05") ///
					 |regexm(icd10,"C06")|regexm(icd10,"C07")|regexm(icd10,"C08") ///
					 |regexm(icd10,"C09")|regexm(icd10,"C10")|regexm(icd10,"C11") ///
					 |regexm(icd10,"C12")|regexm(icd10,"C13")|regexm(icd10,"C14")) //34 changes
replace sitear=2 if regexm(icd10,"C16") //23 changes
replace sitear=3 if regexm(icd10,"C18") //131 changes
replace sitear=4 if regexm(icd10,"C19") //5 changes
replace sitear=5 if (regexm(icd10,"C20")|regexm(icd10,"C21")) //28 changes
replace sitear=6 if regexm(icd10,"C25") //23 changes
replace sitear=7 if (regexm(icd10,"C15")|regexm(icd10,"C17")|regexm(icd10,"C22")|regexm(icd10,"C23")|regexm(icd10,"C24")|regexm(icd10,"C26")) //40 changes
replace sitear=8 if (regexm(icd10,"C30")|regexm(icd10,"C31")|regexm(icd10,"C32")|regexm(icd10,"C33")|regexm(icd10,"C34")|regexm(icd10,"C37")|regexm(icd10,"C38")|regexm(icd10,"C39")) //57 changes
replace sitear=9 if (regexm(icd10,"C40")|regexm(icd10,"C41")) //3 changes
replace sitear=10 if sitecr5db==21|sitecr5db==22|sitecr5db==30|sitecr5db==31 //73 changes
replace sitear=11 if siteiarc==24 //7 changes
replace sitear=12 if siteiarc==25 //0 changes
replace sitear=13 if (regexm(icd10,"C45")|regexm(icd10,"C46")|regexm(icd10,"C47")|regexm(icd10,"C48")|regexm(icd10,"C49")) //12 changes
replace sitear=14 if regexm(icd10,"C50") //174 changes
replace sitear=15 if regexm(icd10,"C53") //21 changes
replace sitear=16 if (regexm(icd10,"C54")|regexm(icd10,"C55")) //49 changes
replace sitear=17 if (regexm(icd10,"C51")|regexm(icd10,"C52")|regexm(icd10,"C56")|regexm(icd10,"C57")|regexm(icd10,"C58")) //14 changes
replace sitear=18 if (regexm(icd10,"C60")|regexm(icd10,"C62")|regexm(icd10,"C63")) //5 changes
replace sitear=19 if regexm(icd10,"C61") //216 changes
replace sitear=20 if (regexm(icd10,"C64")|regexm(icd10,"C65")|regexm(icd10,"C66")|regexm(icd10,"C67")|regexm(icd10,"C68")) //37 changes
replace sitear=21 if (regexm(icd10,"C69")|regexm(icd10,"C70")|regexm(icd10,"C71")|regexm(icd10,"C72")) //6 changes
replace sitear=22 if (regexm(icd10,"C73")|regexm(icd10,"C74")|regexm(icd10,"C75")) //12 changes
replace sitear=23 if regexm(icd10,"C76") //3 changes
**replace sitear=24 if  // captured in sitear 10
replace sitear=25 if regexm(icd10,"C80") //43 changes

tab sitear ,m //0 missing

drop cod1b cod1c cod1d cod2a cod2b onsetnumcod1b onsettxtcod1b onsetnumcod1c ///
	 onsettxtcod1c onsetnumcod1d onsettxtcod1d onsetnumcod2a onsettxtcod2a ///
	 onsetnumcod2b onsettxtcod2b death_certificate_complete tempcod1a

order deathid did fname lname age age5 age_10 sex dob nrn parish dod dodyear mrcancer siteiarc siteiarchaem site pod cod1a

count // 651

save "data\clean\2014_cancer_mort_dc.dta" ,replace
label data "BNR-Cancer Corrections"
notes _dta :These data prepared for 2014 ABS phase
