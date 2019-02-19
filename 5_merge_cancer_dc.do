** This is the fifth *do* file to be called by the master file.

 ******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *
 *  DO FILE: 		5_merge_cancer_dc
 *					5th dofile: Cancer & Death Data Merge
 *
 *	STATUS:			Completed
 *
 *  FIRST RUN: 		20nov2018
 *
 *	LAST RUN:		18dec2018
 *
 *  ANALYSIS: 		Merging cancer and death data
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

log using "logfiles\5_merge_cancer_2014_dc.smcl", replace

set more off

**************************************
** DATA PREPARATION
**************************************
** LOAD the prepared cancer dataset
use "data\clean\2014_cancer_cleaned_dupslabel_cods_dod_dc.dta" ,clear
**this dataset contains the duplicates and ineligibles which can be removed after the death matching(later in this dofile)

** Convert names to lower case and strip possible leading/trailing blanks
replace fname = lower(rtrim(ltrim(itrim(fname)))) //2,553 changes
replace init = lower(rtrim(ltrim(itrim(init)))) //1,877 changes
replace lname = lower(rtrim(ltrim(itrim(lname)))) //2,553 changes

** Testing merge - best to merge without age!
merge m:1 lname fname sex dod using "data\clean\2014_cancer_deaths_dc.dta"
/*
pre-corrections in dofiles 3 & 4 using Lists A and B below


    Result                           # of obs.
    -----------------------------------------
    not matched                        12,625
        from master                     1,073  (_merge==1)
        from using                     11,552  (_merge==2)

    matched                             1,480  (_merge==3)
    -----------------------------------------

post-corrections in dofiles 3 & 4 using Lists A and B below


    Result                           # of obs.
    -----------------------------------------
    not matched                        12,484
        from master                       971  (_merge==1)
        from using                     11,513  (_merge==2)

    matched                             1,582  (_merge==3)
    -----------------------------------------
*/


** remove CR5db duplicates
drop if recstatus==4 //215 obs deleted

count //13,890; 13,938; 13,890; 13,851

rename namematch nm
rename dupsource ds

label define merge_lab 1 "master" 2 "using" 3 "matched", modify
label values _merge merge_lab

/*
	Need to check matched and unmatched data for cases:
	(1) matched but are ineligible according to CR5 recstatus
	(2) not matched but should have been
	   (use dup_pt var along with Stata data editor-filter by fname,lname);
	(3) matched but cr5cod and cod1a (national deaths' cod) do not match

*/
********************
** MATCHED DATA:  **
** ineligible CR5 **
** with DEATHIDs  **
********************
** First check for and remove matches with death data and ineligible CR5db data
count if regexm(lname, "^a") & _merge==3 //53; 51; 53; 55
list deathid pid fname lname natregno basis recstatus ds nm _merge cr5id if regexm(lname, "^a") & _merge==3, nolabel noobs
drop if recstatus==3 //580 obs deleted

count //13,358; 13,310; 13,271

duplicates tag lname fname, gen(dup_pt)
count if dup_pt>1 //1,015; 1,064; 963; 933; 905
count if dup_pt>1 & slc==2 //752; 801; 714; 683


*********************
** UNMATCHED DATA: **
** NATIONAL DEATHS **
**    List A	   **
*********************
** Second check for and identify deaths that should have been matched with CR5db using below list and
** Stata browse editor filtered by fname, lname then correct in dofiles 3(cr5) and 4(deaths) so that these cases will merge
** 2013-2017 unmatched deaths
count if deathid!=. & _merge==2 & cancer==1 & dup_pt>0 //209; 185
list deathid fname lname deathyear nm cancer dup_pt _merge if deathid!=. & _merge==2 & cancer==1 & dup_pt>0
sort lname fname
order deathid pid fname lname sex nm natregno nrn dod cr5cod cod1a
** Shortened above list using namematch(nm) as nm=1 unnecessary to check
count if deathid!=. & _merge==2 & cancer==1 & dup_pt>0 & nm!=1 //26
list deathid fname lname deathyear nm cancer dup_pt _merge if deathid!=. & _merge==2 & cancer==1 & dup_pt>0 & nm!=1
** Update namematch(nm) var for those with same name but diff. pt for death and cr5 records
replace nm=3 if deathid==16151|pid=="20080196" //4 changes
replace nm=3 if deathid==7865|pid=="20130162" //2 changes
replace nm=3 if deathid==19237|pid=="20140868" //3 changes
replace nm=3 if deathid==1187|pid=="20141077" //2 changes
** Re-check list
count if deathid!=. & _merge==2 & cancer==1 & dup_pt>0 & (nm!=1 & nm!=3) //0 - all for list A checked


*********************
** UNMATCHED DATA: **
**     CR5 DB      **
**     List B	   **
*********************
** (1) unmatched CR5 data whose dup_pt>0 (ignore those with slc=1-alive if dup_pt=1) i.e. more than one pt with same name in merged dataset
count if pid!="" & _merge==1 & dup_pt>0 //553; 473
list pid fname lname slc dxyr basis recstatus eidmp ds dup_pt _merge if pid!="" & _merge==1 & dup_pt>0, nolabel noobs
** Shortened above list using slc as slc=1 unnecessary to check
count if pid!="" & _merge==1 & dup_pt>0 & slc!=1 //57; 12 - pid 20141509, 20145157, 20145154 deceased but not found in death data
list pid fname lname slc dod dxyr basis recstatus eidmp ds dup_pt if pid!="" & _merge==1 & dup_pt>0 & slc!=1, nolabel noobs
** Update namematch(nm) var for those with slc=died/unke but not found in deathdata
replace nm=4 if pid=="20140808" //2 changes
replace nm=4 if pid=="20140817" //2 changes
replace nm=4 if pid=="20141509" //2 changes
replace nm=4 if pid=="20145157" //2 changes
replace nm=4 if pid=="20145154" //2 changes
** Re-check list
count if pid!="" & _merge==1 & dup_pt>0 & slc!=1 & (nm!=1 & nm!=3 & nm!=4) //0 - all for list B checked

** (2) CHECK FOR CR5 DEATHS 2014-2017 THAT HAVE NOT MERGED WTIH A NATIONAL DEATH
count if deathid==. & pid!="" & slc==2 & nm!=4 //6 - pid 20141534 deceased but not found in death data
list pid fname lname top morph cr5id if deathid==. & pid!="" & slc==2 & nm!=4
** Update namematch(nm) var for those with slc=died/unke but not found in deathdata
replace nm=4 if pid=="20141534" //1 change
replace nm=4 if pid=="20141542" //1 change
** Re-check list
count if deathid==. & pid!="" & slc==2 & nm!=4 //0 - all for list B checked


***************************
**  MATCHED DATA:  		 **
**  CR5's COD 			 **
**  does not match       **
**  NATIONAL DEATHS' COD **
**    	List C           **
***************************

** Strip possible leading/trailing blanks in causeofdeath
** Create another cause field so that lists can be done alphabetically when checking below field 'mrcancer'
replace cr5cod = rtrim(ltrim(itrim(cr5cod))) //120 changes

replace cod1a = rtrim(ltrim(itrim(cod1a))) //0 changes
count if regexm(cod1a,"^N ") //5,461
count if regexm(cod1a,"^E ") //178

gen cr5cod_orig=cr5cod
drop cr5cod
gen cr5cod=substr(cr5cod_orig, 2, .) if regexm(cr5cod,"^N ")

gen cod1a_orig=cod1a
drop cod1a
gen cod1a=substr(cod1a_orig, 2, .) if regexm(cod1a,"^N ")
/*
gen cod1a=subinstr(cod1a_orig, "^N ","", .) if regexm(cod1a,"^N ") //this not working
replace cod1a=subinstr(cod1a_orig, "^N ","", .) if regexm(cod1a,"^N ") //this works but replaces 'N's in words as well see deathid 7925

split cod1a, p(regexm(cod1a,"^N ")) gen(cause)

rename cause1 cause
replace cause=cause2+" "+cause3+" "+cause4+" "+cause5+" "+cause6
drop cause2 cause3 cause4 cause5 cause6
*/
** Need to drop duplicate CR5 source records
drop if eidmp==. & pid!="" //807 obs deleted

count if eidmp==. //11,513

count if _merge==3 & cr5cod!=cod1a //30 - cr5cod didn't get copied over from S2 into S1 see pid 20141020
order cr5cod cod1a
list pid deathid fname lname age sex natregno cr5id if _merge==3 & cr5cod!=cod1a

count if _merge==3 & cr5cod!="" & cr5cod!=cod1a //0
replace cr5cod=cod1a if _merge==3 & cr5cod!=cod1a //30 changes

count if cod1a=="" & deathid!=. //6,876
list pid deathid if cod1a=="" & deathid!=.

count if cod1a_orig!="" & cod1a=="" //6,876
replace cod1a=cod1a_orig if cod1a_orig!="" & cod1a=="" //6,876 changes

count if cr5cod_orig!="" & cr5cod=="" //377
list pid deathid if cr5cod_orig!="" & cr5cod==""
replace cr5cod=cr5cod_orig if cr5cod_orig!="" & cr5cod=="" //377 changes

count if pid!="" & slc==2 & cr5cod=="" //9 - these are correctly missing cr5cod
sort pid deathid
list pid deathid cr5cod if pid!="" & slc==2 & cr5cod==""

count if deathid!=. & cod1a=="" //0

** Remove all deaths after 2014 that did not merge with any cr5 records
drop if _merge==2 & pid=="" & deathyear!=. & deathyear>2014 //7,176 obs deleted

** Remove all unmatched 2013 deaths i.e. deaths that didn't merge with cr5 2013 records
drop if _merge==2 & pid=="" & deathyear!=. & deathyear<2014 //2,410 obs deleted

** Remove all unmatched 2014 deaths that are not cancer
drop if _merge==2 & pid=="" & cancer!=1 //1,809 obs deleted

count //1,069
count if deathid==. & pid!="" //440 unmatched cr5
count if _merge==2 & deathyear!=2014 //0

** First check for any matches with nrn in cr5 vs death
preserve
drop if _merge!=1 //629 obs deleted
drop nrn
rename natregno nrn
count //440
rename _merge _merge1
save "data\clean\2014_unmerged_cr5_dc.dta" ,replace
restore

preserve
drop if _merge!=2 //951 obs deleted
count //118
rename _merge _merge1
save "data\clean\2014_unmerged_deaths_dc.dta" ,replace
restore

preserve
use "data\clean\2014_unmerged_cr5_dc.dta" ,clear
merge m:1 lname fname sex nrn using "data\clean\2014_unmerged_deaths_dc.dta"
list deathid pid fname lname if _merge==3
/*
Result                           # of obs.
    -----------------------------------------
    not matched                           558
        from master                       440  (_merge==1)
        from using                        118  (_merge==2)

    matched                                 0  (_merge==3)
    -----------------------------------------
*/
sort nrn lname fname pid
quietly by nrn :  gen dupnrn2 = cond(_N==1,0,_n)
sort nrn
count if dupnrn2>0 //21 - checked 29nov18 and no duplicates!
list deathid pid fname lname nrn sex age eidmp dupnrn2 if dupnrn2>0
list nrn deathid pid
save "data\clean\2014_unmerged_cr5 & deaths_dc.dta" ,replace
restore

** Going through list of all events to check (1) unmatched cases that need to be corrected to merge (2) same or different pt (3) # of tumours (4) IARC or non-IARC MP
order pid deathid fname lname age sex dod dot dob natregno nrn slc dlc cr5cod cod1a cancer cod eidmp primary* morph* basis
sort lname fname
count if regexm(lname, "^a") | regexm(lname, "^b") | regexm(lname, "^c") | regexm(lname, "^d") | regexm(lname, "^e") | regexm(lname, "^f") |regexm(lname, "^g") //465
count if regexm(lname, "^h") | regexm(lname, "^i") | regexm(lname, "^j") | regexm(lname, "^k") | regexm(lname, "^l") | regexm(lname, "^m") | regexm(lname, "^n") //311
count if regexm(lname, "^o") | regexm(lname, "^p") | regexm(lname, "^q") | regexm(lname, "^r") | regexm(lname, "^s") | regexm(lname, "^t") | regexm(lname, "^u") ///
	   | regexm(lname, "^v") | regexm(lname, "^w") | regexm(lname, "^x") | regexm(lname, "^y") | regexm(lname, "^z") //293

list fname lname pid deathid age sex natregno nrn if regexm(lname, "^a") | regexm(lname, "^b") | regexm(lname, "^c") | regexm(lname, "^d") | regexm(lname, "^e") ///
												   | regexm(lname, "^f") |regexm(lname, "^g")
list fname lname pid deathid age sex natregno nrn if regexm(lname, "^h") | regexm(lname, "^i") | regexm(lname, "^j") | regexm(lname, "^k") | regexm(lname, "^l") ///
												   | regexm(lname, "^m") | regexm(lname, "^n")
list fname lname pid deathid age sex natregno nrn if regexm(lname, "^o") | regexm(lname, "^p") | regexm(lname, "^q") | regexm(lname, "^r") | regexm(lname, "^s") ///
												   | regexm(lname, "^t") | regexm(lname, "^u") | regexm(lname, "^v") | regexm(lname, "^w") | regexm(lname, "^x") ///
												   | regexm(lname, "^y") | regexm(lname, "^z")
** Updates based on above lists
replace nm=1 if pid=="20140882"|pid=="20145025" ///
			   |pid=="20141505"|pid=="20140170" ///
			   |pid=="20140690"|pid=="20140739" ///
			   |pid=="20140997"|pid=="20141362" ///
			   |pid=="20141406"|pid=="20141446"	//12 changes


** Check for MPs in CODs of unmatched deaths
count if _merge==2 //118 - 1 not cancer
list deathid if _merge==2
list cod1a if _merge==2
replace cancer=2 if deathid==19857 //1 change
replace cod=4 if deathid==19857 //1 change
list deathid cancer if cancer!=1 & _merge==2
drop if cancer!=1 & _merge==2 //1 obs deleted

** Update ptrectot=2-DCO with single event for above cases
replace ptrectot=2 if _merge==2 //117 changes


** Create variable to identify DCI/DCN vs DCO
gen dcostatus=.
label define dcostatus_lab ///
1 "Eligible DCI/DCN-cancer,in CR5db" ///
2 "DCO" ///
3 "Ineligible DCI/DCN" ///
4 "NA-not cancer,not in CR5db" ///
5 "NA-dead,CR5db no death source" ///
6 "NA-alive" ///
7 "NA-not alive/dead" , modify
label values dcostatus dcostatus_lab
label var dcostatus "death certificate status"

** Assign DCO Status=NA for all events that are not cancer
replace dcostatus=2 if _merge==2 //118
replace dcostatus=2 if basis==0 //126
replace dcostatus=4 if cancer==2 //24 changes
count if slc!=2 //435
list cr5cod if slc!=2
replace dcostatus=6 if slc==1
replace dcostatus=7 if slc==9
count if dcostatus==. & cr5cod!="" //358
replace dcostatus=1 if cr5cod!="" & dcostatus==. //358 changes
count if dcostatus==. & deathid!=. //8
list pid deathid basis recstatus eidmp nftype dcostatus if dcostatus==. & deathid!=. ,nolabel //8 - checked in CR5db, none had source with death info
replace dcostatus=5 if dcostatus==. & deathid!=. //8 changes
count if dcostatus==. //1
list pid deathid basis recstatus eidmp nftype if dcostatus==. //1 - checked CR5db, no source with death info
replace dcostatus=5 if pid=="20141542" //1 change

** Check for cases where cancer=2-not cancer but it has been abstracted
count if cancer==2 & pid!="" //24
sort pid deathid
list pid deathid fname lname basis cod cancer recstatus if cancer==2 & pid!="", nolabel
list cr5cod if cancer==2 & pid!=""
list cod1a if cancer==2 & pid!=""
** Corrections from above list
replace cod=1 if pid=="20140047" //1 change
replace cancer=1 if pid=="20140047" //1 change
replace dcostatus=1 if pid=="20140047" //1 change

replace cod=1 if pid=="20140064" //1 change
replace cancer=1 if pid=="20140064" //1 change
replace dcostatus=1 if pid=="20140064" //1 change

replace cancer=1 if pid=="20140093" //1 change
replace dcostatus=1 if pid=="20140093" //1 change

replace cod=1 if pid=="20140143" //1 change
replace cancer=1 if pid=="20140143" //1 change
replace dcostatus=1 if pid=="20140143" //1 change

replace cod=1 if pid=="20140255" //1 change
replace cancer=1 if pid=="20140255" //1 change
replace dcostatus=1 if pid=="20140255" //1 change

replace cod=1 if pid=="20140403" //1 change
replace cancer=1 if pid=="20140403" //1 change
replace dcostatus=1 if pid=="20140403" //1 change

replace cod=1 if pid=="20140434" //1 change
replace cancer=1 if pid=="20140434" //1 change
replace dcostatus=1 if pid=="20140434" //1 change

replace recstatus=3 if pid=="20140439" //1 change
replace dcostatus=3 if pid=="20140439" //1 change

replace cod=1 if pid=="20140507" //1 change
replace cancer=1 if pid=="20140507" //1 change
replace dcostatus=1 if pid=="20140507" //1 change

replace cancer=1 if pid=="20140730" //1 change
replace dcostatus=1 if pid=="20140730" //1 change

replace cancer=1 if pid=="20140779" //1 change
replace dcostatus=1 if pid=="20140779" //1 change

replace cod=1 if pid=="20141072" //1 change
replace cancer=1 if pid=="20141072" //1 change
replace dcostatus=1 if pid=="20141072" //1 change

replace cancer=1 if pid=="20141087" //1 change
replace dcostatus=1 if pid=="20141087" //1 change

replace cancer=1 if pid=="20141201" //1 change
replace dcostatus=1 if pid=="20141201" //1 change

replace cod=1 if pid=="20141267" //1 change
replace cancer=1 if pid=="20141267" //1 change
replace dcostatus=1 if pid=="20141267" //1 change

replace cancer=1 if pid=="20141314" //1 change
replace dcostatus=1 if pid=="20141314" //1 change

replace cancer=1 if pid=="20141337" //1 change
replace dcostatus=1 if pid=="20141337" //1 change

replace cod=1 if pid=="20141343" //1 change
replace cancer=1 if pid=="20141343" //1 change
replace dcostatus=1 if pid=="20141343" //1 change

replace cancer=1 if pid=="20141352" //1 change
replace dcostatus=1 if pid=="20141352" //1 change

replace cancer=1 if pid=="20141363" //1 change
replace dcostatus=1 if pid=="20141363" //1 change

replace cod=1 if pid=="20141557" //1 change
replace cancer=1 if pid=="20141557" //1 change
replace dcostatus=1 if pid=="20141557" //1 change

replace cancer=1 if pid=="20145008" //1 change
replace dcostatus=1 if pid=="20145008" //1 change

replace cancer=1 if pid=="20145035" //1 change
replace dcostatus=1 if pid=="20145035" //1 change

replace cancer=1 if pid=="20145066" //1 change
replace dcostatus=1 if pid=="20145066" //1 change


** Check for incorrect COD in CR5 data
count if _merge==1 & cod!=1 //440

count if _merge==3 & cod!=1 //24; 13 - all correct
list pid cod recstatus if _merge==3 & cod!=1

count if _merge==1 & slc==2 //5 - none found in national death data
list pid fname lname cr5cod if _merge==1 & slc==2

count if cancer==1 & pid!="" & cod==2 //12 - all correct
list pid cancer cod if cancer==1 & pid!="" & cod==2

** Remove ineligible recstatus=3 or dcostatus=1
** First save dataset so you can use to analyse dcostatus in DQI (dofile 9)
list pid basis dcostatus recstatus cr5cod if dcostatus==3|dcostatus==4 //1
replace recstatus=3 if dcostatus==3|dcostatus==4 //0 changes - 20140439 already changed
** Save dataset to use for DQI (dofile 9)
count //
save "data\clean\2014_cancer_merge_dcostatus_dqi_dc.dta" ,replace
label data "BNR-Cancer Cleaning: Data Quality Indicator - DC Status"
notes _dta :These data prepared for 2014 ABS phase

use "data\clean\2014_cancer_merge_dcostatus_dqi_dc.dta" ,clear

drop if recstatus==3 //1 obs deleted
drop if dcostatus==3|dcostatus==4 //0 obs deleted

** Update cancer=1 for cr5 records
count if cancer==. //440
replace cancer=1 if cancer==. //440 changes

** Updating status for ptrectot, beh, basis, to all cases missing these (primarily unmatched merged deaths)
count //1,067

tab cancer ,m
/*
   cancer diagnoses |      Freq.     Percent        Cum.
--------------------+-----------------------------------
        2014 cancer |      1,067      100.00      100.00
--------------------+-----------------------------------
              Total |      1,067      100.00
*/
tab dcostatus ,m
/*
        death certificate status |      Freq.     Percent        Cum.
---------------------------------+-----------------------------------
Eligible DCI/DCN-cancer,in CR5db |        381       35.71       35.71
                             DCO |        242       22.68       58.39
        NA-CR5db no death source |          9        0.84       59.23
                 NA-not deceased |        435       40.77      100.00
---------------------------------+-----------------------------------
                           Total |      1,067      100.00

*/
tab ptrectot ,m
/*
                               ptrectot |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
               CR5 pt with single event |        929       87.07       87.07
                  DCO with single event |        117       10.97       98.03
            CR5 pt with multiple events |         21        1.97      100.00
----------------------------------------+-----------------------------------
                                  Total |      1,067      100.00
*/
tab beh ,m
/*
  Behaviour |      Freq.     Percent        Cum.
------------+-----------------------------------
    In situ |         24        2.25        2.25
  Malignant |        926       86.79       89.03
          . |        117       10.97      100.00
------------+-----------------------------------
      Total |      1,067      100.00
*/
replace beh=3 if ptrectot==2 //117 changes

tab basis ,m
/*
          BasisOfDiagnosis |      Freq.     Percent        Cum.
---------------------------+-----------------------------------
                       DCO |        125       11.72       11.72
             Clinical only |         30        2.81       14.53
Clinical Invest./Ult Sound |         17        1.59       16.12
 Exploratory surg./autopsy |          4        0.37       16.49
Lab test (biochem/immuno.) |          2        0.19       16.68
             Cytology/Haem |         44        4.12       20.81
                Hx of mets |         15        1.41       22.21
             Hx of primary |        667       62.51       84.72
             Autopsy w/ Hx |          9        0.84       85.57
                   Unknown |         37        3.47       89.03
                         . |        117       10.97      100.00
---------------------------+-----------------------------------
                     Total |      1,067      100.00
*/
replace basis=0 if ptrectot==2 //117 changes

tab eidmp ,m
/*
     CR5 tumour |
         events |      Freq.     Percent        Cum.
----------------+-----------------------------------
  single tumour |        939       88.00       88.00
multiple tumour |         11        1.03       89.03
              . |        117       10.97      100.00
----------------+-----------------------------------
          Total |      1,067      100.00
*/
replace eidmp=1 if ptrectot==2 //117 changes

tab dxyr deathyear ,m
/*
DiagnosisY |                       deathyear
       ear |      2014       2015       2016       2017          . |     Total
-----------+-------------------------------------------------------+----------
      2013 |        18          3          0          0          9 |        30
      2014 |       306        105         56         30        431 |       928
         . |       117          0          0          0          0 |       117
-----------+-------------------------------------------------------+----------
     Total |       441        108         56         30        440 |     1,075
*/
replace dxyr=2014 if ptrectot==2 //117 changes

rename ds dupsource
tab dupsource ,m
/*
                    Multiple Sources |      Freq.     Percent        Cum.
-------------------------------------+-----------------------------------
                  MS-Conf Tumour Rec |        958       89.12       89.12
                                   . |        117       10.88      100.00 - leave as is
-------------------------------------+-----------------------------------
                               Total |      1,075      100.00
*/

tab cod slc ,m
/*
                    |        StatusLastContact
     COD categories |     Alive   Deceased    Unknown |     Total
--------------------+---------------------------------+----------
     Dead of cancer |         0        615          0 |       615
Dead of other cause |         0         12          0 |        12
                  . |       430          5          5 |       440
--------------------+---------------------------------+----------
              Total |       430        632          5 |     1,067
*/
replace cod=4 if slc==1 & cod==. //430 changes
list pid deathid cod1a cr5cod if slc==9 & cod==. //5
replace cod=4 if slc==9 & cod==. //5 changes
list pid top morph cr5cod if slc==2 & cod==. //5
replace cod=3 if pid=="20141542" //1 change
replace cod=1 if slc==2 & cod==. //4 changes

** Check for MP in CR5 CODs (pid 20141263)
count if _merge!=2 & cr5cod!="" & cr5cod!="99" //432 - 8 MP CODs found
list pid if _merge!=2 & cr5cod!="" & cr5cod!="99" //easiest to check by using this filter in Stata data editor
list cr5cod if _merge!=2 & cr5cod!="" & cr5cod!="99"
** Corrections (found incidentally) based on above list
replace hx="LINITIS PLASTICA" if pid=="20140256" //1 change
replace morph=8142 if pid=="20140256" //1 change
replace morphcat=6 if pid=="20140256" //1 change

replace grade=6 if pid=="20080677" & regexm(cr5id, "T2") //1 change
** Below missed MPs in cr5 CODs based on above list
expand=2 if pid=="20140339" & cr5id=="T1S1", gen (dupobs1do5)
replace cr5id="T2S1" if pid=="20140339" & dupobs1do5==1 //1 change
replace eidmp=2 if pid=="20140339" & cr5id=="T2S1" //1 change
replace ptrectot=5 if pid=="20140339" & cr5id=="T2S1" //1 change
replace cod=1 if pid=="20140339" & cr5id=="T2S1" //0 changes
replace primarysite="PROSTATE" if pid=="20140339" & cr5id=="T2S1" //1 change
replace topography=619 if pid=="20140339" & cr5id=="T2S1" //1 change
replace top="619" if pid=="20140339" & cr5id=="T2S1" //1 change
replace topcat=53 if pid=="20140339" & cr5id=="T2S1" //1 change
replace hx="CANCER" if pid=="20140339" & cr5id=="T2S1" //1 change
replace morph=8000 if pid=="20140339" & cr5id=="T2S1" //1 change
replace morphcat=1 if pid=="20140339" & cr5id=="T2S1" //1 change
replace lat=0 if pid=="20140339" & cr5id=="T2S1" //0 changes
replace latcat=0 if pid=="20140339" & cr5id=="T2S1" //0 changes
replace beh=3 if pid=="20140339" & cr5id=="T2S1" //0 changes
replace grade=9 if pid=="20140339" & cr5id=="T2S1" //1 change
replace basis=0 if pid=="20140339" & cr5id=="T2S1" //1 change
replace staging=8 if pid=="20140339" & cr5id=="T2S1" //0 changes
replace dot=dlc if pid=="20140339" & cr5id=="T2S1" //1 change
replace consultant=certifier if pid=="20140339" & cr5id=="T2S1" //1 change

expand=2 if pid=="20140490" & cr5id=="T1S1", gen (dupobs2do5)
replace cr5id="T2S1" if pid=="20140490" & dupobs2do5==1 //1 change
replace eidmp=2 if pid=="20140490" & cr5id=="T2S1" //1 change
replace ptrectot=5 if pid=="20140490" & cr5id=="T2S1" //1 change
replace cod=1 if pid=="20140490" & cr5id=="T2S1" //0 changes
replace primarysite="KIDNEY" if pid=="20140490" & cr5id=="T2S1" //1 change
replace topography=649 if pid=="20140490" & cr5id=="T2S1" //1 change
replace top="649" if pid=="20140490" & cr5id=="T2S1" //1 change
replace topcat=56 if pid=="20140490" & cr5id=="T2S1" //1 change
replace hx="CANCER" if pid=="20140490" & cr5id=="T2S1" //1 change
replace morph=8000 if pid=="20140490" & cr5id=="T2S1" //0 changes
replace morphcat=1 if pid=="20140490" & cr5id=="T2S1" //0 changes
replace lat=9 if pid=="20140490" & cr5id=="T2S1" //1 change
replace latcat=37 if pid=="20140490" & cr5id=="T2S1" //1 change
replace beh=3 if pid=="20140490" & cr5id=="T2S1" //0 changes
replace grade=9 if pid=="20140490" & cr5id=="T2S1" //0 changes
replace basis=0 if pid=="20140490" & cr5id=="T2S1" //0 changes
replace staging=8 if pid=="20140490" & cr5id=="T2S1" //0 changes
replace dot=dlc if pid=="20140490" & cr5id=="T2S1" //0 changes
replace consultant=certifier if pid=="20140490" & cr5id=="T2S1" //0 changes

expand=2 if pid=="20140526" & cr5id=="T1S1", gen (dupobs3do5)
replace cr5id="T2S1" if pid=="20140526" & dupobs3do5==1 //1 change
replace eidmp=2 if pid=="20140526" & cr5id=="T2S1" //1 change
replace ptrectot=5 if pid=="20140526" & cr5id=="T2S1" //1 change
replace cod=1 if pid=="20140526" & cr5id=="T2S1" //0 changes
replace primarysite="PROSTATE" if pid=="20140526" & cr5id=="T2S1" //1 change
replace topography=619 if pid=="20140526" & cr5id=="T2S1" //1 change
replace top="619" if pid=="20140526" & cr5id=="T2S1" //1 change
replace topcat=53 if pid=="20140526" & cr5id=="T2S1" //1 change
replace hx="CANCER" if pid=="20140526" & cr5id=="T2S1" //1 change
replace morph=8000 if pid=="20140526" & cr5id=="T2S1" //1 change
replace morphcat=1 if pid=="20140526" & cr5id=="T2S1" //1 change
replace lat=0 if pid=="20140526" & cr5id=="T2S1" //0 changes
replace latcat=0 if pid=="20140526" & cr5id=="T2S1" //0 changes
replace beh=3 if pid=="20140526" & cr5id=="T2S1" //0 changes
replace grade=9 if pid=="20140526" & cr5id=="T2S1" //1 change
replace basis=0 if pid=="20140526" & cr5id=="T2S1" //1 change
replace staging=8 if pid=="20140526" & cr5id=="T2S1" //0 changes
replace dot=dlc if pid=="20140526" & cr5id=="T2S1" //1 change
replace consultant=certifier if pid=="20140526" & cr5id=="T2S1" //0 changes

expand=2 if pid=="20140672" & cr5id=="T1S1", gen (dupobs4do5)
replace cr5id="T2S1" if pid=="20140672" & dupobs4do5==1 //1 change
replace eidmp=2 if pid=="20140672" & cr5id=="T2S1" //1 change
replace ptrectot=5 if pid=="20140672" & cr5id=="T2S1" //1 change
replace cod=1 if pid=="20140672" & cr5id=="T2S1" //0 changes
replace primarysite="COLON" if pid=="20140672" & cr5id=="T2S1" //1 change
replace topography=189 if pid=="20140672" & cr5id=="T2S1" //1 change
replace top="189" if pid=="20140672" & cr5id=="T2S1" //1 change
replace topcat=19 if pid=="20140672" & cr5id=="T2S1" //1 change
replace hx="CANCER" if pid=="20140672" & cr5id=="T2S1" //1 change
replace morph=8000 if pid=="20140672" & cr5id=="T2S1" //1 change
replace morphcat=1 if pid=="20140672" & cr5id=="T2S1" //1 change
replace lat=0 if pid=="20140672" & cr5id=="T2S1" //0 changes
replace latcat=0 if pid=="20140672" & cr5id=="T2S1" //0 changes
replace beh=3 if pid=="20140672" & cr5id=="T2S1" //0 changes
replace grade=9 if pid=="20140672" & cr5id=="T2S1" //0 changes
replace basis=0 if pid=="20140672" & cr5id=="T2S1" //1 change
replace staging=8 if pid=="20140672" & cr5id=="T2S1" //0 changes
replace dot=dlc if pid=="20140672" & cr5id=="T2S1" //1 change
replace consultant=certifier if pid=="20140672" & cr5id=="T2S1" //1 change

expand=2 if pid=="20141263" & cr5id=="T1S1", gen (dupobs5do5)
replace cr5id="T2S1" if pid=="20141263" & dupobs5do5==1 //1 change
replace eidmp=2 if pid=="20141263" & cr5id=="T2S1" //1 change
replace ptrectot=5 if pid=="20141263" & cr5id=="T2S1" //1 change
replace cod=1 if pid=="20141263" & cr5id=="T2S1" //0 changes
replace primarysite="99" if pid=="20141263" & cr5id=="T2S1" //1 change
replace topography=809 if pid=="20141263" & cr5id=="T2S1" //1 change
replace top="809" if pid=="20141263" & cr5id=="T2S1" //1 change
replace topcat=70 if pid=="20141263" & cr5id=="T2S1" //1 change
replace hx="OCCULT MALIGNANCY" if pid=="20141263" & cr5id=="T2S1" //1 change
replace morph=8000 if pid=="20141263" & cr5id=="T2S1" //1 change
replace morphcat=1 if pid=="20141263" & cr5id=="T2S1" //1 change
replace lat=0 if pid=="20141263" & cr5id=="T2S1" //0 changes
replace latcat=0 if pid=="20141263" & cr5id=="T2S1" //0 changes
replace beh=3 if pid=="20141263" & cr5id=="T2S1" //0 changes
replace grade=9 if pid=="20141263" & cr5id=="T2S1" //0 changes
replace basis=0 if pid=="20141263" & cr5id=="T2S1" //1 change
replace staging=8 if pid=="20141263" & cr5id=="T2S1" //0 changes
replace dot=dlc if pid=="20141263" & cr5id=="T2S1" //1 change
replace consultant=certifier if pid=="20141263" & cr5id=="T2S1" //1 change

expand=2 if pid=="20141306" & cr5id=="T1S1", gen (dupobs6do5)
replace cr5id="T2S1" if pid=="20141306" & dupobs6do5==1 //1 change
replace eidmp=2 if pid=="20141306" & cr5id=="T2S1" //1 change
replace ptrectot=5 if pid=="20141306" & cr5id=="T2S1" //1 change
replace cod=1 if pid=="20141306" & cr5id=="T2S1" //0 changes
replace primarysite="ENDOMETRIUM" if pid=="20141306" & cr5id=="T2S1" //1 change
replace topography=541 if pid=="20141306" & cr5id=="T2S1" //1 change
replace top="541" if pid=="20141306" & cr5id=="T2S1" //1 change
replace topcat=47 if pid=="20141306" & cr5id=="T2S1" //1 change
replace hx="SEROUS PAPILLARY" if pid=="20141306" & cr5id=="T2S1" //1 change
replace morph=8460 if pid=="20141306" & cr5id=="T2S1" //1 change
replace morphcat=9 if pid=="20141306" & cr5id=="T2S1" //1 change
replace lat=0 if pid=="20141306" & cr5id=="T2S1" //0 changes
replace latcat=0 if pid=="20141306" & cr5id=="T2S1" //0 changes
replace beh=3 if pid=="20141306" & cr5id=="T2S1" //0 changes
replace grade=9 if pid=="20141306" & cr5id=="T2S1" //1 change
replace basis=0 if pid=="20141306" & cr5id=="T2S1" //1 change
replace staging=8 if pid=="20141306" & cr5id=="T2S1" //0 changes
replace dot=dlc if pid=="20141306" & cr5id=="T2S1" //1 change
replace consultant=certifier if pid=="20141306" & cr5id=="T2S1" //1 change

expand=2 if pid=="20141480" & cr5id=="T1S1", gen (dupobs7do5)
replace cr5id="T2S1" if pid=="20141480" & dupobs7do5==1 //1 change
replace eidmp=2 if pid=="20141480" & cr5id=="T2S1" //1 change
replace ptrectot=5 if pid=="20141480" & cr5id=="T2S1" //1 change
replace cod=1 if pid=="20141480" & cr5id=="T2S1" //0 changes
replace primarysite="BONE MARROW" if pid=="20141480" & cr5id=="T2S1" //1 change
replace topography=421 if pid=="20141480" & cr5id=="T2S1" //1 change
replace top="421" if pid=="20141480" & cr5id=="T2S1" //1 change
replace topcat=38 if pid=="20141480" & cr5id=="T2S1" //1 change
replace hx="MULTIPLE MYELOMA" if pid=="20141480" & cr5id=="T2S1" //1 change
replace morph=9732 if pid=="20141480" & cr5id=="T2S1" //1 change
replace morphcat=46 if pid=="20141480" & cr5id=="T2S1" //1 change
replace lat=0 if pid=="20141480" & cr5id=="T2S1" //0 changes
replace latcat=0 if pid=="20141480" & cr5id=="T2S1" //0 changes
replace beh=3 if pid=="20141480" & cr5id=="T2S1" //0 changes
replace grade=6 if pid=="20141480" & cr5id=="T2S1" //1 change
replace basis=0 if pid=="20141480" & cr5id=="T2S1" //1 change
replace staging=8 if pid=="20141480" & cr5id=="T2S1" //0 changes
replace dot=dlc if pid=="20141480" & cr5id=="T2S1" //1 change
replace consultant=certifier if pid=="20141480" & cr5id=="T2S1" //1 change

expand=2 if pid=="20145082" & cr5id=="T1S1", gen (dupobs8do5)
replace cr5id="T2S1" if pid=="20145082" & dupobs8do5==1 //1 change
replace eidmp=2 if pid=="20145082" & cr5id=="T2S1" //1 change
replace ptrectot=5 if pid=="20145082" & cr5id=="T2S1" //1 change
replace cod=1 if pid=="20145082" & cr5id=="T2S1" //0 changes
replace primarysite="PROSTATE" if pid=="20145082" & cr5id=="T2S1" //1 change
replace topography=619 if pid=="20145082" & cr5id=="T2S1" //1 change
replace top="619" if pid=="20145082" & cr5id=="T2S1" //1 change
replace topcat=53 if pid=="20145082" & cr5id=="T2S1" //1 change
replace hx="CANCER" if pid=="20145082" & cr5id=="T2S1" //1 change
replace morph=8000 if pid=="20145082" & cr5id=="T2S1" //1 change
replace morphcat=1 if pid=="20145082" & cr5id=="T2S1" //1 change
replace lat=0 if pid=="20145082" & cr5id=="T2S1" //0 changes
replace latcat=0 if pid=="20145082" & cr5id=="T2S1" //0 changes
replace beh=3 if pid=="20145082" & cr5id=="T2S1" //0 changes
replace grade=9 if pid=="20145082" & cr5id=="T2S1" //0 changes
replace basis=0 if pid=="20145082" & cr5id=="T2S1" //1 change
replace staging=8 if pid=="20145082" & cr5id=="T2S1" //0 changes
replace dot=dlc if pid=="20145082" & cr5id=="T2S1" //1 change
replace consultant=certifier if pid=="20145082" & cr5id=="T2S1" //0 changes

count //1,075

tab eidmp ,m
/*
     CR5 tumour |
         events |      Freq.     Percent        Cum.
----------------+-----------------------------------
  single tumour |      1,056       98.23       98.23
multiple tumour |         19        1.77      100.00
----------------+-----------------------------------
          Total |      1,075      100.00
*/


** Create variable called "deceased" - same as 2008 dofile called '3_merge_cancer_deaths.do'
tab slc ,m
count if slc!=2 & dod!=. //0
gen deceased=1 if slc!=1 //645 changes
label var deceased "whether patient is deceased"
label define deceased_lab 1 "dead" 2 "alive at last contact" , modify
label values deceased deceased_lab
replace deceased=2 if slc==1 //430 changes

tab deceased ,m
/*
   whether patient is |
             deceased |      Freq.     Percent        Cum.
----------------------+-----------------------------------
                 dead |        645       60.00       60.00
alive at last contact |        430       40.00      100.00
----------------------+-----------------------------------
                Total |      1,075      100.00
*/

** Create the "patient" variable - same as 2008 dofile called '3_merge_cancer_deaths.do'
gen patient=.
label var patient "cancer patient"
label define pt_lab 1 "patient" 2 "separate event",modify
label values patient pt_lab
replace patient=1 if eidmp==1 //1,056 changes
replace patient=2 if eidmp==2 //19 changes
tab patient ,miss

** Update eids, sids for MPs that have matching eid, sid, cr5id
order pid eid sid cr5id deathid eidmp dot dlc dod
list pid eid sid if eidmp==2
replace eid="201404740103" if pid=="20140474" & cr5id=="T3S1" //1 change
replace sid="20140474010301" if pid=="20140474" & cr5id=="T3S1" //1 change

replace eid="201405700102" if pid=="20140570" & cr5id=="T2S1" //1 change
replace sid="20140570010201" if pid=="20140570" & cr5id=="T2S1" //1 change

replace eid="201407860102" if pid=="20140786" & cr5id=="T2S1" //1 change
replace sid="20140786010201" if pid=="20140786" & cr5id=="T2S1" //1 change

replace eid="201403390102" if pid=="20140339" & cr5id=="T2S1" //1 change
replace sid="20140339010201" if pid=="20140339" & cr5id=="T2S1" //1 change

replace eid="201404900102" if pid=="20140490" & cr5id=="T2S1" //1 change
replace sid="20140490010201" if pid=="20140490" & cr5id=="T2S1" //1 change

replace eid="201405260102" if pid=="20140526" & cr5id=="T2S1" //1 change
replace sid="20140526010201" if pid=="20140526" & cr5id=="T2S1" //1 change

replace eid="201406720102" if pid=="20140672" & cr5id=="T2S1" //1 change
replace sid="20140672010201" if pid=="20140672" & cr5id=="T2S1" //1 change

replace eid="201412630102" if pid=="20141263" & cr5id=="T2S1" //1 change
replace sid="20141263010201" if pid=="20141263" & cr5id=="T2S1" //1 change

replace eid="201413060102" if pid=="20141306" & cr5id=="T2S1" //1 change
replace sid="20141306010201" if pid=="20141306" & cr5id=="T2S1" //1 change

replace eid="201414800102" if pid=="20141480" & cr5id=="T2S1" //1 change
replace sid="20141480010201" if pid=="20141480" & cr5id=="T2S1" //1 change

replace eid="201450820102" if pid=="20145082" & cr5id=="T2S1" //1 change
replace sid="20145082010201" if pid=="20145082" & cr5id=="T2S1" //1 change


** Create pid, eid, sid, cr5id for DCOs (117obs) in prep for analysis
count if pid=="" //117 - last pid in Stata editor is 20145171
sort pid deathid
** It's faster to create above id in excel then paste into Stata editor (edit mode)
/*
NB: Since this dataset was manually created, any corrections done to earlier dofiles
	after this dataset was created (03dec18) will need to be re-done in this or later dofiles.
*/
save "data\clean\2014_cancer_deaths_noid.dta" ,replace

use "data\clean\2014_cancer_deaths_id.dta" ,clear

******************************************************
** Final cleaning checks using checks from dofile 2 **
******************************************************
** Check 27 - missing but full NRN available
drop nrnday
gen nrnday = substr(natregno,5,2)
count if dob==. & natregno!="" & natregno!="9999999999" & natregno!="999999-9999" & natregno!="99" & nrnday!="99" //0

** Check 28 - invalid (dob has future year)
drop dob_yr
gen dob_yr = year(dob)
count if dob!=. & dob_yr>2014 //0

** Check 29 - invalid (dob does not match natregno)
drop dob_year
gen dob_year = year(dob) if natregno!="" & natregno!="9999999999" & natregno!="999999-9999" & nrnday!="99" & length(natregno)==11
gen yr1=.
replace yr1 = 20 if dob_year>1999
replace yr1 = 19 if dob_year<2000
replace yr1 = 19 if dob_year==.
replace yr1 = 99 if natregno=="99"
list pid dob_year dob natregno yr1 if dob_year!=. & dob_year > 1999
gen nrn2 = substr(natregno,1,6) if natregno!="" & natregno!="9999999999" & natregno!="999999-9999" & nrnday!="99" & length(natregno)==11
destring nrn2, replace
format nrn2 %06.0f
nsplit nrn2, digits(2 2 2) gen(year month day)
format year month day %02.0f
tostring yr1, replace
drop year2
gen year2 = string(year,"%02.0f")
gen nrnyr = substr(yr1,1,2) + substr(year2,1,2)
destring nrnyr, replace
sort nrn2
drop dobchk
gen dobchk=mdy(month, day, nrnyr)
format dobchk %dD_m_CY
count if dob!=dobchk & dobchk!=. //0
list pid age natregno dob dobchk dob_year dot if dob!=dobchk & dobchk!=.
drop day month year nrnyr yr1 nrn2

sort pid
** Check 30 - missing
count if natregno=="" & dob!=. //0

** Check 31 - invalid length
count if length(natregno)<11 & natregno!="" //0

** Check 32 - missing
count if sex==. | sex==9 //8 - check electoral list if unsure
list pid sex fname mname lname natregno cr5id if sex==. | sex==9
replace sex=1 if pid=="20140687"|pid=="20140701"|pid=="20140773"|pid=="20145117" //4 changes
replace sex=2 if pid=="20140697"|pid=="20140723"|pid=="20140808"|pid=="20145111" //4 changes

** Check 33 - possibly invalid (first name, NRN and sex check: MALES)
drop nrnid
gen nrnid=substr(natregno, -4,4)
count if sex==2 & nrnid!="9999" & regex(substr(natregno,-2,1), "[1,3,5,7,9]") //2 - no changes, all correct
list pid fname lname sex natregno cr5id if sex==2 & nrnid!="9999" & regex(substr(natregno,-2,1), "[1,3,5,7,9]")

** Check 34 - possibly invalid (sex=M; site=breast)
count if sex==1 & (regexm(cr5cod, "BREAST") | regexm(top, "^50")) //4 - no changes; all correct
list pid fname lname natregno sex top cr5cod cr5id if sex==1 & (regexm(cr5cod, "BREAST") | regexm(top, "^50"))

** Check 35 - invalid (sex=M; site=FGS)
count if sex==1 & topcat>43 & topcat<52	& (regexm(cr5cod, "VULVA") | regexm(cr5cod, "VAGINA") | regexm(cr5cod, "CERVIX") | regexm(cr5cod, "CERVICAL") ///
								| regexm(cr5cod, "UTER") | regexm(cr5cod, "OVAR") | regexm(cr5cod, "PLACENTA")) //0

** Check 36 - possibly invalid (first name, NRN and sex check: FEMALES)
count if sex==1 & nrnid!="9999" & regex(substr(natregno,-2,1), "[0,2,4,6,8]") //1 - no change, all correct
list pid fname lname sex natregno cr5id if sex==1 & nrnid!="9999" & regex(substr(natregno,-2,1), "[0,2,4,6,8]")

** Check 37 - invalid (sex=F; site=MGS)
count if sex==2 & topcat>51 & topcat<56 & (regexm(cr5cod, "PENIS")|regexm(cr5cod, "PROSTAT") ///
		|regexm(cr5cod, "TESTIS")|regexm(cr5cod, "TESTIC")) //0

** Check 58 - missing
count if (age==-1 | age==.) & dot!=. //0

** Check 59 - invalid (age<>incidencedate-dob); checked no errors
** Age (at INCIDENCE - to nearest year)
gen ageyrs2 = (dot - dob)/365.25 //
gen checkage2=int(ageyrs2)
drop ageyrs2
label var checkage2 "Age in years at INCIDENCE"
count if dob!=. & dot!=. & age!=checkage2 //28 - these correct according to CR5 as same day & month for dob & dot
list pid dot dob age checkage2 cr5id if dob!=. & dot!=. & age!=checkage2
replace age=checkage2 if dob!=. & dot!=. & age!=checkage2 //28 changes

** Check 103 - InciDate missing
count if dot==. //117
replace dot=dod if ptrectot==2 //117 changes

** Update dotyear
drop dotyear
gen dotyear=year(dot)
label var dotyear "Incidence year"


** Create death year variable
count if dod==. //435
gen dodyear = year(dod)
label var dodyear "Year of death"

** Check dates
tab dodyear if deceased==1 ,m
/*
    Year of |
      death |      Freq.     Percent        Cum.
------------+-----------------------------------
       2014 |        446       69.15       69.15
       2015 |        108       16.74       85.89
       2016 |         56        8.68       94.57
       2017 |         30        4.65       99.22
          . |          5        0.78      100.00
------------+-----------------------------------
      Total |        645      100.00
*/

tab dotyear if deceased==1 ,m
/*
  Incidence |
       year |      Freq.     Percent        Cum.
------------+-----------------------------------
       2013 |         22        3.41        3.41
       2014 |        619       95.97       99.38
       2015 |          3        0.47       99.84
       2016 |          1        0.16      100.00
------------+-----------------------------------
      Total |        645      100.00
*/
tab dotyear ,m
/*
  Incidence |
       year |      Freq.     Percent        Cum.
------------+-----------------------------------
       2013 |         30        2.79        2.79
       2014 |      1,041       96.84       99.63
       2015 |          3        0.28       99.91
       2016 |          1        0.09      100.00
------------+-----------------------------------
      Total |      1,075      100.00
*/

** Create 2013 dataset to append to previous 2013 annual rpt dataset
list pid deathid cr5id dotyear dodyear _merge if dxyr==2013
preserve
drop if dotyear!=2013 //1,045 obs deleted
save "data\clean\2013_cancer_merge_dc.dta" ,replace
restore

** Remove records outside of 2014 registration year
list pid deathid cr5id if dotyear>2014
drop if dotyear>2014 //4 obs deleted - 20141263, 20141306, 20141480, 20145082
drop if dotyear<2014 //30 obs deleted


** Create site variable for unmerged deaths (n=117)
** These groupings are based on AR's 2008 code but for 2014, in addition to this,
** I have added another grouping, at end of this dofile, which is used by IARC in CI5 Vol XI
count
sort cod1a

gen site=1 if (regexm(cod1a, "LIP")	| regexm(cod1a, "MOUTH")	| ///
			   regexm(cod1a, "PHARYNX") | regexm(cod1a, "TONSIL") | ///
			    regexm(cod1a, "TONGUE") | regexm(cod1a, "VOCAL CORD") | ///
				regexm(cod1a, "PHARNYX") | regexm(cod1a, "OF THE SOFT PALATE"))
** 21 changes

replace site=2 if regexm(cod1a, "STOMACH")
** 7 changes

replace site=3 if (regexm(cod1a, "COLON") | regexm(cod1a, "OF BOWEL") | ///
				  regexm(cod1a, "OF THE BOWEL") | ///
				  regexm(cod1a, "CAECAL CARCINOMA") | regexm(cod1a, "CARCINOMA OF THE CAECUM") | ///
				  regexm(cod1a, "OMA OF THE SIGMOID")) & site==.
** 81 changes

replace site=4 if regexm(cod1a, "COLORECTAL") & site==.
** 6 changes

replace site=5 if (regexm(cod1a, "RECTUM") | regexm(cod1a, "RECTAL CARCINOMA") | ///
				   regexm(cod1a, "OF THE ANAL CANAL")) & site==.
** 8 changes

replace site=6 if regexm(cod1a, "PANCREA") & site==.
** 21 changes

replace site=7 if (regexm(cod1a, "GASTRIC CARCINOMA") | regexm(cod1a, "GASTRIC CANCER") | ///
				  regexm(cod1a, "GASTRIC ADENO") | regexm(cod1a, "CANCER OF THE LIVER")  | ///
				  regexm(cod1a, "LIVER CARCIN") | regexm(cod1a, "CARCINOMA OF LIVER") | ///
				  regexm(cod1a, "GALL BLADDER") | regexm(cod1a, "GALLBLADDER") |  ///
				  regexm(cod1a, "HEPATIC CARCIN") | regexm(cod1a, "OESOPHAGAL CANCER") | ///
				  regexm(cod1a, "GASTRO-ESOPHAGEAL JUNC") | ///
				  regexm(cod1a, "CARCINOMA OF OESOPHA") | regexm(cod1a, "OF THE ESOPHAGUS") | ///
				  regexm(cod1a, "CARCINOMA OF THE OESOPHAG") | regexm(cod1a, "JEJUNUM") | ///
				  regexm(cod1a, "HEPATIC CYST") | regexm(cod1a, "CHOLANGIO") | ///
				  regexm(cod1a, "TUMOUR OF ILEUM") | regexm(cod1a, "OESOPHAGEAL CARCINO") | ///
				  regexm(cod1a, "SMALL BOWEL") | regexm(cod1a, "DUODENAL CARCIN")) & site==.
** 21 changes

replace site=8 if regexm(cod1a, "LUNG") | regexm(cod1a, "PLEURA") | ///
				  regexm(cod1a, "LARYNX") | regexm(cod1a, "BRONCHOGENIC") | ///
				  regexm(cod1a, "BRONCHOALVEOLAR CARCIN") & site==.
** 55 changes

replace site=9 if regexm(cod1a, "BONE") & site==.
** 6 changes

replace site=10 if (regexm(cod1a, "MYELOMA") | regexm(cod1a, "MYELODYSPLASTIC") | ///
				    regexm(cod1a, "LEUKAEMIA") | regexm(cod1a, "LEUKEMIA") | ///
					regexm(cod1a, "HAEMA") | regexm(cod1a, "LYMPHO") | ///
					regexm(cod1a, "HODGKIN")) & site==.
** 55 changes

replace site=11 if regexm(cod1a, "MELANOMA")
** 3 changes

replace site=12 if regexm(cod1a, "SKIN") & site==.
** 0 changes

replace site=13 if regexm(cod1a, "MESOTHE") & site==.
** 2 changes

replace site=14 if regexm(cod1a, "BREAST") & site==.
** 59 changes

replace site=15 if regexm(cod1a, "CERVI") & site==.
** 13 changes

replace site=16 if (regexm(cod1a, "UTER") | regexm(cod1a, "OMA OF THE VULVA") | ///
				    regexm(cod1a, "CHORIOCARCIN") | regexm(cod1a, "ENDOMETRIAL CARCINOMA") | ///
					regexm(cod1a, "ENDOMETRIAL CANC") | regexm(cod1a, "OF ENDOMETRIUM") | ///
					regexm(cod1a, "OF THE ENDOMETRIUM")) & site==.
** 26 changes

replace site=17 if (regexm(cod1a, "OVARY") | regexm(cod1a, "OVARIAN") | ///
				   regexm(cod1a, "GERM CELL")) & site==.
** 5 changes

replace site=18 if (regexm(cod1a, "PENILE") | regexm(cod1a, "OF THE TESTES") | ///
					regexm(cod1a, "GERM CELL")) & site==.
** 3 changes

replace site=19 if regexm(cod1a, "PROSTAT") & site==.
** 81 changes

replace site=20 if (regexm(cod1a, "URIN") | regexm(cod1a, "BLADDER") | ///
					regexm(cod1a, "KIDNEY") | regexm(cod1a, "RENAL CELL CARCIN") | ///
					regexm(cod1a, "WILMS") | regexm(cod1a, "TRANSITIONAL CELL") | ///
					regexm(cod1a, "OMA OF THE URETHRA")) & site==.
** 15 changes

replace site=21 if (regexm(cod1a, "EYE") | regexm(cod1a, "BRAIN") | regexm(cod1a, "CEREBRO") | ///
				   regexm(cod1a, "MENINGIO")  | regexm(cod1a, "INTRA-CRANIAL TUMOR") | ///
				   regexm(cod1a, "OITUTARY") | regexm(cod1a, "CEREBRAL NEOPLASM") | ///
				   regexm(cod1a, "GLIOSARCOMA") | regexm(cod1a, "INTRACEREBRAL TUMOUR") ) & site==.
** 3 changes

replace site=22 if (regexm(cod1a, "THYROID") | regexm(cod1a, "ENDOCRIN") ) & site==.
** 5 changes

** site 23 is ill-defined sites which can be assigned when checking the unassigned (i.e. site==.) in below list

replace site=24 if (regexm(cod1a, "LYMPH NODE")) & site==.
** Lymph - Secondary and unspecified malignant neoplasm of lymph nodes
**Excl.:malignant neoplasm of lymph nodes, specified as primary (C81-C86, C96.-)
** 0 changes

replace site=25 if (regexm(cod1a, "OCCULT") | regexm(cod1a, "OMA OF UNKNOWN ORIGIN")) & site==.
** 12 changes

label define site_lab 1 "C00-C14: lip, oral cavity & pharynx" 2 "C16: stomach"  3 "C18: colon" ///
  					  4 "C19: colon and rectum"  5 "C20-C21: rectum & anus" 6 "C25: pancreas" ///
					  7 "C15, C17, C22-C24, C26: other digestive organs" ///
					  8 "C30-C39: respiratory and intrathoracic organs" 9 "C40-41: bone and articular cartilage" ///
					  10 "C42,C77: haem & lymph systems" ///
					  11 "C44: melanoma & reportable skin cancers" 12 "C44: skin (non-reportable)" ///
					  13 "C45-C49: mesothelial and soft tissue" 14 "C50: breast" 15 "C53: cervix" ///
					  16 "C54,55: uterus" 17 "C51-C52, C56-58: other female genital organs" ///
					  18 "C60, C62, C63: male genital organs" 19 "C61: prostate" ///
					  20 "C64-C68: urinary tract" 21 "C69-C72: eye, brain, other CNS" ///
					  22 "C73-C75: thyroid and other endocrine glands"  ///
					  23 "C76: other and ill-defined sites" ///
					  24 "C77: lymph nodes" 25 "C80: unknown primary site"
label var site "site of tumour"
label values site site_lab

** NOW DO OTHER AND ILL DEFINED, AND UNKNOWNS LAST
tab site ,m

sort deathid
order pid cod1a deathid
count if site==. & top=="" //16 - use below filter in Stata editor
list pid deathid top ptrectot if site==. & top==""
list cod1a if site==. & top==""
** Updates based on above list
replace site=25 if pid=="20149009" //1 change
replace site=17 if pid=="20149011" //1 change
replace site=18 if pid=="20149025" //1 change
replace site=25 if pid=="20149028" //1 change
replace site=1 if pid=="20149030" //1 change
replace site=12 if pid=="20149037" //1 change
replace site=1 if pid=="20149045" //1 change
replace site=7 if pid=="20149051" //1 change
replace site=7 if pid=="20149054" //1 change
replace site=1 if pid=="20149055" //1 change
replace site=1 if pid=="20149065" //1 change
replace site=1 if pid=="20149084" //1 change
replace site=25 if pid=="20149090" //1 change
replace site=25 if pid=="20149092" //1 change
replace site=3 if pid=="20149094" //1 change
replace site=23 if pid=="20149105" //1 change


tab site ,m
count if site==. & topography!=. //520
replace site=1 if topography<150 //13 changes
replace site=2 if topography>159 & topography<170 //19 changes
replace site=3 if topography>179 & topography<190 //55 changes
replace site=4 if topography>189 & topography<200 //3 changes
replace site=5 if topography>199 & topography<220 //22 changes
replace site=6 if topography>249 & topography<260 //3 changes
replace site=7 if (topography>149 & topography<160)|(topography>169 & topography<180)|(topography>219 & topography<250)|(topography>259 & topography<300) //26 changes
replace site=8 if topography>299 & topography<400 //19 changes
replace site=9 if topography>399 & topography<420 //3 changes
replace site=10 if (topography>419 & topography<440)|(topography>769 & topography<800) //19 changes
replace site=11 if topography>439 & topography<470 //6 changes
replace site=13 if topography>469 & topography<500 //9 changes
replace site=14 if topography>499 & topography<510 //117 changes
replace site=15 if topography>529 & topography<540 //34 changes
replace site=16 if topography>539 & topography<569 //23 changes
replace site=17 if (topography>509 & topography<530)|(topography>559 & topography<600) //9 changes
replace site=18 if (topography>599 & topography<619)|(topography>619 & topography<649) //3 changes
replace site=19 if topography==619 //138 changes
replace site=20 if topography>639 & topography<690 //25 changes
replace site=21 if topography>689 & topography<739 //4 changes
replace site=22 if topography>729 & topography<760 //9 changes
replace site=23 if topography>759 & topography<770 //2 changes
replace site=24 if topography>769 & topography<780 //14 changes
replace site=25 if topography==809 //31 changes

tab site ,m
tab topography ,m
tab morph ,m

** Update top and morph for national DCOs (n=117) - use Stata editor with filter: topography==.|morph==.
/*
NB: only certain morphs can be assigned to records where basis!=MV
(see IARCcrg Tools-->Help-->Tools-->the IARC Check Program-->BasisOfDiagnosis/Histology)
*/
replace topography=421 if pid=="20149021" //1 change
replace top="421" if pid=="20149021" //1 change
replace topcat=38 if pid=="20149021" //1 change
replace morph=9732 if pid=="20149021" //1 change
replace morphcat=46 if pid=="20149021" //1 change

replace topography=421 if pid=="20149023" //1 change
replace top="421" if pid=="20149023" //1 change
replace topcat=38 if pid=="20149023" //1 change
replace morph=9732 if pid=="20149023" //1 change
replace morphcat=46 if pid=="20149023" //1 change

replace topography=421 if pid=="20149082" //1 change
replace top="421" if pid=="20149082" //1 change
replace topcat=38 if pid=="20149082" //1 change
replace morph=9732 if pid=="20149082" //1 change
replace morphcat=46 if pid=="20149082" //1 change

replace topography=421 if pid=="20149085" //1 change
replace top="421" if pid=="20149085" //1 change
replace topcat=38 if pid=="20149085" //1 change
replace morph=9732 if pid=="20149085" //1 change
replace morphcat=46 if pid=="20149085" //1 change

replace topography=421 if pid=="20149097" //1 change
replace top="421" if pid=="20149097" //1 change
replace topcat=38 if pid=="20149097" //1 change
replace morph=9732 if pid=="20149097" //1 change
replace morphcat=46 if pid=="20149097" //1 change

replace morph=8000 if morph==. //112 changes
replace morphcat=1 if morph==8000 & morphcat==. //112 changes

replace topography=809 if topography==. & site==25 //4 changes
replace top="809" if topography==809 & top=="" //4 changes
replace topcat=70 if topography==809 & topcat==. //4 changes

replace topography=509 if topography==. & site==14 //15 changes
replace top="509" if topography==509 & top=="" //15 changes
replace topcat=43 if topography==509 & topcat==. //15 changes
replace lat=9 if site==14 & lat==. //15 changes
replace latcat=31 if site==14 & latcat==. //15 changes

replace topography=189 if topography==. & site==3 //16 changes
replace top="189" if topography==189 & top=="" //16 changes
replace topcat=19 if topography==189 & topcat==. //16 changes

replace topography=169 if topography==. & site==2 //2 changes
replace top="169" if topography==169 & top=="" //2 changes
replace topcat=17 if topography==169 & topcat==. //2 changes

replace topography=259 if topography==. & site==6 //2 changes
replace top="259" if topography==259 & top=="" //2 changes
replace topcat=26 if topography==259 & topcat==. //2 changes

replace topography=349 if topography==. & site==8 //11 changes
replace top="349" if topography==349 & top=="" //11 changes
replace topcat=32 if topography==349 & topcat==. //11 changes

replace topography=619 if topography==. & site==19 //20 changes
replace top="619" if topography==619 & top=="" //20 changes
replace topcat=53 if topography==619 & topcat==. //20 changes

replace topography=539 if topography==. & site==15 //4 changes
replace top="539" if topography==539 & top=="" //4 changes
replace topcat=46 if topography==539 & topcat==. //4 changes

replace topography=19 if topography==. & regexm(cod1a,"TONGUE") //2 changes
replace top="019" if topography==19 & top=="" //2 changes
replace topcat=2 if topography==19 & topcat==. //2 changes

replace topography=109 if topography==. & regexm(cod1a,"OROPHAR") //3 changes
replace top="109" if topography==109 & top=="" //3 changes
replace topcat=11 if topography==109 & topcat==. //3 changes

replace topography=541 if topography==. & regexm(cod1a,"ENDOMET") //8 changes
replace top="541" if topography==541 & top=="" //8 changes
replace topcat=47 if topography==541 & topcat==. //8 changes

replace topography=119 if topography==. & regexm(cod1a,"NASOPH") //1 change
replace top="119" if topography==119 & top=="" //1 change
replace topcat=12 if topography==119 & topcat==. //1 change

replace topography=139 if topography==. & regexm(cod1a,"HYPOPH") //1 change
replace top="139" if topography==139 & top=="" //1 change
replace topcat=14 if topography==139 & topcat==. //1 change

replace topography=51 if topography==. & regexm(cod1a,"PALATE") //2 changes
replace top="051" if topography==51 & top=="" //2 changes
replace topcat=6 if topography==51 & topcat==. //2 changes

replace topography=80 if topography==. & regexm(cod1a,"SUBMANDIB") //1 change
replace top="080" if topography==80 & top=="" //1 change
replace topcat=9 if topography==80 & topcat==. //1 change
replace lat=9 if topography==80 & lat==. //1 change
replace latcat=2 if topography==80 & latcat==. //1 change

replace topography=99 if topography==. & regexm(cod1a,"TONSIL") //1 change
replace top="099" if topography==99 & top=="" //1 change
replace topcat=10 if topography==99 & topcat==. //1 change
replace lat=9 if topography==99 & lat==. //1 change
replace latcat=7 if topography==99 & latcat==. //1 change

replace topography=410 if topography==. & regexm(cod1a,"MAXILLA") //1 change
replace top="410" if topography==410 & top=="" //1 change
replace topcat=37 if topography==410 & topcat==. //1 change

replace topography=159 if topography==. & regexm(cod1a,"OESO") //2 changes
replace top="159" if topography==159 & top=="" //2 changes
replace topcat=16 if topography==159 & topcat==. //2 changes

replace topography=649 if topography==. & regexm(cod1a,"RENAL CELL") //1 change
replace top="649" if topography==649 & top=="" //1 change
replace topcat=56 if topography==649 & topcat==. //1 change
replace lat=9 if topography==649 & lat==. //1 change
replace latcat=37 if topography==649 & latcat==. //1 change

replace topography=445 if topography==. & pid=="20149037" //1 change
replace top="445" if topography==445 & top=="" //1 change
replace topcat=39 if topography==445 & topcat==. //1 change
replace lat=9 if topography==445 & lat==. //1 change
replace latcat=24 if topography==445 & latcat==. //1 change

replace topography=763 if topography==. & pid=="20149105" //1 change
replace top="763" if topography==763 & top=="" //1 change
replace topcat=68 if topography==763 & topcat==. //1 change

replace topography=529 if topography==. & pid=="20149011" //1 change
replace top="529" if topography==529 & top=="" //1 change
replace topcat=45 if topography==529 & topcat==. //1 change

replace topography=679 if topography==. & pid=="20149017" //1 change
replace top="679" if topography==679 & top=="" //1 change
replace topcat=59 if topography==679 & topcat==. //1 change

replace topography=180 if topography==. & pid=="20149025" //1 change
replace top="180" if topography==180 & top=="" //1 change
replace topcat=19 if topography==180 & topcat==. //1 change

replace topography=199 if topography==. & pid=="20149027" //1 change
replace top="199" if topography==199 & top=="" //1 change
replace topcat=20 if topography==199 & topcat==. //1 change

replace topography=209 if topography==. & (pid=="20149061"|pid=="20149080") //2 changes
replace top="209" if topography==209 & top=="" //2 changes
replace topcat=21 if topography==209 & topcat==. //2 changes

replace topography=140 if topography==. & pid=="20149030" //1 change
replace top="140" if topography==140 & top=="" //1 change
replace topcat=15 if topography==140 & topcat==. //1 change

replace topography=559 if topography==. & pid=="20149114" //1 change
replace top="559" if topography==559 & top=="" //1 change
replace topcat=48 if topography==559 & topcat==. //1 change

replace topography=569 if topography==. & pid=="20149104" //1 change
replace top="569" if topography==569 & top=="" //1 change
replace topcat=49 if topography==569 & topcat==. //1 change
replace lat=4 if topography==569 & lat==. //1 change
replace latcat=32 if topography==569 & latcat==. //1 change

replace topography=779 if topography==. & (pid=="20149039"|pid=="20149077") //2 changes
replace top="779" if topography==779 & top=="" //2 changes
replace topcat=69 if topography==779 & topcat==. //2 changes
replace morph=9673 if pid=="20149039"|pid=="20149077" //2 changes
replace morphcat=43 if pid=="20149039"|pid=="20149077" //2 changes

replace topography=421 if topography==. & pid=="20149049" //1 change
replace top="421" if topography==421 & top=="" //1 change
replace topcat=38 if topography==421 & topcat==. //1 change

replace topography=809 if topography==. & pid=="20149098" //1 change
replace top="809" if topography==809 & top=="" //1 change
replace topcat=70 if topography==809 & topcat==. //1 change
replace site=25 if pid=="20149098" //1 change

** Update other variables for national DCOs (n=117) - use Stata editor to view case
tab grade ,m
replace grade=9 if grade==. //117 changes

tab beh ,m

tab basis ,m

tab lat ,m
replace lat=9 if lat==. //97 changes

tab staging ,m
replace staging=8 if staging==. //117 changes

tab resident ,m
replace resident=9 if resident==. //117 changes

tab parish ,m
replace parish=8 if pid=="20140566" //1 change

tab deceased ,m

tab eidmp ,m

tab dcostatus ,m

tab cancer ,m

tab ptrectot ,m

tab cod ,m

tab pod if slc==2 ,m
replace pod="QEH" if pid=="20145157"|pid=="20141509"|pid=="20141534"|pid=="20145154" //4 changes
replace deathparish=8 if pid=="20145157"|pid=="20141509"|pid=="20141534"|pid=="20145154" //4 changes
** Check for data source of 117 national DCOs - see dofile 9 for data output
tab pod district if ptrectot==2

tab recstatus ,m
replace recstatus=1 if recstatus==. //117 changes

tab nftype ,m
replace nftype=8 if nftype==. //117 changes

tab sourcename ,m
replace sourcename=5 if sourcename==. //117 changes

tab dot ,m

tab dotyear ,m

tab dod if deceased==1 ,m
replace deceased=2 if dod==. & deceased==1 //5 changes

tab dodyear if deceased==1 ,m

tab dlc if deceased==2 ,m
replace dlc=dot if dlc==. & deceased==2 //4 changes

tab age sex ,m //2 males; 1 female with age==999 (missing)

tab slc ,m

tab dob ,m //145 missing
list pid deathid dob birthdate if dob==.

tab natregno ,m

** Export dataset to run data in IARCcrg Tools (Check Programme)
preserve

gen INCIDYR=year(dot)
tostring INCIDYR, replace
gen INCIDMONTH=month(dot)
gen str2 INCIDMM = string(INCIDMONTH, "%02.0f")
gen INCIDDAY=day(dot)
gen str2 INCIDDD = string(INCIDDAY, "%02.0f")
gen INCID=INCIDYR+INCIDMM+INCIDDD
replace INCID="" if INCID=="..." //0 changes
drop INCIDMONTH INCIDDAY INCIDYR INCIDMM INCIDDD dot
rename INCID dot
label var dot "IncidenceDate"

gen BIRTHYR=year(dob)
tostring BIRTHYR, replace
gen BIRTHMONTH=month(dob)
gen str2 BIRTHMM = string(BIRTHMONTH, "%02.0f")
gen BIRTHDAY=day(dob)
gen str2 BIRTHDD = string(BIRTHDAY, "%02.0f")
gen BIRTHD=BIRTHYR+BIRTHMM+BIRTHDD
replace BIRTHD="" if BIRTHD=="..." //151 changes
drop BIRTHDAY BIRTHMONTH BIRTHYR BIRTHMM BIRTHDD dob
rename BIRTHD dob
label var dob "BirthDate"

export_excel pid sex topography morph beh grade basis dot dob age ///
using "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\iarc\2018-12-03_iarccrg.xlsx", firstrow(varlabels) nolabel replace

/*
Results of IARC Check Program:
	9 errors - forgot to do age and sex(unk) check in this dofile under 'Final checks' section so it's done and now only 0 errors
		- 6 invalid sex code
		- 3 invalid age
	65 warnings
		- 6 unlikely hx/site combo
		- 3 unlikely grade/hx combo
		- 56 unlikely basis/hx combo
*/

/*
Results of IARC MP Program:
	24 excluded (non-malignant)
	28 MPs (multiple tumours)
	 3 Duplicate registrations
*/
tab eidmp pid if eidmp==2
count if eidmp==2 //15
sort pid
list pid top morph cr5id if eidmp==2
count if pid=="20140077"|pid=="20140176" ///
	|pid=="20140339"|pid=="20140474"|pid=="20140490"|pid=="20140526" ///
	|pid=="20140555"|pid=="20140566"|pid=="20140570"|pid=="20140672" ///
	|pid=="20140690"|pid=="20140786"|pid=="20140887"|pid=="20141351"
** 29 - 20140690 T5S1 excluded from IARC MP as it's non-malignant (beh=2)
list pid top morph eidmp cr5id if pid=="20140077"|pid=="20140176" ///
	|pid=="20140339"|pid=="20140474"|pid=="20140490"|pid=="20140526" ///
	|pid=="20140555"|pid=="20140566"|pid=="20140570"|pid=="20140672" ///
	|pid=="20140690"|pid=="20140786"|pid=="20140887"|pid=="20141351"

tab beh ,m //24 in-situ
restore

** Updates below based on IARC Check - warnings & MP files
order pid fname mname lname natregno primarysite top

replace primarysite="LYMPH NODE" if pid=="20140259" //1 change - See CR5db comments & abstractor notes in HemeDb under M9827 re peripheral blood involvement
replace topography=779 if pid=="20140259" //1 change
replace top="779" if pid=="20140259" //1 change
replace topcat=69 if pid=="20140259" //1 change

label drop persearch_lab
label define persearch_lab 0 "Not done" 1 "Done: OK" 2 "Done: MP" 3 "Done: Duplicate/Non-IARC MP", modify
label values persearch persearch_lab

tab persearch ,m
replace persearch=3 if pid=="20141351" & top=="187" //1 change
replace persearch=3 if pid=="20140887" & top=="180" //1 change
replace persearch=3 if pid=="20140555" & cr5id=="T2S1" //1 change

replace persearch=2 if pid=="20140077"|pid=="20140176" ///
	|pid=="20140339"|pid=="20140474"|pid=="20140490"|pid=="20140526" ///
	|pid=="20140566"|pid=="20140570"|pid=="20140672" ///
	|(pid=="20140690" & morph!=8077)|pid=="20140786"
** 22 changes

replace persearch=1 if persearch==0|persearch==. //1,016 changes


** Export dataset to run data in IARCcrg Tools (Conversion Programme)
** Convert ICD-O-3 to ICD-10(v2010)
rename ICCCcode iccc
rename ICD10 icd10

preserve

gen INCIDYR=year(dot)
tostring INCIDYR, replace
gen INCIDMONTH=month(dot)
gen str2 INCIDMM = string(INCIDMONTH, "%02.0f")
gen INCIDDAY=day(dot)
gen str2 INCIDDD = string(INCIDDAY, "%02.0f")
gen INCID=INCIDYR+INCIDMM+INCIDDD
replace INCID="" if INCID=="..." //0 changes
drop INCIDMONTH INCIDDAY INCIDYR INCIDMM INCIDDD dot
rename INCID dot
label var dot "IncidenceDate"

gen BIRTHYR=year(dob)
tostring BIRTHYR, replace
gen BIRTHMONTH=month(dob)
gen str2 BIRTHMM = string(BIRTHMONTH, "%02.0f")
gen BIRTHDAY=day(dob)
gen str2 BIRTHDD = string(BIRTHDAY, "%02.0f")
gen BIRTHD=BIRTHYR+BIRTHMM+BIRTHDD
replace BIRTHD="" if BIRTHD=="..." //151 changes
drop BIRTHDAY BIRTHMONTH BIRTHYR BIRTHMM BIRTHDD dob
rename BIRTHD dob
label var dob "BirthDate"


export_excel pid sex topography morph beh grade basis dot dob age cr5id ///
using "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\iarc\2018-12-05_iarccrg_icd10.xlsx", firstrow(varlabels) nolabel replace

/*
Results of IARC Conversion Program:
	0 errors
	0 warnings
*/

save "data\clean\2014_cancer_preicd10_dc.dta" ,replace
clear

** Create Stata dataset to merge icd10 codes with current dataset
import excel using "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\iarc\2018-12-05_iarccrg_icd10_conversion codes.xlsx", firstrow
duplicates list pid, nolabel sepby(pid)
//20140077, 20140176, 20140339, 20140474, 20140490, 20140526, 20140555, 20140566, 20140570, 20140672, 20140690, 20140786, 20140887, 20141351
duplicates tag pid, gen(mpicd10)
list pid top morph icd10 if mpicd10>0
//check icd10 codes for MPs were correctly assigned to its topography and not swapped
keep pid cr5id icd10
save "data\clean\2014_cancer_icd10_dc.dta" ,replace
restore

** Merge IARC ICD-10 coded dataset with this one using pid
rename _merge _merge_deaths
drop icd10
merge m:m pid cr5id using "data\clean\2014_cancer_icd10_dc.dta"
/*
    Result                           # of obs.
    -----------------------------------------
    not matched                             0
    matched                             1,041  (_merge==3)
    -----------------------------------------
*/

** Check for duplicate pid identified above using ptrectot to ensure icd10 codes not swapped
list pid cr5id icd10 top morph if ptrectot==3  //21 but should be 29 - missing 4 pids
** Update ptrectot for 4 pids above
list pid cr5id ptrectot if pid=="20140339"|pid=="20140490"|pid=="20140526"|pid=="20140672"
replace ptrectot=5 if pid=="20140339" & cr5id=="T1S1" ///
					 |pid=="20140490" & cr5id=="T1S1" ///
					 |pid=="20140526" & cr5id=="T1S1" ///
					 |pid=="20140672" & cr5id=="T1S1" //4 changes

count if ptrectot==3|ptrectot==5 //29

** Non-melanoma skin cancer of non-genital areas are not reportable so remove SCC of groin
drop if pid=="20149037" //1 obs deleted

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
replace siteiarc=2 if (regexm(icd10,"C01")|regexm(icd10,"C02")) //6 changes
replace siteiarc=3 if (regexm(icd10,"C03")|regexm(icd10,"C04")|regexm(icd10,"C05")|regexm(icd10,"C06")) //4 changes
replace siteiarc=4 if (regexm(icd10,"C07")|regexm(icd10,"C08")) //2 changes
replace siteiarc=5 if regexm(icd10,"C09") //6 changes
replace siteiarc=6 if regexm(icd10,"C10") //6 changes
replace siteiarc=7 if regexm(icd10,"C11") //4 changes
replace siteiarc=8 if (regexm(icd10,"C12")|regexm(icd10,"C13")) //5 changes
replace siteiarc=9 if regexm(icd10,"C14") //1 change
replace siteiarc=10 if regexm(icd10,"C15") //11 changes
replace siteiarc=11 if regexm(icd10,"C16") //23 changes
replace siteiarc=12 if regexm(icd10,"C17") //5 changes
replace siteiarc=13 if regexm(icd10,"C18") //131 changes
replace siteiarc=14 if (regexm(icd10,"C19")|regexm(icd10,"C20")) //31 changes
replace siteiarc=15 if regexm(icd10,"C21") //2 changes
replace siteiarc=16 if regexm(icd10,"C22") //13 changes
replace siteiarc=17 if (regexm(icd10,"C23")|regexm(icd10,"C24")) //9 changes
replace siteiarc=18 if regexm(icd10,"C25") //23 changes
replace siteiarc=19 if (regexm(icd10,"C30")|regexm(icd10,"C31")) //5 changes
replace siteiarc=20 if regexm(icd10,"C32") //9 changes
replace siteiarc=21 if (regexm(icd10,"C33")|regexm(icd10,"C34")) //43 changes
replace siteiarc=22 if (regexm(icd10,"C37")|regexm(icd10,"C38")) //0 changes
replace siteiarc=23 if (regexm(icd10,"C40")|regexm(icd10,"C41")) //3 changes
replace siteiarc=24 if regexm(icd10,"C43") //7 changes
replace siteiarc=25 if regexm(icd10,"C44") //1 change - removed 20149037 above so now 0 changes
replace siteiarc=26 if regexm(icd10,"C45") //2 changes
replace siteiarc=27 if regexm(icd10,"C46") //0 changes
replace siteiarc=28 if (regexm(icd10,"C47")|regexm(icd10,"C49")) //7 changes
replace siteiarc=29 if regexm(icd10,"C50") //174 changes
replace siteiarc=30 if regexm(icd10,"C51") //2 changes
replace siteiarc=31 if regexm(icd10,"C52") //3 changes
replace siteiarc=32 if regexm(icd10,"C53") //21 changes
replace siteiarc=33 if regexm(icd10,"C54") //47 changes
replace siteiarc=34 if regexm(icd10,"C55") //2 changes
replace siteiarc=35 if regexm(icd10,"C56") //9 changes
replace siteiarc=36 if regexm(icd10,"C57") //0 changes
replace siteiarc=37 if regexm(icd10,"C58") //0 changes
replace siteiarc=38 if regexm(icd10,"C60") //3 changes
replace siteiarc=39 if regexm(icd10,"C61") //216 changes
replace siteiarc=40 if regexm(icd10,"C62") //2 changes
replace siteiarc=41 if regexm(icd10,"C63") //0 changes
replace siteiarc=42 if regexm(icd10,"C64") //12 changes
replace siteiarc=43 if regexm(icd10,"C65") //0 changes
replace siteiarc=44 if regexm(icd10,"C66") //0 changes
replace siteiarc=45 if regexm(icd10,"C67") //25 changes
replace siteiarc=46 if regexm(icd10,"C68") //0 changes
replace siteiarc=47 if regexm(icd10,"C69") //0 changes
replace siteiarc=48 if (regexm(icd10,"C70")|regexm(icd10,"C71")|regexm(icd10,"C72")) //6 changes
replace siteiarc=49 if regexm(icd10,"C73") //11 changes
replace siteiarc=50 if regexm(icd10,"C74") //0 changes
replace siteiarc=51 if regexm(icd10,"C75") //1 change
replace siteiarc=52 if regexm(icd10,"C81") //2 changes
replace siteiarc=53 if (regexm(icd10,"C82")|regexm(icd10,"C83")|regexm(icd10,"C84")|regexm(icd10,"C85")|regexm(icd10,"C86")|regexm(icd10,"C96")) //18 changes
replace siteiarc=54 if regexm(icd10,"C88") //1 change
replace siteiarc=55 if regexm(icd10,"C90") //33 changes
replace siteiarc=56 if regexm(icd10,"C91") //7 changes
replace siteiarc=57 if (regexm(icd10,"C92")|regexm(icd10,"C93")|regexm(icd10,"C94")) //5 changes
replace siteiarc=58 if regexm(icd10,"C95") //3 changes
replace siteiarc=59 if morphcat==54|morphcat==55 //3 changes
replace siteiarc=60 if morphcat==56 //1 change
replace siteiarc=61 if (regexm(icd10,"C26")|regexm(icd10,"C39")|regexm(icd10,"C48")|regexm(icd10,"C76")|regexm(icd10,"C80")) //51 changes
**replace siteiarc=62 if siteiarc<62
**replace siteiarc=63 if siteiarc<62 & siteiarc!=25
replace siteiarc=64 if morph==8077 //24 changes

tab siteiarc ,m //24 missing - all CIN 3(in-situ) so add as siteiarc=64
list pid top morph icd10 if siteiarc==.

gen allsites=1 if siteiarc<62 //1,016 changes - 24 missing values=CIN 3
label var allsites "All sites (ALL)"

gen allsitesbC44=1 if siteiarc<62 & siteiarc!=25
//1,017 changes - 25 missing values=CIN 3; found 1 SCC of non-genital area so removed from above siteiarc code;
//now 1,016 changes
label var allsitesbC44 "All sites but skin (ALLbC44)"

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
replace siteiarchaem=1 if morphcat==41 //8 changes
replace siteiarchaem=2 if morphcat==42 //2 changes
replace siteiarchaem=3 if morphcat==43 //8 changes
replace siteiarchaem=4 if morphcat==44 //2 changes
replace siteiarchaem=5 if morphcat==45 //1 change
replace siteiarchaem=6 if morphcat==46 //33 changes
replace siteiarchaem=7 if morphcat==47 //0 changes
replace siteiarchaem=8 if morphcat==48 //0 changes
replace siteiarchaem=9 if morphcat==49 //0 changes
replace siteiarchaem=10 if morphcat==50 //4 changes
replace siteiarchaem=11 if morphcat==51 //6 changes
replace siteiarchaem=12 if morphcat==52 //5 changes
replace siteiarchaem=13 if morphcat==53 //0 changes
replace siteiarchaem=14 if morphcat==54 //0 changes
replace siteiarchaem=15 if morphcat==55 //3 changes
replace siteiarchaem=16 if morphcat==56 //1 change

tab siteiarchaem ,m //967 missing - correct!
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
					 |regexm(icd10,"C12")|regexm(icd10,"C13")|regexm(icd10,"C14")) //34 changes
replace sitecr5db=2 if regexm(icd10,"C15") //11 changes
replace sitecr5db=3 if regexm(icd10,"C16") //23 changes
replace sitecr5db=4 if (regexm(icd10,"C18")|regexm(icd10,"C19")|regexm(icd10,"C20")|regexm(icd10,"C21")) //164 changes
replace sitecr5db=5 if regexm(icd10,"C22") //13 changes
replace sitecr5db=6 if regexm(icd10,"C25") //23 changes
replace sitecr5db=7 if regexm(icd10,"C32") //9 changes
replace sitecr5db=8 if (regexm(icd10,"C33")|regexm(icd10,"C34")) //43 changes
replace sitecr5db=9 if regexm(icd10,"C43") //7 changes
replace sitecr5db=10 if regexm(icd10,"C50") //174 changes
replace sitecr5db=11 if regexm(icd10,"C53") //21 changes
replace sitecr5db=12 if (regexm(icd10,"C54")|regexm(icd10,"C55")) //49 changes
replace sitecr5db=13 if regexm(icd10,"C56") //9 changes
replace sitecr5db=14 if regexm(icd10,"C61") //216 changes
replace sitecr5db=15 if regexm(icd10,"C62") //2 changes
replace sitecr5db=16 if (regexm(icd10,"C64")|regexm(icd10,"C65")|regexm(icd10,"C66")|regexm(icd10,"C68")) //12 changes
replace sitecr5db=17 if regexm(icd10,"C67") //25 changes
replace sitecr5db=18 if (regexm(icd10,"C70")|regexm(icd10,"C71")|regexm(icd10,"C72")) //6 changes
replace sitecr5db=19 if regexm(icd10,"C73") //11 changes
replace sitecr5db=20 if siteiarc==61 //51 changes
replace sitecr5db=21 if (regexm(icd10,"C81")|regexm(icd10,"C82")|regexm(icd10,"C83")|regexm(icd10,"C84")|regexm(icd10,"C85")|regexm(icd10,"C88")|regexm(icd10,"C90")|regexm(icd10,"C96")) //54 changes
replace sitecr5db=22 if (regexm(icd10,"C91")|regexm(icd10,"C92")|regexm(icd10,"C93")|regexm(icd10,"C94")|regexm(icd10,"C95")) //15 changes
replace sitecr5db=23 if (regexm(icd10,"C17")|regexm(icd10,"C23")|regexm(icd10,"C24")) //14 changes
replace sitecr5db=24 if (regexm(icd10,"C30")|regexm(icd10,"C31")) //5 changes
replace sitecr5db=25 if (regexm(icd10,"C40")|regexm(icd10,"C41")|regexm(icd10,"C45")|regexm(icd10,"C47")|regexm(icd10,"C49")) //12 changes
replace sitecr5db=26 if siteiarc==25 //0 changes
replace sitecr5db=27 if (regexm(icd10,"C51")|regexm(icd10,"C52")|regexm(icd10,"C57")|regexm(icd10,"C58")) //5 changes
replace sitecr5db=28 if (regexm(icd10,"C60")|regexm(icd10,"C63")) //3 changes
replace sitecr5db=29 if (regexm(icd10,"C74")|regexm(icd10,"C75")) //1 change
replace sitecr5db=30 if siteiarc==59 //3 changes
replace sitecr5db=31 if siteiarc==60 //1 change
replace sitecr5db=32 if siteiarc==64 //24 changes

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

tab sitear ,m //24 missing
list beh top morph if sitear==. //thease are cervix in-situ (CIN 3)
replace sitear=15 if sitear==. //24 changes

rename _merge _merge_icd10
rename _merge_deaths _merge

** Save dataset to use for national DCOs check
save "data\clean\2014_cancer_merge_dco_dc.dta" ,replace
label data "BNR-Cancer Cleaning: National DCOs(116)"
notes _dta :These data prepared for 2014 ABS phase


use "data\clean\2014_cancer_merge_dco_dc.dta" ,clear

** Export deathid icd10 to use in dofile 8 for iarcsite variable as national deaths are not icd10 coded
export_excel deathid topography morph ptrectot dodyear siteiarc siteiarchaem cr5id icd10 ///
using "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-05_deaths_icd10.xlsx", firstrow(variables) nolabel replace

** Create list of 116 DCOs that had no info in CR5db for SAF, requested on 17dec2018
count if ptrectot==2 //116
export_excel deathid fname mname lname pod cod1a ///
using "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-17_deaths_116.xlsx" if ptrectot==2, firstrow(variables) replace

/*
JC 18dec2018: SAF noted 116 DCOs from electronic death data had been
abstracted in 2013 dataset so match these below and remove then
create another list of unmatched ones for SAF to check
*/

** First, check for any matches with 116 DCOs not in CR5db against 2013 dataset
** 85 of 116 cases matched
preserve
use "data\clean\2014_cancer_merge_dco_dc.dta" ,clear
drop _merge
drop if ptrectot!=2 //924 obs deleted (116 left)
replace natregno=nrn //109 changes
append using "data\clean\2013_cancer_tumours_with_deaths.dta" ,force

sort natregno lname fname pid
quietly by natregno :  gen dupnrn = cond(_N==1,0,_n)
sort natregno
count if dupnrn>0 //315 - check primarysite & cod1a in Stata data editor
sort lname fname pid
order pid fname lname natregno sex age primarysite cod1a
list pid deathid fname lname natregno sex age if dupnrn>0
list natregno deathid pid

sort lname fname pid
quietly by lname fname :  gen duppt = cond(_N==1,0,_n)
sort lname fname
count if duppt>0 //202 - check primarysite & cod1a in Stata data editor for ones not matched in above list
sort lname fname pid
order pid fname lname natregno sex age primarysite cod1a
list pid deathid fname lname natregno sex age dupnrn if duppt>0
restore

** Second, check for any matches with 116 DCOs not in CR5db against 2008 dataset
** of 116 matched
preserve
use "data\clean\2014_cancer_merge_dco_dc.dta" ,clear
drop _merge
drop if ptrectot!=2 //924 obs deleted (116 left)
replace natregno=nrn //109 changes
append using "data\clean\2008_cancer_tumours_with_deaths.dta" ,force

sort natregno lname fname pid
quietly by natregno :  gen dupnrn = cond(_N==1,0,_n)
sort natregno
count if dupnrn>0 //333 - check primarysite & cod1a in Stata data editor
sort lname fname pid
order pid fname lname natregno sex age primarysite cod1a
list pid deathid fname lname natregno sex age if dupnrn>0

sort lname fname pid
quietly by lname fname :  gen duppt = cond(_N==1,0,_n)
sort lname fname
count if duppt>0 //202 - check primarysite & cod1a in Stata data editor for ones not matched in above list
sort lname fname pid
order pid fname lname natregno sex age primarysite cod1a
list pid deathid fname lname natregno sex age dupnrn if duppt>0
restore

** Third, update 2014 dataset to remove those found in 2008 & 2013 datasets
** 2013 - 85 obs deleted
drop if pid=="20149025"|pid=="20149044"|pid=="20149038"|pid=="20149039" ///
	   |pid=="20149105"|pid=="20149089"|pid=="20149092"|pid=="20149018" ///
	   |pid=="20149080"|pid=="20149106"|pid=="20149051"|pid=="20149066" ///
	   |pid=="20149077"|pid=="20149026"|pid=="20149014"|pid=="20149079" ///
	   |pid=="20149078"|pid=="20149030"|pid=="20149034"|pid=="20149083" ///
	   |pid=="20149024"|pid=="20149054"|pid=="20149063"|pid=="20149109" ///
	   |pid=="20149046"|pid=="20149068"|pid=="20149052"|pid=="20149087" ///
	   |pid=="20149088"|pid=="20149002"|pid=="20149056"|pid=="20149113" ///
	   |pid=="20149110"|pid=="20149093"|pid=="20149085"|pid=="20149013" ///
	   |pid=="20149096"|pid=="20149069"|pid=="20149045"|pid=="20149057" ///
	   |pid=="20149073"|pid=="20149055"|pid=="20149007"|pid=="20149023" ///
	   |pid=="20149029"|pid=="20149070"|pid=="20149035"|pid=="20149067" ///
	   |pid=="20149082"|pid=="20149020"|pid=="20149001"|pid=="20149031" ///
	   |pid=="20149022"|pid=="20149071"|pid=="20149112"|pid=="20149098" ///
	   |pid=="20149107"|pid=="20149108"|pid=="20149060"|pid=="20149048" ///
	   |pid=="20149047"|pid=="20149065"|pid=="20149081"|pid=="20149032" ///
	   |pid=="20149102"|pid=="20149015"|pid=="20149003"|pid=="20149084" ///
	   |pid=="20149008"|pid=="20149033"|pid=="20149095"|pid=="20149010" ///
	   |pid=="20149100"|pid=="20149027"|pid=="20149072"|pid=="20149061" ///
	   |pid=="20149064"|pid=="20149011"|pid=="20149016"|pid=="20149059" ///
	   |pid=="20149094"|pid=="20149114"|pid=="20149111"|pid=="20149062" ///
	   |pid=="20149012"
** 2008 - 15 obs deleted
drop if pid=="20149103"|pid=="20149086"|pid=="20149006"|pid=="20149004" ///
	   |pid=="20149050"|pid=="20149009"|pid=="20149091"|pid=="20149036" ///
	   |pid=="20149075"|pid=="20149019"|pid=="20149101"|pid=="20149116" ///
	   |pid=="20149099"|pid=="20149043"|pid=="20149040"
** 1 ineligible found on 2008 dupnrn list
replace recstatus=3 if pid=="20149097" //1 change
replace cstatus=3 if pid=="20149097" //1 change
replace dot=d(30jun2012) if pid=="20149097" //1 change
replace dxyr=2012 if pid=="20149097" //1 change
drop if pid=="20149097" //1 obs deleted
** CR5db - 12 obs deleted
list pid deathid fname lname nrn if ptrectot==2 //16
list cod1a if ptrectot==2
drop if pid=="20149005"|pid=="20149017"|pid=="20149021"|pid=="20149028" ///
	   |pid=="20149049"|pid=="20149053"|pid=="20149058"|pid=="20149074" ///
	   |pid=="20149076"|pid=="20149104"|pid=="20149115"|pid=="20149117"
** 113 obs deleted

** Fourth, create updated list for SAF from 116 DCOs not matched with 2008/2013/CR5db/MasterDb
count if ptrectot==2 //3
gen updatenotes1="SAF needs to update 20130661 with deathid 2759 info"
gen updatenotes2="SAF needs to update 20140286 dot from 20140122 to 20131230 - see MasterDb 3404"
gen updatenotes3="SAF needs to update 20140455 dot from 20140219 to 20131210 - see MasterDb 2841"
export_excel deathid fname mname lname pod cod1a updatenotes1-updatenotes3 using "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_deaths_3of116.xlsx" if ptrectot==2, sheet("DCOs") firstrow(variables) replace
export_excel updatenotes1-updatenotes3 using "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\clean\2018-12-18_deaths_3of116.xlsx" if ptrectot==2, sheet("PendingUpdates") firstrow(variables)


** Save dataset to use for DQI (dofile 9)
save "data\clean\2014_cancer_merge_dqi_dc.dta" ,replace
label data "BNR-Cancer Cleaning: Duplicate sources with T1S1=COD"
notes _dta :These data prepared for 2014 ABS phase


use "data\clean\2014_cancer_merge_dqi_dc.dta" ,clear

** Remove unnecessary variables then order in prep for analysis dofiles
drop nrnday dob_yr dob_year year2 dobchk nrnid checkage2 dupobs1do5 dupobs2do5 ///
	 dupobs3do5 dupobs4do5 dupobs5do5 dupobs6do5 dupobs7do5 dupobs8do5 ///
	 death_certificate_complete dupname dupdod dup_pt cr5cod_orig cod1a_orig ///
	 cod1b onsetnumcod1b onsettxtcod1b cod1c onsetnumcod1c onsettxtcod1c cod1d ///
	 onsetnumcod1d onsettxtcod1d cod2a onsetnumcod2a onsettxtcod2a cod2b ///
	 onsetnumcod2b onsettxtcod2b dupobs178c1 dupobs178c2 dupobs1do3 dupobs2do3 ///
	 dupobs3do3 dupobs4do3 dupobs5do3 dupobs6do3 dupobs7do3 dupobs8do3 dupobs9do3 ///
	 duppid duppid_all eidmptxt pidobsid pidobstot dup_pid name6 nrnnd stdyear ///
	 stdmonth stdday rdyear rdmonth rdday rptyear rptmonth rptday admyear admmonth ///
	 admday dfcyear dfcmonth dfcday rtyear rtmonth rtday topcheckcat hxcheckcat ///
	 agecheckcat sexcheckcat sitecheckcat latcheckcat behcheckcat behsitecheckcat ///
	 gradecheckcat bascheckcat stagecheckcat dotcheckcat dxyrcheckcat rxcheckcat ///
	 othtreat1 orxcheckcat notreat1 notreat2 norxcheckcat sname sourcecheckcat ///
	 doccheckcat docaddrcheckcat rptcheckcat datescheckcat currentdatept countvar ///
	 sampleyr recvyr rptyr admyr dfcyr rtyr yr2013id txt2013id currentdatett checkage ///
	 dupobs76c1 dupobs76c11 laterality behaviour str_grade bas diagyr currentdatest ///
	 morphcheckcat morphology tumouridsourcetable sid2 streviewer MultiplePrimary ///
	 mpseq mptot ObsoleteFlagTumourTable eid2 patientidtumourtable ///
	 PatientRecordIDTumourTable tumourupdatedby TumourUnduplicationStatus ttreviewer ///
	 comments ObsoleteFlagPatientTable pid2 patientupdatedby PatientRecordStatus ///
	 PatientCheckStatus retsource notesseen fretsource ptreviewer dotmonth dotday ///
	 dotyear2 str_sourcerecordid sourcetotal sourcetot_orig str_pid2 patienttotal ///
	 patienttot str_patientidtumourtable mpseq2 sourceseq tumseq tumsourceseq ///
	 str_sourcerecordid2 eidcorrect tumourtot sourcetot ptupdate non_numeric_ptda ///
	 dobyear dobmonth dobday ttupdate rx1year rx1month rx1day rx2year rx2month rx2day ///
	 rx3year rx3month rx3day rx4year rx4month rx4day


order pid deathid cr5id fname lname age sex dob natregno patient dot persearch ///
	  deceased dlc dod cod resident dotyear dodyear eidmp dcostatus ptrectot ///
	  site siteiarc primarysite icd10 iccc topography top hx morph lat beh basis staging grade ///
	  resident parish address addr pod cr5cod cod1a nftype sourcename cancer ///
	  sid recstatus admdate deathparish _merge _merge_icd10 dup rx* rx*d norx* orx*

** Correction noted in dofile 5 of analysis dofiles
replace dot=d(24feb2014) if pid=="20140110" & regexm(cr5id, "T1") //1 change

count //1,040 (incl. 116 national DCOs); 927 (incl. 3 national DCOs)


save "data\clean\2014_cancer_merge_dc.dta" ,replace
label data "BNR-Cancer Corrections"
notes _dta :These data prepared for 2014 ABS phase
