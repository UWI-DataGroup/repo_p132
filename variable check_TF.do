** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			    variable check_TF.do
    //  project:				        BNR
    //  analysts:				       	Jacqueline CAMPBELL, Stephanie WHITEMAN
    //  date first created      26-FEB-2019
    // 	date last modified	    26-FEB-2019
    //  algorithm task			    Checking variable completeness on 2018 EI7 dataset

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
    log using "`logpath'\variable check_TF", replace
** HEADER -----------------------------------------------------


* ************************************************************************
* RENAME VARIABLES ACCORDING TO GROUPS
*  (1) EI (epi info 7) admin variables
*  (2) HR variables
*  (3) CF variables
*  (4) PQI (performance & quality indicators) variables
**************************************************************************

** Load 2018 EI7 raw data
import excel using "`datapath'\version03\1-input\20190226rawdataTF2018.xlsx" , firstrow case(lower) clear

** Rename all EI7 admin variables to end in EI
rename necessary* =EI
rename unique* =EI
rename gid* =EI
rename taa* =EI
rename pidupdate =EI
rename aidupdate =EI
rename pidappend =EI
rename aidappend =EI

** Rename all HR-related variables to end in HR
rename tid tidHR
rename tf* =HR
rename tdoa =HR
rename tda =HR
rename ttype =HR
rename dsource =HR
rename starttime =HR
rename endtime =HR
rename cfupdate =HR
rename aidpartial =HR
rename elapsed* =HR
rename a1-a12 =HR
rename b1-b12 =HR
rename c1-c12 =HR
rename ae =HR
rename cunit =HR
rename drec =HR
rename hd =HR
rename mrec =HR
rename sunit =HR
rename na =HR
rename micu =HR
rename nicu =HR
rename picu =HR
rename recroom =HR
rename sicu =HR
rename ward* =HR
rename warddateHR warddateCF
rename ae* =HR
rename dr* =HR
rename drpnameHR drpnameCF
rename drmonthHR drmonthCF
rename mr* =HR
rename mrdateHR mrdateCF
rename paypile =CF
rename medpile =CF
rename genpile =CF
rename totpile =CF

** Save dataset to be used in variable completeness quality check
save "`datapath'\version03\3-output\variable check prep_TF.dta", replace
label data "2018 Epi Info 7 Check for Completeness - Tracking Form"
