** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			    variable check_CF.do
    //  project:				        BNR
    //  analysts:				       	Jacqueline CAMPBELL, Stephanie WHITEMAN
    //  date first created      26-FEB-2019
    // 	date last modified	    26-FEB-2019
    //  algorithm task			    Checking variable completeness
    //                          for casefidning form of 2018 EI7 dataset

    ** General algorithm set-up
    version 15
    clear all
    macro drop _all
    set more 1
    set linesize 80

    ** Set working directories: this is for DATASET and LOGFILE import and export
    ** DATASETS to encrypted SharePoint folder
    local datapath "X:/The University of the West Indies/DataGroup - repo_data/data_p132"
    ** LOGFILES to unencrypted OneDrive folder (.gitignore set to IGNORE log files on PUSH to GitHub)
    local logpath X:/OneDrive - The University of the West Indies/repo_datagroup/repo_p132

    ** Close any open log file and open a new log file
    capture log close
    log using "`logpath'\variable check_CF", replace
** HEADER -----------------------------------------------------


* ************************************************************************
* RENAME VARIABLES ACCORDING TO GROUPS
*  (1) EI (epi info 7) admin variables
*  (2) HR variables
*  (3) CF (casefinding) variables
*  (4) PQI (performance & quality indicators) variables
**************************************************************************

** Load 2018 EI7 raw data (Casefinding)
import excel using "`datapath'\version03\1-input\20190226rawdataCF2018.xlsx" , firstrow case(lower) clear

describe //49 variables; 2,082 observations as of 26feb2019

** Note: pid 1 and pid 2 contain dummy data

** Rename all EI7 admin variables to end in EI
rename necessary* =EI
rename unique* =EI
rename gid* =EI
rename cfap =EI
rename cfad =EI
rename cfat =EI
rename toabs =EI
rename cfadat =EI
rename toreview =EI

** Rename all CF-related variables to end in CF
rename transfer =CF
rename pname =CF
rename dobnd =CF
rename age =CF
rename hospnum =CF
rename recnum =CF
rename ward =CF
// ward currently used for casefinding only but for new database it will be also be used as a quality indcator
rename initialdx =CF
// ask NS re this variable as I think AH also uses in analysis (PQI)
rename hstatus =CF
rename vstatus =CF
rename dod =CF
// ask NS re this variable as I think AH also uses in analysis when dod on Discharge page blank (PQI)
rename dodnd =CF
rename finaldx =CF
// ask NS re this variable as I think AH also uses in analysis (PQI)
rename docname =CF
rename cfparish =CF
rename retsource =CF
rename oretsrce =CF
rename cfcomment =CF
rename request1d =CF
rename request2d =CF
rename request3d =CF

** Rename all PQI-related variables to end in PQI
rename pid =PQI
rename etype =PQI
rename cfdoa =PQI
rename ctype =PQI
rename cfsource =PQI
rename fname =PQI
rename mname =PQI
rename lname =PQI
rename sex =PQI
rename dob =PQI
rename natregno =PQI
rename cfadmdate =PQI
rename cfadmdtnd =PQI
rename cstatus =PQI
rename duprec =PQI
rename dupcheck =PQI
rename readmrec =PQI
rename cftype =PQI
// this variable set to default=1 (active)

** Rename all HR-related variables to end in HR
rename cfda =HR

** Save dataset to be used in variable completeness quality check
save "`datapath'\version03\2-working\variable check prep_CF.dta", replace
label data "2018 Epi Info 7 Check for Completeness - Casefinding Form"
