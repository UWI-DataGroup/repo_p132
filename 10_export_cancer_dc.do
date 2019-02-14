** This is the tenth *do* file to be called by the master file.

 ******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *                                                              
 *  DO FILE: 		10_export_cancer_dc
 *					10th dofile: Export data to blank CR5db
 *
 *	STATUS:			Completed
 *
 *  FIRST RUN: 		19dec2018
 *
 *	LAST RUN:		19dec2018
 *
 *  ANALYSIS: 		Producing reports on data quality indicators (DQI), etc
 *					using CR5 database
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

log using "logfiles\10_export_cancer_2014_dc.smcl", replace

set more off

/*
NEED to create population dataset for CR5 2014 in 5 yr age groups
"L:\BNR_data\DM\data_analysis\2014\cancer\versions\version01\data\population\bb2010_5.dta"


sex	age5	age10	age_10	age45	age55	age60	pop_bb
female	0-4	0-9	0-14	0-44	0-54	0-59	8480
male	0-4	0-9	0-14	0-44	0-54	0-59	8875
female	5-9	0-9	0-14	0-44	0-54	0-59	9155
male	5-9	0-9	0-14	0-44	0-54	0-59	9685
female	10-14	10-19	0-14	0-44	0-54	0-59	9120
male	10-14	10-19	0-14	0-44	0-54	0-59	9445
female	15-19	10-19	15-24	0-44	0-54	0-59	9420
male	15-19	10-19	15-24	0-44	0-54	0-59	9450
female	20-24	20-29	15-24	0-44	0-54	0-59	9110
male	20-24	20-29	15-24	0-44	0-54	0-59	9060
female	25-29	20-29	25-34	0-44	0-54	0-59	9775
male	25-29	20-29	25-34	0-44	0-54	0-59	9315
female	30-34	30-39	25-34	0-44	0-54	0-59	9635
male	30-34	30-39	25-34	0-44	0-54	0-59	9150
female	35-39	30-39	35-44	0-44	0-54	0-59	10630
male	35-39	30-39	35-44	0-44	0-54	0-59	9885
female	40-44	40-49	35-44	0-44	0-54	0-59	10450
male	40-44	40-49	35-44	0-44	0-54	0-59	9665
female	45-49	40-49	45-54	45 & over	0-54	0-59	11305
male	45-49	40-49	45-54	45 & over	0-54	0-59	10060
female	50-54	50-59	45-54	45 & over	0-54	0-59	10640
male	50-54	50-59	45-54	45 & over	0-54	0-59	9410
female	55-59	50-59	55-64	45 & over	55 & over	0-59	8780
male	55-59	50-59	55-64	45 & over	55 & over	0-59	7870
female	60-64	60-69	55-64	45 & over	55 & over	60+	7160
male	60-64	60-69	55-64	45 & over	55 & over	60+	6325
female	65-69	60-69	65-74	45 & over	55 & over	60+	5640
male	65-69	60-69	65-74	45 & over	55 & over	60+	4510
female	70-74	70-79	65-74	45 & over	55 & over	60+	4875
male	70-74	70-79	65-74	45 & over	55 & over	60+	3805
female	75-79	70-79	75-84	45 & over	55 & over	60+	4075
male	75-79	70-79	75-84	45 & over	55 & over	60+	2865
female	80-84	80 & over	75-84	45 & over	55 & over	60+	3165
male	80-84	80 & over	75-84	45 & over	55 & over	60+	1970
female	85 & over	80 & over	85 & over	45 & over	55 & over	60+	3388
male	85 & over	80 & over	85 & over	45 & over	55 & over	60+	1666

*/

** Create 2014 dataset for import into blank CR5db
** Load the dataset
use "data\clean\2014_cancer_merge_dc.dta", clear

** Format above dataset to match variables in BNRC-2014 CanReg5 database
** PT
rename persearch PERS
rename lname FAMN
rename fname FIRSTN
gen MIDN=""
rename sex SEX
gen BIRTHYR=year(dob)
tostring BIRTHYR, replace
gen dobmonth=month(dob)
gen str2 BIRTHMM = string(dobmonth, "%02.0f")
gen dobday=day(dob)
gen str2 BIRTHDD = string(dobday, "%02.0f")
gen BIRTHD=BIRTHYR+BIRTHMM+BIRTHDD
replace BIRTHD="" if BIRTHD=="..." //151 changes
**rename natregno NRN
replace dlc=dod if dod!=. & dlc!=dod //27 changes
gen DLCYR=year(dlc)
tostring DLCYR, replace
gen dlcmonth=month(dlc)
gen str2 DLCMM = string(dlcmonth, "%02.0f")
gen dlcday=day(dlc)
gen str2 DLCDD = string(dlcday, "%02.0f")
gen DLC=DLCYR+DLCMM+DLCDD
replace DLC="" if DLC=="..." //0 changes
rename slc STAT
gen OBSOLETEFLAGPATIENTTABLE=.
gen PATIENTRECORDID=pid+"01"
gen PATIENTUPDATEDBY=""
gen PATIENTUPDATEDATE="20130101"
gen PATIENTRECORDSTATUS=.
gen PATIENTCHECKSTATUS=.
rename pid REGNO
** TT
rename recstatus RECS
gen CHEC=0
rename age AGE
gen str2 ADDR = string(parish, "%02.0f")
gen INCIDYR=year(dot)
tostring INCIDYR, replace
gen dotmonth=month(dot)
gen str2 INCIDMM = string(dotmonth, "%02.0f")
gen dotday=day(dot)
gen str2 INCIDDD = string(dotday, "%02.0f")
gen INCID=INCIDYR+INCIDMM+INCIDDD
replace INCID="" if INCID=="..." //0 changes
rename top TOP
rename morph MOR
rename beh BEH
rename basis BAS
rename icd10 I10
gen MPCODE=.
gen MPSEQ=0
gen MPTOT=1
gen UPDATE="20130101"
rename iccc ICCC
gen OBSOLETEFLAGTUMOURTABLE=.
rename eid TUMOURID
gen PATIENTIDTUMOURTABLE=REGNO
gen PATIENTRECORDIDTUMOURTABLE=PATIENTRECORDID
gen TUMOURUPDATEDBY=""
gen TUMOURUNDUPLICATIONSTATUS=.
** ST
rename nftype NFTYPE
rename sourcename SOURCE
rename labnum LABNO
gen CASNO=99
gen TUMOURIDSOURCETABLE=TUMOURID
gen SOURCERECORDID=TUMOURID+"01"
rename siteiarc SITE

destring TUMOURIDSOURCETABLE, replace
format TUMOURIDSOURCETABLE %14.0g
destring SOURCERECORDID, replace
format SOURCERECORDID %16.0g

destring TUMOURID, replace
format TUMOURID %14.0g
destring PATIENTIDTUMOURTABLE, replace
destring PATIENTRECORDIDTUMOURTABLE, replace
format PATIENTRECORDIDTUMOURTABLE %12.0g

destring REGNO, replace
destring PATIENTRECORDID, replace
format PATIENTRECORDID %12.0g
 
** No corrections needed for import to CanReg5 db

sort REGNO //no missing REGNOs

** Create and save dataset to be exported
keep NFTYPE	SOURCE	LABNO	CASNO	TUMOURIDSOURCETABLE	SOURCERECORDID	RECS	CHEC	AGE	ADDR	INCID	TOP	MOR	BEH	BAS	I10	MPCODE	MPSEQ	MPTOT	UPDATE	ICCC ///
	 OBSOLETEFLAGTUMOURTABLE	TUMOURID	PATIENTIDTUMOURTABLE PATIENTRECORDIDTUMOURTABLE	TUMOURUPDATEDBY	TUMOURUNDUPLICATIONSTATUS	REGNO	PERS	FAMN	FIRSTN ///
	 SEX	BIRTHD	DLC	STAT	MIDN	OBSOLETEFLAGPATIENTTABLE PATIENTRECORDID	PATIENTUPDATEDBY	PATIENTUPDATEDATE	PATIENTRECORDSTATUS	PATIENTCHECKSTATUS SITE

order NFTYPE SOURCE	LABNO	CASNO	TUMOURIDSOURCETABLE	SOURCERECORDID	RECS	CHEC	AGE	ADDR	INCID	TOP	MOR	BEH	BAS	SITE I10	MPCODE	MPSEQ	MPTOT	UPDATE ///
	  ICCC OBSOLETEFLAGTUMOURTABLE	TUMOURID	PATIENTIDTUMOURTABLE PATIENTRECORDIDTUMOURTABLE	TUMOURUPDATEDBY	TUMOURUNDUPLICATIONSTATUS	REGNO	PERS	FAMN ///
	  FIRSTN SEX BIRTHD	DLC	STAT	MIDN	OBSOLETEFLAGPATIENTTABLE PATIENTRECORDID	PATIENTUPDATEDBY	PATIENTUPDATEDATE	PATIENTRECORDSTATUS	PATIENTCHECKSTATUS
	 
save "data\2014_BNR-C_CR5db_dataset.dta", replace

export delimited NFTYPE	SOURCE	LABNO	CASNO	TUMOURIDSOURCETABLE	SOURCERECORDID using "data\2014_BNR-C_CR5db_dataset_ST.txt", delimiter(tab) nolabel replace

export delimited RECS	CHEC	AGE	ADDR	INCID	TOP	MOR	BEH	BAS	I10	MPCODE MPSEQ	MPTOT	UPDATE	ICCC	OBSOLETEFLAGTUMOURTABLE	TUMOURID	PATIENTIDTUMOURTABLE ///
				 PATIENTRECORDIDTUMOURTABLE	TUMOURUPDATEDBY	TUMOURUNDUPLICATIONSTATUS using "data\2014_BNR-C_CR5db_dataset_TT.txt", delimiter(tab) nolabel replace

export delimited REGNO	PERS	FAMN	FIRSTN	SEX	BIRTHD	DLC	STAT	MIDN	OBSOLETEFLAGPATIENTTABLE ///
				 PATIENTRECORDID	PATIENTUPDATEDBY	PATIENTUPDATEDATE	PATIENTRECORDSTATUS	PATIENTCHECKSTATUS using "data\2014_BNR-C_CR5db_dataset_PT.txt", delimiter(tab) nolabel replace

** Create 2008 & 2013 datasets for import into blank CR5db

/*
 To prepare cancer dataset:
 (1) import into excel the .txt files exported from CanReg5 and change the format from General to Text for the below fields in excel:
		- TumourIDSourceTable
		- SourceRecordID
		- STDataAbstractor
		- NFType
		- STReviewer
		- TumourID
		- PatientIDTumourTable
		- TTDataAbstractor
		- Parish
		- Topography
		- TTReviewer
		- RegistryNumber
		- PTDataAbstractor
		- PatientRecordID
		- RetrievalSource
		- FurtherRetrievalSource
		- PTReviewer
 (2) import the .xlsx file into Stata and save dataset in Stata
*/
import excel using "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\raw\2018-12-19_BNR-CLEAN_Main Exported Source+Tumour+Patient_excel_JC.xlsx", firstrow clear
save "data\raw\2008_2013_cancer_prelim_dc.dta" ,replace

count //2,185 (1258=2008(312=C44); 927=2013)

drop if regexm(I10,"C44") //312 obs deleted
rename SOURCENAME SOURCE
gen LABNO=99

save "data\2008-2013_BNR-C_CR5db_dataset.dta", replace

export delimited NFTYPE	SOURCE	LABNO	CASNO	TUMOURIDSOURCETABLE	SOURCERECORDID using "data\2008-2013_BNR-C_CR5db_dataset_ST.txt", delimiter(tab) nolabel replace

export delimited RECS	CHEC	AGE	ADDR	INCID	TOP	MOR	BEH	BAS	I10	MPCODE MPSEQ	MPTOT	UPDATE	ICCC	OBSOLETEFLAGTUMOURTABLE	TUMOURID	PATIENTIDTUMOURTABLE ///
				 PATIENTRECORDIDTUMOURTABLE	TUMOURUPDATEDBY	TUMOURUNDUPLICATIONSTATUS using "data\2008-2013_BNR-C_CR5db_dataset_TT.txt", delimiter(tab) nolabel replace

export delimited REGNO	PERS	FAMN	FIRSTN	SEX	BIRTHD	DLC	STAT	MIDN	OBSOLETEFLAGPATIENTTABLE ///
				 PATIENTRECORDID	PATIENTUPDATEDBY	PATIENTUPDATEDATE	PATIENTRECORDSTATUS	PATIENTCHECKSTATUS using "data\2008-2013_BNR-C_CR5db_dataset_PT.txt", delimiter(tab) nolabel replace

count //1,873
