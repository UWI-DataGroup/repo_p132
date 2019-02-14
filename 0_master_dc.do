/*
This is the master *do* file for all data cleaning of BNR-Cancer 2014 dataset
for 2014 annual report which includes duplicate and death data matching.
version02 was prepared by J Campbell on 06sep2018
Dofile running accurately as of 18sep2018.
version02 was prepared by J Campbell on 03dec2018.
Dofile running accurately as of 06dec2018
*/

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

log using "logfiles\0_master_2014_dc.smcl", replace

** Automatic page scrolling of screen output
set more off

 *************************************************************************
 *     C D R C         A N A L Y S I S         C O D E
 *                                                              
 *     DO FILE: 	0_master_dc
 *
 *	   STATUS:		Completed
 *
 *     FIRST RUN:	06sep2018
 *
 *	   LAST RUN:	06dec2018
 *
 *     ANALYSIS: 	Cancer 2014 dataset for quality control & annual report
 *					- cancer team uses to clean BNR-CLEAN database
 *					- JC uses for basis of cleaning for annual report
 *
 *     PRODUCT: 	STATA SE Version 15.1
 *
 *     DATA: 		Datasets prepared by J Campbell		
 *		
 * 	   VERSION: 	version02 - 2014 ABSTRACTION PHASE
 *     
 *     SUPPORT: 	Natasha Sobers/Ian R Hambleton        
 *	
 *************************************************************************

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
import excel using "L:\BNR_data\DM\data_cleaning\2014\cancer\versions\version02\data\raw\2018-11-01_Main Exported Source+Tumour+Patient_excel_JC.xlsx", firstrow
save "data\raw\2014_cancer_prelim_dc.dta" ,replace

** 1st dofile: change variable names and create unique record identifier (cr5id)
do "dofiles\1_prep_cancer_dc"
** Dataset = 2014_cancer_prep_dc.dta 

** 2nd dofile: to identify and correct errors, drop duplicates, drop irrelevant years of data
do "dofiles\2_clean_cancer_dc"
** Dataset = 2014_cancer_clean_dups_dc.dta 

** 3rd dofile: to identify duplicates and prep for merge with national death data
do "dofiles\3_duplicates_cancer_dc"
** Dataset = 2014_cancer_clean_nodups_dc.dta

** 4th dofile: to prep national death data for matching with cancer data
do "dofiles\4_deaths_cancer_dc"
** Dataset = 2014_cancer_deaths_dc.dta

** 5th dofile: to merge death data and cancer data, create MPs in DCO data
do "dofiles\5_merge_cancer_dc"
** Dataset = 2014_cancer_merge_dc.dta

** 6th dofile: to create missed 2013 cases dataset for appending to 2013 annual report dataset
do "dofiles\6_clean_cancer_2013_dc"
** Dataset = 2013_cancer_clean_nodups_dc.dta

** 7th dofile: to create dataset with 2014 cases flagged for SDA to correct in BNR-CLEAN db (still in progress)
**do "dofiles\7_flags_cancer_dc"
** Dataset = 2014_cancer_flags_dc.dta

** 8th dofile: to prep death data for mortality section of annual report
do "dofiles\8_mortality_cancer_dc"
** Dataset = 2014_cancer_mort_dc.dta

** 9th dofile: to report on data quality indicators
do "dofiles\9_dqi_cancer_dc"
** Dataset = 2014_cancer_merge_dqi_dc.dta

** 10th dofile: to export cleaned data to import into blank CR5db
do "dofiles\10_export_cancer_dc"
** Datasets = 2014_BNR-C_CR5db_dataset.dta
**			  2008-2013_BNR-C_CR5db_dataset.dta


