** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			    variable check_ABS.do
    //  project:				        BNR
    //  analysts:				       	Jacqueline CAMPBELL, Stephanie WHITEMAN
    //  date first created      26-FEB-2019
    // 	date last modified	    26-FEB-2019
    //  algorithm task			    Checking variable completeness
    //                          for abstracting form of 2018 EI7 dataset

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
    log using "`logpath'\variable check_ABS", replace
** HEADER -----------------------------------------------------


* ************************************************************************
* RENAME VARIABLES ACCORDING TO GROUPS
*  (1) EI (epi info 7) admin variables
*  (2) HR variables
*  (3) CF (casefinding) variables
*  (4) PQI (performance & quality indicators) variables
**************************************************************************

** Load 2018 EI7 raw data (Abstracting)
import excel using "`datapath'\version03\1-input\20190226rawdataABS2018.xlsx" , firstrow case(lower) clear

describe //847 variables; 976 observations as of 26feb2019

** Note 1: JC used Stata data editor and Variables filter in Stata results window to rename variables
** Note 2: pidabs 1 and pidabs 2 contain dummy data

** Rename all EI7 admin variables to end in EI
rename necessary* =EI
rename pname* =EI
rename unique* =EI
rename *abs =EI
rename gid* =EI
rename absap =EI
rename absad =EI
rename absat =EI
rename absadat =EI
rename toreview =EI

** Rename all CF-related variables to end in CF
rename *txt =CF
rename *sid* =CF
rename *tel* =CF
rename cell =CF
rename cellnd =CF
rename *ekin* =CF
rename *kkin* =CF
rename *lkin* =CF
rename relation =CF
rename orelation =CF
rename gpconsult =CF
rename hospnum =CF
rename sfu* =CF //possibly used in analysis too (PQI)
rename hfu* =CF //possibly used in analysis too (PQI)
rename futype =CF //possibly used in analysis too (PQI)

** Rename all PQI-related variables to end in PQI
rename pidabs =PQI
rename aid =PQI
rename etypeabsEI etypeabsPQI
rename *doa =PQI
rename ctype =PQI
rename *tatus =PQI
rename *resi* =PQI
rename citizen =PQI
rename address =PQI
rename parish =PQI
rename hospital =PQI
rename ohospital =PQI
rename doh =PQI
rename dohnd =PQI
rename toh =PQI
rename tohnd =PQI
rename amb* =PQI
rename *same* =PQI
rename sametelCFPQI sametelCF
rename hospd* =PQI
rename hospt* =PQI
rename atsc* =PQI
rename frmsc* =PQI
rename dohtoh =PQI
rename icu =PQI
rename wardmed =PQI
rename wardae =PQI
rename *stru* =PQI
rename cardunit =PQI
rename oward =PQI
rename nohosp =PQI
rename onohosp =PQI
rename ssym* =PQI
rename ssymtxtCFPQI ssymtxtCF
rename ossym* =PQI
rename *sign* =PQI
rename *day =PQI
rename sonset =PQI
rename *s2sym* =PQI
rename s2symtxtCFPQI s2symtxtCF
rename stype =PQI
rename sdtype =PQI
rename *stroke* =PQI
rename sreview* =PQI
rename hsym* =PQI
rename hsymtxtCFPQI hsymtxtCF
rename doo =PQI
rename doond =PQI
rename too =PQI
rename toond =PQI
rename ohsym* =PQI
rename dootoo =PQI
rename noncsurg =PQI
rename dos* =PQI
rename tos* =PQI
rename sage =PQI
rename dom* =PQI
rename tom* =PQI
rename hage =PQI
rename cardiac =PQI
rename resus =PQI
rename sudd =PQI
rename htype =PQI
rename hdtype =PQI
rename hreview* =PQI
rename *ami* =PQI
rename pihd =PQI
rename pcabg =PQI
rename *ang* =PQI
rename *any =PQI
rename smok* =PQI
rename smoketxtCFPQI smoketxtCF
rename htn =PQI
rename hcl =PQI
rename dia* =PQI
rename *af* =PQI
rename hld =PQI
rename *tia* =PQI
rename obese =PQI
rename *ccf* =PQI
rename *alc* =PQI
rename alctxtCFPQI alctxtCF
rename *dvt* =PQI
rename drugs =PQI
rename scd =PQI
rename ov* =PQI
rename gcs* =PQI
rename eyend =PQI
rename verbalnd =PQI
rename motornd =PQI
rename totalnd =PQI
rename *bp* =PQI
rename assess*  =PQI
rename assesstxtCFPQI assesstxtPQI
rename dct =PQI
rename decho =PQI
rename *ecg* =PQI
rename dcxr =PQI
rename dmri =PQI
rename dctcorang =PQI
rename dcarus =PQI
rename dstress =PQI
rename odi* =PQI
rename ct =PQI
rename doct =PQI
rename doctnd =PQI
rename stiming =PQI
rename ctfeat =PQI
rename *inf* =PQI
rename *haem* =PQI
rename ckmbdone =PQI
rename astdone =PQI
rename trop* =PQI
rename tppv =PQI
rename tnippv =PQI
rename *fib =PQI
rename tcpr =PQI
rename tmech =PQI
rename tpacetemp =PQI
rename oti* =PQI
rename *comp* =PQI
rename hcomptxtCFPQI hcomptxtCF
rename *neu* =PQI
rename *sho* =PQI
rename *ulc* =PQI
rename *uti* =PQI
rename *hy* =PQI
rename *ren* =PQI
rename *bl* =PQI
rename *rest =PQI
rename *sei* =PQI
rename *isc* =PQI
rename *cv* =PQI
rename discvaPQIPQI discvaPQI
rename oabs* =PQI
rename *dxn* =PQI
rename *sub =PQI
rename *uct* =PQI
rename *stemi =PQI
rename *acs* =PQI
rename *chest =PQI
rename *bb =PQI
rename rep* =PQI
rename asp* =PQI
rename warf* =PQI
rename hep* =PQI
rename pla* =PQI
rename stat* =PQI
rename ins* =PQI
rename gip* =PQI
rename o2* =PQI
rename disd =PQI
rename disdnd =PQI
rename disdt =PQI
rename dist =PQI
rename distnd =PQI
rename dod =PQI
rename dodnd =PQI
rename *tod* =PQI
rename pm =PQI
rename cod* =PQI
rename *read* =PQI
rename *carun* =PQI
rename *class =PQI
rename orec* =PQI
rename *sicf =PQI
rename *con =PQI
rename *how =PQI
rename *sit =PQI
rename *los* =PQI
rename *eth* =PQI
rename edu* =PQI
rename main* =PQI
rename *empl* =PQI
rename *rank* =PQI
rename *hxs =PQI
rename *hxa =PQI
rename cig* =PQI
rename *tobac* =PQI
rename pipe =PQI
rename mari* =PQI
rename *gram =PQI
rename spl* =PQI
rename beer* =PQI
rename spir* =PQI
rename win* =PQI


// Below datetime variables created in EI7 at Ashley's request but not needed as Stata can generate these (not added to redcap database)
// ambcalldt hospdt atscndt frmscndt ecgdt dostos domtom reperfdt heplmwdt aspdt warfdt hepdt pladt o2dt gipdt insudt statdt noacsdt disdt dodtod


** Rename all HR-related variables to end in HR
rename *da =HR

** Save dataset to be used in variable completeness quality check
save "`datapath'\version03\3-output\variable check prep_ABS.dta", replace
label data "2018 Epi Info 7 Check for Completeness - Asbracting Form"
