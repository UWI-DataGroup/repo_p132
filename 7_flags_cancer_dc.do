/*
This is the seventh *do* file to be called by the master file.
version02 was prepared by J Campbell on 06sep2018 to flag 2014 ABS errors for 
SDA to correct in BNR-CLEAN CR5 database and is based on the errors corrected in 
dofile 2_clean_cancer_dc.
Dofile running accurately as of 06sep2018
*/

 ******************************************************************************
 *
 *	GA-C D R C      A N A L Y S I S         C O D E
 *                                                              
 *  DO FILE: 		7_flag_cancer_dc
 *					7th dofile: Data Flags
 *
 *	STATUS:			In progress
 *
 *  FIRST RUN: 		07nov2018
 *
 *	LAST RUN:		07nov2018
 *
 *  ANALYSIS: 		Flagging checks on all CR5 tables
 *					Cancer team to use for corrections in clean CR5db
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
cd "L:\BNR_data\DM\data_review\2014\cr5\versions\version02\"

log using "logfiles\7_flags_cancer_2014.smcl", replace

set more off

**************************************
** DATA PREPARATION  
**************************************
** LOAD the prepared dataset
NEED TO FIGURE OUT HOW TO REVAMP THIS DOFILE!
USE DOFILES 2 AND 3 TO SEARCH FOR CORRECTIONS!
use "data\raw\2014_cancer_no flags.dta" ,clear

** DROP all cases dx in 2014 onwards as SAF requested (28jun18) that incorrect
** pre-2014 cases are to be flagged
drop if dxyr>2013
** Create variables that will contain a flag for field name and error description
** These to be used in '2_flag_cancer.do'.

REVAMP BELOW SO LESS CHECKS AND FORMATTING IN EXPORTED EXCEL MORE USER-FRIENDLY
see labelvalclone
display `"{browse "https://www.statalist.org/forums/forum/general-stata-discussion/general/1323756-renaming-replacing-label-names":LABELVALCLONE}"'
display `"{browse "https://www.statalist.org/forums/forum/general-stata-discussion/general/1302000-changing-many-variable-labels-at-once":LABVARCH}"'
labvarch site*, suff("_old") //changes site label to 'site of tumour_old' - does not change site values
/*
Renaming/replacing label names
21 Jan 2016, 23:20
I am working across multiple datasets and have a list of about thirty labels that need to be renamed to slightly different label names (e.g. yesno to yes_no_dnk_nr, edul to school_list, roofl to roof_list). The variables that are associated with each label vary slightly across each dataset. 

For example, in one dataset I have about thirty variables that use the label yesno and I would like to rename the label to yes_no_dnk_nr. In another dataset, I may have fifty variables that use the label yesno and want to also rename these to yes_no_dk_nr. The variables are not always the same across datasets so creating a foreach loop by listing all of the variables in each dataset would be inefficient.

Is there a simple way to identify all variables that are associated with the label yesno and then just rename the label name to yes_no_dk_nr? 

I am using Stata 14. I have looked at labvalclone but the examples I have found relabel the label to the variable name rather than renaming a list of variables to a standardized label name (below)

foreach var of varlist `r(varlist)'{
2. labvalclone "`:val lab `var''" "`var'"
3. la val `var' `var'
4. }

Thank you!

Linnea

*/
/* UNUSED CODE TO CREATE MANY CHECKFLAG VARS AT ONCE
local i=1
foreach var in checkflag {
	gen checkflag`i' = .
	local i = `i'
	}
*/
gen checkflag1=.
gen checkflag2=.
gen checkflag3=.
gen checkflag4=.
gen checkflag5=.
gen checkflag6=.
gen checkflag7=.
gen checkflag8=.
gen checkflag9=.
gen checkflag10=.
gen checkflag11=.
gen checkflag12=.
gen checkflag13=.
gen checkflag14=.
gen checkflag15=.
gen checkflag16=.
gen checkflag17=.
gen checkflag18=.
gen checkflag19=.
gen checkflag20=.
gen checkflag21=.
gen checkflag22=.
gen checkflag23=.
gen checkflag24=.
gen checkflag25=.
gen checkflag26=.
gen checkflag27=.
gen checkflag28=.
gen checkflag29=.
gen checkflag30=.
gen checkflag31=.
gen checkflag32=.
gen checkflag33=.
gen checkflag34=.
gen checkflag35=.
gen checkflag36=.
gen checkflag37=.
gen checkflag38=.
gen checkflag39=.
gen checkflag40=.
gen checkflag41=.
gen checkflag42=.
gen checkflag43=.
gen checkflag44=.
gen checkflag45=.
gen checkflag46=.
gen checkflag47=.
gen checkflag48=.
gen checkflag49=.
gen checkflag50=.
gen checkflag51=.
gen checkflag52=.
gen checkflag53=.
gen checkflag54=.
gen checkflag55=.
gen checkflag56=.
gen checkflag57=.
gen checkflag58=.
gen checkflag59=.
gen checkflag60=.
gen checkflag61=.
gen checkflag62=.
gen checkflag63=.
gen checkflag64=.
gen checkflag65=.
gen checkflag66=.
gen checkflag67=.
gen checkflag68=.
gen checkflag69=.
gen checkflag70=.
gen checkflag71=.
gen checkflag72=.
gen checkflag73=.
gen checkflag74=.
gen checkflag75=.
gen checkflag76=.
gen checkflag77=.
gen checkflag78=.
gen checkflag79=.
gen checkflag80=.
gen checkflag81=.
gen checkflag82=.
gen checkflag83=.
gen checkflag84=.
gen checkflag85=.
gen checkflag86=.
gen checkflag87=.
gen checkflag88=.
gen checkflag89=.
gen checkflag90=.
gen checkflag91=.
gen checkflag92=.
gen checkflag93=.
gen checkflag94=.
gen checkflag95=.
gen checkflag96=.
gen checkflag97=.
gen checkflag98=.
gen checkflag99=.
gen checkflag100=.
gen checkflag101=.
gen checkflag102=.
gen checkflag103=.
gen checkflag104=.
gen checkflag105=.
gen checkflag106=.
gen checkflag107=.
gen checkflag108=.
gen checkflag109=.
gen checkflag110=.
gen checkflag111=.
gen checkflag112=.
gen checkflag113=.
gen checkflag114=.
gen checkflag115=.
gen checkflag116=.
gen checkflag117=.
gen checkflag118=.
gen checkflag119=.
gen checkflag120=.
gen checkflag121=.
gen checkflag122=.
gen checkflag123=.
gen checkflag124=.
gen checkflag125=.
gen checkflag126=.
gen checkflag127=.
gen checkflag128=.
gen checkflag129=.
gen checkflag130=.
gen checkflag131=.
gen checkflag132=.
gen checkflag133=.
gen checkflag134=.
gen checkflag135=.
gen checkflag136=.
gen checkflag137=.
gen checkflag138=.
gen checkflag139=.
gen checkflag140=.
gen checkflag141=.
gen checkflag142=.
gen checkflag143=.
gen checkflag144=.
gen checkflag145=.
gen checkflag146=.
gen checkflag147=.
gen checkflag148=.
gen checkflag149=.
gen checkflag150=.
gen checkflag151=.
gen checkflag152=.
gen checkflag153=.
gen checkflag154=.
gen checkflag155=.
gen checkflag156=.
gen checkflag157=.
gen checkflag158=.
gen checkflag159=.
gen checkflag160=.
gen checkflag161=.
gen checkflag162=.
gen checkflag163=.
gen checkflag164=.
gen checkflag165=.
gen checkflag166=.
gen checkflag167=.
gen checkflag168=.
gen checkflag169=.
gen checkflag170=.
gen checkflag171=.
gen checkflag172=.
gen checkflag173=.
gen checkflag174=.
gen checkflag175=.
gen checkflag176=.
gen checkflag177=.
gen checkflag178=.
gen checkflag179=.
gen checkflag180=.
label var checkflag1 "Check 1"
label var checkflag2 "Check 2"
label var checkflag3 "Check 3"
label var checkflag4 "Check 4"
label var checkflag5 "Check 5"
label var checkflag6 "Check 6"
label var checkflag7 "Check 7"
label var checkflag8 "Check 8"
label var checkflag9 "Check 9"
label var checkflag10 "Check 10"
label var checkflag11 "Check 11"
label var checkflag12 "Check 12"
label var checkflag13 "Check 13"
label var checkflag14 "Check 14"
label var checkflag15 "Check 15"
label var checkflag16 "Check 16"
label var checkflag17 "Check 17"
label var checkflag18 "Check 18"
label var checkflag19 "Check 19"
label var checkflag20 "Check 20"
label var checkflag21 "Check 21"
label var checkflag22 "Check 22"
label var checkflag23 "Check 23"
label var checkflag24 "Check 24"
label var checkflag25 "Check 25"
label var checkflag26 "Check 26"
label var checkflag27 "Check 27"
label var checkflag28 "Check 28"
label var checkflag29 "Check 29"
label var checkflag30 "Check 30"
label var checkflag31 "Check 31"
label var checkflag32 "Check 32"
label var checkflag33 "Check 33"
label var checkflag34 "Check 34"
label var checkflag35 "Check 35"
label var checkflag36 "Check 36"
label var checkflag37 "Check 37"
label var checkflag38 "Check 38"
label var checkflag39 "Check 39"
label var checkflag40 "Check 40"
label var checkflag41 "Check 41"
label var checkflag42 "Check 42"
label var checkflag43 "Check 43"
label var checkflag44 "Check 44"
label var checkflag45 "Check 45"
label var checkflag46 "Check 46"
label var checkflag47 "Check 47"
label var checkflag48 "Check 48"
label var checkflag49 "Check 49"
label var checkflag50 "Check 50"
label var checkflag51 "Check 51"
label var checkflag52 "Check 52"
label var checkflag53 "Check 53"
label var checkflag54 "Check 54"
label var checkflag55 "Check 55"
label var checkflag56 "Check 56"
label var checkflag57 "Check 57"
label var checkflag58 "Check 58"
label var checkflag59 "Check 59"
label var checkflag60 "Check 60"
label var checkflag61 "Check 61"
label var checkflag62 "Check 62"
label var checkflag63 "Check 63"
label var checkflag64 "Check 64"
label var checkflag65 "Check 65"
label var checkflag66 "Check 66"
label var checkflag67 "Check 67"
label var checkflag68 "Check 68"
label var checkflag69 "Check 69"
label var checkflag70 "Check 70"
label var checkflag71 "Check 71"
label var checkflag72 "Check 72"
label var checkflag73 "Check 73"
label var checkflag74 "Check 74"
label var checkflag75 "Check 75"
label var checkflag76 "Check 76"
label var checkflag77 "Check 77"
label var checkflag78 "Check 78"
label var checkflag79 "Check 79"
label var checkflag80 "Check 80"
label var checkflag81 "Check 81"
label var checkflag82 "Check 82"
label var checkflag83 "Check 83"
label var checkflag84 "Check 84"
label var checkflag85 "Check 85"
label var checkflag86 "Check 86"
label var checkflag87 "Check 87"
label var checkflag88 "Check 88"
label var checkflag89 "Check 89"
label var checkflag90 "Check 90"
label var checkflag91 "Check 91"
label var checkflag92 "Check 92"
label var checkflag93 "Check 93"
label var checkflag94 "Check 94"
label var checkflag95 "Check 95"
label var checkflag96 "Check 96"
label var checkflag97 "Check 97"
label var checkflag98 "Check 98"
label var checkflag99 "Check 99"
label var checkflag100 "Check 100"
label var checkflag101 "Check 101"
label var checkflag102 "Check 102"
label var checkflag103 "Check 103"
label var checkflag104 "Check 104"
label var checkflag105 "Check 105"
label var checkflag106 "Check 106"
label var checkflag107 "Check 107"
label var checkflag108 "Check 108"
label var checkflag109 "Check 109"
label var checkflag110 "Check 110"
label var checkflag111 "Check 111"
label var checkflag112 "Check 112"
label var checkflag113 "Check 113"
label var checkflag114 "Check 114"
label var checkflag115 "Check 115"
label var checkflag116 "Check 116"
label var checkflag117 "Check 117"
label var checkflag118 "Check 118"
label var checkflag119 "Check 119"
label var checkflag120 "Check 120"
label var checkflag121 "Check 121"
label var checkflag122 "Check 122"
label var checkflag123 "Check 123"
label var checkflag124 "Check 124"
label var checkflag125 "Check 125"
label var checkflag126 "Check 126"
label var checkflag127 "Check 127"
label var checkflag128 "Check 128"
label var checkflag129 "Check 129"
label var checkflag130 "Check 130"
label var checkflag131 "Check 131"
label var checkflag132 "Check 132"
label var checkflag133 "Check 133"
label var checkflag134 "Check 134"
label var checkflag135 "Check 135"
label var checkflag136 "Check 136"
label var checkflag137 "Check 137"
label var checkflag138 "Check 138"
label var checkflag139 "Check 139"
label var checkflag140 "Check 140"
label var checkflag141 "Check 141"
label var checkflag142 "Check 142"
label var checkflag143 "Check 143"
label var checkflag144 "Check 144"
label var checkflag145 "Check 145"
label var checkflag146 "Check 146"
label var checkflag147 "Check 147"
label var checkflag148 "Check 148"
label var checkflag149 "Check 149"
label var checkflag150 "Check 150"
label var checkflag151 "Check 151"
label var checkflag152 "Check 152"
label var checkflag153 "Check 153"
label var checkflag154 "Check 154"
label var checkflag155 "Check 155"
label var checkflag156 "Check 156"
label var checkflag157 "Check 157"
label var checkflag158 "Check 158"
label var checkflag159 "Check 159"
label var checkflag160 "Check 160"
label var checkflag161 "Check 161"
label var checkflag162 "Check 162"
label var checkflag163 "Check 163"
label var checkflag164 "Check 164"
label var checkflag165 "Check 165"
label var checkflag166 "Check 166"
label var checkflag167 "Check 167"
label var checkflag168 "Check 168"
label var checkflag169 "Check 169"
label var checkflag170 "Check 170"
label var checkflag171 "Check 171"
label var checkflag172 "Check 172"
label var checkflag173 "Check 173"
label var checkflag174 "Check 174"
label var checkflag175 "Check 175"
label var checkflag176 "Check 176"
label var checkflag177 "Check 177"
label var checkflag178 "Check 178"
label var checkflag179 "Check 179"
label var checkflag180 "Check 180"
label define checkflag_lab 0 "No errors" 1 "PT DA:Missing" 2 "PT DA:Invalid Code" 3 "PT DA:Invalid Code Length" 4 "CFDate:Missing" 5 "CFDate:Invalid(future)" ///
						   6 "CaseStatus:Missing" 7 "CaseStatus:ABS but no TT DA" 8 "CaseStatus:Duplicate" 9 "CaseStatus:Deleted" ///
						   10 "CaseStatus:Ineligible but RecStatus NOT ineligible" 11 "CaseStatus:Checked by reviewer; no errors" ///
						   12 "CaseStatus:For review by SDA & CD" 13 "CaseStatus:Incorrect Tumour RecStatus" 14 "RetSource:Missing" ///
						   15 "RetSource:NOT=death rec, NFType=death" 16 "NotesSeen:Missing" 17 "NotesSeen:Pending Ret, CaseStatus=ABS" ///
						   18 "NotesSeenDate:Missing" 19 "NotesSeenDate:No, NSDate not blank" 20 "NotesSeenDate:invalid(future)" 21 "Fur.Ret.Source:Missing" ///
						   22 "Fur.Ret.Source:NOT=death rec, NFType=death" 23 "FirstName:Missing" 24 "MidInitials:Missing" 25 "LastName:Missing" ///
						   26 "BirthDate:Missing" 27 "BirthDate:Missing, NRN available" 28 "BirthDate:future year" 29 "BirthDate:NRN mismatch" 30 "NRN: Missing" ///
						   31 "NRN:Invalid Length" 32 "Sex:Missing" 33 "Sex(M):possibly invalid(Fname, sex, NRN mismatch)" ///
						   34 "Sex(M):possibly invalid(sex=M;site=breast)" 35 "Sex(M):invalid(sex=M;site=FGS)" 36 "Sex(F):possibly invalid(Fname, sex, NRN mismatch)" ///
						   37 "Sex(F):invalid(sex=F;site=MGS)" 38 "Hosp.#:Missing" 39 "ResidentStatus:Missing" 40 "SLC:Missing" 41 "SLC:invalid(slc=died;dlc=blank)" ///
						   42 "SLC:invalid(slc=alive;dlc=blank)" 43 "SLC:invalid(slc=alive;nftype=death)" 44 "DLC:Missing(CaseStatus=ABS)" 45 "DLC:Invalid(future)" ///
						   46 "Comments:Missing" 47 "Record Status:invalid(recstatus=pending;dxyr<2014)" 48 "Record Status:invalid(cstatus=CF;recstatus<>pending)" ///
						   49 "Record Status:Deleted" 50 "Check Status:invalid (checkstatus=notdone;recstatus=pend/confirm;primarysite<>blank)" ///
						   51 "Check Status:invalid (checkstatus=invalid;recstatus=pend/confirm;primarysite<>blank)" 52 "TT DA:Missing" 53 "TT DA:Invalid Code" ///
						   54 "AbsDate:Missing" 55 "AbsDate:Invalid(future)" 56 "Parish:Missing" 57 "Address:Missing" 58 "Age:Missing" ///
						   59 "Age:invalid(Checked by reviewer; no errors)" 60 "Age:invalid (age<>incidencedate-dob)" 61 "PrimSite:Missing" ///
						   62 "PrimSite:Reviewed/Corrected by DA/Reviewer; no errors" 63 "PrimSite:invalid(primarysite<>top)" 64 "Top:Missing" 65 "Top:Invalid Code Length" ///
						   66 "Hx:Missing" 67 "Morph:Missing" 68 "Morph:Invalid Code Length" 69 "HxVsBeh:Reviewed/Corrected by DA/Reviewer; no errors" ///
						   70 "HxVsBeh:invalid(hx vs beh)" 71 "MorphVsBasis:Reviewed/Corrected by DA/Reviewer; no errors" 72 "MorphVsBasis:invalid(morph vs basis)" ///
						   73 "HxVsMorph:Reviewed/Corrected by DA/Reviewer; no errors" 74 "HxVsMorph:invalid(hx<>morph)" ///
						   75 "HxVsPrimSite:Reviewed/Corrected by DA/Reviewer; no errors" 76 "HxVsPrimSite:invalid (primsite<>hx)" ///
						   77 "Age/Site/Hx:Reviewed/Corrected by DA/Reviewer; no errors" 78 "Age/Site/Hx:possibly invalid(IARCcrgTools)(see Reviewer Comments)" ///
						   79 "Sex/Hx:Reviewed/Corrected by DA/Reviewer; no errors" 80 "Sex/Hx:invalid(IARCcrgTools)(see Reviewer Comments)" ///
						   81 "Site/Hx:Reviewed/Corrected by DA/Reviewer; no errors" 82 "Site/Hx:possibly invalid(IARCcrgTools)(see Reviewer Comments)" ///
						   83 "Lat:Missing" 84 "Lat:Invalid Code" 85 "Lat:Reviewed/Corrected by DA/Reviewer; no errors" 86 "Lat:Invalid(see Reviewer Comments)" ///
						   87 "Beh:Missing" 88 "Beh:Invalid Code" 89 "Beh:Reviewed/Corrected by DA/Reviewer; no errors" 90 "Beh:Invalid(see Reviewer Comments)" ///
						   91 "Grade:Missing" 92 "Grade:Invalid Code" 93 "Grade:Reviewed/Corrected by DA/Reviewer; no errors" 94 "Grade:Invalid(see Reviewer Comments)" ///
						   95 "Basis:Missing" 96 "Basis:Invalid Code" 97 "Basis:Reviewed/Corrected by DA/Reviewer; no errors" 98 "Basis:Invalid(see Reviewer Comments)" ///
						   99 "Stage:Missing" 100 "Stage:Invalid Code" 101 "Stage:Reviewed/Corrected by DA/Reviewer; no errors" 102 "Stage:Invalid(see Reviewer Comments)" ///
						   103 "InciDate:Missing" 104 "InciDate:Invalid(future)" 105 "InciDate:Reviewed/Corrected by DA/Reviewer; no errors" ///
						   106 "InciDate:Invalid(see Reviewer Comments)" ///
						   107 "DxYr:Missing" 108 "DxYr:Invalid Code" 109 "DxYr:Reviewed/Corrected by DA/Reviewer; no errors" 110 "DxYr:Invalid(see Reviewer Comments)" ///
						   111 "Rx1-5:Missing" 112 "Rx1-5:Invalid Code" 113 "Rx1-5:Reviewed/Corrected by DA/Reviewer; no errors" 114 "Rx1-5:Invalid(see Reviewer Comments)" ///
						   115 "Rx1-5 Dates:Invalid(future)" 116 "OthRx1&2:Reviewed/Corrected by DA/Reviewer; no errors" 117 "OthRx1&2:Invalid(see Reviewer Comments)" ///
						   118 "NoRx1&2:Reviewed/Corrected by DA/Reviewer; no errors" 119 "NoRx1&2:Invalid(see Reviewer Comments)"  120 "ST DA:Missing" 121 "ST DA:Invalid Code" ///
						   122 "SourceDate:Missing" 123 "SourceDate:Invalid(future)" 124 "NFtype:Missing" 125 "NFtype:Invalid Code" 126 "NFtype:Other(invalid?)" ///
						   127 "SourceName:Missing" 128 "SourceName:Reviewed/Corrected by DA/Reviewer; no errors" 129 "SourceName:Invalid(see Reviewer Comments)" 130 "Doctor:Missing" ///
						   131 "Doctor:Reviewed/Corrected by DA/Reviewer; no errors" 132 "Doctor:Invalid(see Reviewer Comments)" 133 "DocAddr:Missing" ///
						   134 "DocAddr:Reviewed/Corrected by DA/Reviewer; no errors" 135 "DocAddr:Invalid(see Reviewer Comments)" 136 "Rec#:Missing" 137 "Rec#:Invalid Code" ///
						   138 "CFdx:Missing" 139 "CFdx:Invalid ND code" 140 "Lab#:Missing" 141 "Lab#:Invalid ND code" 142 "Specimen:Missing" ///
						   143 "Specimen:Invalid ND code" 144 "SampleDate:Invalid(future)" 145 "ReceivedDate:Invalid(future)" ///
						   146 "RptDate:Invalid(future)" 147 "Rpt Dates:Reviewed/Corrected by DA/Reviewer; no errors" 148 "Rpt Dates:Invalid(see Reviewer Comments)" ///
						   149 "ClinDets:Missing" 150 "ClinDets:Invalid ND code" 151 "CytoFinds:Missing" 152 "CytoFinds:Invalid ND code" 153 "MD:Missing" ///
						   154 "MD:Invalid ND code" 155 "ConsRpt:Missing" 156 "ConsRpt:Invalid ND code" 157 "COD:Missing" 158 "COD:Invalid ND code" ///
						   159 "COD:Invalid(lowercase)" 160 "Duration:Missing" 161 "Duration:Invalid ND code" 162 "Duration:Invalid(lowercase)" ///
						   163 "Interval:Missing" 164 "Interval:Invalid ND code" 165 "Interval:Invalid(lowercase)" 166 "Certifer:Missing" 167 "Certifier:Invalid ND code" ///
						   168 "Certifier:Invalid(lowercase)" 169 "AdmDate:Invalid(future)" 170 "DFC:Invalid(future)" 171 "RTdate:Invalid(future)" ///
						   172 "Adm,DFC,RT Dates:Reviewed/Corrected by DA/Reviewer; no errors" 173 "Adm,DFC,RT Dates:Invalid(see Reviewer Comments)" ///
							,modify
label values checkflag1 checkflag2 checkflag3 checkflag4 checkflag5 checkflag6 checkflag7 checkflag8 checkflag9 checkflag10 ///
			 checkflag11 checkflag12 checkflag13 checkflag14 checkflag15 checkflag16 checkflag17 checkflag18 checkflag19 checkflag20 ///
			 checkflag21 checkflag22 checkflag23 checkflag24 checkflag25 checkflag26 checkflag27 checkflag28 checkflag29 checkflag30 ///
			 checkflag31 checkflag32 checkflag33 checkflag34 checkflag35 checkflag36 checkflag37 checkflag38 checkflag39 checkflag40 ///
			 checkflag41 checkflag42 checkflag43 checkflag44 checkflag45 checkflag46 checkflag47 checkflag48 checkflag49 checkflag50 ///
			 checkflag51 checkflag52 checkflag53 checkflag54 checkflag55 checkflag56 checkflag57 checkflag58 checkflag59 checkflag60 ///
			 checkflag61 checkflag62 checkflag63 checkflag64 checkflag65 checkflag66 checkflag67 checkflag68 checkflag69 checkflag70 ///
			 checkflag71 checkflag72 checkflag73 checkflag74 checkflag75 checkflag76 checkflag77 checkflag78 checkflag79 checkflag80 ///
			 checkflag81 checkflag82 checkflag83 checkflag84 checkflag85 checkflag86 checkflag87 checkflag88 checkflag89 checkflag90 ///
			 checkflag91 checkflag92 checkflag93 checkflag94 checkflag95 checkflag96 checkflag97 checkflag98 checkflag99 checkflag100 ///
			 checkflag101 checkflag102 checkflag103 checkflag104 checkflag105 checkflag106 checkflag107 checkflag108 checkflag109 checkflag110 ///
			 checkflag111 checkflag112 checkflag113 checkflag114 checkflag115 checkflag116 checkflag117 checkflag118 checkflag119 checkflag120 ///
			 checkflag121 checkflag122 checkflag123 checkflag124 checkflag125 checkflag126 checkflag127 checkflag128 checkflag129 checkflag130 ///
			 checkflag131 checkflag132 checkflag133 checkflag134 checkflag135 checkflag136 checkflag137 checkflag138 checkflag139 checkflag140 ///
			 checkflag141 checkflag142 checkflag143 checkflag144 checkflag145 checkflag146 checkflag147 checkflag148 checkflag149 checkflag150 ///
			 checkflag151 checkflag152 checkflag153 checkflag154 checkflag155 checkflag156 checkflag157 checkflag158 checkflag159 checkflag160 ///
			 checkflag161 checkflag162 checkflag163 checkflag164 checkflag165 checkflag166 checkflag167 checkflag168 checkflag169 checkflag170 ///
			 checkflag171 checkflag172 checkflag173 checkflag174 checkflag175 checkflag176 checkflag177 checkflag178 checkflag179 checkflag180 checkflag_lab

** Create variable that will briefly expand on correction that has been flagged
gen reviewertxt1=""
gen reviewertxt2=""
gen reviewertxt3=""
gen reviewertxt4=""
gen reviewertxt5=""
gen reviewertxt6=""
gen reviewertxt7=""
gen reviewertxt8=""
gen reviewertxt9=""
gen reviewertxt10=""
gen reviewertxt11=""
label var reviewertxt1 "Reviewer Comments PT"
label var reviewertxt2 "Reviewer Comments TT: top"
label var reviewertxt3 "Reviewer Comments TT: morph"
label var reviewertxt4 "Reviewer Comments TT: lat-grade"
label var reviewertxt5 "Reviewer Comments TT: basis"
label var reviewertxt6 "Reviewer Comments TT: staging"
label var reviewertxt7 "Reviewer Comments TT: all others"
label var reviewertxt8 "Reviewer Comments ST: sourcename"
label var reviewertxt9 "Reviewer Comments ST: rpt dates"
label var reviewertxt10 "Reviewer Comments ST: dates"
label var reviewertxt11 "Reviewer Comments ST: all others"


*************************************************
** BLANK & INCONSISTENCY CHECKS - PATIENT TABLE
** CHECKS 1 - 46
** (1) FLAG POSSIBLE INCONSISTENCIES 
** (2) EXPORT TO EXCEL FOR CANCER TEAM TO CORRECT
*************************************************

********************** 
** Unique PatientID **
**********************
count if pid=="" //0 28jun18

** Person Search
** None needed for CF phase.

** Patient record updated by
** Auto-generated by CR5 but may be needed when assigning who last accessed record.

** Date patient record updated
** Auto-generated by CR5 but may be needed when assigning who last accessed record.

/*
** PT DA: Imported as a string so destring (contains nonumeric characters so will not destring)
** so check for nonnumeric character
generate byte non_numeric = indexnot(ptda, "0123456789.-")
list pid ptda if non_numeric
** correct the nonnumeric pid (20145017) which was incorrectly entered as a "ST" in CR5; should=09 (SAF)
replace cfda="09" if pid=="20145017"
** Now attempt destring again
destring cfda ,replace
label var cfda "PTDataAbstractor"
label define cfda_lab 01 "Coreen Smith" 18 "Abigail Robinson" 19 "Martinette Forde" 20 "Nicolette Roachford" ///
					  21 "Kimberley Hinds" 22 "Marissa Chandler" 23 "Fiona Blackett" 24 "Allison Richards", modify
label values cfda cfda_lab
*/

************************
** PT Data Abstractor **
************************
** Check 1 - missing
count if ptda=="" & cr5id=="T1S1" //0 28jun18
replace checkflag1=1 if ptda=="" & cr5id=="T1S1"

** Check 2 - nonnumeric characters in numeric field
** contains a nonnumeric character so field needs correcting!
generate byte non_numeric_ptda = indexnot(ptda, "0123456789.-")
count if non_numeric_ptda & cr5id=="T1S1" //0 28jun18
list pid ptda cr5id if non_numeric_ptda & cr5id=="T1S1"
replace checkflag2=2 if non_numeric_ptda & cr5id=="T1S1"

** Check 3 - length
count if length(ptda)<1 & cr5id=="T1S1" //0 28jun18
list pid ptda if length(ptda)<1 & cr5id=="T1S1"
replace checkflag3=3 if length(ptda)<1 & cr5id=="T1S1"

**********************
** Casefinding Date **
**********************
** Check 4 - missing
count if ptdoa==. & cr5id=="T1S1" //0 28jun18
replace checkflag4=4 if ptdoa==. & cr5id=="T1S1"
/*count if ptdoa!=stdoa & ptdoa!=d(01jan2000) & (tumourtot<2 & sourcetot<2) & (dxyr==. | dxyr>2013) //10 04jan2018
list pid eid sid ptdoa stdoa dxyr cr5id if ptdoa!=stdoa & ptdoa!=d(01jan2000) & (tumourtot<2 & sourcetot<2) & (dxyr==. | dxyr>2013)
*/

** Check 5 - invalid (future date)
** Need to create a variable with current date;
** to be used when cleaning dates
gen currentd=c(current_date)
gen double currentdatept=date(currentd, "DMY", 2017)
drop currentd
format currentdatept %dD_m_CY
label var currentdate "Current date PT"
count if ptdoa!=. & ptdoa>currentdatept //0 28jun18
replace checkflag5=5 if ptdoa!=. & ptdoa>currentdatept

*****************
** Case Status **
*****************
** Check 6 - missing
count if cstatus==. & cr5id=="T1S1" //0 28jun18
replace checkflag6=6 if cstatus==. & cr5id=="T1S1"

** Check 7 - invalid (case status=ABS but TT DA is missing)
count if cstatus==1 & ttda==. & cr5id=="T1S1" //0 28jun18
list pid cstatus ttda ttdoa dxyr cr5id if cstatus==1 & ttda==. & cr5id=="T1S1"
replace checkflag7=7 if cstatus==1 & ttda==. & cr5id=="T1S1"

** Check 8 - possibly invalid (patient record listed as duplicate)
count if cstatus==4 & cr5id=="T1S1" //0 28jun18
replace checkflag8=8 if cstatus==4 & cr5id=="T1S1"

** Check 9 - possibly invalid (patient record listed as deleted)
count if cstatus==2 & cr5id=="T1S1" //0 28jun18
replace checkflag9=9 if cstatus==2 & cr5id=="T1S1"

** Check 10 - possibly invalid (patient record listed as ineligible but tumour record status not ineligible)
count if cstatus==3 & recstatus!=3 //3 28jun18
list pid cstatus recstatus dxyr cr5id if cstatus==3 & recstatus!=3
replace checkflag10=10 if cstatus==3 & recstatus!=3

** Check 11 - invalid (record status for all tumours in a patient record=duplicate)
** Flag as checked and no corrections needed if the DA correctly assigned RecStatus=duplicate by
** checking against main CR5 db to see if the 2014 info indicates it is a true duplicate of
** already abstracted case from previous year
count if cstatus==1 & recstatus==4 & (checkflag11!=11 | checkflag12!=12 | checkflag13!=13) //21 28jun18
list pid cstatus dxyr cr5id if cstatus==1 & recstatus==4 & (checkflag11!=11 | checkflag12!=12 | checkflag13!=13)
** Once this has code has been run once and exported to excel sheet then disable the replace code below
replace checkflag11=11 if pid=="20080022" & cr5id=="T2S1" | pid=="20080166" & cr5id=="T2S1"  | pid=="20080208" & cr5id=="T2S1" | pid=="20080306" & cr5id=="T2S1" ///
						 | pid=="20080555" & cr5id=="T2S1" | pid=="20080634" | pid=="20080680" & cr5id=="T2S1" | pid=="20081036" & cr5id=="T2S1" ///
						 | pid=="20130018" & cr5id=="T2S1" | pid=="20130070" & cr5id=="T2S1" | pid=="20130151" & cr5id=="T2S1" | pid=="20130307" & cr5id!="T1S1" ///
						 | pid=="20130307" & cr5id!="T1S1" | pid=="20130357" & cr5id=="T2S1" | pid=="20130620" & (cr5id=="T2S1"|cr5id=="T3S1")
/*
replace checkflag11=11 if pid=="20080059" & cr5id=="T2S1" | pid=="20080137" & cr5id=="T2S1" | pid=="20080166" & cr5id=="T2S1" | pid=="20080482" & cr5id=="T2S1" ///
						  | pid=="20080508" & cr5id=="T2S1" | pid=="20080553" & cr5id=="T2S1" | pid=="20080555" & cr5id=="T2S1" | pid=="20080680" & cr5id=="T2S1" ///
						  | pid=="20081036" & cr5id=="T2S1" | pid=="20130009" & cr5id=="T2S1" | pid=="20130010" & cr5id=="T2S1" | pid=="20130018" & cr5id=="T2S1" ///
						  | pid=="20130044" & cr5id=="T2S1" | pid=="20130049" & cr5id=="T2S1" | pid=="20130056" & cr5id=="T2S1" | pid=="20130080" & cr5id=="T2S1" ///
						  | pid=="20130101" & cr5id=="T2S1" | pid=="20130170" & cr5id=="T2S1" | pid=="20130171" & cr5id=="T2S1" | pid=="20130175" & cr5id=="T3S1" ///
						  | pid=="20130210" & cr5id=="T2S1" | pid=="20130240" & cr5id=="T2S1" | pid=="20130247" & cr5id=="T2S1" | pid=="20130249" & cr5id=="T2S1" ///
						  | pid=="20130250" & cr5id=="T2S1" | pid=="20130252" & cr5id=="T2S1" | pid=="20130257" & cr5id=="T2S1" | pid=="20130258" & cr5id=="T2S1" ///
						  | pid=="20130260" & cr5id=="T2S1" | pid=="20130261" & cr5id=="T2S1" | pid=="20130264" & cr5id=="T2S1" | pid=="20130270" & cr5id=="T2S1" ///
						  | pid=="20130285" & cr5id=="T2S1" | pid=="20130286" & cr5id=="T2S1" | pid=="20130296" & cr5id=="T2S1" | pid=="20130300" & cr5id=="T2S1" ///
						  | pid=="20130303" & cr5id=="T2S1" | pid=="20130317" & cr5id=="T2S1" | pid=="20130338" & cr5id=="T2S1" | pid=="20130353" & cr5id=="T2S1" ///
						  | pid=="20130361" & cr5id=="T2S1" | pid=="20130372" & cr5id=="T2S1" | pid=="20130380" & cr5id=="T2S1" | pid=="20130381" & cr5id=="T2S1"
replace checkflag11=11 if pid=="20130384" & cr5id=="T2S1" | pid=="20130385" & cr5id=="T2S1" | pid=="20130388" & cr5id=="T2S1" | pid=="20130406" & cr5id=="T2S1" ///
						  | pid=="20130412" & cr5id=="T2S1" | pid=="20130508" & cr5id=="T2S1" | pid=="20130510" & cr5id=="T2S1" | pid=="20130581" & cr5id=="T2S1" ///
						  | pid=="20130583" & cr5id=="T2S1" | pid=="20130586" & cr5id=="T2S1" | pid=="20130587" & cr5id=="T2S1" | pid=="20130589" & cr5id=="T2S1" ///
						  | pid=="20130590" & cr5id=="T2S1" | pid=="20130591" & cr5id=="T2S1" | pid=="20130594" & cr5id=="T2S1" | pid=="20130596" & cr5id=="T2S1" ///
						  | pid=="20130597" & cr5id=="T2S1" | pid=="20130603" & cr5id=="T2S1" | pid=="20130616" & cr5id=="T2S1" | pid=="20130620" & cr5id=="T2S1" ///
						  | pid=="20130644" & cr5id=="T2S1" | pid=="20130661" & cr5id=="T2S1" | pid=="20130673" & cr5id=="T2S1" | pid=="20130687" & cr5id=="T2S1" ///
						  | pid=="20130702" & cr5id=="T2S1" | pid=="20130703" & cr5id=="T2S1" | pid=="20130712" & cr5id=="T2S1" | pid=="20130728" & cr5id=="T2S1" ///
						  | pid=="20130730" & cr5id=="T2S1" | pid=="20130731" & cr5id=="T2S1" | pid=="20130751" & cr5id=="T2S1" | pid=="20130752" & cr5id=="T2S1" ///
						  | pid=="20130762" & cr5id=="T2S1" | pid=="20130766" & cr5id=="T2S1" | pid=="20130768" & cr5id=="T2S1" | pid=="20130769" & cr5id=="T2S1" ///
						  | pid=="20130775" & cr5id=="T2S1" | pid=="20130778" & cr5id=="T2S1" | pid=="20130780" & cr5id=="T2S1" | pid=="20130809" & cr5id=="T2S1" ///
						  | pid=="20130861" & cr5id=="T2S1"
replace checkflag11=11 if pid=="20080022" & cr5id=="T2S1" | pid=="20080208" & cr5id=="T2S1" | pid=="20080211" & cr5id=="T2S1" | pid=="20080306" & cr5id=="T2S1" ///
						  | pid=="20080562" & cr5id=="T2S1" | pid=="20080684" & cr5id=="T2S1" | pid=="20080689" & cr5id=="T2S1" | pid=="20130025" & cr5id=="T2S1" ///
						  | pid=="20130029" & cr5id=="T2S1" | pid=="20130107" & cr5id=="T2S1" | pid=="20130169" & cr5id=="T1S1" | pid=="20130172" & cr5id=="T1S1" ///
						  | pid=="20130172" & cr5id=="T1S2" | pid=="20130174" & cr5id=="T2S1" | pid=="20130176" & cr5id=="T2S1" | pid=="20130212" & cr5id=="T2S1" ///
						  | pid=="20130241" & cr5id=="T2S1" | pid=="20130242" & cr5id=="T2S1" | pid=="20130251" & cr5id=="T2S1" | pid=="20130254" & cr5id=="T2S1" ///
						  | pid=="20130262" & cr5id=="T2S1" | pid=="20130276" & cr5id=="T2S1" | pid=="20130279" & cr5id=="T2S1" | pid=="20130293" & cr5id=="T2S1" ///
						  | pid=="20130298" & cr5id=="T2S1" | pid=="20130327" & cr5id=="T2S1" | pid=="20130328" & cr5id=="T2S1" | pid=="20130352" & cr5id=="T2S1" ///
						  | pid=="20130357" & cr5id=="T2S1" | pid=="20130386" & cr5id=="T2S1" | pid=="20130387" & cr5id=="T2S1" | pid=="20130389" & cr5id=="T2S1" ///
						  | pid=="20130582" & cr5id=="T2S1" | pid=="20130585" & cr5id=="T2S1" | pid=="20130588" & cr5id=="T2S1" | pid=="20130612" & cr5id=="T2S1" ///
						  | pid=="20130633" & cr5id=="T2S1" | pid=="20130639" & cr5id=="T2S1" | pid=="20130658" & cr5id=="T2S1" | pid=="20130663" & cr5id=="T2S1" ///
						  | pid=="20130689" & cr5id=="T2S1" | pid=="20130727" & cr5id=="T1S1" | pid=="20130747" & cr5id=="T2S1" | pid=="20130748" & cr5id=="T2S1" ///
						  | pid=="20130779" & cr5id=="T2S1" | pid=="20130819" & cr5id=="T2S1" | pid=="20130834" & cr5id=="T2S1" | pid=="20080634" & cr5id=="T1S1"
*/

** Check 12 - invalid (record status for all tumours in a patient record=duplicate)
** These are cases picked up in Check 10 which need to be reviewed by SDA and/or CD
** Once this has code has been run once and exported to excel sheet then disable the replace code below and
** add pids to replace code in Check 11 so it shows what's been reviewed by has no errors
replace checkflag12=12 if pid=="20080233" & cr5id=="T2S1" | pid=="20080307" & cr5id=="T1S1" | pid=="20130313" & cr5id=="T2S1" | pid=="20130692" & cr5id=="T2S1"
replace reviewertxt1="JC 28jun2018: pid 20080233 - T2 change record status from dup to inelig. (see previous flag KWG copied into Comments), change dxyr from 2008 to 2010." ///
		if pid=="20080233" & cr5id=="T2S1"
replace reviewertxt1="JC 28jun2018: pid 20130307 - Update T1 (e.g. staging, treatment, etc.) as this 2013 case was abstracted from CFdb but further info has become available from 2014 CF info so need to update relevant fields." ///
		if pid=="20130307" & cr5id=="T1S1"
replace reviewertxt1="JC 28jun2018: pid 20130313 - Update T1 (e.g. hx, morph, staging, treatment, etc.) as this 2013 case was abstracted from CFdb but further info has become available from 2014 CF info so need to update relevant fields." ///
		if pid=="20130313" & cr5id=="T1S1"
replace reviewertxt1="JC 28jun2018: pid 20130692 - T1 needs to be reviewed by PP as primarysite=mediastinum(C38.3) but COD=lung(C34.9)." ///
		if pid=="20130692" & cr5id=="T2S1"
/* 28jun18
replace checkflag12=12 if pid=="20080200" & (cr5id=="T2S1" | cr5id=="T3S1") | pid=="20080233" & cr5id=="T2S1" | pid=="20130307" & cr5id=="T1S1" ///
						 | pid=="20130313" & cr5id=="T2S1" | pid=="20130341" & cr5id=="T1S1" | pid=="20130692" & cr5id=="T2S1" | pid=="20130774" & cr5id=="T1S1"
replace reviewertxt1="JC 19feb2018: pid 20080200 - T1 & T2 need to be reviewed by PP as follow up of the immunohistochemistry of T3 is needed since this may indicate primary site=pancreas not breast." ///
		if pid=="20080200"
replace reviewertxt1="JC 19feb2018: pid 20080233 - T2 needs to be reviewed as T1=in-situ ca of rectosigmoid but T2=prostate ca; MasterDb (2469) Comments='Ca prostate-2010' so may not need reviewing(?)." ///
		if pid=="20080233"
*/
/* replace reviewertxt1="JC 19feb2018: pid 20080634 - Update T1 as T2 primarysite & topography has more accurate info; when merging cases please check if duplicate has more specific info that needs to be copied into original." ///
		if pid=="20080634" & cr5id=="T1S1"
replace reviewertxt1="JC 19feb2018: pid 20130248 - Update T1 laterality as this 2013 case was incorrectly abstracted as 'Right' but it should be 'Left' as indicated by T2 (and CFdb)." ///
		if pid=="20130248" & cr5id=="T2S1"
replace reviewertxt1="JC 19feb2018: pid 20130253 - Update T1 primarysite, topography (C44.5) & basis of diagnosis (7) as 2014 CF info, ABS Comments & CFdb indicate site." ///
		if pid=="20130253" & cr5id=="T1S1"
replace reviewertxt1="JC 19feb2018: pid 20130275 - T1S3 incorrectly put under T1 but S3 indicates this is a separate multiple primary." ///
		if pid=="20130275" & cr5id=="T1S3"
*/
/* 28jun18
replace reviewertxt1="JC 19feb2018: pid 20130307 - Update T1 (e.g. staging, treatment, etc.) as this 2013 case was abstracted from CFdb but further info has become available from 2014 CF info so need to update relevant fields." ///
		if pid=="20130307" & cr5id=="T1S1"
replace reviewertxt1="JC 19feb2018: pid 20130313 - Update T1 (e.g. hx, morph, staging, treatment, etc.) as this 2013 case was abstracted from CFdb but further info has become available from 2014 CF info so need to update relevant fields." ///
		if pid=="20130313" & cr5id=="T1S1"
replace reviewertxt1="JC 19feb2018: pid 20130341 - PP to review primarysite & topog (C48.1-mesentery vs C77.2-mesenteric LN) based on info in T2, T3 & CFdb(see CD of #3894).  PP to review staging once primarysite & topog determined. Update T1 treatment based on CD of T2 as this 2013 case was abstracted from CFdb but further info has become available from 2014 CF info so need to update." ///
		if pid=="20130341" & cr5id=="T1S1"
*/
/*
replace reviewertxt1="JC 19feb2018: pid 20130417 - Update T1 (e.g. treatment, etc.) as this was not done when 2013 case was abstracted but according to T2 & CFdb treatment was done." ///
		if pid=="20130417" & cr5id=="T1S1"
*/
/* 28jun18
replace reviewertxt1="JC 26feb2018: pid 20130692 - T1 needs to be reviewed by PP as primarysite=mediastinum(C38.3) but COD=lung(C34.9); Of note, clinical details of path rpt in CFdb indicates RT given." ///
		if pid=="20130692" & cr5id=="T2S1"
replace reviewertxt1="JC 19feb2018: pid 20130774 - Update T1 (e.g. treatment, etc.) as this 2013 case was abstracted from CFdb but further info has become available from 2014 CF info (T3) so need to update relevant fields." ///
		if pid=="20130774" & cr5id=="T1S1"
*/
		
** Check 13 - invalid (record status for all tumours in a patient record=duplicate)
** These are cases picked up in Check 10 whose Tumour Record Status is incorrectly assigned as dupliate
** Once this has code has been run once and exported to excel sheet then disable the replace code below
replace checkflag13=13 if pid=="20080063" & cr5id=="T2S1"
replace reviewertxt1="JC 28jun2018: pid 20080063 - T2 change Record Status from dup to inelig. T2 and T1 do not relate as T1 not referenced in COD; and ineligible term used in COD" ///
		if pid=="20080063" & cr5id=="T2S1"
/* 28jun18
replace checkflag13=13 if pid=="20080063" & cr5id=="T2S1" | pid=="20080622" & cr5id=="T2S1"
*/
/*
replace reviewertxt1="JC 19feb2018: pid 20080403 - T2 Record Status incorrect" ///
		if pid=="20080403" & cr5id=="T2S1"

replace reviewertxt1="JC 19feb2018: pid 20130162 - T2 Record Status incorrect" ///
		if pid=="20130162" & cr5id=="T2S1"
*/
/* 28jun18
replace reviewertxt1="JC 26feb2018: pid 20080063 - T2 Record Status incorrect; ineligible term used in COD" ///
		if pid=="20080063" & cr5id=="T2S1"
replace reviewertxt1="JC 26feb2018: pid 20080622 - T2 Record Status incorrect; ineligible COD" ///
		if pid=="20080622" & cr5id=="T2S1"
*/
		
** Checks 11-13 - need to repeat list once the above replacements have been done to check for new errors since list was last run
count if cstatus==1 & recstatus==4 & (checkflag11==. & checkflag12==. & checkflag13==.) //0 28jun18
list pid cstatus dxyr cr5id if cstatus==1 & recstatus==4 & (checkflag11==. & checkflag12==. & checkflag13==.)

**********************
** Retrieval Source **
**********************
** Since decision to not retrieve pt notes for upcoming years the below set of code has been
** made defunct until it is to be used at every 5th year of data collection
/*
** Check 14 - missing 
count if retsource==. & cr5id=="T1S1" //0 20feb18
replace checkflag14=14 if retsource==. & cr5id=="T1S1"

** Check 15 - invalid (retsource NOT=death rec but nf type=death rec/death certificate and sourcename=QEH)
count if retsource!=2 & (nftype==8 | nftype==9) & sourcename==1 & (dxyr==. | dxyr>2013) & recstatus<3 //4 20feb18
list pid cr5id retsource nftype recstatus dxyr if retsource!=2 & (nftype==8 | nftype==9) & sourcename==1 & (dxyr==. | dxyr>2013) & recstatus<3
replace checkflag15=15 if retsource!=2 & (nftype==8 | nftype==9) & sourcename==1 & (dxyr==. | dxyr>2013) & recstatus<3

****************
** Notes Seen **
****************
** Check 16 - missing 
count if notesseen==. & cr5id=="T1S1" //0 20feb18
replace checkflag16=16 if notesseen==. & cr5id=="T1S1"

** Check 17 - invalid (notesseen=pending ret. but casestatus=ABS)
count if notesseen==0 & cstatus==1 & cr5id=="T1S1" //1 20feb18
list pid cr5id notesseen cstatus dxyr if notesseen==0 & cstatus==1 & cr5id=="T1S1"
replace checkflag17=17 if notesseen==0 & cstatus==1 & cr5id=="T1S1"

*********************
** Notes Seen Date **
*********************
** Check 18 - missing 
count if nsdate==. & cr5id=="T1S1" & (notesseen==1 | notesseen==2) //6 20feb18
list pid cr5id notesseen nsdate dxyr if nsdate==. & cr5id=="T1S1" & (notesseen==1 | notesseen==2)
replace checkflag18=18 if nsdate==. & cr5id=="T1S1" & (notesseen==1 | notesseen==2)

** Check 19 - invalid (notesseen=No/Cannot be retrieved but nsdate is not blank)
count if cr5id=="T1S1" & (nsdate!=. & nsdate!=d(01jan2000)) & (notesseen>2 | notesseen==0) //3 20feb18
list pid cr5id notesseen nsdate dxyr if cr5id=="T1S1" & (nsdate!=. & nsdate!=d(01jan2000)) & (notesseen>2 | notesseen==0)
replace checkflag19=19 if cr5id=="T1S1" & (nsdate!=. & nsdate!=d(01jan2000)) & (notesseen>2 | notesseen==0)

** Check 20 - invalid (future date)
count if nsdate!=. & nsdate>currentdatept //0 26feb18
replace checkflag20=20 if nsdate!=. & nsdate>currentdatept

******************************
** Further Retrieval Source **
******************************
** Check 21 - missing 
count if fretsource==. & notesseen==2 & cr5id=="T1S1" //0 20feb18
replace checkflag21=21 if retsource==. & notesseen==2 & cr5id=="T1S1"

** Check 22 - invalid (notesseen=fur ret. and furretsource NOT=death rec but nf type=death rec/death certificate and sourcename=QEH)
count if fretsource!=2 & notesseen==2 & (nftype==8 | nftype==9) & sourcename==1 & (dxyr==. | dxyr>2013) & recstatus<3 //0 20feb18
list pid cr5id fretsource nftype recstatus dxyr if fretsource!=2 & notesseen==2 & (nftype==8 | nftype==9) & sourcename==1 & (dxyr==. | dxyr>2013) & recstatus<3
replace checkflag22=22 if fretsource!=2 & notesseen==2 & (nftype==8 | nftype==9) & sourcename==1 & (dxyr==. | dxyr>2013) & recstatus<3
*/


********************************
** First, Middle & Last Names **
********************************
** Check 23 - missing
count if fname=="" & cr5id=="T1S1" //0 28jun18
replace checkflag23=23 if fname=="" & cr5id=="T1S1"

** Check 24 - missing 
count if init=="" & cr5id=="T1S1" //0 28jun18
replace checkflag24=24 if init=="" & cr5id=="T1S1"

** Check 25 - missing 
count if lname=="" & cr5id=="T1S1" //0 28jun18
replace checkflag25=25 if lname=="" & cr5id=="T1S1"

*******************
** Date of Birth **
*******************
** Check 26 - missing (use birthdate var as partial dates are dropped when dob was formatted to a date var)
count if birthdate==. & primarysite!="" &  cr5id=="T1S1" //0 28jun18
list pid dobyear dobmonth dobday if birthdate==. & primarysite!="" &  cr5id=="T1S1"
replace checkflag26=26 if birthdate==. & primarysite!=""

** Check 27 - missing but full NRN available
gen nrnday = substr(natregno,5,2)
count if dob==. & natregno!="" & natregno!="9999999999" & natregno!="999999-9999" & nrnday!="99" //0 28jun18
list pid cr5id dob natregno cstatus recstatus dxyr if dob==. & natregno!="" & natregno!="9999999999" & natregno!="999999-9999" & nrnday!="99"
replace checkflag27=27 if dob==. & natregno!="" & natregno!="9999999999" & natregno!="999999-9999" & nrnday!="99"

** Check 28 - invalid (dob has future year)
gen dob_yr = year(dob)
count if dob!=. & dob_yr>2014 //0 28jun18
list pid dob dob_yr if dob!=. & dob_yr>2014
replace checkflag28=28 if dob!=. & dob_yr>2014

** Check 29 - invalid (dob does not match natregno)
gen dob_year = year(dob) if natregno!="" & natregno!="9999999999" & natregno!="999999-9999" & nrnday!="99" & length(natregno)==11
gen yr1=.
replace yr1 = 20 if dob_year>1999
replace yr1 = 19 if dob_year<2000
replace yr1 = 19 if dob_year==.
replace yr1 = 99 if natregno=="99"
list pid dob_year dob natregno yr yr1 if dob_year!=. & dob_year > 1999
gen nrn = substr(natregno,1,6) if natregno!="" & natregno!="9999999999" & natregno!="999999-9999" & nrnday!="99" & length(natregno)==11
destring nrn, replace
format nrn %06.0f
nsplit nrn, digits(2 2 2) gen(year month day)
format year month day %02.0f
tostring yr1, replace
gen year2 = string(year,"%02.0f")
gen nrnyr = substr(yr1,1,2) + substr(year2,1,2)
destring nrnyr, replace
sort nrn
gen dobchk=mdy(month, day, nrnyr)
format dobchk %dD_m_CY
count if dob!=dobchk & dobchk!=. //1 28jun18
list pid age natregno dob dobchk dob_year if dob!=dobchk & dobchk!=.
replace checkflag29=29 if dob!=dobchk
drop day month year nrnyr yr yr1 nrn


***********************
** National Reg. No. **
***********************
sort pid
** Check 30 - missing 
count if natregno=="" & dob!=. //0 28jun18
list pid cr5id dob natregno cstatus recstatus dxyr if natregno=="" & dob!=.
replace checkflag30=30 if natregno=="" & dob!=.

** Check 31 - invalid length
count if length(natregno)<11 & natregno!="" & cr5id=="T1S1" //0 28jun18
list pid natregno if length(natregno)<11 & natregno!="" & cr5id=="T1S1"
replace checkflag31=31 if length(natregno)<11 & natregno!="" & cr5id=="T1S1"

*********
** Sex **
*********
** Check 32 - missing
count if sex==. //0 28jun18
replace checkflag32=32 if sex==.

** Check 33 - possibly invalid (first name, NRN and sex check: MALES)
gen nrnid=substr(natregno, -4,4)
count if cr5id=="T1S1" & sex==2 & nrnid!="9999" & regex(substr(natregno,-2,1), "[1,3,5,7,9]") //3 28jun18
list pid fname lname sex natregno cr5id if cr5id=="T1S1" & sex==2 & nrnid!="9999" & regex(substr(natregno,-2,1), "[1,3,5,7,9]")
replace checkflag33=33 if cr5id=="T1S1" & sex==2 & nrnid!="9999" & regex(substr(natregno,-2,1), "[1,3,5,7,9]")

** Check 34 - possibly invalid (sex=M; site=breast)
count if cr5id=="T1S1" & sex==1 & (regexm(cr5cod, "BREAST") | regexm(top, "^50")) //7 28jun18
list pid fname lname natregno sex top cr5cod cr5id if cr5id=="T1S1" & sex==1 & (regexm(cr5cod, "BREAST") | regexm(top, "^50"))
replace checkflag34=34 if cr5id=="T1S1" & sex==1 & (regexm(cr5cod, "BREAST") | regexm(top, "^50"))

** Check 35 - invalid (sex=M; site=FGS)
count if cr5id=="T1S1" & sex==1 & topcat>43 & topcat<52	& (regexm(cr5cod, "VULVA") | regexm(cr5cod, "VAGINA") | regexm(cr5cod, "CERVIX") | regexm(cr5cod, "CERVICAL") ///
								| regexm(cr5cod, "UTER") | regexm(cr5cod, "OVAR") | regexm(cr5cod, "PLACENTA")) //0 28jun18
list pid fname lname natregno sex top cr5cod cr5id if cr5id=="T1S1" & sex==1 & topcat>43 & topcat<52 & (regexm(cr5cod, "VULVA") | regexm(cr5cod, "VAGINA") ///
								| regexm(cr5cod, "CERVIX") | regexm(cr5cod, "CERVICAL") | regexm(cr5cod, "UTER") | regexm(cr5cod, "OVAR") | regexm(cr5cod, "PLACENTA"))
replace checkflag35=35 if cr5id=="T1S1" & sex==1 & topcat>43 & topcat<52 & (regexm(cr5cod, "VULVA") | regexm(cr5cod, "VAGINA") | regexm(cr5cod, "CERVIX") ///
								| regexm(cr5cod, "CERVICAL") | regexm(cr5cod, "UTER") | regexm(cr5cod, "OVAR") | regexm(cr5cod, "PLACENTA"))
								
** Check 36 - possibly invalid (first name, NRN and sex check: FEMALES)
count if cr5id=="T1S1" & sex==1 & nrnid!="9999" & regex(substr(natregno,-2,1), "[0,2,4,6,8]") //4 28jun18
list pid fname lname sex natregno cr5id if cr5id=="T1S1" & sex==1 & nrnid!="9999" & regex(substr(natregno,-2,1), "[0,2,4,6,8]")
replace checkflag36=36 if cr5id=="T1S1" & sex==1 & nrnid!="9999" & regex(substr(natregno,-2,1), "[0,2,4,6,8]")

** Check 37 - invalid (sex=F; site=MGS)
count if cr5id=="T1S1" & sex==2 & topcat>51 & topcat<56 & (regexm(cr5cod, "PENIS")|regexm(cr5cod, "PROSTAT")|regexm(cr5cod, "TESTIS")|regexm(cr5cod, "TESTIC")) //0 28jun18
list pid fname lname natregno sex top cr5cod cr5id if cr5id=="T1S1" & sex==2 & topcat>51 & topcat<56 & (regexm(cr5cod, "PENIS")|regexm(cr5cod, "PROSTAT") ///
													  |regexm(cr5cod, "TESTIS")|regexm(cr5cod, "TESTIC"))
replace checkflag37=37 if cr5id=="T1S1" & sex==2 & topcat>51 & topcat<56 & (regexm(cr5cod, "PENIS")|regexm(cr5cod, "PROSTAT")|regexm(cr5cod, "TESTIS") ///
						  |regexm(cr5cod, "TESTIC"))												  

*********************
** Hospital Number **
*********************
** Check 38 - missing
count if hospnum=="" & retsource<8 & cr5id=="T1S1" //0 28jun18
list pid hospnum retsource cr5id if hospnum=="" & retsource<8 & cr5id=="T1S1"
replace checkflag38=38 if hospnum=="" & retsource<8 & cr5id=="T1S1"

*********************
** Resident Status **
*********************
** Check 39 - missing
count if resident==. & cr5id=="T1S1" //0 28jun18
list pid resident cr5id if resident==. & cr5id=="T1S1"
replace checkflag39=39 if resident==. & cr5id=="T1S1"

*************************
** Status Last Contact **
*************************
** Check 40 - missing
count if slc==. & cstatus==1 & cr5id=="T1S1" //0 28jun18
list pid slc cr5id if slc==. & cstatus==1 & cr5id=="T1S1"
replace checkflag40=40 if slc==. & cstatus==1 & cr5id=="T1S1"

** Check 41 - invalid (slc=died;dlc=blank)
count if slc==2 & dlc==. & cr5id=="T1S1" //0 28jun18
list pid slc dlc cr5id if slc==2 & dlc==. & cr5id=="T1S1"
replace checkflag41=41 if slc==2 & dlc==. & cr5id=="T1S1"

** Check 42 - invalid (slc=alive;dlc=blank)
count if slc==1 & dlc==. & cr5id=="T1S1" //0 28jun18
** JC 26feb18: there was one case (20090061) but MasterDb had the dlc (ID 622) so
** changed it in main CR5 and noted this in Comments field
replace checkflag42=42 if slc==1 & dlc==. & cr5id=="T1S1"

** Check 43 - invalid (slc=alive;nftype=death info)
count if slc==1 & (nftype==8 | nftype==9) //1 28jun18
list pid slc nftype cr5id if slc==1 & (nftype==8 | nftype==9)
replace checkflag43=43 if slc==1 & (nftype==8 | nftype==9)

***********************
** Date Last Contact **
***********************
** Check 44 - missing
count if dlc==. & cstatus==1 & cr5id=="T1S1" //0 28jun18
list pid slc dlc cr5id if dlc==. & cstatus==1 & cr5id=="T1S1"
** JC 26feb18: there were 5 cases so changed it in main CR5 and noted this in Comments field
** (20080179) but used unk day & month for this (MasterDb ID 3410)
** (20080359) but electronic death data had dlc (deathid 389)
** (20080609) but electronic death data had dlc (X0000021A/2010)
** (20080664) but used unk day & month for this (Comments & MasterDb ID 596)
** (20081106) but used unk day for this (Comments & MasterDb ID 492)
replace checkflag44=44 if dlc==. & cstatus==1 & cr5id=="T1S1"

** Check 45 - invalid (future date)
** Use already created variable called 'currentdatept';
** to be used when cleaning dates
count if dlc!=. & dlc>currentdatept //0 28jun18
replace checkflag45=45 if dlc!=. & dlc>currentdatept

**************
** Comments **
**************
** Check 46 - missing
count if comments=="" & cstatus==1 & cr5id=="T1S1" //0 28jun18
list pid cstatus comments cr5id if comments=="" & cstatus==1 & cr5id=="T1S1"
** JC 26feb18: there were 5 cases whose comments didn't import into Stata as they all
** end with " in main CR5 comments field so changed it in main CR5 by adding a full stop
** 20080056, 20080083, 20080358, 20080600 & 20090006
replace checkflag46=46 if comments=="" & cstatus==1 & cr5id=="T1S1"

** Crate a variable that contains the # of characters in the 'Comments' variable
gen countvar = wordcount(comments)

*****************
** PT Reviewer **
*****************
** No checks on this field as review process changed from originally planned


**********************************************************
** BLANK & INCONSISTENCY CHECKS - TUMOUR TABLE
** CHECKS 47 - 119
** (1) FLAG POSSIBLE INCONSISTENCIES 
** (2) EXPORT TO EXCEL FOR CANCER TEAM TO CORRECT
**********************************************************

*********************
** Unique TumourID **
*********************
count if eid=="" //0 28jun18

**********************
** TT Record Status **
**********************
** This is auto-generated by CR5 while simultaneously allowing for manual input so
** there will never be any records with missing recstatus

** Check 47 - invalid (recstatus=pending;dxyr<2014) - CHANGE WHEN RUNNING 2014 DATA!!
count if recstatus==0 & dxyr!=. & dxyr<2014 //128 28jun18
list pid dxyr cr5id if recstatus==0 & dxyr!=. & dxyr<2014
replace checkflag47=47 if recstatus==0 & dxyr!=. & dxyr<2014

** Check 48 - invalid(cstatus=CF;recstatus<>Pending) - CHANGE WHEN RUNNING 2014 DATA!!
count if recstatus!=0 & cstatus==0 & ttdoa!=. & dxyr<2014 //2 28jun18 - 20080365 T1&T2 <2014 but T3=2015 so don't include in checkflag for version02
list pid cstatus recstatus dxyr ttdoa cr5id if recstatus!=0 & cstatus==0 & ttdoa!=. & dxyr<2014
replace checkflag48=48 if recstatus!=0 & cstatus==0 & ttdoa!=. & pid!="20080365"
/*replace reviewertxt2="JC 26feb2018: pid 20080704 - since T2 ineligible then CaseStatus=ABS not CF as no eligible tumuors pending abstraction" ///
		if pid=="20080704" & cr5id=="T2S1" 
*/

** Check 49 - possibly invalid (tumour record listed as deleted)
count if recstatus==2 //0 28jun18
replace checkflag49=49 if recstatus==2

** REVIEW ALL dxyr>2013 CASES FLAGGED AS INELIGIBLE SINCE SOME DISCOVERED IN 2014 AS INELIGIBLE WHICH ARE ELIGIBLE FOR REGISTRATION
** Points to note: (1) reason for ineligibility should be recorded by DA in Comments field; (2) dxyr should be updated with correct year.
count if recstatus==3 & dxyr>2013 //0 28jun18
list pid cr5id dxyr ttda recstatus if recstatus==3 & dxyr>2013


** IMPORTANT: Since batch corrections (i.e. exporting CR5 data, importing data into excel, updating in excel, then reimporting to main CR5 - see latcheckcat 11) 
** resulted in the 'Record Status' being reset to 'Pending' for cases where the CR5 check had an invalid result (mostly happened with ineligible cases) so
** create a list of all cases where comments=ineligible and rec status=Pending for 2014 cases
list pid cr5id recstatus if (regexm(comments, "ineligible")|regexm(comments, "Ineligible")|regexm(comments, "INELIGIBLE")) & recstatus==0 & dxyr==2014


*********************
** TT Check Status **
*********************
** This is auto-generated by CR5 while simultaneously allowing for manual input so
** there will never be any records with missing recstatus

** Check 50 - invalid (checkstatus=notdone;recstatus=pend/confirm;primarysite<>blank)
count if checkstatus==0 & recstatus<2 & primarysite!="" //4 28jun18
list pid dxyr checkstatus recstatus cr5id if checkstatus==0 & recstatus<2 & primarysite!=""
replace checkflag50=50 if checkstatus==0 & recstatus<2 & primarysite!=""

** Check 51 - invalid (checkstatus=invalid;recstatus=pend/confirm;primarysite<>blank)
count if checkstatus==3 & recstatus<2 & primarysite!="" //2 28jun18
list pid dxyr checkstatus recstatus cr5id if checkstatus==3 & recstatus<2 & primarysite!=""
replace checkflag51=51 if checkstatus==3 & recstatus<2 & primarysite!=""

** MP Sequence
** Auto-generated by CR5 but may be need later on.

** MP Total
** Auto-generated by CR5 but may be need later on.

** Tumour record updated by
** Auto-generated by CR5 but may be needed when assigning who last accessed record.

** Date tumour record updated
** Auto-generated by CR5 but may be needed when assigning who last accessed record.

************************
** TT Data Abstractor **
************************
** Check 52 - missing
count if ttda==. & primarysite!="" //0 28jun18
replace checkflag52=52 if ttda==. & primarysite!=""

** Length check not needed as this field is numeric
** Check 53 - invalid code
count if ttda!=. & ttda>13 & (ttda!=22 & ttda!=88 & ttda!=98 & ttda!=99) //0 28jun18
list pid ttda cr5id if ttda!=. & ttda>13 & (ttda!=22 & ttda!=88 & ttda!=98 & ttda!=99)
replace checkflag53=53 if ttda!=. & ttda>13 & (ttda!=22 & ttda!=88 & ttda!=98 & ttda!=99)

**********************
** Abstraction Date **
**********************
** Check 54 - missing
count if ttdoa==. & primarysite!="" //0 28jun18
replace checkflag54=54 if ttdoa==. & primarysite!=""
/*count if ptdoa!=stdoa & ptdoa!=d(01jan2000) & (tumourtot<2 & sourcetot<2) & (dxyr==. | dxyr>2013) //10 04jan2018
list pid eid sid ptdoa stdoa dxyr cr5id if ptdoa!=stdoa & ptdoa!=d(01jan2000) & (tumourtot<2 & sourcetot<2) & (dxyr==. | dxyr>2013)
*/

** Check 55 - invalid (future date)
gen currentd=c(current_date)
gen double currentdatett=date(currentd, "DMY", 2017)
drop currentd
format currentdatett %dD_m_CY
label var currentdatett "Current date TT"
count if ttdoa!=. & ttdoa>currentdatett //0 28jun18
replace checkflag55=55 if ttdoa!=. & ttdoa>currentdatett

************
** Parish **
************
** Check 56 - missing
count if parish==. & addr!="" //0 28jun18
list pid parish addr cr5id if parish==. & addr!=""
replace checkflag56=56 if parish==. & addr!=""

*************
** Address **
*************
** Check 57 - missing
count if addr=="" & parish!=. & cstatus!=0 & cr5id=="T1S1" //0 28jun18
list pid parish addr sourcename cr5id if addr=="" & parish!=. & cstatus!=0 & cr5id=="T1S1"
replace checkflag57=57 if addr=="" & parish!=. & cstatus!=0 & cr5id=="T1S1"
** JC 26feb18: there was one case whose address didn't import into Stata as it
** ends with " in main CR5 address field so changed it in main CR5 by adding a full stop
** 20090024

**********	
**	Age **
**********
** Check 58 - missing
count if (age==-1 | age==.) & dot!=. //0 28jun18
replace checkflag58=58 if (age==-1 | age==.) & dot!=.

** Check 59 - invalid (age<>incidencedate-dob); checked no errors
** Age (at INCIDENCE - to nearest year)
gen ageyrs = (dot - dob)/365.25 //
gen checkage=int(ageyrs)
drop ageyrs
label var checkage "Age in years at INCIDENCE"
count if dob!=. & dot!=. & age!=checkage //2 28jun18 - these correct according to CR5 as same day & month for dob & dot
count if (dobday!=dotday & dobmonth!=dotmonth) & dob!=. & dot!=. & age!=checkage //0 28jun18
list pid dotday dobday dotmonth dobmonth if (dobday!=dotday & dobmonth!=dotmonth) & dob!=. & dot!=. & age!=checkage
list pid dot dob dotday dobday dotmonth dobmonth age checkage cr5id if dob!=. & dot!=. & age!=checkage
replace checkflag59=59 if (dobday!=dotday & dobmonth!=dotmonth) & dob!=. & dot!=. & age!=checkage & checkflag59!=59
/*
** Flag as checked and no corrections needed if the DA correctly assigned age by
** checking against main CR5 db
** Once this has code has been run once and exported to excel sheet then disable the replace code below
replace checkflag59=59 if pid=="20080036" & cr5id=="T1S1" | pid=="20080358" & cr5id=="T1S1"

** Check 60 - invalid (age<>incidencedate-dob); need to repeat list once the above replacements have been done to check for new errors since list was last run
count if dob!=. & dot!=. & age!=checkage & checkflag59!=59 //0 26feb18
list pid dot dob age checkage cr5id if dob!=. & dot!=. & age!=checkage & checkflag59!=59
replace checkflag60=60 if dob!=. & dot!=. & age!=checkage & checkflag59!=59
*/

******************
** Primary Site **
******************
** Check 61 - missing
count if primarysite=="" & topography!=. //0 28jun18
list pid primarysite topography cr5id if primarysite=="" & topography!=.
replace checkflag61=61 if primarysite=="" & topography!=.

** Checks 62 & 63 - invalid(primarysite<>top); Review done visually via lists (checkflag 63) below and specific checks created (topcheckcat). 
** Check 62=Reviewed/Corrected by DA/Reviewer; no errors
** Check 63=Invalid (primarysite<>top) generated via topcheckcat
** First, flag errors and assign as checkflag 63 then
** flag rest of cases as checkflag 62 (no errors)
** When running this code on 2014 abstractions then need to use Checkflag63 lists that is after the topcheckcat (scroll down)

** Check 62 - invalid (primarysite<>top); checked no errors
/* old code below prior to creation of topcheckcat
replace checkflag62=62 if pid=="20080634" & cr5id=="T1S2" | pid=="" & cr5id==""
*/

** Check 63 - invalid(primarysite<>top)
** Used category created in 1_prep_cancer.do for this check but
** will need to update when the below list code is re-run to ensure all possible
** errors are checked
sort topography pid
count if topcheckcat!=. //44 28jun18
list pid primarysite topography cr5id if topcheckcat!=.

** NEED TO CHANGE IN MAIN CR5: (JC changed these on 28feb18) 
** PRIMARYSITE FOR 2 CASES (20080217 & 20080222) AS THESE SHOULD=RECTOSIGMOID; 
** 20080218 PRIMARYSITE=OVERLAPPING LESION OF DESCENDING & SIGMOID COLON;
** 20080634 T2 PRIMSITE=OVERLAPPING LESION OF STOMACH...; Didn't update on Main CR5 as another flag for this case in Check 12; Changed by JC 05mar18.
** 20080684 T1 PRIMSITE=OVERLAPPING LESION OF PHARYNX...; (Had to change up primarysite as limited character length of 50 for this field)

list pid primarysite topography cr5id if ///
		regexm(primarysite, "LIP") & !(strmatch(strupper(primarysite), "*SKIN*")|strmatch(strupper(primarysite), "*CERVIX*")) & (topography>9&topography!=148) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==8 ///
		| regexm(primarysite, "TONGUE") & (topography<19|topography>29) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==28 ///
		| regexm(primarysite, "GUM") & (topography<30|topography>39) & !(strmatch(strupper(primarysite), "*SKIN*")) ///
		| regexm(primarysite, "MOUTH") & (topography<40|topography>69) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==48 ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==58 ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==68 ///
		| regexm(primarysite, "GLAND") & (topography<79|topography>89) & !(strmatch(strupper(primarysite), "*MINOR*")|strmatch(strupper(primarysite), "*PROSTATE*")|strmatch(strupper(primarysite), "*THYROID*")|strmatch(strupper(primarysite), "*PINEAL*")|strmatch(strupper(primarysite), "*PITUITARY*")) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==88 ///
		| regexm(primarysite, "TONSIL") & (topography<90|topography>99) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==98 ///
		| regexm(primarysite, "OROPHARYNX") & (topography<100|topography>109) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==108 ///
		| regexm(primarysite, "NASOPHARYNX") & (topography<110|topography>119) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==118 ///
		| regexm(primarysite, "PYRIFORM") & (topography!=129&topography!=148) ///
		| regexm(primarysite, "HYPOPHARYNX") & (topography<130|topography>139) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==138 ///
		| (regexm(primarysite, "PHARYNX") & regexm(primarysite, "OVERLAP")) & (topography!=140&topography!=148) ///		
		| regexm(primarysite, "WALDEYER") & topography!=142 ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==148 ///
		| regexm(primarysite, "PHAGUS") & !(strmatch(strupper(primarysite), "*JUNCT*")) & (topography<150|topography>159) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==158 ///
		| (regexm(primarysite, "GASTR") | regexm(primarysite, "STOMACH")) & !(strmatch(strupper(primarysite), "*GASTROINTESTINAL*")|strmatch(strupper(primarysite), "*ABDOMEN*")) & (topography<160|topography>169) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==168 ///
		| (regexm(primarysite, "NUM") | regexm(primarysite, "SMALL")) & !(strmatch(strupper(primarysite), "*STERNUM*")|strmatch(strupper(primarysite), "*MEDIA*")|strmatch(strupper(primarysite), "*POSITION*")) & (topography<170|topography>179) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==178 ///
		| regexm(primarysite, "COLON") & !(strmatch(strupper(primarysite), "*RECT*")) & (topography<180|topography>189) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==188 ///
		| regexm(primarysite, "RECTO") & topography!=199 ///
		| regexm(primarysite, "RECTUM") & !(strmatch(strupper(primarysite), "*AN*")) & topography!=209 ///
		| regexm(primarysite, "ANUS") & !(strmatch(strupper(primarysite), "*RECT*")) & (topography<210|topography>212) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")|strmatch(strupper(primarysite), "*RECT*")|strmatch(strupper(primarysite), "*AN*")|strmatch(strupper(primarysite), "*JUNCT*")) & topography==218 ///
		| (regexm(primarysite, "LIVER")|regexm(primarysite, "HEPTO")) & !(strmatch(strupper(primarysite), "*GLAND*")) & (topography<220|topography>221) ///
		| regexm(primarysite, "GALL") & topography!=239 ///
		| (regexm(primarysite, "BILI")|regexm(primarysite, "VATER")) & !(strmatch(strupper(primarysite), "*INTRAHEP*")) & (topography<240|topography>241&topography!=249) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==248 ///
		| regexm(primarysite, "PANCREA") & !(strmatch(strupper(primarysite), "*ABDOMEN*")) & (topography<250|topography>259) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==258 ///
		| (regexm(primarysite, "BOWEL") | regexm(primarysite, "INTESTIN")) & !(strmatch(strupper(primarysite), "*SMALL*")|strmatch(strupper(primarysite), "*GASTRO*")) & (topography!=260|topography!=269) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==268 ///
		| regexm(primarysite, "NASAL") & !(strmatch(strupper(primarysite), "*SIN*")) & topography!=300 ///
		| regexm(primarysite, "EAR") & !(strmatch(strupper(primarysite), "*SKIN*")) & topography!=301 ///
		| regexm(primarysite, "SINUS") & !(strmatch(strupper(primarysite), "*INTRA*")|strmatch(strupper(primarysite), "*PHARYN*")) & (topography<310|topography>319) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==318 ///
		| (regexm(primarysite, "GLOTT") | regexm(primarysite, "CORD")) & !(strmatch(strupper(primarysite), "*TRANS*")|strmatch(strupper(primarysite), "*CNS*")) & (topography<320|topography>329) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==328 ///
		| regexm(primarysite, "TRACH") & topography!=339 ///
		| (regexm(primarysite, "LUNG") | regexm(primarysite, "BRONCH")) & (topography<340|topography>349) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==348 ///
		| regexm(primarysite, "THYMUS") & topography!=379 
** NEED TO CHANGE IN MAIN CR5: (JC changed these on 28feb18)
** 20080699 PRIMARYSITE=BONE MARROW;
** 20090039 PRIMARYSITE=BONE MARROW;
** 20090054 PRIMARYSITE=BONE MARROW;
** 20090068 PRIMARYSITE=BONE MARROW;
** 20070004 PRIMARYSITE=OVERLAPPING LESION...;
** 20080001	PRIMARYSITE=OVERLAPPING LESION BREAST - UPPER CENTRAL;
** 20080018 PRIMARYSITE=OVERLAPPING LESION...;
** 20080053 PRIMARYSITE=OVERLAPPING LESION...;
** 20080057 TOPOGRAPHY CHANGED TO 509;
** 20080058 PRIMARYSITE=OVERLAPPING LESION...;
** 20080061 PRIMARYSITE=OVERLAPPING LESION...;
** 20080062 TOPOGRAPHY CHANGED TO 509;
** 20080067 PRIMARYSITE=OVERLAPPING LESION...;
** 20080119 PRIMARYSITE=OVERLAPPING LESION...;
** 20080125 PRIMARYSITE=OVERLAPPING LESION...;
** 20080127 PRIMARYSITE=OVERLAPPING LESION...;
** 20080152 PRIMARYSITE=OVERLAPPING LESION...;
** 20080161 PRIMARYSITE=OVERLAPPING LESION...;
** 20080165 PRIMARYSITE=OVERLAPPING LESION...;
** 20080169 PRIMARYSITE=OVERLAPPING LESION...;
** 20080173 PRIMARYSITE=OVERLAPPING LESION...;
** 20080175 PRIMARYSITE=OVERLAPPING LESION...;
** 20080187 TOPOGRAPHY CHANGED TO 509;
** 20080190 PRIMARYSITE=OVERLAPPING LESION...;
** 20080192 PRIMARYSITE=OVERLAPPING LESION...;
** 20080200 PRIMARYSITE=OVERLAPPING LESION...;
** 20080204 TOPOGRAPHY CHANGED TO 509;
** 20080516 PRIMARYSITE=OVERLAPPING LESION...;
** 20080955 PRIMARYSITE=OVERLAPPING LESION...;
** 20081056 PRIMARYSITE=OVERLAPPING LESION...;
** 20090004 PRIMARYSITE=OVERLAPPING LESION...;
** 20090010 PRIMARYSITE=OVERLAPPING LESION...;
** 20090015 PRIMARYSITE=OVERLAPPING LESION...;
** 20090034 PRIMARYSITE=OVERLAPPING LESION...;
** 20080141 PRIMARYSITE=TESTIS (JC 28feb18: removed scrotum);
** 20080686 PRIMARYSITE=KIDNEY (JC 28feb18: removed renal);
** 20080078 PRIMARYSITE=OVERLAPPING LESION...;
** 20090038 PRIMARYSITE=OVERLAPPING LESION...; - 28jun18 JC: not needed as no overlap code in ICD-O-3 for meninges
** 20130181 PRIMARYSITE=OVERLAPPING LESION...;
sort topography pid
list pid ttda primarysite topography cr5id if ///
		(regexm(primarysite, "HEART")|regexm(primarysite, "CARD")|regexm(primarysite, "STINUM")|regexm(primarysite, "PLEURA")) & !(strmatch(strupper(primarysite), "*GASTR*")|strmatch(strupper(primarysite), "*STOMACH*")) & (topography<380|topography>384) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==388 ///
		| regexm(primarysite, "RESP") & topography!=390 ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==398 ///
		| regexm(primarysite, "RESP") & topography!=399 ///
		| regexm(primarysite, "BONE") & !(strmatch(strupper(primarysite), "*MARROW*")) & (topography<400|topography>419) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==408 ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==418 ///
		| regexm(primarysite, "BLOOD") & !(strmatch(strupper(primarysite), "*MARROW*")) & topography!=420 ///
		| regexm(primarysite, "MARROW") & topography!=421 ///
		| regexm(primarysite, "SPLEEN") & topography!=422 ///
		| regexm(primarysite, "RETICU") & topography!=423 ///
		| regexm(primarysite, "POIETIC") & topography!=424 ///
		| regexm(primarysite, "SKIN") & (topography<440|topography>449) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==448 ///
		| regexm(primarysite, "NERV") & (topography<470|topography>479) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==478 ///
		| regexm(primarysite, "PERITON") & !(strmatch(strupper(primarysite), "*NODE*")) & (topography<480|topography>482) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==488 ///
		| regexm(primarysite, "TISSUE") & (topography<490|topography>499) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==498 ///
		| regexm(primarysite, "BREAST") & !(strmatch(strupper(primarysite), "*SKIN*")) & (topography<500|topography>509) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==508 ///
		| regexm(primarysite, "VULVA") & (topography<510|topography>519) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==518 ///
		| regexm(primarysite, "VAGINA") & topography!=529 ///
		| regexm(primarysite, "CERVIX") & (topography<530|topography>539) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==538 ///
		| (regexm(primarysite, "UTERI")|regexm(primarysite, "METRIUM")) & !(strmatch(strupper(primarysite), "*CERVIX*")|strmatch(strupper(primarysite), "*UTERINE*")|strmatch(strupper(primarysite), "*OVARY*")) & (topography<540|topography>549) ///
		| regexm(primarysite, "UTERINE") & !(strmatch(strupper(primarysite), "*CERVIX*")|strmatch(strupper(primarysite), "*CORPUS*")) & topography!=559 ///
		| regexm(primarysite, "OVARY") & topography!=569 ///
		| (regexm(primarysite, "FALLOPIAN")|regexm(primarysite, "LIGAMENT")|regexm(primarysite, "ADNEXA")|regexm(primarysite, "FEMALE")) & (topography<570|topography>579) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==578 ///
		| regexm(primarysite, "PLACENTA") & topography!=589 ///
		| (regexm(primarysite, "PENIS")|regexm(primarysite, "FORESKIN")) & (topography<600|topography>609) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==608 ///
		| regexm(primarysite, "PROSTATE") & topography!=619 ///
		| regexm(primarysite, "TESTIS") & (topography<620|topography>629) ///
		| (regexm(primarysite, "EPI")|regexm(primarysite, "SPERM")|regexm(primarysite, "SCROT")|regexm(primarysite, "MALE")) & !(strmatch(strupper(primarysite), "*FEMALE*")) & (topography<630|topography>639) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==638 ///
		| regexm(primarysite, "KIDNEY") & topography!=649 ///
		| regexm(primarysite, "RENAL") & topography!=659 ///
		| regexm(primarysite, "URETER") & !(strmatch(strupper(primarysite), "*BLADDER*")) & topography!=669 ///
		| regexm(primarysite, "BLADDER") & !(strmatch(strupper(primarysite), "*GALL*")) & (topography<670|topography>679) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==678 ///
		| (regexm(primarysite, "URETHRA")|regexm(primarysite, "URINARY")) & !(strmatch(strupper(primarysite), "*BLADDER*")) & (topography<680|topography>689) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==688 ///
		| (regexm(primarysite, "EYE")|regexm(primarysite, "RETINA")|regexm(primarysite, "CORNEA")|regexm(primarysite, "LACRIMAL")|regexm(primarysite, "CILIARY")|regexm(primarysite, "CHOROID")|regexm(primarysite, "ORBIT")|regexm(primarysite, "CONJUNCTIVA")) & !(strmatch(strupper(primarysite), "*SKIN*")) & (topography<690|topography>699) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==698 ///
		| regexm(primarysite, "MENINGE") & (topography<700|topography>709) ///
		| regexm(primarysite, "BRAIN") & !strmatch(strupper(primarysite), "*MENINGE*") & (topography<710|topography>719) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==718 ///
		| (regexm(primarysite, "SPIN")|regexm(primarysite, "CAUDA")|regexm(primarysite, "NERV")) & (topography<720|topography>729) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==728 ///
		| regexm(primarysite, "THYROID") & topography!=739 ///
		| regexm(primarysite, "ADRENAL") & (topography<740|topography>749)
list pid ttda primarysite topography cr5id if ///
		(regexm(primarysite, "PARATHYROID")|regexm(primarysite, "PITUITARY")|regexm(primarysite, "CRANIOPHARYNGEAL")|regexm(primarysite, "CAROTID")|regexm(primarysite, "ENDOCRINE")) & (topography<750|topography>759) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==758 ///
		| (regexm(primarysite, "NOS")|regexm(primarysite, "DEFINED")) & !(strmatch(strupper(primarysite), "*SKIN*")|strmatch(strupper(primarysite), "*NOSE*")|strmatch(strupper(primarysite), "*NOSTRIL*")|strmatch(strupper(primarysite), "*STOMACH*")|strmatch(strupper(primarysite), "*GENITAL*")|strmatch(strupper(primarysite), "*PENIS*")) & (topography<760|topography>767) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==768 ////
		| regexm(primarysite, "NODE") & (topography<770|topography>779) ///
		| !(strmatch(strupper(primarysite), "*OVERLAP*")) & topography==778 ///
		| regexm(primarysite, "UNKNOWN") & topography!=809
		
** Add checkflag to corrections to be done
replace checkflag63=63 if topcheckcat!=. & checkflag62!=62 //44 28jun18
		
** Add reviewer comments to those that need to be corrected
** 48 changes made on 46 pids
/*replace reviewertxt2="JC 27feb2018: pid 20080634 - Update T2's primary site to: OVERLAP-STOMACH INVOLV. BODY,PYLORIC AN." ///
		if pid=="20080634" & (cr5id=="T2S1"|cr5id=="T2S2")
** JC changed directly in main CR5 on 05mar18.	
*/
replace reviewertxt2="JC 27feb2018: pid 20130074 - Update T1's primary site to: OVERLAP-LARYNX TRANSGLOTTIS." ///
		if pid=="20130074" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20130226 - Update T1's primary site to: OVERLAP-STOMACH GREATER CURVATURE&POST.WALL." ///
		if pid=="20130226" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20130260 - Update T1's primary site to: OVERLAP-PALATE JUNCTION OF HARD&SOFT." ///
		if pid=="20130260" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20130261 - Update T1's primary site & topography to: EPIGLOTTIS; C32.1 as CR5 Comments indicate 'Large tumour replacing epiglottis. Tumour extends to left tongue base. Tumour also extends inferiorly to left aryepiglottic fold.' Staging still correct as regional by dir ext." ///
		if pid=="20130261" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20130549 - Update T1's primary site to: OVERLAP-LUNG UPPER,MIDDLE,LOWER LOBES." ///
		if pid=="20130549" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20080780 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20080780" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20080797 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20080797" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20080835 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20080835" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20080857 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20080857" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20080880 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20080880" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20080891 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20080891" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20080925 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20080925" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20080928 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20080928" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20090061 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20090061" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20130071 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20130071" & cr5id=="T1S1"	
replace reviewertxt2="JC 27feb2018: pid 20130179 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20130179" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20130349 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20130349" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20130373 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20130373" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20130544 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20130544" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20081049 - Update T1's primary site to: HEMATOPOIETIC SYSTEM." ///
		if pid=="20081049" & cr5id=="T1S1"
replace reviewertxt2="JC 27feb2018: pid 20081050 - Update T1's primary site to: HEMATOPOIETIC SYSTEM." ///
		if pid=="20081050" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130015 - Update T1's primary site & topography to: BREAST - UO QUADRANT; C50.4 as Comments indicate: mass in lower aspect of UO left quadrant." ///
		if pid=="20130015" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130033 - Update T1's primary site to: OVERLAP BREAST-LOWER R&L QUADRANTS." ///
		if pid=="20130033" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130035 - Update T1's primary site to: OVERLAP BREAST-MIDLINE." ///
		if pid=="20130035" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130038 - Update T1's primary site to: OVERLAP BREAST-3 O CLOCK." ///
		if pid=="20130038" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130040 - Update T1's primary site to: OVERLAP BREAST-6 O CLOCK." ///
		if pid=="20130040" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130044 - Update T1's primary site to: OVERLAP BREAST-MIDLINE." ///
		if pid=="20130044" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130123 - Update T1's primary site to: OVERLAP BREAST-MIDLINE." ///
		if pid=="20130123" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130136 - Update T1's primary site to: OVERLAP BREAST-MIDLINE." ///
		if pid=="20130136" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130246 - Update T1's primary site to: OVERLAP BREAST-MIDLINE." ///
		if pid=="20130246" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130248 - Update T1's primary site to: OVERLAP BREAST-MIDLINE." ///
		if pid=="20130248" & (cr5id=="T1S1"|cr5id=="T1S2")
replace reviewertxt2="JC 28feb2018: pid 20130331 - Update T1's primary site to: OVERLAP BREAST-6 O CLOCK." ///
		if pid=="20130331" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130334 - Update T1's primary site to: OVERLAP BREAST-LOWER POLE." ///
		if pid=="20130334" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130359 - Update T1's primary site to: OVERLAP BREAST-UPPER." ///
		if pid=="20130359" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130361 - Update T1's primary site to: OVERLAP BREAST-3 O'CLOCK; Previously stated as CENTRAL but Comments indicate: Thickened area right breast at 3 o'clock position." ///
		if pid=="20130361" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130374 - Update T1's primary site to: OVERLAP BREAST-UPPER." ///
		if pid=="20130374" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130661 - Update T1's primary site to: OVERLAP BREAST-RUQ." ///
		if pid=="20130661" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130672 - Update T1's primary site to: OVERLAP BREAST-MEDIAL/INNER." ///
		if pid=="20130672" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20081000 - Update T1's primary site & topography to: OVERLAP FGS-CERVIX&ENDOMETRIUM and C57.8; Previously stated as ENDOMETRIUM and FGS NOS C57.9 but path rpt shows both cx bx & endo asp. had carcinoma." ///
		if pid=="20081000" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20080874 - Update T1's primary site to: OVERLAP FGS-ENDOMETRIUM,OVARY." ///
		if pid=="20080874" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130714 - Update T1's primary site & topography to: OVERLAP FGS-OVARY/UTERUS and C57.8." ///
		if pid=="20130714" & cr5id=="T1S1"
		
/* below if POST-2013		
replace reviewertxt2="JC 27feb2018: pid 20130162 - Update T2's primary site to: OVERLAP-STOMACH POSTERIOR WALL." ///
		if pid=="20130162" & cr5id=="T2S1"
replace reviewertxt2="JC 27feb2018: pid 20130291 - Update T1's primary site to: BONE MARROW." ///
		if pid=="20130291" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130818 - Update T1's primary site to: OVERLAP BREAST-LT OUTER QUADRANT." ///
		if pid=="20130818" & cr5id=="T1S1"
replace reviewertxt2="JC 28feb2018: pid 20130769 - Update T1's primary site to: OVERLAP LYMPH NODES-INGUINAL & PARA-AORTIC." ///
		if pid=="20130769" & cr5id=="T1S1"
*/		
/*
      +---------------------------------------------------+
      |      pid   ttda    primarysite   topogr~y   cr5id |
      |---------------------------------------------------|
1047. | 20080780    SAF          BLOOD        421    T1S1 |
1066. | 20080797    SAF          BLOOD        421    T1S1 |
1104. | 20080835    SAF          BLOOD        421    T1S1 |
1125. | 20080857    SAF          BLOOD        421    T1S1 |
      |---------------------------------------------------|
1148. | 20080880    SAF          BLOOD        421    T1S1 |
1159. | 20080891    SAF          BLOOD        421    T1S1 |
1193. | 20080925    SAF          BLOOD        421    T1S1 |
1196. | 20080928    SAF          BLOOD        421    T1S1 |
1321. | 20081049    SAF         BLOOD         424    T1S1 |
      |---------------------------------------------------|
1322. | 20081050    SAF          BLOOD        424    T1S1 |
1479. | 20090061    SAF          BLOOD        421    T1S1 |
      |---------------------------------------------------|
1604. | 20130071    SAF          BLOOD        421    T1S1 |
1741. | 20130179    SAF   BONE MARRROW        421    T1S1 |
1905. | 20130291    SAF          BLOOD        421    T1S1 |
1986. | 20130349    SAF           BONE        421    T1S1 |
2019. | 20130373    SAF          BLOOD        421    T1S1 |
      |---------------------------------------------------|
2149. | 20130544    KWG          BLOOD        421    T1S1 |
      +---------------------------------------------------+
      +-------------------------------------------------------------------------------------------+
      |      pid     ttda                                          primarysite   topogr~y   cr5id |
      |-------------------------------------------------------------------------------------------|
1530. | 20130015      SAF                                              BREAST         508    T1S1 |
1558. | 20130033      SAF                      BREAST - LOWER RT & LT QUADRANT        508    T1S1 |
1560. | 20130035      SAF                                     BREAST - MIDLINE        508    T1S1 |
1564. | 20130038      SAF                                   BREAST - 3 O CLOCK        508    T1S1 |
1566. | 20130040      SAF                                   BREAST - 6 O CLOCK        508    T1S1 |
      |-------------------------------------------------------------------------------------------|
1571. | 20130044      SAF                                     BREAST - MIDLINE        508    T1S1 |
1664. | 20130123      SAF                                     BREAST - MIDLINE        508    T1S1 |
1679. | 20130136      SAF                                     BREAST - MIDLINE        508    T1S1 |
      |-------------------------------------------------------------------------------------------|
1825. | 20130246      SAF                                     BREAST - MIDLINE        508    T1S1 |
1830. | 20130248      SAF                                      BREAST - MEDIAL        508    T1S2 |
1831. | 20130248      SAF                                      BREAST - MEDIAL        508    T1S1 |
1963. | 20130331      SAF                                   BREAST - 6 O CLOCK        508    T1S1 |
      |-------------------------------------------------------------------------------------------|
1966. | 20130334      SAF                                  BREAST - LOWER POLE        508    T1S1 |
2001. | 20130359      SAF                                       BREAST - UPPER        508    T1S1 |
2004. | 20130361      SAF                                     BREAST - CENTRAL        508    T1S1 |
      |-------------------------------------------------------------------------------------------|
2020. | 20130374      SAF                                       BREAST - OUTER        508    T1S1 |
2301. | 20130661      KWG                                         BREAST - RUQ        508    T1S1 |
2313. | 20130672      KWG                           MEDIAL BREAST/INNER BREAST        508    T1S1 |
2499. | 20130818      KWG                         BREAST - LEFT OUTER QUADRANT        508    T1S1 |
      +-------------------------------------------------------------------------------------------+
1739. | 20081000    SAF                       ENDOMETRIUM        559    T1S1 |
1767. | 20080874    SAF                ENDOMETRIUM, OVARY        578    T1S1 |
1768. | 20130714    KWG                      OVARY/UTERUS        579    T1S1 |
      +----------------------------------------------------------------------+
      +---------------------------------------------------------------------------+
      |      pid   ttda                            primarysite   topogr~y   cr5id |
      |---------------------------------------------------------------------------|
2342. | 20130769    KWG   LYMPH NODES - INGUINAL & PARA-AORTIC        778    T1S1 |
      +---------------------------------------------------------------------------+

*/		

** Check 62 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag62=62 if checkflag63!=63


****************
** Topography **
****************
** Check 64 - missing
count if topography==. & primarysite!=""  //0 28jun18
list pid primarysite topography cr5id if topography==. & primarysite!=""
replace checkflag64=64 if topography==. & primarysite!=""

** Check 65 - length
** Need to change all top=="." to top==""
replace top="" if top=="." //0 changes made 28jun18
count if top!="" & length(top)!=3 //0 28jun18
list pid top topography cr5id if top!="" & length(top)!=3
replace checkflag65=65 if top!="" & length(top)!=3

** No other checks needed as covered in primarysite checks 62 & 63


****************************
** Histology & Morphology **
****************************
** Check 66 - Histology missing
count if (hx==""|hx=="99"|hx=="9999"|regexm(hx, "UNK")) & morph!=. //0 28jun18
list pid hx morph cr5id if (hx==""|hx=="99"|hx=="9999"|regexm(hx, "UNK")) & morph!=.
** NEED TO CHANGE IN MAIN CR5: (JC changed these on 01mar18)
** 20060001 T1: HX=CANCER;(previously 99)
** 20080259 T1: HX=ADVANCED CANCER;(previously 99)
** 20080476 T1: HX=SQUAMOUS CELL CARCINOMA;(previously 9999)
** 20080498 T1: HX=CIN 2-3;(previously 9999)
replace checkflag66=66 if (hx==""|hx=="99"|hx=="9999"|regexm(hx, "UNK")) & morph!=.

** Check 67 - Morphology missing
count if (morph==.|morph==99|morph==9999) & hx!="" //0 28jun18
list pid hx morph cr5id if (morph==.|morph==99|morph==9999) & hx!=""
replace checkflag67=67 if (morph==.|morph==99|morph==9999) & hx!=""

** Check 68 - Morphology length
** Need to create string variable for morphology
gen morphology=morph
tostring morphology, replace
** Need to change all morphology=="." to morphology==""
replace morphology="" if morphology=="." //134 changes made 28jun18
count if morphology!="" & length(morphology)!=4 //0 28jun18
list pid morphology morph cr5id if morphology!="" & length(morphology)!=4
replace checkflag68=68 if morphology!="" & length(morphology)!=4

		
** Checks 69 & 70 - invalid (hx vs beh); Review done visually via lists below. 
** Check 69=Reviewed/Corrected by DA/Reviewer; no errors
** Check 70=Invalid (hx vs beh) generated via below lists
** First, flag errors and assign as checkflag 70 then
** flag rest of cases as checkflag 69 (no errors)

** Check 69 - possibly invalid (hx vs beh); Reviewed/Corrected by DA/Reviewer; no errors
sort pid
/* old code prior to new method of flagging ones that do not have errors based on lists generated & checked
count if (beh==2|beh==3) & !(strmatch(strupper(hx), "*MALIG*")|strmatch(strupper(hx), "*CANCER*")|strmatch(strupper(hx), "*OMA*") ///
		 |strmatch(strupper(hx), "*SUSPICIOUS*")|strmatch(strupper(hx), "*CIN*")|strmatch(strupper(hx), "*LEU*")|strmatch(strupper(hx), "*META*") ///
		 |strmatch(strupper(hx), "*INVAS*")|strmatch(strupper(hx), "*CARC*")) //56 01mar18
list pid hx beh cr5id if (beh==2|beh==3) & !(strmatch(strupper(hx), "*MALIG*")|strmatch(strupper(hx), "*CANCER*")|strmatch(strupper(hx), "*OMA*") ///
						 |strmatch(strupper(hx), "*SUSPICIOUS*")|strmatch(strupper(hx), "*CIN*")|strmatch(strupper(hx), "*LEU*")|strmatch(strupper(hx), "*META*") ///
						 |strmatch(strupper(hx), "*INVAS*")|strmatch(strupper(hx), "*CARC*"))
replace checkflag69=69 if pid=="20080153" & cr5id=="T1S1" | pid=="20080223" & cr5id=="T1S1" | pid=="20080512" & cr5id=="T1S1" | pid=="20080566" & cr5id=="T1S1" ///
						 | pid=="20080569" & cr5id=="T1S1" | pid=="20080636" & cr5id=="T1S1" | pid=="20080640" & cr5id=="T1S1" | pid=="20080651" & cr5id=="T1S1" ///
						 | pid=="20080698" & (cr5id=="T1S1"|cr5id=="T2S1") | pid=="20080710" & cr5id=="T1S1" | pid=="20080747" & cr5id=="T3S1" ///
						 | pid=="20080753" & cr5id=="T1S1" | pid=="20080800" & cr5id=="T1S1" | pid=="20080847" & cr5id=="T1S1" | pid=="20080851" & (cr5id=="T1S1"|cr5id=="T2S1") ///
						 | pid=="20080870" & cr5id=="T1S1" | pid=="20081047" & cr5id=="T1S1" | pid=="20081105" & cr5id=="T1S1" | pid=="20090046" & cr5id=="T1S1" ///
						 | pid=="20090047" & cr5id=="T1S1" | pid=="20090048" & cr5id=="T1S1" | pid=="20090049" & cr5id=="T1S1" | pid=="20090050" & cr5id=="T1S1" ///
						 | pid=="20090056" & (cr5id=="T1S1"|cr5id=="T1S2") | pid=="20090061" & cr5id=="T1S1" | pid=="20100005" & cr5id=="T2S1" ///
						 | pid=="20130034" & cr5id=="T1S1" | pid=="20130071" & cr5id=="T1S1" | pid=="20130072" & cr5id=="T1S1" | pid=="20130084" & cr5id=="T1S1" ///
						 | pid=="20130091" & (cr5id=="T1S1"|cr5id=="T1S2") | pid=="20130110" & cr5id=="T1S1" | pid=="20130502" & cr5id=="T1S1" ///
						 | pid=="20130504" & cr5id=="T1S1" | pid=="20130550" & cr5id=="T1S1" | pid=="20130569" & cr5id=="T1S1" | pid=="20130748" & cr5id=="T1S1"
*/

** Check 70 - possibly invalid (hx vs beh)
** NEED TO CHANGE IN MAIN CR5: (JC changed these on 01mar18)
** 20080641 T1: RecStatus=3 (ineligbile); (previously recstatus=1 confirmed but hx is not a reportable cancer dx)
** 20090040 T1: HX=METASTATIC COLON CANCER/POLYPOID TUMOUR (previously only POLYPOID TUMOUR)	
** Add reviewer comments to those that need to be corrected
count if (beh==2|beh==3) & !(strmatch(strupper(hx), "*MALIG*")|strmatch(strupper(hx), "*CANCER*")|strmatch(strupper(hx), "*OMA*") ///
		 |strmatch(strupper(hx), "*SUSPICIOUS*")|strmatch(strupper(hx), "*CIN*")|strmatch(strupper(hx), "*LEU*")|strmatch(strupper(hx), "*META*") ///
		 |strmatch(strupper(hx), "*INVAS*")|strmatch(strupper(hx), "*CARC*")|strmatch(strupper(hx), "*HIGH GRADE*")|strmatch(strupper(hx), "*ESSENTIAL*") ///
		 |strmatch(strupper(hx), "*KLATSKIN*")|strmatch(strupper(hx), "*MYELODYSPLAS*")|strmatch(strupper(hx), "*MYELOPROLIFER*") ///
		 |strmatch(strupper(hx), "*CHRONIC IDIOPATHIC*")|strmatch(strupper(hx), "*BOWEN*")|strmatch(strupper(hx), "*POLYCYTHEMIA*") ///
		 |strmatch(strupper(hx), "*WILMS*")|strmatch(strupper(hx), "*MULLERIAN*")|strmatch(strupper(hx), "*YOLK*")|strmatch(strupper(hx), "*REFRACTORY*") ///
		 |strmatch(strupper(hx), "*ACUTE MYELOID*")|strmatch(strupper(hx), "*PAGET*")|strmatch(strupper(hx), "*PLASMA CELL*") ///
		 |strmatch(strupper(hx), "*PIN III*")|strmatch(strupper(hx), "*NEUROENDOCRINE*")|strmatch(strupper(hx), "*TERATOID/RHABOID*") ///
		 |strmatch(strupper(hx), "*INTRA-EPITHELIAL NEOPLASIA*")) & hx!="CLL" & hx!="PIN" & hx!="HGCGIN /  AIS" //8 04jul18
list pid hx beh cr5id if (beh==2|beh==3) & !(strmatch(strupper(hx), "*MALIG*")|strmatch(strupper(hx), "*CANCER*")|strmatch(strupper(hx), "*OMA*") ///
						 |strmatch(strupper(hx), "*SUSPICIOUS*")|strmatch(strupper(hx), "*CIN*")|strmatch(strupper(hx), "*LEU*")|strmatch(strupper(hx), "*META*") ///
						 |strmatch(strupper(hx), "*INVAS*")|strmatch(strupper(hx), "*CARC*")|strmatch(strupper(hx), "*HIGH GRADE*") ///
						 |strmatch(strupper(hx), "*ESSENTIAL*")|strmatch(strupper(hx), "*KLATSKIN*")|strmatch(strupper(hx), "*MYELODYSPLAS*") ///
						 |strmatch(strupper(hx), "*MYELOPROLIFER*")|strmatch(strupper(hx), "*CHRONIC IDIOPATHIC*")|strmatch(strupper(hx), "*BOWEN*") ///
						 |strmatch(strupper(hx), "*POLYCYTHEMIA*")|strmatch(strupper(hx), "*WILMS*")|strmatch(strupper(hx), "*MULLERIAN*") ///
						 |strmatch(strupper(hx), "*YOLK*")|strmatch(strupper(hx), "*REFRACTORY*")|strmatch(strupper(hx), "*ACUTE MYELOID*") ///
						 |strmatch(strupper(hx), "*PAGET*")|strmatch(strupper(hx), "*PLASMA CELL*")|strmatch(strupper(hx), "*PIN III*") ///
						 |strmatch(strupper(hx), "*NEUROENDOCRINE*")|strmatch(strupper(hx), "*TERATOID/RHABOID*") ///
						 |strmatch(strupper(hx), "*INTRA-EPITHELIAL NEOPLASIA*")) & hx!="CLL" & hx!="PIN" & hx!="HGCGIN /  AIS"
						 
replace checkflag70=70 if pid=="20080895" & cr5id=="T1S1" | pid=="20080903" & cr5id=="T1S1" | pid=="20080908" & cr5id=="T1S1" | pid=="20080935" & cr5id=="T1S1" ///
						  | pid=="20081062" & cr5id=="T1S1" | pid=="20130224" & cr5id=="T1S1" | pid=="20130526" & cr5id=="T1S1"
replace reviewertxt3="JC 01mar2018: pid 20080895 - Update T1's beh to: 1. No path rpt and COD doesn't specify if COD is malignant/benign." ///
		if pid=="20080895" & cr5id=="T1S1"
replace reviewertxt3="JC 01mar2018: pid 20080903 - Update T1's beh to: 1. No path rpt and COD doesn't specify if COD is malignant/benign." ///
		if pid=="20080903" & cr5id=="T1S1"
replace reviewertxt3="JC 01mar2018: pid 20080908 - Update T1's beh to: 1. No path rpt and COD doesn't specify if COD is malignant/benign." ///
		if pid=="20080908" & cr5id=="T1S1"
replace reviewertxt3="JC 01mar2018: pid 20080935 - Update T1's beh to: 1. No path rpt and COD doesn't specify if COD is malignant/benign." ///
		if pid=="20080935" & cr5id=="T1S1"
replace reviewertxt3="JC 01mar2018: pid 20081062 - Update T1's beh to: 2. Path rpt MD indicates no invasion and Comments in MasterDb ID 1040 has 'Review with PP' but outcome of review not stated." ///
		if pid=="20081062" & cr5id=="T1S1"
replace reviewertxt3="JC 01mar2018: pid 20130224 - Update T1's beh to: 1. No path rpt and COD doesn't specify if COD is malignant/benign." ///
		if pid=="20130224" & cr5id=="T1S1"
replace reviewertxt3="JC 01mar2018: pid 20130526 - Update T1's beh to: 1. No path rpt and COD doesn't specify if COD is malignant/benign." ///
		if pid=="20130526" & cr5id=="T1S1"
/* 04jul18
replace reviewertxt3="JC 01mar2018: pid 20130688 - Update T1's hx to: METASTATIC NEUROENDOCRINE TUMOUR. RT reg in MasterDb ID 1108 indicates this tumour is malignant so best to qualify hx if not the tumour as is would be a beh code of 1 (uncertain benign/malignant)." ///
		if pid=="20130688" & cr5id=="T1S1"
pid=20081105 T1S1 is correctly assigned as beh=2 so not included in above reviewertxt field.
*/
** Check 69 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag69=69 if checkflag70!=70

		
** Checks 71 & 72 - invalid (morph vs basis); Review done visually via list below. 
** Check 71=Reviewed/Corrected by DA/Reviewer; no errors
** Check 72=Invalid (morph vs basis) generated
** First, flag errors and assign as checkflag 72 then
** flag rest of cases as checkflag 71 (no errors)
** When running this code on 2014 abstractions then need to use list below
	
** Check 71 - invalid (morph vs basis); Reviewed/Corrected by DA/Reviewer; no errors

/* old code prior to new method of flagging ones that do not have errors based on lists generated & checked
count if morph==8000 & (basis==6|basis==7|basis==8) //15 01mar18
list pid hx basis cr5id if morph==8000 & (basis==6|basis==7|basis==8)
** NEED TO CHANGE IN MAIN CR5: (JC changed these on 28feb18)
** 20080728 T3: BASIS=1 (previously basis=7 but no path rpt to support this basis and hx indicates clinical)
replace checkflag71=71 if pid=="20080005" & cr5id=="T1S1" | pid=="20080565" & (cr5id=="T1S1"|cr5id=="T1S2") | pid=="2008728" & cr5id=="T3S1" ///
						 | pid=="20130389" & (cr5id=="T1S1"|cr5id=="T1S2")
*/
replace checkflag71=71 if pid=="20080005" & cr5id=="T1S1" | pid=="20080565" & (cr5id=="T1S1"|cr5id=="T1S2") | pid=="20130389" & (cr5id=="T1S1"|cr5id=="T1S2")

** Check 72 - invalid (morph vs basis)
** Add reviewer comments to those that need to be corrected
count if morph==8000 & (basis==6|basis==7|basis==8)
list pid hx basis cr5id if morph==8000 & (basis==6|basis==7|basis==8)

replace checkflag72=72 if pid=="20130083" & cr5id=="T1S1" | pid=="20130344" & cr5id=="T1S1" | pid=="20130353" & (cr5id=="T1S1"|cr5id=="T1S2") 

/* 04jul18
replace reviewertxt3="JC 28feb2018: pid 20080795 - Update T1's basis of dx to: 5. No path rpt in MasterDb or Comments to indicate hx of primary as basis." ///
		if pid=="20080795" & cr5id=="T1S1"		
replace reviewertxt3="JC 28feb2018: pid 20080897 - Update T1's morphology to: M8010." ///
		if pid=="20080897" & cr5id=="T1S1"
replace reviewertxt3="JC 28feb2018: pid 20081125 - Update T1's histology & morphology to: TRANSITIONAL CELL CARCINOMA and M8120; MasterDb ID 3997 indicates TCC in MD which can use as no Dx available once PP has ok'd it." ///
		if pid=="20081125" & cr5id=="T1S1"
replace reviewertxt3="JC 28feb2018: pid 20130167 - Update T1's morphology to: M8010; MasterDb ID 1584 indicates carcinoma." ///
		if pid=="20130167" & cr5id=="T1S1"
replace reviewertxt3="JC 28feb2018: pid 20130330 - Update T1's basis of dx to: 9. No path rpt in MasterDb or Comments to indicate hx of primary as basis; only a BVH admission." ///
		if pid=="20130330" & cr5id=="T1S1"
*/
replace reviewertxt3="JC 28feb2018: pid 20130083 - Update T1's histology & morphology to: ACINAR ADENOCARCINOMA and M8550; MasterDb ID 2596 indicates in MD & Cons.Rpt that differential is acinar adenoca & acinar proliferation-awiting IHC to confirm; IHC confirms prostatic malignancy; Confirm with PP." ///
		if pid=="20130083" & cr5id=="T1S1"
replace reviewertxt3="JC 28feb2018: pid 20130344 - Update T1's primarysite, topography & morphology to: PROSTATE, C61.9 and M8010; MasterDb ID 3979 indicates in Dx, MD & Cons.Rpt that thigh mass is most likely met ca of prostate; Confirm with PP." ///
		if pid=="20130344" & cr5id=="T1S1"
replace reviewertxt3="JC 28feb2018: pid 20130353 - Update T1's morphology to: M8010; hx=carcinoma." ///
		if pid=="20130353" & cr5id=="T1S1"

** Check 71 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag71=71 if checkflag72!=72

	
** Checks 73 & 74 - invalid (hx<>morph); Review done visually via lists (CATS 1-55) below and specific checks created (morphcheckcat). 
** Check 73=Reviewed/Corrected by DA/Reviewer; no errors
** Check 74=Invalid (hx<>morph) generated via morphcheckcat
** First, flag errors and assign as checkflag 74 then
** flag rest of cases as checkflag 73 (no errors)
** When running this code on 2014 abstractions then need to use CATS 1-55 lists that are after the morphcheckcat (scroll down)

** Check 74 - invalid(hx<>morph)
** NEED TO CHANGE IN MAIN CR5: (JC changed these on 28feb18)
** 20080152 T1: HX=INTRADUCTAL PAPILLOMATOSIS; MORPH=8505 (not in CR5 dictionary!); BEH=0 (previously M8000 & beh=3)
** 20080214 T1: BEH=0; RECSTATUS=3 (previously beh=3; recstatus=1)
** 20080536 T2: HX=SQUAMOUS CELL CARCINOMA; MORPH=8070 (previously CARCINOMA & M8000)
** 20080730 T3: BEH=1; (previously beh=3)
** 20080728 T1: HX=BASAL CELL CARCINOMA; MORPH=8090 (previously CARCINOMA & M8000; removed 'CLINICAL' from Hx)
** 20090069 T1: HX=ADENOCARCINOMA; MORPH=8140(previously CARCINOMA & M8000)
** 20080601 T2: Changed directly in main CR5 from M8076 to M8070 as 8076 used for microinvasive only.

****CHECK CATS1-5 LISTS THEN PRINT BELOW LISTS (ATS6-9 & 10-55) THEN CHECK THAT HX, MORPH & BASIS CORRECTLY MATCH EACH OTHER:
****THOSE THAT DON'T MATCH NEED TO (DO THIS FIRST BELOW NEXT LINE OF CODE) 
** Below are records changed directly in CR5 by JC on 08mar18 and were found, not via specific checks,
** but via visual checking lists (CATS1-5;CATS6-9;CATS10-55)

** Add reviewer comments to those that need to be corrected
replace checkflag74=74 if pid=="20130698" & cr5id=="T1S1" | pid=="20130299" & cr5id=="T1S1" | pid=="20130629" & cr5id=="T1S1" | pid=="20130204" & cr5id=="T1S1" ///
						  | pid=="20130354" & cr5id=="T1S1" | pid=="20130212" & cr5id=="T1S1" | pid=="20080886" & cr5id=="T1S1" ///
						  | pid=="20130001" & (cr5id=="T1S1"|cr5id=="T1S2") | pid=="20130013" & cr5id=="T1S1" | pid=="20130056" & cr5id=="T1S1" ///
						  | pid=="20080874" & cr5id=="T1S1" | pid=="20130591" & cr5id=="T1S1" | pid=="20130699" & cr5id=="T1S1" | pid=="20130402" & cr5id=="T1S1" ///
						  | pid=="20130598" & cr5id=="T1S1" | pid=="20130620" & cr5id=="T1S1" | pid=="20130641" & cr5id=="T1S1" ///
						  | pid=="20130248" & (cr5id=="T1S1"|cr5id=="T1S2") | pid=="20130053" & cr5id=="T1S1" | pid=="20081031" & cr5id=="T1S1" ///
						  | pid=="20130363" & cr5id=="T1S1" | pid=="20130293" & cr5id=="T1S1" | pid=="20130321" & cr5id=="T1S1" | pid=="20081046" & cr5id=="T1S1" ///
						  | pid=="20130052" & cr5id=="T1S1" | pid=="20130173" & cr5id=="T1S1" | pid=="20130770" & cr5id=="T1S1" | pid=="20130349" & cr5id=="T1S1" ///
						  | pid=="20081066" & cr5id=="T1S1" | pid=="20130091" & (cr5id=="T1S1"|cr5id=="T1S2") | pid=="20081047" & cr5id=="T1S1"
replace reviewertxt3="JC 07mar2018: pid 20080698 - Update T1's morph to: M8500 - invasive mammary ca same as invasive ductal ca." ///
		if pid=="20080698" & cr5id=="T1S1"
replace reviewertxt3="JC 07mar2018: pid 20130299 - Update T1's hx & morph to: ADENOCARCINOMA and M8140 - see path rpt in MasterDb ID 4009." ///
		if pid=="20130299" & cr5id=="T1S1"
replace reviewertxt3="JC 07mar2018: pid 20130662 - Update T1's morph to: M8503 - see online updated ICD-O-3 which includes intracystic with invasion in M8503/3." ///
		if pid=="20130662" & cr5id=="T1S1"
replace reviewertxt3="JC 07mar2018: pid 20130629 - Update T1's morph to: M8318 - see ICD-O-3 book for reference." ///
		if pid=="20130629" & cr5id=="T1S1"
replace reviewertxt3="JC 07mar2018: pid 20130204 - Update T1's beh & morph to: 2(in-situ) and M8077 - Check with PP what 'margin involvement' means in CIN 3 re morph and beh; Although mentions gland involvement that still is staged as in-situ so M8076 may not be correct." ///
		if pid=="20130204" & cr5id=="T1S1"
replace reviewertxt3="JC 07mar2018: pid 20130354 - Update T1's beh & morph to: 2(in-situ) and M8077 - Check with PP what 'margin involved' means in CIN 3 re morph and beh; Although mentions gland involvement that still is staged as in-situ so M8076 may not be correct." ///
		if pid=="20130354" & cr5id=="T1S1"
replace reviewertxt3="JC 07mar2018: pid 20130212 - Update T1's hx to: MICROINVASIVE SQUAMOUS CELL CARCINOMA." ///
		if pid=="20130212" & cr5id=="T1S1"
replace reviewertxt3="JC 13mar2018: pid 20080886 - Update T1's behaviour, record status and comments to: 0(benign), 3(ineligible) & 'Ineligible due to behaviour & case definition'." ///
		if pid=="20080886" & cr5id=="T1S1"
replace reviewertxt3="JC 13mar2018: pid 20130001 - Query T1's morph to: M8263? - Please confirm with PP if villoglandular and tubulovillous are synonymous." ///
		if pid=="20130001" & (cr5id=="T1S1"|cr5id=="T1S2")
replace reviewertxt3="JC 13mar2018: pid 20130013 - Query T1's morph to: M8263? - Please confirm with PP if villoglandular and tubulovillous are synonymous." ///
		if pid=="20130013" & cr5id=="T1S1"
replace reviewertxt3="JC 13mar2018: pid 20130056 - Query T1's morph to: M8263? - Please confirm with PP if villoglandular and tubulovillous are synonymous." ///
		if pid=="20130056" & cr5id=="T1S1"
replace reviewertxt3="JC 13mar2018: pid 20130519 - Query T1's hx & morph to: TUBULOVILLOUS ADENOMA WITH HIGH GRADE DYSPLASIA and M8263/3 - Pls confirm with PP morphology in light of hx & beh & COD (see MasterDb path rpt & death 3780 & 2956)." ///
		if pid=="20130519" & cr5id=="T1S1"
replace reviewertxt3="JC 13mar2018: pid 20080874 - Update T1's hx to: ENDOMETRIOID (replace this with ENDOMETRIAL)." ///
		if pid=="20080874" & cr5id=="T1S1"
replace reviewertxt3="JC 13mar2018: pid 20130591 - Update T1's morph to: M8010 (M8380 is used for a specific term: endometrioid)." ///
		if pid=="20130591" & cr5id=="T1S1"
replace reviewertxt3="JC 13mar2018: pid 20130699 - Update T1's hx to: ENDOMETRIOID (replace this with ENDOMETRIAL)." ///
		if pid=="20130699" & cr5id=="T1S1"
replace reviewertxt3="JC 15mar2018: pid 20130402 - Update T1's morph to: M8552 as this is a new term for mixed acinar-ductal ca in ICD-O-3 online updates for 2011. In Cancer SOPs OneNote bk it says in 'Comments' section for M8552 'Cases dx prior to 1/1/2018 use code M8523/3' but when I check ICD-O-3 online I'm not seeing that rule - where did it come from so I can update the code file to reflect this." ///
		if pid=="20130402" & cr5id=="T1S1"
replace reviewertxt3="JC 20mar2018: pid 20130598 - Update T1's morph to: M8500 as incorrect morph code (M8521) has been used." ///
		if pid=="20130598" & cr5id=="T1S1"
replace reviewertxt3="JC 20mar2018: pid 20130620 - Update T1's morph to: M8520 as incorrect morph code (M8522) has been used." ///
		if pid=="20130620" & cr5id=="T1S1"
replace reviewertxt3="JC 20mar2018: pid 20130641 - Update T1's morph to: M8520 as incorrect morph code (M8522) has been used." ///
		if pid=="20130641" & cr5id=="T1S1"
replace reviewertxt3="JC 20mar2018: pid 20130248 - Update T1's morph to: M8522 as incorrect morph code (M8523) has been used." ///
		if pid=="20130248" & (cr5id=="T1S1"|cr5id=="T1S2")
replace reviewertxt3="JC 20mar2018: pid 20130053 - Query T1's morph: M8560 (adenosquamous ca) is used but nowhere in path rpt does it indicate squamous component was malignant so more accurate morph may be M8570 but re-confirm with PP; she previously reviewed & stated: 'PP 20150811 Yes, adenosquamous carcinoma, if the squamous component is also malignant and if the morpho code is accepted for the Topo/site. If only squamous metaplasia in Adenoca, code as adenoca'." ///
		if pid=="20130053" & cr5id=="T1S1"
replace reviewertxt3="JC 21mar2018: pid 20081031 - Update T1's hx: 'MYXOID CHONDROSARCOMA' - use most specific term available if available: path rpt MD uses this term in conjunction with 'favour' which is a reportable term. For future cases, it is best to confirm with PP terms used in the areas other than the path rpt dx." ///
		if pid=="20081031" & cr5id=="T1S1"
replace reviewertxt3="JC 21mar2018: pid 20130363 - Query/Update T1's morph: M9510? (use for poorly differentiated): Confirm with PP since the morph codes M9511 and M9512 refer to specific differentiation which is not listed with a specific code in ICD-O-3." ///
		if pid=="20130363" & cr5id=="T1S1"
replace reviewertxt3="JC 21mar2018: pid 20130293 - Update T1's morph: M9673 - incorrect ICD-O-3 morph code assigned for mantle cell lymphoma." ///
		if pid=="20130293" & cr5id=="T1S1"
replace reviewertxt3="JC 21mar2018: pid 20130321 - Update T1's morph: M9702 - incorrect ICD-O-3 morph code assigned for T-cell lymphoma." ///
		if pid=="20130321" & cr5id=="T1S1"
replace reviewertxt3="JC 21mar2018: pid 20081046 - Update T1's hx & morph: hx is 'Non-Hodgkins Lymphoma' but should='Non-Hodgkin's lymphoma, follicular, mixed small cleaved and large cell type' as stated in path rpt dx; incorrect morph code used for hx (M9691) but code to path rpt dx=M9690-code to higher value." ///
		if pid=="20081046" & cr5id=="T1S1"
replace reviewertxt3="JC 21mar2018: pid 20130052 - Update T1's hx & morph: morph should=M9875 and hx should='CHRONIC MYELOID LEUKEMIA, BCR-ABL1 TRANSLOCATION' as stated in CR5 Comments; HemeDb under CML, NOS notes 'Presumably myelogenous leukemia without genetic studies done would be coded to M9863'. Also see HemeDb CML entry. HemeDb & WHO Classification bk (pgs 32-37) notes that if genetic studies done esp. BCR-ABL1 then morph should=M9875, not M9863 for dx after yr 2001." ///
		if pid=="20130052" & cr5id=="T1S1"
replace reviewertxt3="JC 21mar2018: pid 20130173 - Update T1's hx & morph: morph should=M9875 and hx should='CHRONIC MYELOID LEUKEMIA, BCR-ABL1 POSITIVE' as stated in CR5 Comments; HemeDb under CML, NOS notes 'Presumably myelogenous leukemia without genetic studies done would be coded to M9863'. Also see HemeDb CML entry. HemeDb & WHO Classification bk (pgs 32-37) notes that if genetic studies done esp. BCR-ABL1 then morph should=M9875, not M9863 for dx after yr 2001." ///
		if pid=="20130173" & cr5id=="T1S1"
replace reviewertxt3="JC 21mar2018: pid 20130770 - Update T1's hx & morph: morph should=M9875 and hx should='CHRONIC MYELOID LEUKEMIA, BCR-ABL1 TRANSLOCATION, PHILADELPHIA CHROMOSOME' as stated in CR5 Comments; HemeDb under CML, NOS notes 'Presumably myelogenous leukemia without genetic studies done would be coded to M9863'. Also see HemeDb CML entry. HemeDb & WHO Classification bk (pgs 32-37) notes that if genetic studies done esp. BCR-ABL1 then morph should=M9875, not M9863 for dx after yr 2001." ///
		if pid=="20130770" & cr5id=="T1S1"
replace reviewertxt3="JC 21mar2018: pid 20130349 - Update T1's hx: hx='CHRONIC MYELOGENOUS LEUKEMIA, BCR-ABL1 FUSION' as stated in CR5 Comments; HemeDb under CML, NOS notes 'Presumably myelogenous leukemia without genetic studies done would be coded to M9863'. Also see HemeDb CML entry. HemeDb & WHO Classification bk (pgs 32-37) notes that if genetic studies done esp. BCR-ABL1 then morph should=M9875, not M9863 for dx after yr 2001. SOP UPDATE: may want to add in re CML when genetic studies done how to document hx and morph e.g. to differentiate between when to use M9863 and M9875: M9875's hx should=CML, BCR-ABL1 POSITIVE, FUSION, TRANSLOCATION etc. or M9863's hx should=CML, NO GENETIC STUDIES." ///
		if pid=="20130349" & cr5id=="T1S1"
replace reviewertxt3="JC 21mar2018: pid 20081066 - Update T1's hx: hx='ACUTE MYELOID LEUKEMIA, LIKELY MONOCYTIC (FAB M5)' as stated in path rpt dx; AML, NOS=M9861." ///
		if pid=="20081066" & cr5id=="T1S1"
replace reviewertxt3="JC 21mar2018: pid 20130091 - Update T1's hx: hx='PRIMARY POLYCYTHEMIA' as MasterDb (ID 626) comments='25AUG15 SF Eligibility changed to Yes - Primary Polycythemia, treated with Chemo.' but hx remained unchanged. Note: HemeDb under 'Polycythemia' states 'For polycythemia to be reportable, the diagnosis MUST state polycythemia vera, or one of the other alternate names listed under 9950/3: Polycythemia Vera'." ///
		if pid=="20130091" & (cr5id=="T1S1"|cr5id=="T1S2")
replace reviewertxt3="JC 21mar2018: pid 20081047 - Update T1's morph: morph=M9960 as HemeDb (see: Myelodysplastic/myeloproliferative neoplasm, unclassifiable; see: Chronic myeloproliferative disease, NOS) notes that myeloproliferative dx before 2010 should=M9960 and after 2010 should=M9975." ///
		if pid=="20081047" & cr5id=="T1S1"

** Now can start checking all morphologies against hx by listing those that have not been previously checked
sort pid
count if checkflag73!=73 //4994 01mar18; 5002 06mar18
** Split list into sections
count if morphcat==. //3577 01mar18; 2743 06mar18; 2751 06mar18
count if morphcat!=. & checkflag73!=73 //1421 01mar18; 2251 06mar18

** Below lists used to visually check hx vs morph and to compile/categorize specific checks (see morphcheckcat in '1_prep_cancer.do')
sort morph pid
** MORPH CATS 1-5
count if morphcat!=. & morphcat<6 & checkflag73!=73 //cats1-5:912 01mar18; 1522 06mar18; cats1-5: 826 06mar18; 995 04jul18
list pid hx morph cr5id if morphcat!=. & morphcat<6 & checkflag73!=73
list pid cfdx morph basis cr5id if morphcat!=. & morphcat<6 & checkflag73!=73

** MORPH CATS 6-9
count if morphcat!=. & morphcat>5 & morphcat<10 & checkflag73!=73 //cats 6-9: 509 01mar18; 1425 06mar18; cats6-9: 696 06mar18
list pid hx morph cr5id if morphcat!=. & morphcat>5 & morphcat<10 & checkflag73!=73
list pid cfdx morph basis cr5id if morphcat!=. & morphcat>5 & morphcat<10 & checkflag73!=73

** MORPH CATS 10-55
count if morphcat!=. & morphcat>9 & checkflag73!=73 //cats 10-55:729 06mar18
list pid hx morph cr5id if morphcat!=. & morphcat>9 & checkflag73!=73
list pid cfdx morph basis cr5id if morphcat!=. & morphcat>9 & checkflag73!=73

** Below lists used to visually check cfdx, specimen vs top, morph and to compile/categorize specific checks (see morphcheckcat in '1_prep_cancer.do')
** NOTE 1: THIS LIST WAS FIRST RUN ON MOSTLY 2008 & 2013 ABS SO WILL NEED TO COMPILE CHECKS WHEN LISTS RUN ON 2014 ABS (JC 25apr18)
** IMPORTANT NOTE 2: When looking at abstraction in Stata Results window and CR5 look for inconsistencies between 
** top, morph, lat, beh, grade, basis, (staging) VS cfdx, specimen, clin dets, md, consrpt, CODs !!
sort morph pid
** CFDX/SPECIMEN/TOPOG/MORPH CATS 1-5
count if dxyr==2014 & (morphcat!=. & morphcat<6) //cats1-5:0 25apr18
list pid top morph cr5id if dxyr==2014 & (morphcat!=. & morphcat<6)
list specimen cfdx if dxyr==2014 & (morphcat!=. & morphcat<6), notrim

** CFDX/SPECIMEN/TOPOG/MORPH CATS 6-9
count if dxyr==2014 & (morphcat!=. & morphcat>5 & morphcat<10) //cats 6-9: 0 25apr18
list pid top morph cr5id if dxyr==2014 & (morphcat!=. & morphcat>5 & morphcat<10)
list specimen cfdx if dxyr==2014 & (morphcat!=. & morphcat>5 & morphcat<10), notrim

** CFDX/SPECIMEN/TOPOG/MORPH CATS 10-55
count if dxyr==2014 & (morphcat!=. & morphcat>9) //cats 10-55: 3 25apr18
list pid top morph cr5id if dxyr==2014 & (morphcat!=. & morphcat>9)
list specimen cfdx if dxyr==2014 & (morphcat!=. & morphcat>9), notrim

****** Compiling specific Hx vs Morph checks based on findings in above lists
** JC 08mar18: created category for below specific checks so no longer need to use 
** lengthy check but simply create lists for each morphcheckcat value to perform
** visual check on data flagged in '1_prep_cancer.do' for this category

** morphcheckcat 1: Hx=Undifferentiated Ca & Morph!=8020
** 20080111 T1: Changed directly in main CR5 from M8012 to M8020 as code to higher morph when 2 terms used in hx.
count if morphcheckcat==1 //4 07mar18 - corrected; 0 04jul18
list pid hx morph basis cfdx cr5id if morphcheckcat==1
/*
count if regexm(hx, "UNDIFF") & morph!=8020 //4 07mar18 - corrected
list pid hx morph basis cr5id if regexm(hx, "UNDIFF") & morph!=8020
*/

** morphcheckcat 2: Hx!=Undifferentiated Ca & Morph==8020
** 20130299 T1: Already flagged in checkflag 73 & 74.
count if morphcheckcat==2 //1 07mar18 - corrected
list pid hx morph basis cfdx cr5id if morphcheckcat==2
/* 
count if !strmatch(strupper(hx), "*DIFF*") & morph==8020 //1 07mar18 - corrected
list pid hx morph basis cr5id if !strmatch(strupper(hx), "*DIFF*") & morph==8020
*/

** morphcheckcat 3: Hx=Papillary ca & Morph!=8050
** 20080292 T1: Changed directly in main CR5 from M8260 to M8460 as code change based on previous codes reviewed by PP.
count if morphcheckcat==3 //31 08mar18 - checked & corrected where applicable; 32 04jul18
list pid hx morph basis beh cfdx cr5id if morphcheckcat==3
/*
count if regexm(hx, "PAPIL") & morph!=8050 //35 07mar18 - corrected; 4 more than morphcheckcat=3 because some fall into other morph checks e.g. 20080152 (intraduct.papillomatosis)
list pid hx morph basis beh cr5id if regexm(hx, "PAPIL") & morph!=8050
*/

** morphcheckcat 4: Hx=Papillary serous adenoca & Morph!=8460 & Top!=ovary/peritoneum
count if morphcheckcat==4 //3 07mar18 - corrected above (thyroid/renal=M8260 & ovary/peritoneum=M8461 & endometrium=M8460); 0 04jul18
list pid top hx morph basis beh cfdx cr5id if morphcheckcat==4
/*
count if regexm(hx, "PAPILLARY SEROUS") & morph!=8460 //3 07mar18 - corrected above (thyroid/renal=M8260 & ovary/peritoneum=M8461 & endometrium=M8460)
list pid primarysite hx morph basis beh cr5id if regexm(hx, "PAPILLARY SEROUS") & morph!=8460
*/

** morphcheckcat 5: Hx=Papillary & intraduct/intracyst & Morph!=8503
count if morphcheckcat==5 //2 07mar18 - corrected above; 2 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==5
/*
count if (regexm(hx, "PAPIL")&regexm(hx, "INTRA")) & morph!=8503 //2 07mar18 - corrected above
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "PAPIL")&regexm(hx, "INTRA")) & morph!=8503
*/

** morphcheckcat 6: Hx=Keratoacanthoma & Morph!=8070
** 20080440 T1: Changed directly in main CR5 from M8071 to M8070 as code change based on previous codes used for hx=SCC Keratoacanthoma type.
** 20080443 T4: Changed directly in main CR5 from M8071 to M8070 as code change based on previous codes used for hx=SCC Keratoacanthoma type.
count if morphcheckcat==6 //2 07mar18 - corrected above; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==6
/*
count if regexm(hx, "KERATO") & morph!=8070 //2 07mar18 - corrected above
list pid primarysite hx morph basis beh cr5id if regexm(hx, "KERATO") & morph!=8070
*/

** morphcheckcat 7: Hx=Squamous & microinvasive & Morph!=8076
count if morphcheckcat==7 //0 07mar18 - none to correct; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==7
/*
count if (regexm(hx, "SQUAMOUS")&regexm(hx, "MICROINVAS")) & morph!=8076 //0 07mar18 - none to correct
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "SQUAMOUS")&regexm(hx, "MICROINVAS")) & morph!=8076
*/

** morphcheckcat 8: Hx=Bowen excluding clinical & basis==6/7/8 & morph!=8081 (want to check skin SCCs that have bowen disease is coded to M8081) 
count if morphcheckcat==8 //0 08mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==8
/* 
count if regexm(hx, "BOWEN") & morph!=8081 //3 08mar18 - one correct; rest correct as these are clinical only cases.
list pid primarysite hx morph basis beh cr5id if regexm(hx, "BOWEN") & morph!=8081
*/

** morphcheckcat 9: Hx=adenoid BCC & morph!=8098
** 20080369 T1: Changed directly in main CR5 from M8090 to M8098 as 8098 more specific code to describe adenoid BCC.
** 20080362 T2: Changed directly in main CR5 from hx from BCC-SOLID & ADENOID PATTERNS to BCC as path rpt only states BCC in dx; MD states adenoid patterns.
** 20081084 T1: Changed directly in main CR5 from M8090 to M8098 as 8098 more specific code to describe adenoid BCC.
** 20080387 T1: Changed directly in main CR5 from M8092 to M8098 as code morph to higher code if 2 morphologies in dx (adenoid & sclerosing).
count if morphcheckcat==9 //4 08mar18 - corrected all; 1 04jul18 - changed T1 to M8098 in main CR5
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==9
/*
count if (regexm(hx, "ADENOID")&regexm(hx, "BASAL")) & morph!=8098 //4 08mar18 - corrected all.
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "ADENOID")&regexm(hx, "BASAL")) & morph!=8098
*/

** morphcheckcat 10: Hx=infiltrating BCC excluding nodular & morph!=8092
** 20080410 T1: Changed directly in main CR5 from M8090 to M8092 as 8092 more specific code to describe infiltrating BCC.
count if morphcheckcat==10 //1 08mar18 - one corrected; rest correct; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==10
/*
count if (regexm(hx, "INFIL")&regexm(hx, "BASAL")) & !strmatch(strupper(hx), "*NODU*") & morph!=8092 //1 08mar18 - one corrected; rest correct.
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "INFIL")&regexm(hx, "BASAL")) & !strmatch(strupper(hx), "*NODU*") & morph!=8092
*/

** morphcheckcat 11: Hx=superficial BCC excluding nodular & basis=6/7/8 & morph!=8091
** 20080443 T6: Changed directly in main CR5 from M8090 to M8091 as 8091 more specific code to describe superficial BCC.
** 20080711 T1: Changed directly in main CR5 from hx from BCC-SUPERFICIAL to BCC as path rpt only states BCC in dx; MD states superficial.
** 20080713 T1: Changed directly in main CR5 from M8090 to M8091 as 8091 more specific code to describe superficial BCC.
** 20080740 T1: Changed directly in main CR5 from M8090 to M8091 as 8091 more specific code to describe superficial BCC.
** 20080746 T4: Changed directly in main CR5 from M8090 to M8091 as 8091 more specific code to describe superficial BCC.
count if morphcheckcat==11 //5 08mar18 - corrected all; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==11
/*
count if (regexm(hx, "SUPER")&regexm(hx, "BASAL")) & !strmatch(strupper(hx), "*NODU*") & (basis==6|basis==7|basis==8) & morph!=8091 //5 08mar18 - corrected all.
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "SUPER")&regexm(hx, "BASAL")) & !strmatch(strupper(hx), "*NODU*") & (basis==6|basis==7|basis==8) & morph!=8091
*/

** morphcheckcat 12: Hx=sclerotic/sclerosing BCC excluding nodular & morph!=8091
** 20080472 T1: Changed directly in main CR5 from M8090 to M8092 as 8092 more specific code to describe sclerotic/sclerosing BCC.
count if morphcheckcat==12 //1 08mar18 - corrected; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==12
/*
count if (regexm(hx, "SCLER")&regexm(hx, "BASAL")) & !strmatch(strupper(hx), "*NODU*") & morph!=8092 //1 08mar18 - corrected
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "SCLER")&regexm(hx, "BASAL")) & !strmatch(strupper(hx), "*NODU*") & morph!=8092
*/

** morphcheckcat 13: Hx=nodular BCC excluding clinical & morph!=8097
** 20080718 T1: Changed directly in main CR5 removed 'nodular type' from hx as path rpt dx only states BCC.
count if morphcheckcat==13 //1 08mar18 - corrected; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==13
/*
count if (regexm(hx, "NODU")&regexm(hx, "BASAL")) & !strmatch(strupper(hx), "*CLINICAL*") & morph!=8097 //1 08mar18 - corrected
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "NODU")&regexm(hx, "BASAL")) & !strmatch(strupper(hx), "*CLINICAL*") & morph!=8097
*/

** morphcheckcat 14: Hx!=nodular BCC excluding clinical & morph==8097
** 20080336 T1: Changed directly in main CR5 added 'nodular' to hx as PP reviewed to code to M8097
** 20080414 T1: Changed directly in main CR5 changed morph from M8097 to M8090 as no review done by PP and path rpt dx states only BCC.
** 20080653 T2: Changed directly in main CR5 changed morph from M8097 to M8090 as no review done by PP and path rpt dx states only BCC.
** 20080656 T1: Changed directly in main CR5 changed morph from M8097 to M8090 as no review done by PP and path rpt dx states only BCC.
count if morphcheckcat==14 //4 08mar18 - corrected; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==14
/*
count if regexm(hx, "BASAL") & !strmatch(strupper(hx), "*NODU*") & morph==8097 //4 08mar18 - corrected
list pid primarysite hx morph basis beh cr5id if regexm(hx, "BASAL") & !strmatch(strupper(hx), "*NODU*") & morph==8097 
*/

** morphcheckcat 15: Hx=BCC & SCC excluding basaloid & morph!=8094
count if morphcheckcat==15 //0 08mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==15
/*
count if (regexm(hx, "SQUA")&regexm(hx, "BASAL")) & !strmatch(strupper(hx), "*BASALOID*") & morph!=8094 //0 08mar18
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "SQUA")&regexm(hx, "BASAL")) & !strmatch(strupper(hx), "*BASALOID*") & morph!=8094
*/

** morphcheckcat 16: Hx!=BCC & SCC & morph==8094
** 20080382 T1: Changed directly in main CR5 hx from 'BCC (see path rpt)' to 'BCC-focus of squamous cell carcinoma' as PP reviewed to code to M8094.
count if morphcheckcat==16 //1 08mar18 - corrected; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==16
/*
count if regexm(hx, "BASAL") & !strmatch(strupper(hx), "*SQUA*") & morph==8094 //0 08mar18
list pid primarysite hx morph basis beh cr5id if regexm(hx, "BASAL") & !strmatch(strupper(hx), "*SQUA*") & morph==8094
*/

** morphcheckcat 17: Hx!=transitional/urothelial & morph==8120
count if morphcheckcat==17 //0 08mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==17
/*
count if (!strmatch(strupper(hx), "*TRANS*")&!strmatch(strupper(hx), "*UROTHE*")) & morph==8120 //0 08mar18
list pid primarysite hx morph basis beh cr5id if (!strmatch(strupper(hx), "*TRANS*")&!strmatch(strupper(hx), "*UROTHE*")) & morph==8120
*/

** morphcheckcat 18: Hx=transitional/urothelial excluding papillary & morph!=8120
count if morphcheckcat==18 //0 08mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==18
/*
count if (regexm(hx, "TRANS")|regexm(hx, "UROTHE")) & !strmatch(strupper(hx), "*PAPIL*") & morph!=8120 //0 08mar18
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "TRANS")|regexm(hx, "UROTHE")) & !strmatch(strupper(hx), "*PAPIL*") & morph!=8120
*/

** morphcheckcat 19: Hx=transitional/urothelial & papillary & morph!=8130
count if morphcheckcat==19 //0 08mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==19
/*
count if (regexm(hx, "TRANS")|regexm(hx, "UROTHE")) & regexm(hx, "PAPIL") & morph!=8130 //0 08mar18
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "TRANS")|regexm(hx, "UROTHE")) & regexm(hx, "PAPIL") & morph!=8130
*/

** morphcheckcat 20: Hx=villous & adenoma excluding tubulo & morph!=8261
** 20080541 T1: Changed directly in main CR5 morph from M8140 to M8261 as more specific code available.
count if morphcheckcat==20 //1 13mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==20
/*
count if (regexm(hx, "VILL")&regexm(hx, "ADENOM")) & !strmatch(strupper(hx), "*TUBUL*") & morph!=8261 //1 13mar18
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "VILL")&regexm(hx, "ADENOM")) & !strmatch(strupper(hx), "*TUBUL*") & morph!=8261
*/

** morphcheckcat 21: Hx=intestinal excl. stromal (GISTs) & morph!=8144
** 20080816 T1: Changed directly in main CR5 morph from M8140 to M8144 as more specific code available.
count if morphcheckcat==21 //1 13mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==21
/*
count if regexm(hx, "INTESTINAL") & !strmatch(strupper(hx), "*STROMA*") & morph!=8144 //1 13mar18
list pid primarysite hx morph basis beh cr5id if regexm(hx, "INTESTINAL") & !strmatch(strupper(hx), "*STROMA*") & morph!=8144
*/

** morphcheckcat 22: Hx=villoglandular & morph!=8263
count if morphcheckcat==22 //4 13mar18; 4 04jul18 - flagged for correction above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==22
/*
count if regexm(hx, "VILLOGLANDULAR") & morph!=8263 //4 13mar18
list pid primarysite hx morph basis beh cr5id if regexm(hx, "VILLOGLANDULAR") & morph!=8263
*/

** morphcheckcat 23: Hx!=clear cell & morph==8310
** 20080109 T1: Changed directly in main CR5 hx from ADENOCA to CLEAR CELL ADENOCA as more specific hx available from path rpt dx.
count if morphcheckcat==23 //1 13mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==23
/*
count if !strmatch(strupper(hx), "*CLEAR*") & morph==8310 //1 13mar18
list pid primarysite hx morph basis beh cr5id if !strmatch(strupper(hx), "*CLEAR*") & morph==8310
*/

** morphcheckcat 24: Hx==clear cell & morph!=8310
count if morphcheckcat==24 //0 13mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==24
/*
count if regexm(hx, "CLEAR") & !strmatch(strupper(hx), "*RENAL*") & morph!=8310 //0 13mar18
list pid primarysite hx morph basis beh cr5id if regexm(hx, "CLEAR") & !strmatch(strupper(hx), "*RENAL*") & morph!=8310
*/

** morphcheckcat 25: Hx==cyst & renal & morph!=8316
count if morphcheckcat==25 //0 13mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==25
/*
count if (regexm(hx, "CYST")&regexm(hx, "RENAL")) & morph!=8316 //0 13mar18
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "CYST")&regexm(hx, "RENAL")) & morph!=8316
*/

** morphcheckcat 26: Hx==chromophobe & renal & morph!=8317
count if morphcheckcat==26 //0 13mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==26
/*
count if (regexm(hx, "CHROMO")&regexm(hx, "RENAL")) & morph!=8317 //0 13mar18
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "CHROMO")&regexm(hx, "RENAL")) & morph!=8317
*/

** morphcheckcat 27: Hx==sarcomatoid & renal & morph!=8318
count if morphcheckcat==27 //1 13mar18 - already flagged in CATS 1-5 list (see checkflag74); 1 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==27
/*
count if (regexm(hx, "SARCO")&regexm(hx, "RENAL")) & morph!=8318 //1 13mar18
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "SARCO")&regexm(hx, "RENAL")) & morph!=8318
*/

** morphcheckcat 28: Hx==follicular excl.minimally invasive & morph!=8330
count if morphcheckcat==28 //0 13mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==28
/*
count if regexm(hx, "FOLLIC") & (!strmatch(strupper(hx), "*MINIMAL*")&!strmatch(strupper(hx), "*PAPIL*")) & morph!=8330 //0 13mar18
list pid primarysite hx morph basis beh cr5id if regexm(hx, "FOLLIC") & (!strmatch(strupper(hx), "*MINIMAL*")&!strmatch(strupper(hx), "*PAPIL*")) & morph!=8330
*/

** morphcheckcat 29: Hx==follicular & minimally invasive & morph!=8335
count if morphcheckcat==29 //0 13mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==29
/*
count if (regexm(hx, "FOLLIC")&regexm(hx, "MINIMAL")) & morph!=8335 //0 13mar18
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "FOLLIC")&regexm(hx, "MINIMAL")) & morph!=8335
*/

** morphcheckcat 30: Hx==microcarcinoma & morph!=8341
count if morphcheckcat==30 //0 13mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==30
/*
count if regexm(hx, "MICROCARCINOMA") & morph!=8341 //0 13mar18
list pid primarysite hx morph basis beh cr5id if regexm(hx, "MICROCARCINOMA") & morph!=8341
*/

** morphcheckcat 31: Hx!=endometrioid & morph==8380
count if morphcheckcat==31 //3 13mar18 - flagged in checkflag74; 3 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==31
/*
count if (!strmatch(strupper(hx), "*OID*")&!strmatch(strupper(hx), "*IOD*")) & morph==8380 //3 13mar18
list pid primarysite hx morph basis beh cr5id if (!strmatch(strupper(hx), "*OID*")&!strmatch(strupper(hx), "*IOD*")) & morph==8380
*/

** morphcheckcat 32: Hx==poroma & morph!=8409 & mptot<2
count if morphcheckcat==32 //0 13mar18 - one case (20080730) was an MP due to morph in 2 different groups; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==32
/*
count if regexm(hx, "POROMA") & morph!=8409 & mptot<2 //0 13mar18
list pid primarysite hx morph basis beh cr5id if regexm(hx, "POROMA") & morph!=8409 & mptot<2
*/

** morphcheckcat 33: Hx==serous excl. papillary & morph!=8441
count if morphcheckcat==33 //0 13mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==33
/*
count if regexm(hx, "SEROUS") & !strmatch(strupper(hx), "*PAPIL*") & morph!=8441 //0 13mar18
list pid primarysite hx morph basis beh cr5id if regexm(hx, "SEROUS") & !strmatch(strupper(hx), "*PAPIL*") & morph!=8441
*/

** morphcheckcat 34: Hx==mucinous excl. endocervical,producing,secreting,infiltrating duct & morph!=8480
count if morphcheckcat==34 //0 14mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==34
/*
count if regexm(hx, "MUCIN") & (!strmatch(strupper(hx), "*CERVI*")&!strmatch(strupper(hx), "*PROD*")&!strmatch(strupper(hx), "*SECRE*")&!strmatch(strupper(hx), "*DUCT*")) & morph!=8480 //0 14mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "MUCIN") & (!strmatch(strupper(hx), "*CERVI*")&!strmatch(strupper(hx), "*PROD*")&!strmatch(strupper(hx), "*SECRE*")&!strmatch(strupper(hx), "*DUCT*")) & morph!=8480
*/

** morphcheckcat 35: Hx!=mucinous & morph==8480
** 20110002 T1: Changed directly in main CR5 hx from ADENOCA to ADENOCA WITH MUCINOUS FEATURES as more specific hx available from path rpt dx.
count if morphcheckcat==35 //1 14mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==35
/*
count if !strmatch(strupper(hx), "*MUCIN*") & morph==8480 //1 14mar18
list pid primarysite hx morph basis cr5id if !strmatch(strupper(hx), "*MUCIN*") & morph==8480
*/

** morphcheckcat 36: Hx==acinar & duct & morph!=8552
count if morphcheckcat==36 //1 15mar18; 1 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==36
/*
count if (regexm(hx, "ACIN")&regexm(hx, "DUCT")) & morph!=8552 //1 15mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "ACIN")&regexm(hx, "DUCT")) & morph!=8552
*/

** morphcheckcat 37: Hx==intraduct & micropapillary or intraduct & clinging & morph!=8507
count if morphcheckcat==37 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==37
/*
count if ((regexm(hx, "INTRADUCT")&regexm(hx, "MICROPAP")) | (regexm(hx, "INTRADUCT")&regexm(hx, "CLING"))) & morph!=8507 //0 20mar18
list pid primarysite hx morph basis cr5id if ((regexm(hx, "INTRADUCT")&regexm(hx, "MICROPAP")) | (regexm(hx, "INTRADUCT")&regexm(hx, "CLING"))) & morph!=8507
*/

** morphcheckcat 38: Hx!=intraduct & micropapillary or intraduct & clinging & morph==8507
** 20080633 T1: Changed directly in main CR5 morph from M8507 to M8500 as path rpt dx states 'intraductal ca' only and PP did not review.
** 20080700 T3: Changed directly in main CR5 hx from intraductal ca to intraductal ca, micropapillary variant as PP reviewed and used path rpt MD over dx.
count if morphcheckcat==38 //2 20mar18; 1 04jul18 - changed T3 in main CR5 as 'micropap' was not in hx.
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==38
/*
count if (!strmatch(strupper(hx), "*MICROPAP*")|!strmatch(strupper(hx), "*CLING*")) & morph==8507 //2 20mar18
list pid primarysite hx morph basis cr5id if (!strmatch(strupper(hx), "*MICROPAP*")!strmatch(strupper(hx), "*CLING*")) & morph==8507
*/

** morphcheckcat 39: Hx!=ductular & morph==8521
count if morphcheckcat==39 //1 20mar18 - flagged in checkflag 74 above; 1 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==39
/*
count if !strmatch(strupper(hx), "*DUCTULAR*") & morph==8521 //1 20mar18
list pid primarysite hx morph basis cr5id if !strmatch(strupper(hx), "*DUCTULAR*") & morph==8521
*/

** morphcheckcat 40: Hx!=duct & Hx==lobular & morph!=8520
count if morphcheckcat==40 //2 20mar18 - flagged in checkflag 74 above; 2 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==40
/*
count if regexm(hx, "LOB") & !strmatch(strupper(hx), "*DUCT*") & morph!=8520 //2 20mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "LOB") & !strmatch(strupper(hx), "*DUCT*") & morph!=8520
*/

** morphcheckcat 41: Hx==duct & lobular & morph!=8522
count if morphcheckcat==41 //2 20mar18 - flagged in checkflag 74 above; 2 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==41
/*
count if (regexm(hx, "DUCT")&regexm(hx, "LOB")) & morph!=8522 //2 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "DUCT")&regexm(hx, "LOB")) & morph!=8522
*/

** morphcheckcat 42: Hx!=acinar & morph==8550
count if morphcheckcat==42 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==42
/*
count if !strmatch(strupper(hx), "*ACIN*") & morph==8550 //0 20mar18
list pid primarysite hx morph basis cr5id if !strmatch(strupper(hx), "*ACIN*") & morph==8550
*/

** morphcheckcat 43: Hx!=adenosquamous & morph==8560
** 20130372 T1: Changed directly in main CR5 hx from 'adeno-squamous' to 'adenosquamous'.
count if morphcheckcat==43 //2 20mar18 - 1 flagged in checkflag 74 above; 1 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==43
/*
count if !strmatch(strupper(hx), "*ADENOSQUA*") & morph==8560 //2 20mar18
list pid primarysite hx morph basis cr5id if !strmatch(strupper(hx), "*ADENOSQUA*") & morph==8560
*/

** morphcheckcat 44: Hx!=thecoma & morph==8600
count if morphcheckcat==44 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==44
/*
count if !strmatch(strupper(hx), "*THECOMA*") & morph==8600 //0 20mar18
list pid primarysite hx morph basis cr5id if !strmatch(strupper(hx), "*THECOMA*") & morph==8600
*/

** morphcheckcat 45: Hx!=sarcoma & morph==8800
count if morphcheckcat==45 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==45
/*
count if !strmatch(strupper(hx), "*SARCOMA*") & morph==8800 //0 20mar18
list pid primarysite hx morph basis cr5id if !strmatch(strupper(hx), "*SARCOMA*") & morph==8800
*/

** morphcheckcat 46: Hx=spindle & sarcoma & morph!=8801
count if morphcheckcat==46 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==46
/*
count if (regexm(hx, "SPIN")&regexm(hx, "SARCOMA")) & morph!=8801 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "SPIN")&regexm(hx, "SARCOMA")) & morph!=8801
*/

** morphcheckcat 47: Hx=undifferentiated & sarcoma & morph!=8805
count if morphcheckcat==47 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==47
/*
count if (regexm(hx, "UNDIFF")&regexm(hx, "SARCOMA")) & morph!=8805 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "UNDIFF")&regexm(hx, "SARCOMA")) & morph!=8805
*/

** morphcheckcat 48: Hx=fibrosarcoma & Hx!=myxo or dermato & morph!=8810
count if morphcheckcat==48 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==48
/*
count if regexm(hx, "FIBROSARCOMA") & (!strmatch(strupper(hx), "*MYXO*")&!strmatch(strupper(hx), "*DERMA*")) & morph!=8810 //0 20mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "FIBROSARCOMA") & (!strmatch(strupper(hx), "*MYXO*")&!strmatch(strupper(hx), "*DERMA*")) & morph!=8810
*/

** morphcheckcat 49: Hx=fibrosarcoma & Hx=myxo & morph!=8811
count if morphcheckcat==49 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==49
/*
count if (regexm(hx, "FIBROSARCOMA")&regexm(hx, "MYXO")) & morph!=8811 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "FIBROSARCOMA")&regexm(hx, "MYXO")) & morph!=8811
*/

** morphcheckcat 50: Hx=fibro & histiocytoma & morph!=8830
count if morphcheckcat==50 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==50
/*
count if (regexm(hx, "FIBRO")&regexm(hx, "HISTIOCYTOMA")) & morph!=8830 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "FIBRO")&regexm(hx, "HISTIOCYTOMA")) & morph!=8830
*/

** morphcheckcat 51: Hx!=dermatofibrosarcoma & morph==8832
count if morphcheckcat==51 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==51
/*
count if (!strmatch(strupper(hx), "*DERMA*")&!strmatch(strupper(hx), "*FIBRO*")&!strmatch(strupper(hx), "*SARCOMA*")) & morph==8832 //0 20mar18
list pid primarysite hx morph basis cr5id if (!strmatch(strupper(hx), "*DERMA*")&!strmatch(strupper(hx), "*FIBRO*")&!strmatch(strupper(hx), "*SARCOMA*")) & morph==8832
*/

** morphcheckcat 52: Hx==stromal sarcoma high grade & morph!=8930
count if morphcheckcat==52 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==52
/*
count if (regexm(hx, "STROMAL")&regexm(hx, "SARCOMA")&regexm(hx, "HIGH")) & morph!=8930 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "STROMAL")&regexm(hx, "SARCOMA")&regexm(hx, "HIGH")) & morph!=8930
*/

** morphcheckcat 53: Hx==stromal sarcoma low grade & morph!=8931
count if morphcheckcat==53 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==53
/*
count if (regexm(hx, "STROMAL")&regexm(hx, "SARCOMA")&regexm(hx, "LOW")) & morph!=8931 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "STROMAL")&regexm(hx, "SARCOMA")&regexm(hx, "LOW")) & morph!=8931
*/

** morphcheckcat 54: Hx==gastrointestinal stromal tumour & morph!=8936
count if morphcheckcat==54 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==54
/*
count if (regexm(hx, "GASTRO")&regexm(hx, "STROMAL")|regexm(hx, "GIST")) & morph!=8936 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "GASTRO")&regexm(hx, "STROMAL")|regexm(hx, "GIST")) & morph!=8936
*/

** morphcheckcat 55: Hx==mixed mullerian tumour & Hx!=mesodermal & morph!=8950
count if morphcheckcat==55 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==55
/*
count if (regexm(hx, "MIXED")&regexm(hx, "MULLER")) & !strmatch(strupper(hx), "*MESO*") & morph!=8950 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "MIXED")&regexm(hx, "MULLER")) & !strmatch(strupper(hx), "*MESO*") & morph!=8950
*/

** morphcheckcat 56: Hx==mesodermal mixed & morph!=8951
count if morphcheckcat==56 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==56
/*
count if (regexm(hx, "MIXED")&regexm(hx, "MESO")) & morph!=8951 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "MIXED")&regexm(hx, "MESO")) & morph!=8951
*/

** morphcheckcat 57: Hx==wilms or nephro & morph!=8960
count if morphcheckcat==57 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==57
/*
count if (regexm(hx, "WILM")|regexm(hx, "NEPHR")) & morph!=8960 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "WILM")|regexm(hx, "NEPHR")) & morph!=8960
*/

** morphcheckcat 58: Hx==mesothelioma & Hx!=fibrous or sarcoma or epithelioid/papillary or cystic & morph!=9050
count if morphcheckcat==58 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==58
/*
count if regexm(hx, "MESOTHE") & (!strmatch(strupper(hx), "*FIBR*")&!strmatch(strupper(hx), "*SARC*")&!strmatch(strupper(hx), "*EPITHE*")&!strmatch(strupper(hx), "*PAPIL*")&!strmatch(strupper(hx), "*CYST*")) & morph!=9050 //0 20mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "MESOTHE") & (!strmatch(strupper(hx), "*FIBR*")&!strmatch(strupper(hx), "*SARC*")&!strmatch(strupper(hx), "*EPITHE*")&!strmatch(strupper(hx), "*PAPIL*")&!strmatch(strupper(hx), "*CYST*")) & morph!=9050
*/

** morphcheckcat 59: Hx==fibrous or sarcomatoid mesothelioma & Hx!=epithelioid/papillary or cystic & morph!=9051
count if morphcheckcat==59 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==59
/*
count if (regexm(hx, "MESOTHE")&regexm(hx, "FIBR")|regexm(hx, "MESOTHE")&regexm(hx, "SARC")) & (!strmatch(strupper(hx), "*EPITHE*")&!strmatch(strupper(hx), "*PAPIL*")&!strmatch(strupper(hx), "*CYST*")) & morph!=9051 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "MESOTHE")&regexm(hx, "FIBR")|regexm(hx, "MESOTHE")&regexm(hx, "SARC")) & (!strmatch(strupper(hx), "*EPITHE*")&!strmatch(strupper(hx), "*PAPIL*")&!strmatch(strupper(hx), "*CYST*")) & morph!=9051
*/

** morphcheckcat 60: Hx==epitheliaoid or papillary mesothelioma & Hx!=fibrous or sarcomatoid or cystic & morph!=9052
count if morphcheckcat==60 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==60
/*
count if (regexm(hx, "MESOTHE")&regexm(hx, "EPITHE")|regexm(hx, "MESOTHE")&regexm(hx, "PAPIL")) & (!strmatch(strupper(hx), "*FIBR*")&!strmatch(strupper(hx), "*SARC*")&!strmatch(strupper(hx), "*CYST*")) & morph!=9052 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "MESOTHE")&regexm(hx, "EPITHE")|regexm(hx, "MESOTHE")&regexm(hx, "PAPIL")) & (!strmatch(strupper(hx), "*FIBR*")&!strmatch(strupper(hx), "*SARC*")&!strmatch(strupper(hx), "*CYST*")) & morph!=9052
*/

** morphcheckcat 61: Hx==biphasic mesothelioma & morph!=9053
count if morphcheckcat==61 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==61
/*
count if (regexm(hx, "MESOTHE")&regexm(hx, "BIPHAS")) & morph!=9053 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "MESOTHE")&regexm(hx, "BIPHAS")) & morph!=9053
*/

** morphcheckcat 62: Hx==adenomatoid tumour & morph!=9054
count if morphcheckcat==62 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==62
/*
count if regexm(hx, "ADENOMATOID") & morph!=9054 //0 20mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "ADENOMATOID") & morph!=9054
*/

** morphcheckcat 63: Hx==cystic mesothelioma & morph!=9055
count if morphcheckcat==63 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==63
/*
count if (regexm(hx, "MESOTHE")&regexm(hx, "CYST")) & morph!=9055 //0 20mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "MESOTHE")&regexm(hx, "CYST")) & morph!=9055
*/

** morphcheckcat 64: Hx==yolk & morph!=9071
count if morphcheckcat==64 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==64
/*
count if regexm(hx, "YOLK") & morph!=9071 //0 20mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "YOLK") & morph!=9071
*/

** morphcheckcat 65: Hx==teratoma & morph!=9080
count if morphcheckcat==65 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==65
/*
count if regexm(hx, "TERATOMA") & morph!=9080 //0 20mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "TERATOMA") & morph!=9080
*/

** morphcheckcat 66: Hx==teratoma & Hx!=metastatic or malignant or embryonal or teratoblastoma or immature & morph==9080
** 20080141 T1: Changed directly in main CR5 hx from 'teratoma' to 'metastatic teratoma'.
count if morphcheckcat==66 //1 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==66
/*
count if regexm(hx, "TERATOMA") & (!strmatch(strupper(hx), "*METAS*")&!strmatch(strupper(hx), "*MALIG*")&!strmatch(strupper(hx), "*EMBRY*")&!strmatch(strupper(hx), "*BLAST*")&!strmatch(strupper(hx), "*IMMAT*")) & morph==9080 //1 20mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "TERATOMA") & (!strmatch(strupper(hx), "*METAS*")&!strmatch(strupper(hx), "*MALIG*")&!strmatch(strupper(hx), "*EMBRY*")&!strmatch(strupper(hx), "*BLAST*")&!strmatch(strupper(hx), "*IMMAT*")) & morph==9080
*/

** morphcheckcat 67: Hx==complete hydatidiform mole & Hx!=choriocarcinoma & beh==3 & morph==9100
** 20080280 T1: Changed directly in main CR5 hx from 'invasive hydatidiform mole' to 'choricarcinoma/invasive hydatidiform mole' since PP reviewed (MasterDb 4642) and noted clinical dx of choriocarcinoma not confirmed by hx. Also pt treated with chemo; Changed basis from 7 to 2.
count if morphcheckcat==67 //1 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==67
/*
count if regexm(hx, "MOLE") & !strmatch(strupper(hx), "*CHORIO*") & beh==3 & morph==9100 //1 20mar18
list pid primarysite hx morph beh basis cr5id if regexm(hx, "MOLE") & !strmatch(strupper(hx), "*CHORIO*") & beh==3 & morph==9100
*/

** morphcheckcat 68: Hx==choriocarcinoma & morph!=9100
count if morphcheckcat==68 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==68
/*
count if regexm(hx, "CHORIO") & morph!=9100 //0 20mar18
list pid primarysite hx morph beh basis cr5id if regexm(hx, "CHORIO") & morph!=9100
*/

** morphcheckcat 69: Hx==epithelioid hemangioendothelioma & Hx!=malignant & morph==9133
** 20080514 T1: Changed directly in main CR5 hx from 'epithelioid hemangioendothelioma' to '(malignant) epithelioid hemangioendothelioma/low grade epithelioid angiosarcoma' since path rpt (MasterDb 2358) noted in IHC that this tumour is malignant by use of angiosarcoma term.
count if morphcheckcat==69 //1 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==69
/*
count if (regexm(hx, "EPITHE")&regexm(hx, "HEMANGIOENDOTHELIOMA")) & !strmatch(strupper(hx), "*MALIG*") & morph==9133 //1 20mar18
list pid primarysite hx morph beh basis cr5id if (regexm(hx, "EPITHE")&regexm(hx, "HEMANGIOENDOTHELIOMA")) & !strmatch(strupper(hx), "*MALIG*") & morph==9133
*/

** morphcheckcat 70: Hx==osteosarcoma & morph!=9180
count if morphcheckcat==70 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==70
/*
count if regexm(hx, "OSTEOSARC") & morph!=9180 //0 20mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "OSTEOSARC") & morph!=9180
*/

** morphcheckcat 71: Hx==chondrosarcoma & morph!=9220
count if morphcheckcat==71 //0 20mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==71
/*
count if regexm(hx, "CHONDROSARC") & morph!=9220 //0 20mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "CHONDROSARC") & morph!=9220
*/

** morphcheckcat 72: Hx=myxoid and Hx!=chondrosarcoma & morph==9231
count if morphcheckcat==72 //1 21mar18 - flagged above in checkflag 74; 1 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==72
/*
count if regexm(hx, "MYXOID") & !strmatch(strupper(hx), "*CHONDROSARC*") & morph==9231 //1 21mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "MYXOID") & !strmatch(strupper(hx), "*CHONDROSARC*") & morph==9231
*/

** morphcheckcat 73: Hx=retinoblastoma and poorly or undifferentiated & morph==9511
count if morphcheckcat==73 //1 21mar18 - flagged above in checkflag 74; 1 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==73
/*
count if regexm(hx, "RETINOBLASTOMA") & (regexm(hx, "POORLY")|regexm(hx, "UNDIFF")) & morph==9511 //1 21mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "RETINOBLASTOMA") & (regexm(hx, "POORLY")|regexm(hx, "UNDIFF")) & morph==9511
*/

** morphcheckcat 74: Hx=meningioma & Hx!=meningothelial/endotheliomatous/syncytial & morph==9531
** 20080678 T1: Changed directly in main CR5 hx from 'meningioma' to 'meningioma, syncytial variant' as stated in path rpt (MasterDb 2089).
count if morphcheckcat==74 //1 21mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==74
/*
count if regexm(hx, "MENINGIOMA") & (!strmatch(strupper(hx), "*THELI*")&!strmatch(strupper(hx), "*SYN*")) & morph==9531 //1 21mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "MENINGIOMA") & (!strmatch(strupper(hx), "*THELI*")&!strmatch(strupper(hx), "*SYN*")) & morph==9531
*/

** morphcheckcat 75: Hx=mantle cell lymphoma & morph!=9673
count if morphcheckcat==75 //1 21mar18 - flagged above in checkflag 74; 1 04jul18 - flagged above; 20130736
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==75
/*
count if (regexm(hx, "MANTLE")&regexm(hx, "LYMPH")) & morph!=9673 //1 21mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "MANTLE")&regexm(hx, "LYMPH")) & morph!=9673
*/

** morphcheckcat 76: Hx=T-cell lymphoma & Hx!=leukemia & morph!=9702
count if morphcheckcat==76 //1 21mar18 - flagged above in checkflag 74; 1 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==76
/*
count if (regexm(hx, "T CELL")&regexm(hx, "LYMPH")|regexm(hx, "T-CELL")&regexm(hx, "LYMPH")) & !strmatch(strupper(hx), "*LEU*") & morph!=9702 //1 21mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "T CELL")&regexm(hx, "LYMPH")|regexm(hx, "T-CELL")&regexm(hx, "LYMPH")) & !strmatch(strupper(hx), "*LEU*") & morph!=9702
*/

** morphcheckcat 77: Hx=non-hodgkin lymphoma & Hx!=cell (to excl. mantle, large, cleaved, small, etc) & morph!=9591
count if morphcheckcat==77 //1 21mar18 - flagged above in checkflag 74; 2 04jul18 - 1 flagged above; 1 changed in bascheckcat=3 (20130736)
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==77
/*
count if (regexm(hx, "NON")&regexm(hx, "HODGKIN")&regexm(hx, "LYMPH")) & !strmatch(strupper(hx), "*CELL*") & morph!=9591 //1 21mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "NON")&regexm(hx, "HODGKIN")&regexm(hx, "LYMPH")) & !strmatch(strupper(hx), "*CELL*") & morph!=9591
*/

** morphcheckcat 78: Hx=precursor t-cell acute lymphoblastic leukemia & morph!=9837
** note: ICD-O-3 has another matching code (M9729) but WHO Classification notes that M9837 more accurate
count if morphcheckcat==78 //0 21mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==78
/*
count if (regexm(hx, "PRE")&regexm(hx, "T CELL")&regexm(hx, "LYMPH")&regexm(hx, "LEU")|regexm(hx, "PRE")&regexm(hx, "T-CELL")&regexm(hx, "LYMPH")&regexm(hx, "LEU")) & morph!=9837 //0 21mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "PRE")&regexm(hx, "T CELL")&regexm(hx, "LYMPH")&regexm(hx, "LEU")|regexm(hx, "PRE")&regexm(hx, "T-CELL")&regexm(hx, "LYMPH")&regexm(hx, "LEU")) & morph!=9837
*/

** morphcheckcat 79: Hx=CML (chronic myeloid/myelogenous leukemia) & Hx!=genetic studies & morph==9863
** note: HemeDb under CML, NOS notes 'Presumably myelogenous leukemia without genetic studies done would be coded to M9863.'
** JC 21mar18 checked all dx with M9863 & 9875 to ensure no genetic studies were done but if they were then these were
** flagged for correction in checkflag 74 above.
** 20080714 T1: Changed directly in main CR5 hx from 'CML' to 'CML, no genetic studies' as indicated in CR5 Comments.
** 20080942 T1: Changed directly in main CR5 hx from 'CML' to 'CML, no genetic studies' as indicated in CR5 Comments.
count if morphcheckcat==79 //5 21mar18 - 2 changed in main CR5; 3 flagged above in checkflag 74; 2 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==79
/*
count if (regexm(hx, "CHRON")&regexm(hx, "MYELO")&regexm(hx, "LEU")) & !strmatch(strupper(hx), "*GENETIC*") & morph==9863 //5 21mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "CHRON")&regexm(hx, "MYELO")&regexm(hx, "LEU")) & !strmatch(strupper(hx), "*GENETIC*") & morph==9863
*/

** morphcheckcat 80: Hx=CML (chronic myeloid/myelogenous leukemia) & Hx!=BCR/ABL1 & morph==9875
** note: HemeDb under CML, NOS notes 'Presumably myelogenous leukemia without genetic studies done would be coded to M9863.'
** JC 21mar18 checked all dx with M9863 & 9875 to ensure no genetic studies were done but if they were then these were
** flagged for correction in checkflag 74 above.
count if morphcheckcat==80 //1 21mar18 - 1 flagged above in checkflag 74; 1 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==80
/*
count if (regexm(hx, "CHRON")&regexm(hx, "MYELO")&regexm(hx, "LEU")) & (!strmatch(strupper(hx), "*BCR*")|!strmatch(strupper(hx), "*ABL1*")) & morph==9875 //1 21mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "CHRON")&regexm(hx, "MYELO")&regexm(hx, "LEU")) & (!strmatch(strupper(hx), "*BCR*")|!strmatch(strupper(hx), "*ABL1*")) & morph==9875
*/

** morphcheckcat 81: Hx=acute myeloid leukemia & Hx!=myelodysplastic/down syndrome & basis==cyto/heme/histology... & morph!=9861
** 20081053 T1: Changed directly in main CR5 morph from M9896 to M9861 as no specific type of AML noted in CR5 comments, MasterDb etc.
count if morphcheckcat==81 //2 21mar18 - 1 changed in main CR5; 1 flagged above in checkflag 74; 1 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==81
/*
count if (regexm(hx, "ACUTE")&regexm(hx, "MYELOID")&regexm(hx, "LEU")) & (!strmatch(strupper(hx), "*DYSPLAST*")&!strmatch(strupper(hx), "*DOWN*")) & (basis>4&basis<9) & morph!=9861 //2 21mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "ACUTE")&regexm(hx, "MYELOID")&regexm(hx, "LEU")) & (!strmatch(strupper(hx), "*DYSPLAST*")&!strmatch(strupper(hx), "*DOWN*")) & (basis>4&basis<9) & morph!=9861
*/

** morphcheckcat 82: Hx=acute myeloid leukemia & down syndrome & morph!=9898
** 20080089 T1: Changed directly in main CR5 morph from M9910 to M9898 as online 2011 ICD-O-3 indicates this code should be used and no indication if dx prior to 2011 should be excluded.
count if morphcheckcat==82 //1 21mar18 - flagged above in checkflag 74; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==82
/*
count if (regexm(hx, "DOWN")&regexm(hx, "MYELOID")&regexm(hx, "LEU")) & morph!=9898 //1 21mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "DOWN")&regexm(hx, "MYELOID")&regexm(hx, "LEU")) & morph!=9898
*/

** morphcheckcat 83: Hx=secondary myelofibrosis & recstatus!=3 & morph==9931 or 9961
count if morphcheckcat==83 //0 21mar18 - previous case (20080641) already flagged as inelgible in CR5; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==83
/*
count if (regexm(hx, "SECOND")&regexm(hx, "MYELOFIBR")) & recstatus!=3 & (morph==9931|morph==9961) //0 21mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "SECOND")&regexm(hx, "MYELOFIBR")) & recstatus!=3 & (morph==9931|morph==9961)
*/

** morphcheckcat 84: Hx=polycythemia & Hx!=vera/proliferative/primary & morph==9950
count if morphcheckcat==84 //1 21mar18 - flagged above in checkflag 74; 2 04jul18 - flagged above (same pid)
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==84
/*
count if regexm(hx, "POLYCYTHEMIA") & (!strmatch(strupper(hx), "*VERA*")&!strmatch(strupper(hx), "*PROLIF*")&!strmatch(strupper(hx), "*PRIMARY*")) & morph==9950 //1 21mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "POLYCYTHEMIA") & (!strmatch(strupper(hx), "*VERA*")&!strmatch(strupper(hx), "*PROLIF*")&!strmatch(strupper(hx), "*PRIMARY*")) & morph==9950
*/

** morphcheckcat 85: Hx=myeloproliferative & Hx!=essential & dxyr<2010 & morph==9975
count if morphcheckcat==85 //1 21mar18 - flagged above in checkflag 74; 1 04jul18 - flagged above
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==85
/*
count if regexm(hx, "MYELOPROLIFERATIVE") & !strmatch(strupper(hx), "*ESSENTIAL*") & dxyr<2010 & morph==9975 //1 21mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "MYELOPROLIFERATIVE") & !strmatch(strupper(hx), "*ESSENTIAL*") & dxyr<2010 & morph==9975
*/

** morphcheckcat 86: Hx=myeloproliferative & Hx!=essential & dxyr>2009 & morph==9960
count if morphcheckcat==86 //0 21mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==86
/*
count if regexm(hx, "MYELOPROLIFERATIVE") & !strmatch(strupper(hx), "*ESSENTIAL*") & dxyr>2009 & morph==9960 //0 21mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "MYELOPROLIFERATIVE") & !strmatch(strupper(hx), "*ESSENTIAL*") & dxyr>2009 & morph==9960
*/

** morphcheckcat 87: Hx=refractory anemia & Hx!=sideroblast or blast & morph!=9980
count if morphcheckcat==87 //0 21mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==87
/*
count if (regexm(hx, "REFRACTORY")&regexm(hx, "AN")) & (!strmatch(strupper(hx), "*SIDERO*")&!strmatch(strupper(hx), "*BLAST*")) & morph!=9980 //0 21mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "REFRACTORY")&regexm(hx, "AN")) & (!strmatch(strupper(hx), "*SIDERO*")&!strmatch(strupper(hx), "*BLAST*")) & morph!=9980
*/

** morphcheckcat 88: Hx=refractory anemia & sideroblast & Hx!=excess blasts & morph!=9982
count if morphcheckcat==88 //0 21mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==88
/*
count if (regexm(hx, "REFRACTORY")&regexm(hx, "AN")&regexm(hx, "SIDERO")) & !strmatch(strupper(hx), "*EXCESS*") & morph!=9982 //0 21mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "REFRACTORY")&regexm(hx, "AN")&regexm(hx, "SIDERO")) & !strmatch(strupper(hx), "*EXCESS*") & morph!=9982
*/

** morphcheckcat 89: Hx=refractory anemia & excess blasts &  Hx!=sidero & morph!=9983
count if morphcheckcat==89 //0 21mar18; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==89
/*
count if (regexm(hx, "REFRACTORY")&regexm(hx, "AN")&regexm(hx, "EXCESS")) & !strmatch(strupper(hx), "*SIDERO*") & morph!=9983 //0 21mar18
list pid primarysite hx morph basis cr5id if (regexm(hx, "REFRACTORY")&regexm(hx, "AN")&regexm(hx, "EXCESS")) & !strmatch(strupper(hx), "*SIDERO*") & morph!=9983
*/

** morphcheckcat 90: Hx=myelodysplasia & Hx!=syndrome & recstatus!=inelig. & morph==9989
** 20080640 T1: Changed directly in main CR5 morph from M9980 to M9989; hx from 'myelodyplasia: refractory anemia' to 'myelodysplasia' and recstatus from 1(confir.) to 3(ineligible) as BM rpt (MasterDb 1097) & CR5 comments does not indicate definitive dx of refractory anemia or myelodysplastic syndrome. Note: HemeDb states (under myelodysplasia) 'Myelodysplasia and myelodysplastic syndrome  (9989/3) are not the same disease. Myelodysplasia may be used as an alternate names for myelodysplastic syndrome; however, the terms MDS, or myelodysplastic syndrome should be used somewhere in the medical record'.
count if morphcheckcat==90 //0 21mar18 - above case picked up by visual check in CATS 10-55 list; 0 04jul18
list pid primarysite hx morph basis beh cfdx cr5id if morphcheckcat==90
/*
count if regexm(hx, "MYELODYSPLASIA") & !strmatch(strupper(hx), "*SYNDROME*") & recstatus!=3 & morph==9989 //0 21mar18
list pid primarysite hx morph basis cr5id if regexm(hx, "MYELODYSPLASIA") & !strmatch(strupper(hx), "*SYNDROME*") & recstatus!=3 & morph==9989
*/


** Check 73 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag73=73 if checkflag74!=74

*************************************************************************************************************************************
********************************** Lists for 2014 abstractions! - Run after the above lines of code *********************************
*************************************************************************************************************************************

** Below lists used to visually check hx vs morph and to compile/categorize specific checks (see morphcheckcat in '1_prep_cancer.do')
sort morph pid
** MORPH CATS 1-5
count if morphcat!=. & morphcat<6 & checkflag73!=73 //cats1-5:912 01mar18; 1522 06mar18; cats1-5: 826 06mar18
list pid hx morph cr5id if morphcat!=. & morphcat<6 & checkflag73!=73
list pid cfdx morph basis cr5id if morphcat!=. & morphcat<6 & checkflag73!=73

** MORPH CATS 6-9
count if morphcat!=. & morphcat>5 & morphcat<10 & checkflag73!=73 //cats 6-9: 509 01mar18; 1425 06mar18; cats6-9: 696 06mar18
list pid hx morph cr5id if morphcat!=. & morphcat>5 & morphcat<10 & checkflag73!=73
list pid cfdx morph basis cr5id if morphcat!=. & morphcat>5 & morphcat<10 & checkflag73!=73

** MORPH CATS 10-55
count if morphcat!=. & morphcat>9 & checkflag73!=73 //cats 10-55: 729 06mar18
list pid hx morph cr5id if morphcat!=. & morphcat>9 & checkflag73!=73
list pid cfdx morph basis cr5id if morphcat!=. & morphcat>9 & checkflag73!=73

	
** Checks 75 & 76 - invalid (primarysite vs hx); Review done visually via lists below and specific checks created (hxcheckcat). 
** Check 75=Reviewed/Corrected by DA/Reviewer; no errors
** Check 76=Invalid (primarysite vs hx) generated via hxcheckcat
** First, flag errors and assign as checkflag 76 then
** flag rest of cases as checkflag 75 (no errors)
** When running this code on 2014 abstractions then need to use lists that are after the morphcheckcat (scroll down)

** Check 75 - invalid (primarysite vs hx); Reviewed/Corrected by DA/Reviewer; no errors
/* old code used prior to creation of hxcheckcat
replace checkflag75=75 if pid=="20130099" & cr5id=="T1S1" | pid=="20130389" & (cr5id=="T1S1"|cr5id=="T1S2") | pid=="20080619" & cr5id=="T1S1" | pid=="" & cr5id=="T1S1"
*/

** Check 76 - invalid(primarysite vs hx)

** hxcheckcat 1: PrimSite=Blood & Hx=Lymphoma
count if hxcheckcat==1 //2 08mar18 - flagged above in checkflag 76; 2 09jul18 - already flagged above.
list pid primarysite top hx morph cr5id if hxcheckcat==1
/*
count if topcat==38 & morphcat==42 //2 06mar18
list pid primarysite top hx morph cr5id if topcat==38 & morphcat==42
*/

** hxcheckcat 2: PrimSite=Thymus & MorphCat!=13 (Thymic epithe. neo.) & Hx!=carcinoma
count if hxcheckcat==2 //0 08mar18; 0 09jul18
list pid primarysite top hx morph basis cr5id if hxcheckcat==2
/*
count if topcat==33 & morphcat!=13 //1 06mar18
list pid primarysite top hx morph basis cr5id if topcat==33 & morphcat!=13
*/

** hxcheckcat 3: PrimSite!=Bone Marrow & MorphCat==56 (Myelodysplastic Syn.)
count if hxcheckcat==3 //1 06mar18 - flagged above in checkflag 76; 1 09jul18 - already flagged above.
list pid primarysite top hx morph basis cr5id if hxcheckcat==3
/*
count if topography!=421 & morphcat==56 //1 06mar18
list pid primarysite top hx morph basis cr5id if topography!=421 & morphcat==56
*/

** hxcheckcat 4: PrimSite!=thyroid & Hx=Renal & Hx=Papillary ca & Morph!=8260
count if hxcheckcat==4 //0 08mar18; 0 09jul18
list pid primarysite hx morph basis beh cr5id if hxcheckcat==4
/*
count if (regexm(hx, "PAPIL")&regexm(hx, "RENAL")) & topography!=739 & morph!=8260 //23 07mar18 - all correct
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "PAPIL")&regexm(hx, "RENAL")) & topography!=739 & morph!=8260
*/

** hxcheckcat 5: PrimSite==thyroid & Hx!=Renal & Hx=Papillary ca & adenoca & Morph!=8260
count if hxcheckcat==5 //0 08mar18; 0 09jul18
list pid primarysite hx morph basis beh cr5id if hxcheckcat==5
/*
count if (regexm(hx, "PAPIL")&regexm(hx, "ADENO")) & !strmatch(strupper(hx), "*RENAL*") & topography==739 & morph!=8260 //0 08mar18 
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "PAPIL")&regexm(hx, "ADENO")) & !strmatch(strupper(hx), "*RENAL*") & topography==739 & morph!=8260
*/

** hxcheckcat 6: PrimSite==ovary or peritoneum & Hx=Papillary & Serous & Morph!=8461
count if hxcheckcat==6 //0 07mar18 - none to correct; 0 09jul18
list pid hx morph basis beh cr5id if hxcheckcat==6
/*
count if (regexm(hx, "PAPILLARY")&regexm(hx, "SEROUS")) & (topcat==41|topcat==49) & morph!=8461 //0 07mar18 - none to correct
list pid hx morph basis beh cr5id if (regexm(hx, "PAPILLARY")&regexm(hx, "SEROUS")) & (topcat==41|topcat=49) & morph!=8461
*/

** hxcheckcat 7: PrimSite==endometrium & Hx=Papillary & Serous & Morph!=8460
count if hxcheckcat==7 //1 08mar18 - corrected above in check 73 & 74 (morphcheckcat 3); 0 09jul18
list pid primarysite hx morph basis beh cr5id if hxcheckcat==7
/*
count if (regexm(hx, "PAPILLARY")&regexm(hx, "SEROUS")) & topography==541 & morph!=8460 //1 07mar18 - corrected above in check 73 & 74
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "PAPILLARY")&regexm(hx, "SEROUS")) & topography==541 & morph!=8460
*/

** hxcheckcat 8: PrimSite!=bone; Hx=plasmacytoma & Morph==9731(bone)
count if hxcheckcat==8 //0 21mar18; 0 09jul18
list pid primarysite hx morph basis beh cr5id if hxcheckcat==8
/*
count if regexm(hx, "PLASMA") & (topcat!=36&topcat!=37) & morph==9731 //0 21mar18 - corrected above in check 73 & 74
list pid primarysite hx morph basis beh cr5id if regexm(hx, "PLASMA") & (topcat!=36&topcat!=37) & morph==9731
*/

** hxcheckcat 9: PrimSite==bone; Hx=plasmacytoma & Morph==9734(not bone)
count if hxcheckcat==9 //0 21mar18; 0 09jul18
list pid primarysite hx morph basis beh cr5id if hxcheckcat==9
/*
count if regexm(hx, "PLASMA") & (topcat==36|topcat==37) & morph==9734 //0 21mar18 - corrected above in check 73 & 74
list pid primarysite hx morph basis beh cr5id if regexm(hx, "PLASMA") & (topcat==36|topcat==37) & morph==9734
*/

** hxcheckcat 10: PrimSite!=meninges; Hx=meningioma
** 20090038 T1: Changed in main CR5 primsite from 'overlapping lesion...' to 'meninges-...' and topog from 718 to 700.
count if hxcheckcat==10 //3 10apr18 - 1 corrected below in checkflag 85/86 (latcheckcat 6), 1 corrected in main CR5; 1 flagged for correction in check 76 below; 1 09jul18 - already flagged below
list pid primarysite hx morph basis beh cr5id if hxcheckcat==10
/*
count if topcat!=62 & morphcat==38 //0 10apr18 - corrected above in check 73 & 74
list pid primarysite hx morph basis beh cr5id if topcat!=62 & morphcat==38
*/

** Check 76 - invalid (primarysite vs hx)
** Add reviewer comments to those that need to be corrected
replace checkflag76=76 if pid=="20130366" & cr5id=="T1S1" | pid=="20130665" & cr5id=="T1S1" | pid=="20080847" & cr5id=="T1S1" | pid=="20130679" & cr5id=="T1S1"
replace reviewertxt3="JC 06mar2018: pid 20130366 - Update T1's primary site & topog. to: RT CERVICAL LYMPH NODE and C77.0." ///
		if pid=="20130366" & cr5id=="T1S1"
replace reviewertxt3="JC 06mar2018: pid 20130665 - Update T1's primary site & topog. to: PSU and C80.9." ///
		if pid=="20130665" & cr5id=="T1S1"
replace reviewertxt3="JC 06mar2018: pid 20080847 - Update T1's primary site & topog. to: BONE MARROW and C42.1." ///
		if pid=="20080847" & cr5id=="T1S1"
replace reviewertxt3="JC 10apr2018: pid 20130679 - Update T1's primary site & topog. to: 'MENINGES-...' and C70.0." ///
		if pid=="20130679" & cr5id=="T1S1"

	
count if topography!=. //2407 06mar18; 2414 09jul18
count if topcat!=. //2407 06mar18; 2414 09jul18
count if morph!=. //2407 06mar18; 2414 09jul18
count if morphcat!=. //2407 06mar18; 2414 09jul18
count if hxcheckcat!=. //4 08mar18; 4 09jul18
	

** Below lists used to visually check primarysite vs hx and to compile/categorize specific checks (see hxcheckcat in '1_prep_cancer.do')
/* Not needed as using IARCcrgTools Check on pg7 (site/histology)
sort topography morph pid
** MORPH CATS 1-5
count if morphcat!=. & morphcat<6 & checkflag75!=75 //979 06mar18
list pid topcat top morphcat morph cr5id if morphcat!=. & morphcat<6 & checkflag75!=75

** MORPH CATS 6-9
count if morphcat!=. & morphcat>5 & morphcat<10 & checkflag75!=75 //697 06mar18
list pid topcat top morphcat morph cr5id if morphcat!=. & morphcat>5 & morphcat<10 & checkflag75!=75

** MORPH CATS 10-55
count if morphcat!=. & morphcat>9 & checkflag75!=75 //731 06mar18
list pid topcat top morphcat morph cr5id if morphcat!=. & morphcat>5 & morphcat<10 & checkflag75!=75
*/

** Check 75 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag75=75 if checkflag76!=76		
		


** Check 77 & 78 - possibly invalid (age/site/histology); Review done visually via lists below and specific checks created (agecheckcat). 
** IARCcrgTools Checks for unlikely combinations (age/site/histology) pgs 6&7.
** Check 77=Reviewed/Corrected by DA/Reviewer; no errors
** Check 78=Invalid (age/site/histology) generated via agecheckcat
** First, flag errors and assign as checkflag 78 then
** flag rest of cases as checkflag 77 (no errors)
** When running this code on 2014 abstractions then need to use lists that are after the agecheckcat (scroll down)

** Check 78 - invalid(age/site/histology)
** NEED TO CHANGE IN MAIN CR5:

** agecheckcat 1: Age<3 & Hx=Hodgkin Lymphoma
count if agecheckcat==1 //0 22mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==1

** agecheckcat 2: Age 10-14 & Hx=Neuroblastoma
count if agecheckcat==2 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==2

** agecheckcat 3: Age 6-14 & Hx=Retinoblastoma
count if agecheckcat==3 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==3

** agecheckcat 4: Age 9-14 & Hx=Wilm's Tumour
count if agecheckcat==4 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==4

** agecheckcat 5: Age 0-8 & Hx=Renal carcinoma
count if agecheckcat==5 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==5

** agecheckcat 6: Age 6-14 & Hx=Hepatoblastoma
count if agecheckcat==6 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==6

** agecheckcat 7: Age 0-8 & Hx=Hepatic carcinoma
count if agecheckcat==7 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==7

** agecheckcat 8: Age 0-5 & Hx=Osteosarcoma
count if agecheckcat==8 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==8

** agecheckcat 9: Age 0-5 & Hx=Chondrosarcoma
count if agecheckcat==9 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==9

** agecheckcat 10: Age 0-3 & Hx=Ewing sarcoma
count if agecheckcat==10 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==10

** agecheckcat 11: Age 8-14 & Hx=Non-gonadal germ cell
count if agecheckcat==11 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==11

** agecheckcat 12: Age 0-4 & Hx=Gonadal carcinoma
count if agecheckcat==12 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==12

** agecheckcat 13: Age 0-5 & Hx=Thyroid carcinoma
count if agecheckcat==13 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==13

** agecheckcat 14: Age 0-5 & Hx=Nasopharyngeal carcinoma
count if agecheckcat==14 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==14

** agecheckcat 15: Age 0-4 & Hx=Skin carcinoma
count if agecheckcat==15 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==15

** agecheckcat 16: Age 0-4 & Hx=Carcinoma, NOS
count if agecheckcat==16 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==16

** agecheckcat 17: Age 0-14 & Hx=Mesothelial neoplasms
count if agecheckcat==17 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==17

** agecheckcat 18: Age <40 & Hx=814_ & Top=61_
count if agecheckcat==18 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==18

** agecheckcat 19: Age <20 & Top=15._,19._,20._,21._,23._,24._,38.4,50._53._,54._,55._
count if agecheckcat==19 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==19

** agecheckcat 20: Age <20 & Top=17._ & Morph<9590(ie.not lymphoma)
count if agecheckcat==20 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==20

** agecheckcat 21: Age <20 & Top=33._ or 34._ or 18._ & Morph!=824_(ie.not carcinoid)
count if agecheckcat==21 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==21

** agecheckcat 22: Age >45 & Top=58._ & Morph==9100(chorioca.)
count if agecheckcat==22 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==22

** agecheckcat 23: Age <26 & Morph==9732(myeloma) or 9823(BCLL)
count if agecheckcat==23 //0 26mar18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==23

** agecheckcat 24: Age >15 & Morph==8910/8960/8970/8981/8991/9072/9470/9490/9500/951_/9687
count if agecheckcat==24 //0 03apr18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==24

** agecheckcat 25: Age <15 & Morph==9724
count if agecheckcat==25 //0 03apr18; 0 09jul18
list pid cr5id age hx morph dxyr if agecheckcat==25


** Check 78 - invalid (age/site/histology)
** Add reviewer comments to those that need to be corrected
/* Not needed as no errors flagged in checkflag 78 as of 03apr18.
replace checkflag78=78 if pid=="" & cr5id=="T1S1" | pid=="" & cr5id=="T1S1"
replace reviewertxt3="JC 26mar2018: pid ... - ..." ///
		if pid=="" & cr5id=="T1S1"
*/

** Check 77 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag77=77 if checkflag78!=78

** Check 79 & 80 - possibly invalid (sex/histology); Review done visually via lists below and specific checks created (sexcheckcat). 
** IARCcrgTools Checks for unlikely combinations (sex/histology) pg 7.
** Check 79=Reviewed/Corrected by DA/Reviewer; no errors
** Check 80=Invalid (sex/histology) generated via sexcheckcat
** First, flag errors and assign as checkflag 80 then
** flag rest of cases as checkflag 79 (no errors)
** When running this code on 2014 abstractions then need to use lists that are after the sexcheckcat (scroll down)

** Check 80 - invalid(sex/histology)
** NEED TO CHANGE IN MAIN CR5:
** Of note, histological family in IARCcrgTools Check doc refers to the family groupings that appear in Appendix 1 of
** same doc under the heading 'Family Number'
** sexcheckcat 1: Sex=male & Hx family=23,24,25,26,27
count if sexcheckcat==1 //0 22mar18; 0 09jul18
list pid cr5id age hx morph hxfamcat dxyr if sexcheckcat==1

** sexcheckcat 2: Sex=female & Hx family=28 or 29
count if sexcheckcat==2 //0 22mar18; 0 09jul18
list pid cr5id age hx morph hxfamcat dxyr if sexcheckcat==2

** Check 80 - invalid (sex/histology)
** Add reviewer comments to those that need to be corrected
/* Not needed as no errors flagged in checkflag 80 as of 04apr18.
replace checkflag80=80 if pid=="" & cr5id=="T1S1" | pid=="" & cr5id=="T1S1"
replace reviewertxt3="JC 26mar2018: pid ... - ..." ///
		if pid=="" & cr5id=="T1S1"
*/

** Check 79 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag79=79 if checkflag80!=80

** Check 81 & 82 - possibly invalid (site/histology); Review done visually via lists below and specific checks created (sitecheckcat). 
** IARCcrgTools Checks for unlikely combinations (site/histology) pg 7.
** Check 81=Reviewed/Corrected by DA/Reviewer; no errors
** Check 82=Invalid (site/histology) generated via sitecheckcat
** First, flag errors and assign as checkflag 80 then
** flag rest of cases as checkflag 81(no errors)
** When running this code on 2014 abstractions then need to use lists that are after the sitecheckcat (scroll down)

** Check 82 - invalid(site/histology)
** NEED TO CHANGE IN MAIN CR5:
** Of note, histological family in IARCcrgTools Check doc refers to the family groupings that appear in Appendix 1 of
** same doc under the heading 'Family Number'
** sitecheckcat 1: NOT haem. tumours
count if sitecheckcat==1 //0 22mar18; 0 09jul18
list pid cr5id age hx morph dxyr if sitecheckcat==1

** sitecheckcat 2: NOT site-specific carcinomas
count if sitecheckcat==2 //0 22mar18; 0 09jul18
list pid cr5id age hx morph dxyr if sitecheckcat==2

** sitecheckcat 3: NOT site-specific sarcomas
count if sitecheckcat==3 //0 22mar18; 0 09jul18
list pid cr5id age hx morph dxyr if sitecheckcat==3

** sitecheckcat 4: Top=Bone; Hx=Giant cell sarc. except bone
count if sitecheckcat==4 //0 22mar18; 0 09jul18
list pid cr5id age hx morph dxyr if sitecheckcat==4

** sitecheckcat 5: NOT sarcomas affecting CNS
count if sitecheckcat==5 //0 22mar18; 0 09jul18
list pid cr5id age hx morph dxyr if sitecheckcat==5

** sitecheckcat 6: NOT sites for Kaposi sarcoma
count if sitecheckcat==6 //0 22mar18; 0 09jul18
list pid cr5id age hx morph dxyr if sitecheckcat==6

** sitecheckcat 7: Top=Bone; Hx=extramedullary plasmacytoma
count if sitecheckcat==7 //0 22mar18; 0 09jul18
list pid cr5id age hx morph dxyr if sitecheckcat==7


** Check 80 - invalid (site/histology)
** Add reviewer comments to those that need to be corrected
/* Not needed as no errors flagged in checkflag 82 as of 04apr18.
replace checkflag82=82 if pid=="" & cr5id=="T1S1" | pid=="" & cr5id=="T1S1"
replace reviewertxt3="JC 26mar2018: pid ... - ..." ///
		if pid=="" & cr5id=="T1S1"
*/

** Check 81 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag81=81 if checkflag82!=82


****************
** Laterality **
****************
** Check 83 - Laterality missing
count if lat==. & primarysite!="" //0 04apr18; 0 09jul18
list pid lat primarysite cr5id if lat==. & primarysite!=""
replace checkflag83=83 if lat==. & primarysite!=""

** Check 84 - Laterality length
** Need to create string variable for laterality
gen laterality=lat
tostring laterality, replace
** Need to change all laterality=="." to laterality==""
replace laterality="" if laterality=="." //2751 changes made 04apr18
count if laterality!="" & length(laterality)!=1 //0 04apr18; 0 09jul18
list pid laterality lat cr5id if laterality!="" & length(laterality)!=1
replace checkflag84=84 if laterality!="" & length(laterality)!=1
 
** Check 85 & 86 - invalid (laterality); Review done visually via lists below and specific checks created (latcheckcat). 
** Check 85=Reviewed/Corrected by DA/Reviewer; no errors
** Check 86=Invalid (laterality) generated via latcheckcat
** First, flag errors and assign as checkflag 86 then
** flag rest of cases as checkflag 85(no errors)
** When running this code on 2014 abstractions then need to use lists that are after the latcheckcat (scroll down)

** Check 86 - invalid(laterality)
sort pid

** latcheckcat 1: COD='left'; COD=cancer (codcat!=1); latcat>0; lat!=left
count if latcheckcat==1 //0 04apr18; 0 09jul18
list pid cr5id primarysite lat cr5cod dxyr if latcheckcat==1

** latcheckcat 2: COD='right'; COD=cancer (codcat!=1); latcat>0; lat!=right
count if latcheckcat==2 //0 04apr18; 0 09jul18
list pid cr5id primarysite lat cr5cod dxyr if latcheckcat==2

** latcheckcat 3: CFdx='left'; latcat>0; lat!=left
count if latcheckcat==3 //0 04apr18; 0 09jul18
list pid cr5id primarysite lat cfdx dxyr if latcheckcat==3

** latcheckcat 4: CFdx='right'; latcat>0; lat!=right
count if latcheckcat==4 //0 04apr18; 0 09jul18
list pid cr5id primarysite lat cfdx dxyr if latcheckcat==4

** latcheckcat 5: topog==809 & lat!=0-paired site (in accord with SEER Prog. Coding manual 2016 pg 82 #1.a.)
** 20080075 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080079 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080085 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080095 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080096 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080117 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080267 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080787 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080804 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080830 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080842 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20081011 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20081012 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20081059 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20081107 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20081118 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20090065 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
count if latcheckcat==5 //61 05apr18 - 17 changed in main CR5; 44 flagged in checkflag 86; 40 09jul18 - already flagged.
list pid cr5id primarysite topography lat dxyr if latcheckcat==5

** latcheckcat 6: latcat>0 & lat==0 or 8 (in accord with SEER Prog. Coding manual 2016 pg 82 #2)
count if latcheckcat==6 //70 09apr18 - 66 corrected in main CR5; 4 flagged in check 86 below; 4 09jul18 - already flagged.
** 20080308 T1, T2, T3: Changed in main CR5 lat from NA to right, right and unk-no info for lat, respectively in accord with SEER prog. coding manual 2016 rule #6; altho T3 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20080336 T1: Changed in main CR5 lat from NA to right & primary site from 'back' to 'skin - rt lower back' in accord with SEER prog. coding manual 2016 rule #2 & MasterDb Clin Dets. ID#411.
** 20080356 T1: Changed in main CR5 lat from NA to left, primary site to 'lt eye muscle...' in accord with SEER prog. coding manual 2016 rule #2.
** 20080379 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080381 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080407 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080425 T2: Changed in main CR5 lat from NA to unk-no info for lat, prim site to 'centre of nose', in accord with SEER prog. coding manual 2016 rule #2; altho T2 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20080430 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; altho T1 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20080435 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080437 T1, T2: Changed in main CR5 lat from NA to unk-no info for lat, respectively in accord with SEER prog. coding manual 2016 rule #6.
** 20080439 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080440 T1, T2: Changed in main CR5 lat from NA to unk-no info for lat, respectively in accord with SEER prog. coding manual 2016 rule #6.
** 20080441 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080442 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080446 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080448 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080456 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080466 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080468 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080469 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080471 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080472 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080473 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080475 T2, T3: Changed in main CR5 lat from NA to unk-no info for lat, respectively in accord with SEER prog. coding manual 2016 rule #6.
** 20080496 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; altho T1 primary site stated as midline(sternum), the midline code (5) not to be used for dx prior to 2010.
** 20080626 T6: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; altho T6 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20080627 T1: Changed in main CR5 lat from NA to unk-no info for lat, primsite to 'lower mid back' in accord with SEER prog. coding manual 2016 rule #2; altho T1 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20080655 T2: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; altho T2 primary site stated as midline(sternum), the midline code (5) not to be used for dx prior to 2010.
** 20080658 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; altho T1 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20080672 T1: Changed in main CR5 lat from NA to right & primary site to 'skin - rt chest' in accord with SEER prog. coding manual 2016 rule #2.
** 20080678 T1: Changed in main CR5 lat from NA to left in accord with SEER prog. coding manual 2016 rule #2.
** 20080687 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; altho T1 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20080696 T1, T2: Changed in main CR5 T1, T2 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; altho T1 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20080702 T1: Changed in main CR5 lat from NA to left & primary site to 'meninges-lt frontal lobe' in accord with SEER prog. coding manual 2016 rule #2.
** 20080705 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6.
** 20080708 T1: Changed in main CR5 lat from NA to left & primary site to 'skin-lt upper back' in accord with SEER prog. coding manual 2016 rule #2.
** 20080710 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; altho T1 primary site stated as midline(sternum), the midline code (5) not to be used for dx prior to 2010.
** 20080712 T1: Changed in main CR5 lat from NA to left & primary site to 'skin-sternum & lt pectoral' in accord with SEER prog. coding manual 2016 rule #2.
** 20080713 T1: Changed in main CR5 lat from NA to right & primary site to 'skin-rt upper pectoral' in accord with SEER prog. coding manual 2016 rule #2.
** 20080718 T1: Changed in main CR5 lat from NA to left & primary site to 'skin-lt anterior hair line' in accord with SEER prog. coding manual 2016 rule #2.
** 20080722 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; altho T1 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20080728 T2: Changed in main CR5 lat from NA to right & primary site to 'skin-rt anterior hair line' in accord with SEER prog. coding manual 2016 rule #2.
** 20080736 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; altho T1 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20080739 T6: Changed in main CR5 lat from NA to left & primary site to 'skin-lt forehead' in accord with SEER prog. coding manual 2016 rule #2.
** 20080742 T1: Changed in main CR5 lat from NA to left & primary site to 'skin-lt malar region' in accord with SEER prog. coding manual 2016 rule #2.
** 20080748 T1: Changed in main CR5 lat from NA to unk-no info for lat, primsite to 'skin-central chest' in accord with SEER prog. coding manual 2016 rule #6; altho T1 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20080752 T1: Changed in main CR5 lat from NA to left & primary site to 'skin-lt back' in accord with SEER prog. coding manual 2016 rule #2.
** 20080764 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; altho T1 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20080765 T1: Changed in main CR5 lat from NA to left & primary site to 'skin-lt lower back' in accord with SEER prog. coding manual 2016 rule #2.
** 20080766 T1: Changed in main CR5 lat from NA to left in accord with SEER prog. coding manual 2016 rule #2.
** 20080823 T1: Changed in main CR5 lat from NA to left & primary site to 'cerebral-lt thalamic region' in accord with SEER prog. coding manual 2016 rule #2.
** 20080869 T1: Changed in main CR5 lat from NA to left & primary site to 'lt pleura' in accord with SEER prog. coding manual 2016 rule #2.
** 20081030 T1: Changed in main CR5 lat from NA to left & primary site to 'lt lung' in accord with SEER prog. coding manual 2016 rule #2.
** 20081055 T1: Changed in main CR5 lat from NA to unk-no info for lat in accord with SEER prog. coding manual 2016 rule #6, changed primary site to 'meninges-olfactory groove', topog from 711 to 700 as incorrectly coded.
** 20081088 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; altho T1 primary site stated as midline, the midline code (5) not to be used for dx prior to 2010.
** 20081090 T1: Changed in main CR5 lat from NA to unk-no info for lat in accord with SEER prog. coding manual 2016 rule #6.
** 20081105 T1: Changed in main CR5 lat from NA to unk-no info for lat in accord with SEER prog. coding manual 2016 rule #6.
** 20090066 T1: Changed in main CR5 lat from NA to unk-no info for lat in accord with SEER prog. coding manual 2016 rule #6.
list pid cr5id topography lat latcat dxyr if latcheckcat==6

** latcheckcat 7: latcat!=ovary,lung,eye,kidney & lat==4 (in accord with SEER Prog. Coding manual 2016 pg 82 #4 & IARC MP recommendations for recording #1)
** 20080310 T3, T7: Changed in main CR5 T3 lat from bilat. to right; Abstracted T7 with lat to left; see MasterDb ID #1412.
** 20080386 T1, T2: Changed in main CR5 T1 lat from bilat. to right; Abstracted T2 with lat to left; see MasterDb ID #1103.
** 20080432 T1, T2: Changed in main CR5 T1 lat from bilat. to right; Abstracted T2 with lat to left; see MasterDb ID #1297.
** 20080454 T1: Changed in main CR5 lat from bilateral to left, primary site to 'skin-lt side face' in accord with SEER prog. coding manual 2016 rule #2.
** 20080465 T1, T4: Changed in main CR5 T1 lat from bilat. to right; Abstracted T4 with lat to left; see MasterDb ID #1278.
** 20080499 T1, T3: Changed in main CR5 T1 lat from bilat. to right; Abstracted T3 with lat to left; see MasterDb ID #2142.
** 20080593 T1: Changed in main CR5 lat from bilateral to NA, primary site to 'colon - transverse' in accord with SEER prog. coding manual 2016 rule #2.
** 20080635 T1: Changed in main CR5 lat from bilateral to right, primary site to 'lymph node - rt posterior triangle neck' in accord with SEER prog. coding manual 2016 rule #2.
** 20080671 T1: Changed in main CR5 lat from bilateral to NA in accord with SEER prog. coding manual 2016 rule #2 for thyroid.
** 20080725 T1, T2: Changed in main CR5 T1 lat from bilat. to right; Abstracted T2 with lat to left; see MasterDb ID #2325.
** 20080733 T1, T4: Changed in main CR5 T1 lat from bilat. to right, hx from 'adenoid cystic bcc' to 'solid bcc', morph from 8098 to 8090; Abstracted T4 with lat to left, hx 'adenoid cystic bcc', morph 8098; see MasterDb ID #1036.
** 20080739 T4: Changed in main CR5 lat from bilateral to unk-no info for lat in accord with SEER prog. coding manual 2016 rule #6.
** 20080747 T3, T8: Changed in main CR5 T3 lat from bilat. to right; Abstracted T8 with lat to left; see CR5 Comment 3.
** 20081089 T1, T2: Changed in main CR5 T1 lat from bilat. to right; Abstracted T2 with lat to left; see MasterDb ID #1284.
** 20100006 T2, T3: Changed in main CR5 T2 lat from bilat. to right, primary site to 'skin-rt upper & forearm'; Abstracted T3 with lat to left; see CR5 Comment 2.
** 20130550 T1: Changed in main CR5 lat from bilateral to NA in accord with SEER prog. coding manual 2016 rule #2 for bile duct.
** 20130602 T1: Changed in main CR5 lat from bilateral to NA in accord with SEER prog. coding manual 2016 rule #2 for thyroid.
count if latcheckcat==7 //17 10apr18 - 16 corrected in main CR5; 1 flagged in check 86; 0 09jul18
list pid cr5id primarysite topography lat latcat dxyr if latcheckcat==7

** latcheckcat 8: latcat=meninges/brain/CNS/skin-face,trunk & dxyr>2009 & lat!=5 & lat=NA (in accord with SEER Prog. Coding manual 2016 pg 83 #5) (lat 5-midline only for 2010 onwards dx)
** 20080435 T2: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; laterality not mentioned.
** 20080436 T2: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; laterality not mentioned.
** 20080438 T1: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; laterality not mentioned.
** 20080443 T6, T7: Changed in main CR5 T6 lat from NA to left, primary site to 'skin - back lt lumbar'; Abstracted T7 with lat to right; see MasterDb ID #4899.
** 20080474 T2: Changed in main CR5 lat from NA to unk-no info for lat, in accord with SEER prog. coding manual 2016 rule #6; laterality not mentioned.
** 20080705 T4: Changed in main CR5 lat from NA to 5-midline, in accord with SEER prog. coding manual 2016 rule #5; laterality in primary site & dx after 2009.
** 20080729 T2: Changed in main CR5 lat from NA to 5-midline, primary site to 'skin-central upper back', in accord with SEER prog. coding manual 2016 rule #5; laterality in primary site & dx after 2009.
** 20080733 T2: Changed in main CR5 lat from NA to 5-midline, primary site to 'skin-central upper back', hx to 'superficial type bcc', morph from 9080 to 8091 as MasterDb #4806 dx specifies type, in accord with SEER prog. coding manual 2016 rule #5; laterality in primary site & dx after 2009.
** 20080738 T6: Changed in main CR5 lat from NA to 5-midline, in accord with SEER prog. coding manual 2016 rule #5; laterality in primary site & dx after 2009.
** 20080772 T2: Changed in main CR5 lat from NA to 5-midline, primary site to 'skin-central upper back', in accord with SEER prog. coding manual 2016 rule #5; laterality in MasterDb #5020 & dx after 2009.
** 20100004 T1: Changed in main CR5 lat from NA to 5-midline, in accord with SEER prog. coding manual 2016 rule #5; laterality in primary site & dx after 2009.
** 20100005 T2: Changed in main CR5 lat from NA to left, primary site to 'skin-forehead lt of centre' in accord with SEER prog. coding manual 2016 rule #2; see CR5 Comment 2.
** 20130253 T1: Changed in main CR5 lat from NA to right, primary site to 'rt groin' in accord with SEER prog. coding manual 2016 rule #2; see CR5 Comments.
** 20130583 T1: Changed in main CR5 lat from NA to 5-midline, primary site to 'mass involving both frontal lobes' in accord with SEER prog. coding manual 2016 rule #5; see CR5 Comments.
count if latcheckcat==8 //15 11apr18 - 14 corrected in main CR5; 1 flagged in check 86 below; 1 09jul18 - already flagged.
list pid cr5id primarysite topography lat latcat dxyr if latcheckcat==8

** latcheckcat 9: latcat!=meninges/brain/CNS/skin-face,trunk & dxyr>2009 & lat==5 (in accord with SEER Prog. Coding manual 2016 pg 83 #5.a.i.) (lat 5-midline only for 2010 onwards dx)
count if latcheckcat==9 //0 10apr18; 0 09jul18
list pid cr5id primarysite topography lat latcat dxyr if latcheckcat==9

** latcheckcat 10: latcat!=0,8,12,19,20 & basis==0 & lat=NA (in accord with SEER Prog. Coding manual 2016 pg 83 #6.b.)
count if latcheckcat==10 //2 11apr18 - both flagged in check 86 below; 2 09jul18 - already flagged.
list pid cr5id primarysite topography lat latcat dxyr if latcheckcat==10

** latcheckcat 11: primsite=thyroid and lat!=NA
** IMPORTANT: WHEN IMPORTING BATCH CORRECTIONS - UNTICK 'Do Checks' IN MAIN CR5! WHEN CHECKS ARE RUN THE RECORD STATUS CHANGES.
** Changed in MAIN CR5 all of the 20 cases from lat=NA to lat=ND by exporting tumour table only as .txt, importing into excel, updating laterality to NA, updating 
** comments to "JC 11APR18: Changed laterality to 8-NA in accordance with latcheckcat 11 (thyroid) & SEER prog. coding manual 2016 rules for primary sites that do not require laterality code. ",
** saving excel workbook as .txt and then importing into main CR5
** Filter used to export data in main CR5 (206 cases as only tumour data exported so e.g. cr5id=T1S2 excluded): Topography = '739' AND Laterality <> '8'
count if latcheckcat==11 //20 11apr18 - all corrected via export/import to main CR5; 0 09jul18
list pid cr5id primarysite topography lat latcat dxyr if latcheckcat==11

** latcheckcat 12: latcat=no lat cat (i.e. laterality n/a); topog!=809; lat!=N/A; latcheckcat==. (this can capture any that have not already been corrected in above latcheckcats)
/* BELOW CASES WERE CHANGED IN MAIN CR5 BASED ON OLD CHECK (latcheckcat 5 below)
** 20080596 T1: Changed directly in main CR5 morph from lat=left to lat=NA'.
** 20080614 T1: Changed directly in main CR5 morph from lat=left to lat=NA'.
** 20080985 T1: Changed directly in main CR5 morph from lat=left to lat=NA'.
** 20080966 T1: Changed directly in main CR5 morph from lat=right to lat=NA'.
** 20080850 T1: Changed T1 laterality from left to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080700 T2: Changed T2 laterality from left to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
count if latcheckcat==5 //16 04apr18 - flagged 9 below in checkflag 86; corrected 7 in main CR5
list pid cr5id primarysite topography lat latcat dxyr if latcheckcat==5
*/
count if latcheckcat==12 //220 05apr18; 202 10apr18; 202(186 in CR5) 11apr18 - all corrected via export/import to main CR5; 0 09jul18
list pid cr5id primarysite topography lat latcat dxyr if latcheckcat==12
** IMPORTANT: WHEN IMPORTING BATCH CORRECTIONS - UNTICK 'Do Checks' IN MAIN CR5! WHEN CHECKS ARE RUN THE RECORD STATUS CHANGES.
** Changed in MAIN CR5 all of the 220 cases lat=NA by exporting tumour table only as .txt, importing into excel, updating laterality to NA, updating 
** comments to "JC 11APR18: Changed T laterality from  to 8-NA in accordance with latcheckcat 5 & SEER prog. coding manual 2016 rules for primary sites that do not require laterality code. ",
** saving excel workbook as .txt and then importing into main CR5
** Filter used to export data in main CR5 (186 cases as only tumour data exported so e.g. cr5id=T1S2 excluded): Topography <> '079' AND Topography <> '080' AND Topography <> '081' AND Topography <> '090' AND Topography <> '091' AND Topography <> '098' AND Topography <> '099' AND Topography <> '300' AND Topography <> '301' AND Topography <> '310' AND Topography <> '312' AND Topography <> '340' AND Topography <> '341' AND Topography <> '342' AND Topography <> '343' AND Topography <> '348' AND Topography <> '349' AND Topography <> '384' AND Topography <> '400' AND Topography <> '401' AND Topography <> '402' AND Topography <> '403' AND Topography <> '413' AND Topography <> '414' AND Topography <> '441' AND Topography <> '442' AND Topography <> '443' AND Topography <> '445' AND Topography <> '446' AND Topography <> '447' AND Topography <> '471' AND Topography <> '472' AND Topography <> '491' AND Topography <> '492' AND Topography <> '500' AND Topography <> '501' AND Topography <> '502' AND Topography <> '503' AND Topography <> '504' AND Topography <> '505' AND Topography <> '506' AND Topography <> '508' AND Topography <> '509' AND Topography <> '569' AND Topography <> '570' AND Topography <> '620' AND Topography <> '621' AND Topography <> '629' AND Topography <> '630' AND Topography <> '631' AND Topography <> '649' AND Topography <> '659' AND Topography <> '669' AND Topography <> '690' AND Topography <> '691' AND Topography <> '692' AND Topography <> '693' AND Topography <> '694' AND Topography <> '695' AND Topography <> '696' AND Topography <> '698' AND Topography <> '699' AND Topography <> '700' AND Topography <> '710' AND Topography <> '711' AND Topography <> '712' AND Topography <> '713' AND Topography <> '714' AND Topography <> '722' AND Topography <> '723' AND Topography <> '724' AND Topography <> '725' AND Topography <> '740' AND Topography <> '741' AND Topography <> '749' AND Topography <> '754' AND Topography <> '809' AND DiagnosisYear <'2014' AND Laterality <> '' AND Laterality <> '8'

/* - NOT USING BELOW CHECK AS NEW CHECK (latcheckcat 5 above) WILL DEAL WITH THIS BUT HAD TO KEEP AS CHANGED BACK FROM UPDATES NOTED BELOW IN MAIN CR5
** latcheckcat 5: topography=809 & lat==N/A
** 20080075 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080079 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080085 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080095 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080117 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080267 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080787 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080804 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080830 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20080842 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20081011 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20081012 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
** 20090065 T1: Changed directly in main CR5 morph from lat=NA to 0(not paired site) in accordance with SEER prog. coding manual 2016 rules for topog=C80.9.
count if latcheckcat==5 //30 04apr18 - flagged 9 below in checkflag 86; corrected 7 in main CR5
list pid cr5id primarysite topography lat dxyr if latcheckcat==5
*/

** Check 86 - invalid (laterality)
** Add reviewer comments to those that need to be corrected

replace checkflag86=86 if pid=="20130582" & cr5id=="T1S1" | pid=="20130550" & cr5id=="T1S1" | pid=="20130031" & cr5id=="T1S1" | pid=="20130174" & cr5id=="T1S1" ///
						  | pid=="20130420" & cr5id=="T1S1" | pid=="20130184" & cr5id=="T1S1" | pid=="20130525" & cr5id=="T1S1" | pid=="20130206" & cr5id=="T1S1" ///
						  | pid=="20080837" & cr5id=="T1S1" | pid=="20081093" & cr5id=="T1S1" ///
						  | pid=="20130220" & cr5id=="T1S1" | pid=="20130335" & cr5id=="T1S1" | pid=="20130344" & cr5id=="T1S1" | pid=="20130351" & cr5id=="T1S1" ///
						  | pid=="20130397" & cr5id=="T1S1" | pid=="20130398" & cr5id=="T1S1" | pid=="20130399" & cr5id=="T1S1" | pid=="20130426" & cr5id=="T1S1" ///
						  | pid=="20130516" & cr5id=="T1S1" | pid=="20130520" & cr5id=="T1S1" | pid=="20130564" & cr5id=="T1S1" | pid=="20130566" & cr5id=="T1S1" ///
						  | pid=="20130816" & cr5id=="T1S1" | pid=="20080859" & cr5id=="T1S1" | pid=="20080860" & cr5id=="T1S1" | pid=="20080908" & cr5id=="T1S1" ///
						  | pid=="20080911" & cr5id=="T1S1" | pid=="20081048" & cr5id=="T1S1" | pid=="20081113" & cr5id=="T1S1" | pid=="20081126" & cr5id=="T1S1" ///
						  | pid=="20130177" & cr5id=="T1S1" | pid=="20130188" & cr5id=="T1S1" | pid=="20130189" & cr5id=="T1S1" | pid=="20130521" & cr5id=="T1S1" ///
						  | pid=="20130522" & cr5id=="T1S1" | pid=="20130524" & cr5id=="T1S1" | pid=="20130527" & cr5id=="T1S1" | pid=="20130552" & cr5id=="T1S1" ///
						  | pid=="20130555" & cr5id=="T1S1" | pid=="20130593" & cr5id=="T1S1" | pid=="20130599" & cr5id=="T1S1" | pid=="20130624" & cr5id=="T1S1" ///
						  | pid=="20130724" & cr5id=="T1S1" | pid=="20130777" & cr5id=="T1S1" | pid=="20130810" & cr5id=="T1S1" | pid=="20080636" & cr5id=="T2S1" ///
						  | pid=="20130055" & cr5id=="T1S1" | pid=="20130265" & cr5id=="T1S1" | pid=="20130538" & cr5id=="T1S1" | pid=="20130602" & cr5id=="T1S1" ///
						  | pid=="20130679" & cr5id=="T1S1" | pid=="20130423" & cr5id=="T1S1" | pid=="20130635" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130582 - Update T1's laterality to 8-NA." ///
		if pid=="20130582" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130550 - Update T1's laterality to 8-NA." ///
		if pid=="20130550" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130031 - Update T1's laterality to 8-NA." ///
		if pid=="20130031" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130174 - Update T1's laterality to 8-NA." ///
		if pid=="20130174" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130420 - Update T1's laterality to 8-NA." ///
		if pid=="20130420" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130184 - Update T1's laterality to 8-NA." ///
		if pid=="20130184" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130525 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130525" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130206 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130206" & cr5id=="T1S1"
/* 10jul18 - top changed from 809 to 220
replace reviewertxt4="JC 04apr2018: pid 20130318 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130318" & cr5id=="T1S1"
*/
replace reviewertxt4="JC 04apr2018: pid 20080837 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20080837" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20081093 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20081093" & cr5id=="T1S1"
/* 10jul18 - top changed from 809 to 768
replace reviewertxt4="JC 04apr2018: pid 20130182 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130182" & cr5id=="T1S1"
*/
replace reviewertxt4="JC 04apr2018: pid 20130220 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130220" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130335 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130335" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130344 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130344" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130351 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130351" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130397 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130397" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130398 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130398" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130399 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130399" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130426 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130426" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130516 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130516" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130520 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130520" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130564 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130564" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130566 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130566" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130816 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130816" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20080859 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20080859" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20080860 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20080860" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20080908 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20080908" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20080911 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20080911" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20081048 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20081048" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20081113 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20081113" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20081126 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20081126" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130177 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130177" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130188 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130188" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130189 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130189" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130521 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130521" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130522 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130522" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130524 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130524" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130527 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130527" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130552 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130552" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130555 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130555" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130593 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130593" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130599 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130599" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130624 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130624" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130724 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130724" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130777 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130777" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid 20130810 - Update T1's laterality to 0-not paired site in accordance with SEER prog. coding manual 2016 rules for topog=C80.9." ///
		if pid=="20130810" & cr5id=="T1S1"
replace reviewertxt4="JC 10apr2018: pid 20080636 - Update T2's laterality to 9-no info for lat in accordance with SEER prog. coding manual 2016 rules #5 & #6." ///
		if pid=="20080636" & cr5id=="T2S1"
replace reviewertxt4="JC 10apr2018: pid 20130055 - Update T1's laterality to 2-left in accordance with SEER prog. coding manual 2016 rules #2." ///
		if pid=="20130055" & cr5id=="T1S1"
replace reviewertxt4="JC 10apr2018: pid 20130265 - Update T1's laterality to 2-left in accordance with SEER prog. coding manual 2016 rules #2." ///
		if pid=="20130265" & cr5id=="T1S1"
replace reviewertxt4="JC 10apr2018: pid 20130538 - Update T1's laterality to 9-no info for lat in accordance with SEER prog. coding manual 2016 rule #6." ///
		if pid=="20130538" & cr5id=="T1S1"
replace reviewertxt4="JC 10apr2018: pid 20130602 - Update T1's laterality to 8-NA in accordance with SEER prog. coding manual 2016 rule #2 (thyroid not considered a paired site)." ///
		if pid=="20130602" & cr5id=="T1S1"
replace reviewertxt4="JC 11apr2018: pid 20130679 - Update T1's laterality to 2-left, primary site to '...LT PARIETAL LOBE' in accordance with SEER prog. coding manual 2016 rule #2. See CR5 Comments for laterality." ///
		if pid=="20130679" & cr5id=="T1S1"
replace reviewertxt4="JC 11apr2018: pid 20130423 - Update T1's laterality to 9-no info for lat in accordance with SEER prog. coding manual 2016 rule #6.b." ///
		if pid=="20130423" & cr5id=="T1S1"
replace reviewertxt4="JC 11apr2018: pid 20130635 - Update T1's laterality to 9-no info for lat in accordance with SEER prog. coding manual 2016 rule #6.b." ///
		if pid=="20130635" & cr5id=="T1S1"

** Check 85 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag85=85 if checkflag86!=86



***************
** Behaviour **
***************
** Check 87 - Behaviour missing
count if beh==. & primarysite!="" //0 12apr18; 0 09jul18
list pid beh primarysite cr5id if beh==. & primarysite!=""
replace checkflag87=87 if beh==. & primarysite!=""

** Check 88 - Behaviour length
** Need to create string variable for behaviour
gen behaviour=beh
tostring behaviour, replace
** Need to change all behaviour=="." to behaviour==""
replace behaviour="" if behaviour=="." //2751 changes made 12apr18
count if behaviour!="" & length(behaviour)!=1 //0 12apr18; 0 09jul18
list pid behaviour beh cr5id if behaviour!="" & length(behaviour)!=1
replace checkflag88=88 if behaviour!="" & length(behaviour)!=1
 
** Check 89 & 90 - invalid (behaviour); Review done visually via lists below and specific checks created (behcheckcat & behsitecheckcat). 
** Check 89=Reviewed/Corrected by DA/Reviewer; no errors
** Check 90=Invalid (behaviour) generated via behcheckcat & behsitecheckcat
** First, flag errors and assign as checkflag 90 then
** flag rest of cases as checkflag 89(no errors)
** When running this code on 2014 abstractions then need to use lists that are after the behcheckcat & behsitecheckcat (scroll down)

** Check 90 - invalid(behaviour)

** behcheckcat 1: Beh!=2 & Morph==8503
count if behcheckcat==5 //1 07mar18 - all correct; 0 12apr18; 0 09jul18
list pid hx morph basis beh cr5id if behcheckcat==5
/*
count if beh!=2 & morph==8503 //1 07mar18 - all correct
list pid hx morph basis beh cr5id if beh!=2 & morph==8503
*/

** behcheckcat 2: Beh!=2 & Morph==8077
count if behcheckcat==2 //0 07mar18 - none to correct; 0 09jul18
list pid primarysite hx morph basis beh cr5id if behcheckcat==2
/*
count if beh!=2 & morph==8077 //0 07mar18 - none to correct
list pid primarysite hx morph basis beh cr5id if beh!=2 & morph==8077
*/

** behcheckcat 3: Hx=Squamous & microinvasive & Beh=2 & Morph!=8076
count if behcheckcat==3 //0 07mar18 - none to correct; 0 09jul18
list pid primarysite hx morph basis beh cr5id if behcheckcat==3
/*
count if (regexm(hx, "SQUAMOUS")&regexm(hx, "MICROINVAS")) & beh!=3 & morph!=8076 //0 07mar18 - none to correct
list pid primarysite hx morph basis beh cr5id if (regexm(hx, "SQUAMOUS")&regexm(hx, "MICROINVAS")) & beh!=3 & morph!=8076
*/

** behcheckcat 4: Hx=Bowen & Beh!=2 (want to check skin SCCs that have bowen disease is coded to beh=in-situ)
** 20080741 T2: Changed directly in main CR5 from beh=1(uncertain) to beh=2(in-situ).
count if behcheckcat==4 //1 08mar18 - corrected in above code directly to main CR5; 1 09jul18 - corrected same case again in main CR5
list pid primarysite hx morph basis beh cr5id if behcheckcat==4
/*
count if regexm(hx, "BOWEN") & beh!=2 //1 08mar18 - corrected in above code directly to main CR5.
list pid primarysite hx morph basis beh cr5id if regexm(hx, "BOWEN") & beh!=2
*/

** behcheckcat 5: PrimSite==appendix & Morph==8240 & Beh!=1
count if behcheckcat==5 //0 13mar18; 0 09jul18
list pid primarysite hx morph basis beh cr5id if behcheckcat==5
/*
count if topography==181 & morph==8240 & beh!=1 //0 13mar18
list pid primarysite hx morph basis beh cr5id if topography==181 & morph==8240 & beh!=1
*/

** behcheckcat 6: Hx=adenoma excl. adenocarcinoma & invasion & Morph==8263 & Beh!=2
count if behcheckcat==6 //0 13mar18; 0 09jul18
list pid hx morph beh cr5id if behcheckcat==6
/*
count if regexm(hx, "ADENOMA") & (!strmatch(strupper(hx), "*ADENOCARCINOMA*")&!strmatch(strupper(hx), "*INVASION*")) & beh!=2 & morph==8263 //0 13mar18
list pid hx morph beh cr5id if regexm(hx, "ADENOMA") & (!strmatch(strupper(hx), "*ADENOCARCINOMA*")&!strmatch(strupper(hx), "*INVASION*")) & beh!=2 & morph==8263 
*/

** behcheckcat 7: Morph not listed in ICD-O-3 (IARCcrgTools Check pg 8)
count if behcheckcat==7 //0 13mar18; 0 09jul18
list pid hx morph beh cr5id if behcheckcat==7
/*
count if morphcat==. & morph!=. //0 29mar18
list pid hx morph beh cr5id if morphcat==. & morph!=. 
*/

** Below checks taken from IARCcrgTools pg 8.
** behsitecheckcat 1: Beh==2 & Top==C40._(bone)
count if behsitecheckcat==1 //0 29mar18; 0 09jul18
list pid primarysite topography beh cr5id if behsitecheckcat==1

** behsitecheckcat 2: Beh==2 & Top==C41._(bone,NOS)
count if behsitecheckcat==2 //0 29mar18; 0 09jul18
list pid primarysite topography beh cr5id if behsitecheckcat==2

** behsitecheckcat 3: Beh==2 & Top==C42._(haem)
count if behsitecheckcat==3 //0 29mar18; 0 09jul18
list pid primarysite topography beh cr5id if behsitecheckcat==3

** behsitecheckcat 4: Beh==2 & Top==C47._(ANS)
count if behsitecheckcat==4 //0 29mar18; 0 09jul18
list pid primarysite topography beh cr5id if behsitecheckcat==4

** behsitecheckcat 5: Beh==2 & Top==C49._(tissues)
count if behsitecheckcat==5 //0 29mar18; 0 09jul18
list pid primarysite topography beh cr5id if behsitecheckcat==5

** behsitecheckcat 6: Beh==2 & Top==C70._(meninges)
count if behsitecheckcat==6 //0 29mar18; 0 09jul18
list pid primarysite topography beh cr5id if behsitecheckcat==6

** behsitecheckcat 7: Beh==2 & Top==C71._(brain)
count if behsitecheckcat==7 //0 29mar18; 0 09jul18
list pid primarysite topography beh cr5id if behsitecheckcat==7

** behsitecheckcat 8: Beh==2 & Top==C72._(CNS)
count if behsitecheckcat==8 //0 29mar18; 0 09jul18
list pid primarysite topography beh cr5id if behsitecheckcat==8

** Check 90 - invalid (behaviour)
** Add reviewer comments to those that need to be corrected
/* Not needed as no errors flagged in checkflag 89 as of 12apr18.
replace checkflag90=90 if pid=="" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid ... - Update T1's laterality to 8-NA." ///
		if pid=="..." & cr5id=="T1S1"
*/

** Check 89 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag89=89 if checkflag90!=90


***********
** Grade **
***********
** Check 91 - Grade missing
count if grade==. & primarysite!="" //0 12apr18; 0 09jul18
list pid grade primarysite cr5id if grade==. & primarysite!=""
replace checkflag91=91 if grade==. & primarysite!=""

** Check 92 - Grade length
** Need to create string variable for grade
gen str_grade=grade
tostring str_grade, replace
** Need to change all grade=="." to grade==""
replace str_grade="" if str_grade=="." //2751 changes made 12apr18
count if str_grade!="" & length(str_grade)!=1 //0 12apr18; 0 09jul18
list pid str_grade grade cr5id if str_grade!="" & length(str_grade)!=1
replace checkflag92=92 if str_grade!="" & length(str_grade)!=1
 
** Check 93 & 94 - invalid (grade); Review done visually via lists below and specific checks created (gradecheckcat). 
** Check 93=Reviewed/Corrected by DA/Reviewer; no errors
** Check 94=Invalid (grade) generated via gradecheckcat
** First, flag errors and assign as checkflag 94 then
** flag rest of cases as checkflag 93(no errors)
** When running this code on 2014 abstractions then need to use lists that are after the gradecheckcat (scroll down)

** Check 94 - invalid(grade)

** Below code only applies to 2014 data as 2008 & 2013 data did not collect grade.
** Taken from IACRcrgTools pg 9
** gradecheckcat 1: Beh<3 & Grade<9 & DxYr>2013
count if gradecheckcat==1 //0 12apr18; 0 09jul18
list pid grade beh morph cr5id if gradecheckcat==1

** gradecheckcat 2: Grade>=5 & <=8 & Hx<9590 & DxYr>2013
count if gradecheckcat==2 //0 12apr18; 0 09jul18
list pid grade beh morph cr5id if gradecheckcat==2

** gradecheckcat 3: Grade>=1 & <=4 & Hx>=9590 & DxYr>2013
count if gradecheckcat==3 //0 12apr18; 0 09jul18
list pid grade beh morph cr5id if gradecheckcat==3

** gradecheckcat 4: Grade!=5 & Hx=9702-9709,9716-9726(!=9719),9729,9827,9834,9837 & DxYr>2013
count if gradecheckcat==4 //0 12apr18 (8 from 2008 & 2013 as grade==9(NA)); 0 09jul18
list pid grade beh morph cr5id if gradecheckcat==4

** gradecheckcat 5: Grade!=5 or 7 & Hx=9714 & DxYr>2013
count if gradecheckcat==5 //0 12apr18; 0 09jul18
list pid grade beh morph cr5id if gradecheckcat==5

** gradecheckcat 6: Grade!=5 or 8 & Hx=9700/9701/9719/9831 & DxYr>2013
count if gradecheckcat==6 //0 12apr18; 0 09jul18
list pid grade beh morph cr5id if gradecheckcat==6

** gradecheckcat 7: Grade!=6 & Hx=>=9670,<=9699,9712,9728,9737,9738,>=9811,<=9818,9823,9826,9833,9836 & DxYr>2013
count if gradecheckcat==7 //0 12apr18; 0 09jul18
list pid grade beh morph cr5id if gradecheckcat==7

** gradecheckcat 8: Grade!=8 & Hx=9948 & DxYr>2013
count if gradecheckcat==8 //0 12apr18; 0 09jul18
list pid grade beh morph cr5id if gradecheckcat==8

** gradecheckcat 9: Grade!=1 & Hx=8331/8851/9187/9511 & DxYr>2013
count if gradecheckcat==9 //0 12apr18; 0 09jul18
list pid grade beh morph cr5id if gradecheckcat==9

** gradecheckcat 10: Grade!=2 & Hx=8249/8332/8858/9083/9243/9372 & DxYr>2013
count if gradecheckcat==10 //0 12apr18; 0 09jul18
list pid grade beh morph cr5id if gradecheckcat==10

** gradecheckcat 11: Grade!=3 & HX=8631/8634 & DxYr>2013
count if gradecheckcat==11 //0 12apr18; 0 09jul18
list pid grade beh morph cr5id if gradecheckcat==11

** gradecheckcat 12: Grade!=4 & Hx=8020/8021/8805/9062/9082/9392/9401/9451/9505/9512 & DxYr>2013
count if gradecheckcat==12 //0 12apr18; 0 09jul18
list pid grade beh morph cr5id if gradecheckcat==12


** Check 94 - invalid (grade)
** Add reviewer comments to those that need to be corrected
/* Not needed as no errors flagged in checkflag 93 as of 12apr18.
replace checkflag94=94 if pid=="" & cr5id=="T1S1"
replace reviewertxt4="JC 04apr2018: pid ... - Update T1's laterality to 8-NA." ///
		if pid=="..." & cr5id=="T1S1"
*/

** Check 93 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag93=93 if checkflag94!=94



************************
** Basis of Diagnosis **
************************
** Check 95 - Basis missing
count if basis==. & primarysite!="" //0 12apr18; 0 09jul18
list pid basis primarysite cr5id if basis==. & primarysite!=""
replace checkflag95=95 if basis==. & primarysite!=""

** Check 96 - Basis length
** Need to create string variable for basis
gen bas=basis
tostring bas, replace
** Need to change all bas=="." to bas==""
replace bas="" if bas=="." //2751 changes made 12apr18
count if bas!="" & length(bas)!=1 //0 12apr18; 0 09jul18
list pid bas basis cr5id if bas!="" & length(bas)!=1
replace checkflag96=96 if bas!="" & length(bas)!=1
 
** Check 97 & 98 - invalid (basis); Review done visually via lists below and specific checks created (bascheckcat). 
** Check 97=Reviewed/Corrected by DA/Reviewer; no errors
** Check 98=Invalid (basis) generated via bascheckcat
** First, flag errors and assign as checkflag 98 then
** flag rest of cases as checkflag 97(no errors)
** When running this code on 2014 abstractions then need to use lists that are after the bascheckcat (scroll down)

** Check 98 - invalid(basis)

** bascheckcat 1: morph==8000 & (basis==6|basis==7|basis==8)
** 20080005 T1: Changed in main CR5 treatment1 from sx to hormonorx, treatment1date from 20080228 to 20080414 as indicated by CR5 Comments.
** 20080795 T1: Changed in main CR5 basis from 7 to 5, hx from 'malignancy' to 'metastatic adenoca', morph from 8000 to 8140, laterality from 1 to 9 as indicated by CR5 Comments & MasterDb #3784.
** 20080897 T1: Changed in main CR5 morph from 8000 to 8010, laterality from 9 to 3 as indicated by CR5 Comments & MasterDb #2749.
** 20081125 T1: Changed in main CR5 hx from 'malig. neoplasm' to 'transitional cell ca', morph from 8000 to 8120, IncidDate from 20080225 to 20080215 as indicated by CR5 Comments & MasterDb #3997.
** 20130167 T1: Changed in main CR5 hx from 'carcinoma' to 'poorly differentiated ca', morph from 8000 to 8010 as indicated by CR5 Comments & MasterDb #1584.
** 20130330 T1: Changed in main CR5 basis from 7 to 9 as indicated by CR5 Comments & MasterDb #2776 - no bx seen.
count if bascheckcat==1 //14 12apr18 - 11 corrected in main CR5; 3 flagged in check 98; 9 09jul18 - only 6 as 3 are MSs(multiple source records): 3 flagged below - 20080005,20080565,20130083 flagged in checkflags 71 & 72 above;
list pid cr5id hx basis dxyr if bascheckcat==1

** bascheckcat 2: hx=...OMA & basis!=6/7/8
count if bascheckcat==2 //0 12apr18; 0 09jul18
list pid cr5id hx basis dxyr if bascheckcat==2

** bascheckcat 3: Basis not missing & basis!=cyto/heme/histology... & Hx!=...see BOD/Hx Control pg 47,48 of IARCcrgTools Check Program
** 20080101 T1: Changed directly in main CR5 basis from 3(exp.sx) to 7(hx of prim), IncidD from 20080403 to 20070525 and dxyr from 2008 to 2007 as stated in CR5 comments.
** 20130207 T1: Changed directly in main CR5 morph from M8010 to M8000 as indicated by basis=1 and CR5 edit checks.
** 20130685 T1: Changed directly in main CR5 morph from M8010 to M8000 as indicated by basis=1 and CR5 edit checks.
** 20130798 T2: Changed directly in main CR5 morph from M8010 to M8000 as indicated by basis=3 and CR5 edit checks.
** 20130230 T1: Changed directly in main CR5 morph from M8160 to M8000 as indicated by basis=2 and CR5 edit checks altho PP reviewed & said to leave as is due to obstructive jaundice symptom.
** 20130683 T1: Changed directly in main CR5 morph from M8160 to M8000 as indicated by basis=0 and CR5 edit checks.
** 20130802 T1: Changed directly in main CR5 morph from M8160 to M8000 as indicated by basis=0 and CR5 edit checks.
** 20130550 T1: Changed directly in main CR5 morph from M8162 to M8000 as indicated by basis=2 and CR5 edit checks altho PP reviewed & determined morph (didn't take into account IARC basis coding rules).
** 20080103 T1: Changed directly in main CR5 basis from 1(clin.) to 7(hx of prim), IncidD from 20080302 to 20070907 and dxyr from 2008 to 2007 as stated in CR5 comments.
** 20130271 T1: Changed directly in main CR5 morph from M8312 to M8000 as indicated by basis=2 and CR5 edit checks.
** 20090028 T1: Changed directly in main CR5 basis from 2(clin.ivg) to 7 as indicated in MasterDb path rpt (4658) & CR5 edit checks.
** 20130736 T1: Changed directly in main CR5 morph from M9591 to M9590 as indicated by basis=0, CR5 edit checks and IARCcrgTools Check Program pg 10.
** 20130755 T1: Changed directly in main CR5 morph from M9866 to M9800 as indicated by basis=0, CR5 edit checks and IARCcrgTools Check Program pg 10.
count if bascheckcat==3 //15 13mar18; 0 12apr18; 0 09jul18
list pid primarysite hx morph basis cr5id if bascheckcat==3
/*
count if basis!=. & morph!=8000 & (basis<5|basis>8) & (morph<8150|morph>8154) & morph!=8170 & (morph<8270|morph>8281) ///
		 & (morph!=8800&morph!=8960&morph!=9100&morph!=9140&morph!=9350&morph!=9380&morph!=9384&morph!=9500&morph!=9510) ///
		 & (morph!=9590&morph!=9732&morph!=9761&morph!=9800) //15 13mar18
list pid primarysite hx morph basis cr5id if basis!=. & morph!=8000 & (basis<5|basis>8) & (morph<8150|morph>8154) & morph!=8170 & (morph<8270|morph>8281) ///
		 & (morph!=8800&morph!=8960&morph!=9100&morph!=9140&morph!=9350&morph!=9380&morph!=9384&morph!=9500&morph!=9510) ///
		 & (morph!=9590&morph!=9732&morph!=9761&morph!=9800)
*/

** bascheckcat 4: Hx=mass; Basis=DCO; Morph==8000 - If topog=CNS then terms such as neoplasm & tumour eligible criteria (see Eligibility SOP)
count if bascheckcat==4 //0 12apr18; 0 09jul18
list pid cr5id primarysite hx morph basis dxyr if bascheckcat==4


** Check 98 - invalid (basis)
** Add reviewer comments to those that need to be corrected

replace checkflag98=98 if pid=="20130344" & cr5id=="T1S1" | pid=="20130353" & cr5id=="T1S1" | pid=="20130389" & cr5id=="T1S1"
replace reviewertxt5="JC 12apr2018: pid 20130344 - Update T1's morph to 8010 - see MasterDb #3979." ///
		if pid=="20130344" & cr5id=="T1S1"
replace reviewertxt5="JC 12apr2018: pid 20130353 - Update T1's morph to 8010 - see MasterDb #2166." ///
		if pid=="20130353" & cr5id=="T1S1"
replace reviewertxt5="JC 12apr2018: pid 20130389 - Query T1's morph with PP if to code to M8020: unidfferentiated ca? - see MasterDb #2872." ///
		if pid=="20130389" & cr5id=="T1S1"


** Check 97 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag97=97 if checkflag98!=98


*********************
** Summary Staging **
*********************
** NOTE 1: Staging only done at 5 year intervals so staging done on 2013 data then 2018 and so on;
** NOTE 2: In upcoming years of data collection (2018 dc year), more stagecheckcat checks will be compiled based on site in SEER Summary Staging manual.

** Check 99 - Staging missing
count if staging==. & primarysite!="" //0 12apr18; 0 09jul18
list pid staging basis topography cr5id if staging==. & primarysite!=""
replace checkflag99=99 if staging==. & primarysite!=""

** Check 100 - Staging length
** Need to create string variable for staging
gen stage=staging
tostring stage, replace
** Need to change all stage=="." to stage==""
replace stage="" if stage=="." //2751 changes made 12apr18
count if stage!="" & length(stage)!=1 //0 12apr18; 0 09jul18
list pid stage staging cr5id if stage!="" & length(stage)!=1
replace checkflag100=100 if stage!="" & length(stage)!=1
 
** Check 101 & 102 - invalid (staging); Review done visually via lists below and specific checks created (stagecheckcat). 
** Check 101=Reviewed/Corrected by DA/Reviewer; no errors
** Check 102=Invalid (staging) generated via stagecheckcat
** First, flag errors and assign as checkflag 102 then
** flag rest of cases as checkflag 101(no errors)
** When running this code on 2014 abstractions then need to use lists that are after the stagecheckcat (scroll down)

** Check 102 - invalid(staging)

** stagecheckcat 1: basis!=0(DCO) or 9(unk) & staging=9(DCO)
** 20130181 T1: JC 10JUL18 Changed main CR5 stage from 9 to 1.
** 20130207 T1: JC 10JUL18 Changed main CR5 basis from 1 to 2.
count if stagecheckcat==1 //153 12apr18; 144 12apr18 (changed after I added in stagecheckcat 4); 136 12apr18(changed after basis=9 was removed) - all 136 flagged in check 102; 132 09jul18
list pid cr5id staging basis morph ttda dxyr if stagecheckcat==1

** stagecheckcat 2: beh!=2(in-situ) & staging=0(in-situ)
count if stagecheckcat==2 //2 12apr18 - 2 flagged below in check 102; 2 10jul18
list pid cr5id staging beh morph ttda dxyr if stagecheckcat==2

** stagecheckcat 3: topog=778(overlap LNs) & staging=1(local.)
count if stagecheckcat==3 //0 12apr18; 0 10jul18
list pid cr5id staging basis morph ttda dxyr if stagecheckcat==3

** stagecheckcat 4: staging!=8(NA) & dxyr=2013
** 20080754 T1: Changed in main CR5 stage from 9 to 8(NA) as NOT dx in 2013.
count if stagecheckcat==4 //21 12apr18; 2 10jul18 - flagged in check 102 below.
list pid cr5id staging basis morph ttda dxyr if stagecheckcat==4

** stagecheckcat 5: staging!=9(NK) & topog=809 & dxyr=2013
count if stagecheckcat==5 //0 23apr18; 1 10jul18 - flagged in check 102 below.
list pid cr5id staging basis primarysite ttda dxyr if stagecheckcat==5

** stagecheckcat 6: basis=0(DCO) or 9(unk) & staging!=9(DCO) & dxyr=2013
count if stagecheckcat==6 //0 23apr18; 0 10jul18
list pid cr5id staging basis primarysite ttda dxyr if stagecheckcat==6

** stagecheckcat 7: beh==2(in-situ) & staging!=0(in-situ) & dxyr=2013
count if stagecheckcat==7 //0 23apr18; 0 10jul18
list pid cr5id staging beh morph ttda dxyr if stagecheckcat==7


** Check 102 - invalid (staging)
** Add reviewer comments to those that need to be corrected
/* 10jul2018
replace checkflag102=102 if stagecheckcat==1 //136 12apr18
replace reviewertxt6="JC 12apr2018: Possibly invalid stage as indicated by basis - pls recheck MasterDb & CR5 Comments." if stagecheckcat==1
*/
replace checkflag101=101 if pid=="20130177" & cr5id=="T1S1" | pid=="20130188" & cr5id=="T1S1" | pid=="20130189" & cr5id=="T1S1" | pid=="20130206" & cr5id=="T1S1" ///
							| pid=="20130207" & cr5id=="T1S1" | pid=="20130223" & cr5id=="T1S1" | pid=="20130335" & cr5id=="T1S1" | pid=="20130351" & cr5id=="T1S1" ///
							| pid=="20130397" & cr5id=="T1S1" | pid=="20130398" & cr5id=="T1S1" | pid=="20130399" & cr5id=="T1S1" | pid=="20130516" & cr5id=="T1S1" ///
							| pid=="20130520" & cr5id=="T1S1" | pid=="20130521" & cr5id=="T1S1" | pid=="20130522" & cr5id=="T1S1" | pid=="20130524" & cr5id=="T1S1" ///
							| pid=="20130525" & cr5id=="T1S1" | pid=="20130527" & cr5id=="T1S1" | pid=="20130528" & cr5id=="T1S1" | pid=="20130552" & cr5id=="T1S1" ///
							| pid=="20130555" & cr5id=="T1S1" | pid=="20130564" & cr5id=="T1S1" | pid=="20130566" & cr5id=="T1S1" | pid=="20130567" & cr5id=="T1S1" ///
							| pid=="20130573" & cr5id=="T1S1" | pid=="20130593" & cr5id=="T1S1" | pid=="20130599" & cr5id=="T1S1" | pid=="20130608" & cr5id=="T1S1" ///
							| pid=="20130666" & cr5id=="T1S1" | pid=="20130680" & cr5id=="T1S1" | pid=="20130724" & cr5id=="T1S1" | pid=="20130747" & cr5id=="T1S1"
replace checkflag102=102 if pid=="20130009" & cr5id=="T1S1" | pid=="20130012" & cr5id=="T1S1" | pid=="20130019" & cr5id=="T1S1" | pid=="20130060" & cr5id=="T1S1" ///
							| pid=="20130073" & cr5id=="T1S1" | pid=="20130079" & cr5id=="T1S1" | pid=="20130081" & cr5id=="T1S1" | pid=="20130083" & cr5id=="T1S1" ///
							| pid=="20130090" & cr5id=="T1S1" | pid=="20130096" & cr5id=="T1S1" | pid=="20130101" & cr5id=="T1S1" | pid=="20130113" & cr5id=="T1S1" ///
							| pid=="20130126" & cr5id=="T1S1" | pid=="20130162" & cr5id=="T2S1" | pid=="20130164" & cr5id=="T1S1" | pid=="20130172" & cr5id=="T2S1" ///
							| pid=="20130175" & cr5id=="T2S1" | pid=="20130182" & cr5id=="T2S1" | pid=="20130187" & cr5id=="T2S1" | pid=="20130204" & cr5id=="T1S1" ///
							| pid=="20130209" & cr5id=="T1S1" | pid=="20130253" & cr5id=="T1S1" | pid=="20130272" & cr5id=="T1S1" | pid=="20130273" & cr5id=="T1S1" ///
							| pid=="20130280" & cr5id=="T1S1" | pid=="20130281" & cr5id=="T1S1" | pid=="20130288" & cr5id=="T1S1" | pid=="20130289" & cr5id=="T1S1" ///
							| pid=="20130290" & cr5id=="T1S1" | pid=="20130291" & cr5id=="T1S1" | pid=="20130293" & cr5id=="T1S1" | pid=="20130295" & cr5id=="T1S1" ///
							| pid=="20130303" & cr5id=="T1S1" | pid=="20130304" & cr5id=="T1S1" | pid=="20130307" & cr5id=="T1S1" | pid=="20130309" & cr5id=="T1S1" ///
							| pid=="20130310" & cr5id=="T1S1" | pid=="20130311" & cr5id=="T1S1" | pid=="20130313" & cr5id=="T1S1" | pid=="20130317" & cr5id=="T1S1" ///
							| pid=="20130318" & cr5id=="T1S1" | pid=="20130324" & cr5id=="T1S1" | pid=="20130326" & cr5id=="T1S1" | pid=="20130329" & cr5id=="T1S1" ///
							| pid=="20130331" & cr5id=="T1S1" | pid=="20130332" & cr5id=="T1S1" | pid=="20130334" & cr5id=="T1S1" | pid=="20130336" & cr5id=="T1S1" ///
							| pid=="20130337" & cr5id=="T1S1" | pid=="20130338" & cr5id=="T2S1" | pid=="20130339" & cr5id=="T1S1" | pid=="20130341" & cr5id=="T1S1" ///
							| pid=="20130342" & cr5id=="T1S1" | pid=="20130344" & cr5id=="T1S1" | pid=="20130354" & cr5id=="T1S1" | pid=="20130355" & cr5id=="T1S1" ///
							| pid=="20130368" & cr5id=="T1S1" | pid=="20130375" & cr5id=="T1S1" | pid=="20130377" & cr5id=="T1S1" | pid=="20130378" & cr5id=="T1S1" ///
							| pid=="20130395" & cr5id=="T1S1" | pid=="20130396" & cr5id=="T1S1" | pid=="20130426" & cr5id=="T1S1" | pid=="20130429" & cr5id=="T1S1" ///
							| pid=="20130426" & cr5id=="T1S1" | pid=="20130513" & cr5id=="T1S1" | pid=="20130543" & cr5id=="T1S1" | pid=="20130545" & cr5id=="T1S1" ///
							| pid=="20130554" & cr5id=="T1S1" | pid=="20130556" & cr5id=="T1S1" | pid=="20130607" & cr5id=="T1S1" | pid=="20130622" & cr5id=="T1S1" ///
							| pid=="20130631" & cr5id=="T1S1" | pid=="20130632" & cr5id=="T1S1" | pid=="20130633" & cr5id=="T1S1" | pid=="20130637" & cr5id=="T1S1" ///
							| pid=="20130639" & cr5id=="T1S1" | pid=="20130640" & cr5id=="T1S1" | pid=="20130641" & cr5id=="T1S1" | pid=="20130642" & cr5id=="T1S1" ///
							| pid=="20130643" & cr5id=="T1S1" | pid=="20130650" & cr5id=="T1S1" | pid=="20130652" & cr5id=="T1S1" | pid=="20130653" & cr5id=="T1S1" ///
							| pid=="20130654" & cr5id=="T1S1" | pid=="20130664" & cr5id=="T1S1" | pid=="20130665" & cr5id=="T1S1" | pid=="20130688" & cr5id=="T1S1" ///
							| pid=="20130748" & cr5id=="T1S1" | pid=="20130752" & cr5id=="T1S1" | pid=="20130753" & cr5id=="T1S1" | pid=="20130798" & cr5id=="T1S1" ///
							| pid=="20130799" & cr5id=="T1S1" | pid=="20130816" & cr5id=="T1S1"
replace reviewertxt6="JC 09jul2018: pid 20130009 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #2519." ///
		if pid=="20130009" & cr5id=="T1S1"
replace reviewertxt6="JC 09jul2018: pid 20130012 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #1743." ///
		if pid=="20130012" & cr5id=="T1S1"
replace reviewertxt6="JC 09jul2018: pid 20130019 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #2477." ///
		if pid=="20130019" & cr5id=="T1S1"
replace reviewertxt6="JC 09jul2018: pid 20130060 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #1885." ///
		if pid=="20130060" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130073 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #1415." ///
		if pid=="20130073" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130079 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #2215." ///
		if pid=="20130079" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130081 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #1411." ///
		if pid=="20130081" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130083 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #3610." ///
		if pid=="20130083" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130090 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #1460." ///
		if pid=="20130090" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130096 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #1458." ///
		if pid=="20130096" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130101 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #1852." ///
		if pid=="20130101" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130113 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #2470." ///
		if pid=="20130113" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130126 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #2231." ///
		if pid=="20130126" & cr5id=="T1S1"
replace reviewertxt6="JC 12apr2018: pid 20130162 - Update T2's staging from 1 to 8(NA) as NOT dx in 2013 (5-yr interval)." ///
		if pid=="20130162" & cr5id=="T2S1"
replace reviewertxt6="JC 10jul2018: pid 20130164 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #3832." ///
		if pid=="20130164" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130172 - Update T1's stage from 9 to 7(distant)-see Comments/MasterDb #3403." ///
		if pid=="20130172" & cr5id=="T1S1"
replace reviewertxt6="JC 12apr2018: pid 20130175 - Update T2's staging from 9 to 8(NA) as NOT dx in 2013 (5-yr interval)." ///
		if pid=="20130175" & cr5id=="T2S1"
replace reviewertxt6="JC 10jul2018: pid 20130182 - Update T1's primsite from UNKNOWN to ABDOMEN/PELVIS, topog from 80.9 to 76.8-see Comments/MasterDb #1658." ///
		if pid=="20130182" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130187 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #2525." ///
		if pid=="20130187" & cr5id=="T1S1"
replace reviewertxt6="JC 12apr2018: pid 20130204 - Update T1's behaviour from 3 to 2-see morph and staging." ///
		if pid=="20130204" & cr5id=="T1S1"
replace reviewertxt6="JC 12apr2018: pid 20130209 - Update T1's behaviour from 3 to 2-see morph and staging." ///
		if pid=="20130209" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130230 - Update T1's stage from 9 to 7(distant)-see Comments(scans)/MasterDb #3354." ///
		if pid=="20130230" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130253 - Update T1's stage from 9 to 1(localized), recstatus from 1 to 3(ineligible)-see Comments(scans)/MasterDb #1871. Ineligible as SCC of skin, non-genital site." ///
		if pid=="20130253" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130272 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #3969." ///
		if pid=="20130272" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130273 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #3951." ///
		if pid=="20130273" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130280 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #3963." ///
		if pid=="20130280" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130281 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #4024." ///
		if pid=="20130281" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130288 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #3961." ///
		if pid=="20130288" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130289 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #3858." ///
		if pid=="20130289" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130290 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb #4038." ///
		if pid=="20130290" & cr5id=="T1S1"
replace reviewertxt6="JC 12apr2018: pid 20130291 - Update T1's staging from 9 to 8(NA) as NOT dx in 2013 (5-yr interval)." ///
		if pid=="20130291" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130293 - Update T1's primsite from AXILLARY LN to CERVICAL & AXILLARY LN, top from 77.3 to 77.8, stage from 9 to 5(regional)-see Comments/MasterDb #3851/SS manual p7#2." ///
		if pid=="20130293" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130295 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130295" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130303 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130303" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130304 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130304" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130307 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130307" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130309 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130309" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130310 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130310" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130311 - Update T1's stage from 9 to 2(reg dir ext)-see Comments/MasterDb." ///
		if pid=="20130311" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130313 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130313" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130317 - Update T1's primsite from LUNG to LUNG-MAIN STEM, top from 34.9 to 34.0, stage from 9 to 2(reg dir ext)-see Comments/MasterDb." ///
		if pid=="20130317" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130318 - Update T1's primsite from UNKNOWN to LIVER-RT LOBE, top from 80.9 to 22.0, hx from UNDIFF CA to NEUROENDOCRINE CARCINOMA, morph from 8010 to 8246, stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130318" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130324 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130324" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130326 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130326" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130329 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130329" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130331 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130331" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130332 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130332" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130334 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130334" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130336 - Update T1's stage from 9 to 3(reg ipsilat LNs)-see Comments/MasterDb." ///
		if pid=="20130336" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130337 - Update T1's stage from 9 to 2(reg dir ext)-see Comments/MasterDb." ///
		if pid=="20130337" & cr5id=="T1S1"
replace reviewertxt6="JC 12apr2018: pid 20130338 - Update T1's staging from 9 to 8(NA) as NOT dx in 2013 (5-yr interval)." ///
		if pid=="20130338" & cr5id=="T2S1"
replace reviewertxt6="JC 10jul2018: pid 20130339 - Update T1's stage from 9 to 3(reg LNs)-see Comments/MasterDb." ///
		if pid=="20130339" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130341 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130341" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130342 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130342" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130344 - Update T1's stage from 9 to 7(distant)-see Comments/MasterDb." ///
		if pid=="20130344" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130354 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130354" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130355 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130355" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130368 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130368" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130375 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130375" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130377 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130377" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130378 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130378" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130395 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130395" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130396 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130396" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130426 - Update T1's stage from 9 to 2(reg dir ext)-see DeathData/Comments/MasterDb. Pt died in 2016, COD prostate ca" ///
		if pid=="20130426" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130429 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130429" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130513 - Update T1's stage 8(NA) as not dx in 2013." ///
		if pid=="20130513" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130543 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130543" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130545 - Update T1's stage from 9 to 4(reg both)-see Comments/MasterDb." ///
		if pid=="20130545" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130554 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130554" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130556 - Update T1's stage from 9 to 2(reg dir ext)-see Comments/MasterDb." ///
		if pid=="20130556" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130607 - Update T1's stage from 9 to 2(reg dir ext)-see Comments/MasterDb." ///
		if pid=="20130607" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130622 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130622" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130631 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130631" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130632 - Update T1's stage from 9 to 4(reg both)-see Comments/MasterDb." ///
		if pid=="20130632" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130633 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130633" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130637 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130637" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130639 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130639" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130640 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130640" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130641 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130641" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130642 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130642" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130643 - Update T1's stage from 9 to 3(reg LNs)-see Comments/MasterDb." ///
		if pid=="20130643" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130650 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130650" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130652 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb." ///
		if pid=="20130652" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130653 - Update T1's stage from 9 to 7(distant)-see Comments/MasterDb." ///
		if pid=="20130653" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130654 - Update T1's stage from 9 to 7(distant)-see Comments/MasterDb." ///
		if pid=="20130654" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130664 - Update T1's stage from 9 to 7(distant)-see Comments/MasterDb." ///
		if pid=="20130664" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130665 - Update T1's stage from 9 to 7(distant)-see Comments/MasterDb(StageIIIA)." ///
		if pid=="20130665" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130688 - Update T1's stage from 9 to 7(distant)-see Comments/MasterDb(COD)." ///
		if pid=="20130688" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130748 - Update T1's stage from 9 to 7(distant)-see Comments/MasterDb." ///
		if pid=="20130748" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130752 - Update T1's stage from 9 to 7(distant)-see Comments/MasterDb(COD)." ///
		if pid=="20130752" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130753 - Update T1's stage from 9 to 7(distant)-see Comments/MasterDb(COD); NB: death info not entered into separate CR5 source." ///
		if pid=="20130753" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130798 - Update T1's stage from 9 to 1(localized)-see Comments/MasterDb(BOD & COD)." ///
		if pid=="20130798" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130799 - Update T1's primsite from BONE MARROW to UNKNOWN, top from 42.1 to 80.9-see Comments/MasterDb(COD)-cannot find any mention of primary site being bone marrow." ///
		if pid=="20130799" & cr5id=="T1S1"
replace reviewertxt6="JC 10jul2018: pid 20130816 - Update T1's stage from 7 to 9(unk)-see Comments/MasterDb." ///
		if pid=="20130816" & cr5id=="T1S1"


** Check 101 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag101=101 if checkflag102!=102


********************
** Incidence Date **
********************
** Check 103 - InciDate missing
count if dot==. & primarysite!="" //14 22mar18; 0 10jul18
list pid dotyear dotmonth dotday if dot==. & primarysite!=""
** replace missing incidence dates using dotyear, dotmonth, dotday and
** checking main CR5 to ensure missing day and month (30jun) is logical
** in terms of CR5 comments and other dates e.g. admdate, dlc, treatment dates, etc.
** Changed the incidence dates of the below cases in main CR5:
** 20030001 T1: JC 22MAR18: T1 changed InciD from 20039999 to 20030630 using missing day & month.
** 20050001 T1: JC 22MAR18: T1 changed InciD from 20059999 to 20050630 using missing day & month.
** 20070005 T1: JC 22MAR18: T1 changed InciD from 20071199 to 20071115 using missing day.
** 20070006 T1: JC 22MAR18: T1 changed InciD from 20071299 to 20071215 using missing day.
** 20070007 T1: JC 22MAR18: T1 changed InciD from 20071299 to 20071215 using missing day.
** 20070012 T1: JC 22MAR18: T1 changed InciD from 20071299 to 20071210 using date of first biopsy.
** 20080186 T1: JC 22MAR18: T1 changed InciD from 20080199 to 20080115 using missing day and Age from 64 to 65.
** 20080384 T1: JC 22MAR18: T1 changed InciD from 20071299 to 20071215 using missing day.
** 20080639 T1: JC 22MAR18: T1 changed InciD from 20080899 to 20080815 using missing day.
** 20080645 T1: JC 22MAR18: T1 changed InciD from 20080599 to 20080515 using missing day and Age from 17 to 16.
** 20081043 T1: JC 22MAR18: T1 changed InciD from 20079999 to 20070630 using missing day and month and Age from 72 to 70.
** 20130297 T1: JC 22MAR18: T1 changed InciD from 20130899 to 20130815 using missing day.
** 20130607 T1: JC 22MAR18: T1 changed InciD from 20130899 to 20130815 using missing day.
replace checkflag103=103 if dot==. & primarysite!=""

** Check 104 - InciDate (future date)
count if dot!=. & dot>currentdatett //0 16apr18; 0 10jul18
replace checkflag104=104 if ttdoa!=. & dot>currentdatett

** Check 105 & 106 - invalid (InciDate); Review done visually via lists below and specific checks created (dotcheckcat). 
** Check 105=Reviewed/Corrected by DA/Reviewer; no errors
** Check 106=Invalid (InciDate) generated via dotcheckcat
** First, flag errors and assign as checkflag 106 then
** flag rest of cases as checkflag 105(no errors)
** When running this code on 2014 abstractions then need to use lists that are after the dotcheckcat (scroll down)

** Check 106 - invalid(InciDate)

** dotcheckcat 1: InciDate before DOB
count if dotcheckcat==1 //0 16apr18; 0 10jul18
list pid cr5id dot dob ttda dxyr if dotcheckcat==1

** dotcheckcat 2: InciDate after DLC
count if dotcheckcat==2 //0 16apr18; 0 10jul18
list pid cr5id dot dlc ttda dxyr if dotcheckcat==2

** dotcheckcat 3: Basis=DCO & InciDate!=DLC
count if dotcheckcat==3 //1 16apr18 - flagged in check 106 below; 3 10jul18 - 20050001 correct as DCO since interval indicates dx 2005 but died 2008.
list pid cr5id dot dlc basis ttda dxyr if dotcheckcat==3

** dotcheckcat 4: InciDate<>DFC/AdmDate/RTdate/SampleDate/ReceiveDate/RptDate/DLC (2014 onwards)
count if dotcheckcat==4 //3 16apr18 - all 3 flagged in check 106 below; 0 10jul18
list pid cr5id dot dfc admdate rtdate sampledate recvdate rptdate dlc ttda dxyr if dotcheckcat==4

** dotcheckcat 5: InciDate=DFC; DFC after AdmDate/RTdate/SampleDate/ReceiveDate/RptDate (2014 onwards)
count if dotcheckcat==5 //0 16apr18; 0 10jul18
list pid cr5id dot dfc admdate rtdate sampledate recvdate rptdate ttda dxyr if dotcheckcat==5

** dotcheckcat 6: InciDate=AdmDate; AdmDate after DFC/RTdate/SampleDate/ReceiveDate/RptDate (2014 onwards)
count if dotcheckcat==6 //0 16apr18; 0 10jul18
list pid cr5id dot dfc admdate rtdate sampledate recvdate rptdate ttda dxyr if dotcheckcat==6

** dotcheckcat 7: InciDate=RTdate; RTdate after DFC/AdmDate/SampleDate/ReceiveDate/RptDate (2014 onwards)
count if dotcheckcat==7 //0 16apr18; 0 10jul18
list pid cr5id dot dfc admdate rtdate sampledate recvdate rptdate ttda dxyr if dotcheckcat==7

** dotcheckcat 8: InciDate=SampleDate; SampleDate after DFC/AdmDate/RTdate/ReceiveDate/RptDate (2014 onwards)
count if dotcheckcat==8 //0 16apr18; 0 10jul18
list pid cr5id dot dfc admdate rtdate sampledate recvdate rptdate ttda dxyr if dotcheckcat==8

** dotcheckcat 9: InciDate=ReceiveDate; ReceiveDate after DFC/AdmDate/RTdate/SampleDate/RptDate (2014 onwards)
count if dotcheckcat==9 //0 16apr18; 0 10jul18
list pid cr5id dot dfc admdate rtdate sampledate recvdate rptdate ttda dxyr if dotcheckcat==9

** dotcheckcat 10: InciDate=RptDate; RptDate after DFC/AdmDate/RTdate/SampleDate/ReceiveDate (2014 onwards)
count if dotcheckcat==10 //0 16apr18; 0 10jul18
list pid cr5id dot dfc admdate rtdate sampledate recvdate rptdate ttda dxyr if dotcheckcat==10


** Check 106 - invalid (InciDate)
** Add reviewer comments to those that need to be corrected
replace checkflag106=106 if pid=="20081042" & cr5id=="T1S1" | pid=="20081043" & cr5id=="T1S1" | pid=="20130162" & cr5id=="T2S1" | pid=="20130338" & cr5id=="T1S1" ///
							| pid=="20130800" & cr5id=="T1S1"
replace reviewertxt7="JC 10jul2018: pid 20081042 - Update T1's BOD from DCO to ClinOnly. Pls see Comments/MasterDb." ///
		if pid=="20081042" & cr5id=="T1S1"
replace reviewertxt7="JC 10jul2018: pid 20081043 - Update T1's BOD from DCO to Hx of Prim. Pls see Comments/MasterDb #96(comments)." ///
		if pid=="20081043" & cr5id=="T1S1"
replace reviewertxt7="JC 16apr2018: pid 20130162 - Update T2's ReportDate to 20140521 and AdmDate to 20140414 (Date first seen in MOPD for this cancer)." ///
		if pid=="20130162" & cr5id=="T2S1"
replace reviewertxt7="JC 16apr2018: pid 20130338 - Update T1's InciDate to 20131231, DxYr to 2013, SampleDate to 20131231 and ReportDate to 20140102. Pls see MasterDb #3973." ///
		if pid=="20130338" & cr5id=="T1S1"
replace reviewertxt7="JC 16apr2018: pid 20130800 - Update T1's Basis to 9-unk since this case was abstracted based on RT reg and death certif. Pls see MasterDb #2066." ///
		if pid=="20130800" & cr5id=="T1S1"


** Check 105 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag105=105 if checkflag106!=106

********************
** Diagnosis Year **
********************
** Check 107 - DxYr missing
count if dxyr==. //48 16apr18; 0 11jul18
list pid ptdoa stdoa dot dxyr cr5id if dxyr==.
replace checkflag107=107 if dxyr==.

** Check 108 - DxYr length
** Need to create string variable for DxYr
gen diagyr=dxyr
tostring diagyr, replace
** Need to change all diagyr=="." to diagyr==""
replace diagyr="" if diagyr=="." //48 changes made 16apr18
count if diagyr!="" & length(diagyr)!=4 //0 16apr18; 0 11jul18
list pid diagyr dxyr cr5id if diagyr!="" & length(diagyr)!=4
replace checkflag108=108 if diagyr!="" & length(diagyr)!=4
 
** Check 109 & 110 - invalid (dxyr); Review done visually via lists below and specific checks created (dxyrcheckcat). 
** Check 109=Reviewed/Corrected by DA/Reviewer; no errors
** Check 110=Invalid (dxyr) generated via dxyrcheckcat
** First, flag errors and assign as checkflag 110 then
** flag rest of cases as checkflag 109(no errors)
** When running this code on 2014 abstractions then need to use lists that are after the dxyrcheckcat (scroll down)

** Check 110 - invalid(dxyr)

** dxyrcheckcat 1: dotyear!=dxyr
** 20080706 T4: JC 11JUL2018 changed dxyr from 2011 to 2010
count if dxyrcheckcat==1 //0 16apr18; 1 11jul18 - corrected on main CR5
list pid cr5id dot dotyear dxyr ttda if dxyrcheckcat==1

** dxyrcheckcat 2: admyear!=dxyr & dxyr>2013
count if dxyrcheckcat==2 //8 30apr18 - 20130162 T2 flagged in checkflag 106 above; rest flagged in 110 below; 0 11jul18
list pid cr5id admdate admyear dxyr ttda if dxyrcheckcat==2

** dxyrcheckcat 3: dfcyear!=dxyr & dxyr>2013
count if dxyrcheckcat==3 //0 30apr18; 0 11jul18
list pid cr5id dfc dfcyear dxyr ttda if dxyrcheckcat==3

** dxyrcheckcat 4: rtyear!=dxyr & dxyr>2013
count if dxyrcheckcat==4 //2 30apr18 - flagged in 110 below; 0 11jul18
list pid cr5id rtdate rtyear dxyr ttda if dxyrcheckcat==4


** Check 110 - invalid (dxyr)
** Add reviewer comments to those that need to be corrected

/* 11jul18 - all of the below relate to cases dx AFTER 2013 despite some cases with pid starting '2013...'

replace checkflag110=110 if pid=="20130175" & cr5id=="T2S1" | pid=="20140002" & cr5id=="T1S2" | pid=="20140006" & cr5id=="T1S2" | pid=="20140015" & cr5id=="T1S2" ///
							| pid=="20140062" & cr5id=="T1S2" | pid=="20130692" & cr5id=="T1S1" | pid=="20150002" & cr5id=="T1S2" | pid=="20150023" & cr5id=="T1S4"
replace reviewertxt7="JC 30apr2018: pid 20130175 - Update T2's AdmDate from 20131119 to 20141119(see CR5 comments)." ///
		if pid=="20130175" & cr5id=="T2S1"
replace reviewertxt7="JC 30apr2018: pid 20130291 - Update T1's AdmDate from 20130818 to 99999999(see CR5 comments and MasterDb 2789 comments)." ///
		if pid=="20130291" & cr5id=="T1S1"
replace reviewertxt7="JC 30apr2018: pid 20140002 - Query T1's AdmDate=2013 but DxYr=2014 - why is this case ineligible? No reason for ineligibility given in CR comments. Pls update DA SOP to include that if case is ineligible then a reason for ineligibility MUST be recorded in Comments field." ///
		if pid=="20140002" & cr5id=="T1S2"
replace reviewertxt7="JC 30apr2018: pid 20140006 - Update T1's DxYr from 2014 to 2013 (see Source 2: AdmDate)." ///
		if pid=="20140006" & cr5id=="T1S2"
replace reviewertxt7="JC 30apr2018: pid 20140015 - Update T1's DxYr from 2014 to 2013 - why is this case ineligible? 2013 is not outside of registration year as noted in CR5 comments. Pls update DA SOP to include that if case from a valid registry year and is picked up in another registry data collection year it is still eligible." ///
		if pid=="20140015" & cr5id=="T1S2"
replace reviewertxt7="JC 30apr2018: pid 20140062 - Update T1's DxYr from 2014 to 2013 - why is this case ineligible? 2013 is not outside of registration year as noted in CR5 comments. Pls update DA SOP to include that if case from a valid registry year and is picked up in another registry data collection year it is still eligible." ///
		if pid=="20140062" & cr5id=="T1S2"
replace reviewertxt7="JC 30apr2018: pid 20130692 - Update T3's DxYr from 2014 to 2013 (see AdmDate)." ///
		if pid=="20130692" & cr5id=="T1S1"
replace reviewertxt7="JC 30apr2018: pid 20150002 - Update T1's DxYr from 2015 to 2014 (see Source 2: RTDate)." ///
		if pid=="20150002" & cr5id=="T1S2"
replace reviewertxt7="JC 30apr2018: pid 20150023 - Update T1's DxYr from 2015 to 2014 (see dates in Sources 2 & 4)." ///
		if pid=="20150023" & cr5id=="T1S4"
*/

** Check 109 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag109=109 if checkflag110!=110


****************
** Consultant **
****************
** No checks on this as checks done under 'Doctor' variable


********************
** Treatments 1-5 **
********************
** NOTE 1: Treatment only collected at 5 year intervals so treatment collected on 2013 data then 2018 and so on;
** NOTE 2: In upcoming years of data collection (2018 dc year), more rxcheckcat checks will be compiled based on data.

** Check 111 - Rx1-5 missing
count if rx1==. & primarysite!="" //0 16apr18; 0 11jul18
list pid rx1 dxyr cr5id if rx1==. & primarysite!=""
count if rx2==. & rx2d!=. //0 16apr18; 0 11jul18
list pid rx2 rx2d dxyr cr5id if rx2==. & rx2d!=.
count if rx3==. & rx3d!=. //0 16apr18; 0 11jul18
list pid rx3 rx3d dxyr cr5id if rx3==. & rx3d!=.
count if rx4==. & rx4d!=. //0 16apr18; 0 11jul18
list pid rx4 rx4d dxyr cr5id if rx4==. & rx4d!=.
count if rx5==. & rx5d!=. //0 16apr18; 0 11jul18
list pid rx5 rx5d dxyr cr5id if rx5==. & rx5d!=.
replace checkflag111=111 if (rx1==. & primarysite!="")|(rx2==. & rx2d!=.)|(rx3==. & rx3d!=.)|(rx4==. & rx4d!=.)|(rx5==. & rx5d!=.)

** Check 112 - Rx1-5 length
** Need to create string variable for Rx1-5
gen treat1=rx1
tostring treat1, replace
gen treat2=rx2
tostring treat2, replace
gen treat3=rx3
tostring treat3, replace
gen treat4=rx4
tostring treat4, replace
gen treat5=rx5
tostring treat5, replace
** Need to change all treat1-5=="." to treat1-5==""
replace treat1="" if treat1=="." //2751 16apr18
replace treat2="" if treat2=="." //4644 16apr18
replace treat3="" if treat3=="." //4993 16apr18
replace treat4="" if treat4=="." //5121 16apr18
replace treat5="" if treat5=="." //5158 16apr18
count if (treat1!="" & length(treat1)!=1)|(treat2!="" & length(treat2)!=1)|(treat3!="" & length(treat3)!=1)|(treat4!="" & length(treat4)!=1) ///
		 |(treat5!="" & length(treat5)!=1) //0 16apr18; 0 11jul18
list pid treat1 rx1 treat2 rx2 treat3 rx3 treat4 rx4 treat5 rx5 dxyr cr5id if (treat1!="" & length(treat1)!=1)|(treat2!="" & length(treat2)!=1) ///
		 |(treat3!="" & length(treat3)!=1)|(treat4!="" & length(treat4)!=1)|(treat5!="" & length(treat5)!=1)
replace checkflag112=112 if (treat1!="" & length(treat1)!=1)|(treat2!="" & length(treat2)!=1)|(treat3!="" & length(treat3)!=1)|(treat4!="" & length(treat4)!=1) ///
		|(treat5!="" & length(treat5)!=1)
 
** Check 113 & 114 - invalid (Rx1-5); Review done visually via lists below and specific checks created (rxcheckcat). 
** Check 113=Reviewed/Corrected by DA/Reviewer; no errors
** Check 114=Invalid (Rx1-5) generated via rxcheckcat
** First, flag errors and assign as checkflag 114 then
** flag rest of cases as checkflag 113(no errors)
** When running this code on 2014 abstractions then need to use lists that are after the rxcheckcat (scroll down)
** For treatment checks (rxcheckcat 36-39) use checkflag 113 to indicate a case has been reviewed and is correct
replace checkflag113=113 if pid=="20080812" & cr5id=="T1S1" | pid=="20090042" & cr5id=="T1S1" | pid=="20130022" & (cr5id=="T1S1"|cr5id=="T1S2") ///
							| pid=="20080312" & cr5id=="T1S1" | pid=="20080644" & cr5id=="T1S1" | pid=="20080700" & (cr5id=="T2S1"|cr5id=="T3S1") ///
							| pid=="20090058" & cr5id=="T1S1" | pid=="20080053" & cr5id=="T1S1" | pid=="20080078" & cr5id=="T1S1" ///
							| pid=="20080103" & cr5id=="T1S1" | pid=="20080117" & cr5id=="T1S1" | pid=="20080870" & cr5id=="T1S1" ///
							| pid=="20090064" & cr5id=="T1S1" | pid=="20130181" & (cr5id=="T1S1"|cr5id=="T1S2") | pid=="20130229" & cr5id=="T1S1" ///
							| pid=="20130526" & cr5id=="T1S1" | pid=="20080321" & cr5id=="T1S1" | pid=="20090011" & cr5id=="T1S1"
							
** Check 114 - invalid(Rx1-5)

** rxcheckcat 1: rx1=0-no rx & rx1d!=./01jan00
** 20080340 T1: Changed in main CR5 rx1 from 0 to 8, rx1d from 20090115 to 99999999, otherrx1 from blank to 3-rx abroad, otherrx2 from blank to 99. See CR5 Comments.
** 20080653 T1: Changed in main CR5 rx1 from 0 to 1. See CR5 Comments.
count if rxcheckcat==1 //2 16apr18 - all corrected in main CR5; 0 11jul18
list pid cr5id rx1 rx1d dxyr ttda if rxcheckcat==1

** rxcheckcat 2: rx1=9-unk & rx1d!=./01jan00
count if rxcheckcat==2 //0 16apr18; 0 11jul18
list pid cr5id rx1 rx1d dxyr ttda if rxcheckcat==2

** rxcheckcat 3: rx1!=0-no rx & rx1!=9-unk & rx1d==./01jan00
** 20070005 JC 17APR18 T1: Changed in main CR5 rx1d from blank to 20080331, added in rx2, rx2d, othrx1, othrx2 using CR5 Comments.
** 20080002 JC 17APR18 T1: Changed in main CR5 rx1d from blank to 20080725, removed norx1 using CR5 Comments.
** 20080003 JC 17APR18 T1: Changed in main CR5 rx1d from blank to 20080624, rx2 from blank to hormono, rx2d to 20081001 using missing day, removed norx1 and CR5 Comments.
** 20080014 JC 17APR18 T1: Changed in main CR5 rx1d from blank to 20081124, removed norx1 using CR5 Comments & MasterDb #2346.
** 20080077 JC 17APR18 T1: Changed in main CR5 rx1 from othrx to no rx, removed othrx1, added norx1-alt rx, norx2-symp rx using CR5 Comments.
** 20080103 JC 17APR18 T1: Changed in main CR5 rx1 from chemo to immuno, rx1d from 99999999 to 20071001 using missing day, removed norx1 and CR5 Comments.
** 20080109 JC 17APR18 T1: Changed in main CR5 rx1 from othrx to hormono, rx1d from 99999999 to 20080621, removed othrx1 using CR5 Comments.
** 20080126 T1: Changed in main CR5 rx1d from 20080499 to 20080630 using missing day & month values and CR5 Comments.
** 20080142 JC 17APR18 T1: Changed in main CR5 rx1d from 99999999 to 20080229 using CR5 Comments.
** 20080206 JC 17APR18 T1: Changed in main CR5 rx1 from othrx to sx, rx1d from blank to 20081112, InciD from 20081107 to 20081112 as it's an incidental finding using CR5 Comments.
** 20080224 JC 17APR18 T1: Changed in main CR5 rx1d from 99999999 to 20080630 using missing day and month values and CR5 Comments.
** 20080245 JC 17/23APR18 T1: Changed in main CR5 rx1 from othrx to unk, removed othrx1(treated abroad) in accord with CR5 Comments as treatment suggested, no indication it was not done.
** 20080309 JC 17APR18 T1: Changed in main CR5 rx1d from 99999999 to 20080630 using missing day and month values, added othrx2 to '99' using CR5 Comments.
** 20080312 JC 17APR18 T2: Changed in main CR5 rx1 from chemo to immuno, rx1d from 20099999 to 20090630 using missing day and month values and CR5 Comments.
** 20080340 JC 11JUL18 T2: Changed in main CR5 rx1 from other rx to no rx as rx plan discussed and suggested but no evidence it was completed. See CR5 Comments.
** 20080356 JC 17APR18 T2: Changed in main CR5 rx1 from RT to unk, rx1d from 20099999 to blank using CR5 Comments & MasterDb #3458 (RT adm).
** 20080489 JC 17APR18 T1: Changed in main CR5 rx1d from 20081099 to 20081013 using CR5 Comments.
** 20080553 JC 17APR18 T1: Changed in main CR5 rx1d from 20139999 to 20131124 using CR5 Comments.
** 20080583 JC 17APR18 T1: Changed in main CR5 rx1 from othrx to unk, removed othrx1(treated abroad) using CR5 Comments.
** 20080619 JC 17APR18 T1: Changed in main CR5 rx1 from othrx to unk, removed othrx1(treated abroad) using CR5 Comments.
** 20080621 JC 17APR18 T1: Changed in main CR5 rx1 from othrx to no rx, removed othrx1(palliative), othrx2(symp & alt rx), added in norx1(alt),norx2(symp) using CR5 Comments.
** 20080645 JC 17APR18 T1: Changed in main CR5 rx1 from sx to chemo, rx1d from 20080799 to 20080701 using missing day value and CR5 Comments.
** 20080700 JC 17APR18 T1: Changed in main CR5 rx1d from 20109999 to 20100813, added in rx2 and rx2d using CR5 Comments.
** 20080761 JC 17APR18 T1: Changed in main CR5 rx1 from chemo to unk using CR5 Comments.
** 20080799 JC 17APR18 T1: Changed in main CR5 rx1d from blank to 20080630 using missing day and month values, othrx2 to '99', primarysite from 'rectum' to 'cervix', topog from '209' to '539' as path rpt's comments not reviewed by PP and COD states 'multiple metastatic dz' and 'ca cervix'. See MasterDb #1799,3226 and CR5 Comments.
** 20080818 JC 17APR18 T1: Changed in main CR5 rx1d from blank to 20080109, othrx2 'colostomy' using CR5 Comments.
** 20080820 JC 17APR18 T1: Changed in main CR5 rx1 from othrx to sx, rx1d from blank to 20080814, removed othrx1(palliative), othrx2 'transverse colectomy' using CR5 Comments; DA incorrectly recorded colectomy as a palliative measure.
** 20080828 JC 17APR18 T1: Changed in main CR5 rx1d from blank to 20080709, othrx2 'ascites tap/paracentesis' using CR5 Comments.
** 20080836 JC 17APR18 T1: Changed in main CR5 rx1d from blank to 20080619, othrx2 '99' using CR5 Comments.
** 20080838 JC 17APR18 T1: Changed in main CR5 rx1d from blank to 20080606, othrx2 '99' using CR5 Comments.
** 20080857 JC 17APR18 T1: Changed in main CR5 rx1 from othrx to no rx, removed othrx1(palliative), added in norx1 to 'symp' using CR5 Comments.
** 20080880 JC 17APR18 T1: Changed in main CR5 rx1d from 99999999 to 20080715, added in rx2(othrx), rx3d 20090701 using missing day value, othrx1(palliative), othrx2(RT) using CR5 Comments.
** 20080904 JC 17APR18 T1: Changed in main CR5 InciD from 20080404 to 20070630(missing day and month), age from 36 to 35, dxyr from 2008 to 2007, rx1d from 20079999 to 20070630 using missing day and month values, MasterDb #1417 and CR5 Comments.
** 20081042 JC 17APR18 T1: Changed in main CR5 InciD from 20090128 to 20080501(missing day), age from 78 to 77, dxyr from 2009 to 2008, rx1 from chemo to immuno, rx1d from 99999999 to 20080630 using missing day and month values, MasterDb #3875(CD) and CR5 Comments.
** 20081053 JC 17APR18 T1: Changed in main CR5 InciD from 20080918 to 20080901(missing day), rx1d from 99999999 to 20080901 using missing day value, MasterDb #2534(CD) and CR5 Comments.
** 20081067 JC 17APR18 T1: Changed in main CR5 InciD from 20080806 to 20080710(see MasterDb #1099), rx1d from 99999999 to 20080826 using MasterDb #2531(CD) and CR5 Comments.
** 20081076 JC 17APR18 T2,T3: Changed in main CR5 rx1d from 20081099 to 20081029 using MasterDb #2141(CD) and CR5 Comments.
** 20081080 JC 17APR18 T1: Changed in main CR5 rx1d from 20089999 to 20080101 using MasterDb #1165(CD) and CR5 Comments.
** 20090041 JC 17APR18 T1: Changed in main CR5 rx1d from 99999999 to 20090630 using missing day and month values, MasterDb #4771(CD) and CR5 Comments.
** 20090060 JC 17APR18 T1: Changed in main CR5 rx1d from 99999999 to 20081215 using missing day value and CR5 Comments.
** 20090064 JC 17APR18 T1: Changed in main CR5 rx1 from othrx to no rx, removed othrx1(palliative), added in norx1(symp) using CR5 Comments.
** 20090065 JC 17APR18 T1: Changed in main CR5 rx1 from othrx to no rx, removed othrx1(palliative), added in norx1(symp) using CR5 Comments.
** 20110002 JC 17APR18 T1: Changed in main CR5 rx1d from 99999999 to 20110630, added in rx2(RT), rx2d 20110630 using missing day & month values and CR5 Comments.
** 20130003 JC 18APR18 T1: Changed in main CR5 rx1d from 99999999 to 20130613 using missing day & month values (DLC=20130613 so used that day) and CR5 Comments.
** 20130004 JC 18APR18 T1: Changed in main CR5 rx1d from 20139999 to 20130322 using CR5 Comments.
** 20130151 JC 18APR18 T1: Changed in main CR5 rx1d from 99999999 to 20140120 using CR5 Comments.
** 20130164 JC 18APR18 T1: Changed in main CR5 rx1d from 20130499 to 20130401 using missing day value and CR5 Comments.
** 20130181 JC 18APR18 T1: Changed in main CR5 rx1d from 20130699 to 20130610 using missing day value and CR5 Comments.
** 20130257 JC 18APR18 T1: Changed in main CR5 rx1d from 20130899 to 20130801, added in rx2(immuno), rx2d 20130801 using missing day value and CR5 Comments.
** 20130279 JC 18APR18 T1: Changed in main CR5 rx1d from 20139999 to 20140116, InciD from 20131212 to 20131205 using CR5 Comments.
** 20130321 JC 18APR18 T1: Changed in main CR5 rx1d from 20139999 to 20130816(same as DLC/path sample date since no date in Comments), DLC from 20130821(path: rpt date) to 20130816(path: sample date), InciD from 20130614 to 20130529 using CR5 Comments.
** 20130349 JC 18APR18 T1: Changed in main CR5 rx1d from 20131099 to 20131001 using missing day value and CR5 Comments.
** 20130513 JC 18APR18 T1: Changed in main CR5 rx1 from othrx to unk, removed rx1d(99999999), removed othrx1(palliative), othrx2(99), InciD from 20130102 to 20121110, dxyr from 2013 to 2012, age from 92 to 91 using CR5 Comments.
** 20130518 JC 18APR18 T1: Changed in main CR5 rx1 from othrx to no rx, removed rx1d(99999999), removed othrx1(palliative), othrx2(99), added in norx1(symp) using CR5 Comments.
** 20130534 JC 18APR18 T1: Changed in main CR5 rx1d from 20139999 to 20130513 using CR5 Comments.
** 20130541 JC 18APR18 T1: Changed in main CR5 rx1d from 20130699 to 20130620 using CR5 Comments.
** 20130620 JC 18APR18 T1: Changed in main CR5 rx1d from 20139999 to 20130630 using missing day and month values and CR5 Comments.
** 20130673 JC 18APR18 T1: Changed in main CR5 rx1d from 20130399 to 20130315 using missing day value and CR5 Comments.
** 20130703 JC 18APR18 T1: Changed in main CR5 rx1d from 20131099 to 20131001 using missing day value, InciD from 20130821 to 20130819 as incorrectly assigned by DA using MasterDb #3873 and CR5 Comments.
** 20130737 JC 18APR18 T1: Changed in main CR5 rx1d from 20139999 to 20131222 using DLC/InciD as COD notes chemo. See MasterDb #2026 and CR5 Comments.
** 20130791 JC 18APR18 T1: Changed in main CR5 rx1d from 20130399 to 20130313 using InciD as BVH adm notes sx See MasterDb #2739 and CR5 Comments.
** 20130830 JC 18APR18 T1: Changed in main CR5 rx1d from 20139999 to 20130729 using InciD as path rpt notes radiation See MasterDb #2349 and CR5 Comments.
** 20130835 JC 18APR18 T1: Changed in main CR5 rx1d from 20139999 to 20130708 using InciD as path rpt notes radiation See MasterDb #2244 and CR5 Comments.
count if rxcheckcat==3 //73 16apr18 - all corrected in main CR5; 1 11jul18 - 20080340 corrected in main CR5.
list pid cr5id rx1 rx1d dxyr ttda if rxcheckcat==3

** rxcheckcat 4: rx1d after rx2d
** 20040001 T1: Changed in main CR5 switched rx1 with rx2 and vice versa. See CR5 Comments.
** 20060001 T1: Changed in main CR5 rx1d from 20061199 to 20061101. See CR5 Comments.
** 20070001 T1: Changed in main CR5 switched rx1 with rx2 and vice versa. See CR5 Comments.
** 20070003 T1: Changed in main CR5 switched rx1 with rx2 and vice versa. See CR5 Comments.
** 20070008 T1: Changed in main CR5 switched rx1 with rx2 and vice versa. See CR5 Comments.
** 20080186 T1: Changed in main CR5 rx1d from 20080799 to 20080701 using missing day value. See CR5 Comments.
** 20080743 T1: Changed in main CR5 rx1d from 20080899 to 20080826. See CR5 Comments & MasterDb #1994.
** 20080849 T1: Changed in main CR5 rx1d from 20080599 to 20080501 using missing day value. See CR5 Comments.
** 20130137 T1: Changed in main CR5 removed rx2 (chemo) and rx2d (20140701) since watchful waiting done and no rx done over 1yr later. See CR5 Comments.
count if rxcheckcat==4 //9 16apr18 - all corrected in main CR5; 0 11jul18
list pid cr5id rx1d rx2d dxyr ttda if rxcheckcat==4

** rxcheckcat 5: rx1d after rx3d
** 20080319 T1: Changed in main CR5 rx1d from 20099999 to 20090115 using missing day value and CR5 Comments.
count if rxcheckcat==5 //1 16apr18 - all corrected in main CR5; 0 11jul18
list pid cr5id rx1d rx3d dxyr ttda if rxcheckcat==5

** rxcheckcat 6: rx1d after rx4d
count if rxcheckcat==6 //0 16apr18; 0 11jul18
list pid cr5id rx1d rx4d dxyr ttda if rxcheckcat==6

** rxcheckcat 7: rx1d after rx5d
count if rxcheckcat==7 //0 16apr18; 0 11jul18
list pid cr5id rx1d rx5d dxyr ttda if rxcheckcat==7

** rxcheckcat 8: rx2=0-no rx or 9-unk
count if rxcheckcat==8 //0 16apr18; 0 11jul18
list pid cr5id rx1 rx2 rx2d dxyr ttda if rxcheckcat==8

** rxcheckcat 9: rx2==. & rx2d!=./01jan00
count if rxcheckcat==9 //0 16apr18; 0 11jul18
list pid cr5id rx2 rx2d dxyr ttda if rxcheckcat==9

** rxcheckcat 10: rx2!=0-no rx & rx2!=9-unk & rx2d==./01jan00
** 20070004 T1: Changed in main CR5 rx2d from blank to 20080630 using missing day & month values and CR5 Comments.
** 20070012 T1: Changed in main CR5 rx2d from 20089999 to 20080506 using CR5 Comments.
** 20080113 T1: Changed in main CR5 rx1d from 20080999 to 20080903, rx2d from 20081199 to 20081101 using missing day value and CR5 Comments.
** 20080114 T1: Changed in main CR5 rx2d from 20090199 to 20090113 using CR5 Comments.
** 20080281 T1: Changed in main CR5 rx2d from blank to 20081016 using CR5 Comments.
** 20080357 T1: Changed in main CR5 removed rx2(RT) and rx2d(20099999) in accordance with CR5 Comments.
** 20080363 T1: Changed in main CR5 removed rx2(other) and othrx1(cryo) in accordance with CR5 Comments.
** 20080686 T2: Changed in main CR5 rx2d from 99999999 to 20110630 using missing day & month values and CR5 Comments.
** 20080744 T1: Changed in main CR5 rx2d from 20099999 to 20090630 using missing day & month values and CR5 Comments.
** 20080755 T1: Changed in main CR5 rx1d from 20081017 to 20081117 as incorrectly entered, rx2d from 99999999 to 20081117 using CR5 Comments.
** 20080780 T1: Changed in main CR5 rx2d from 20089999 to 20090630 using missing day & month values and CR5 Comments.
** 20080781 T1: Changed in main CR5 rx2d from 20081099 to 20081001 using missing day value and CR5 Comments.
** 20090014 JC 17APR18 T1: Changed in main CR5 rx2d from 99999999 to 20090630 using missing day & month values and CR5 Comments.
** 20130019 JC 17APR18 T1: Changed in main CR5 rx2d from 20140599 to 20140401 using CR5 Comments.
** 20130036 JC 17APR18 T1: Changed in main CR5 rx2d from 20139999 to 20130801 using missing day value and CR5 Comments.
** 20130050 JC 17APR18 T1: Changed in main CR5 rx2d from 20139999 to 20140201 using missing day value and CR5 Comments.
** 20130063 JC 17APR18 T1: Changed in main CR5 rx2d from 20141299 to 20141201 using missing day value and CR5 Comments.
** 20130076 JC 17APR18 T1: Changed in main CR5 rx2d from 99999999 to 20140215 using missing day value and CR5 Comments.
** 20130202 JC 17APR18 T1: Changed in main CR5 rx1d & rx2d from 20149999 to 20140630 using missing day & month values and CR5 Comments.
** 20130272 JC 17APR18 T1: Changed in main CR5 rx1d from 99999999 to 20130630, rx2d from 99999999 to 20140630 using missing day & month values and CR5 Comments.
** 20130297 JC 17APR18 T1: Changed in main CR5 rx2d from 20140199 to 20140101 using missing day value and CR5 Comments.
** 20130319 JC 17APR18 T1: Changed in main CR5 rx2d from 20139999 to 20130630 using missing day & month values and CR5 Comments.
** 20130323 JC 17APR18 T1: Changed in main CR5 rx2d from 20140199 to 20140120 using CR5 Comments; T2: Changed in main CR5 rx2d from 20140199 to 20140120 using CR5 Comments.
** 20130343 JC 17APR18 T1: Changed in main CR5 rx2d from 20139999 to 20130630 using missing day & month values and CR5 Comments; T2: Changed in main CR5 rx2d from 20149999 to 20140606 using CR5 Comments.
** 20130401 JC 17APR18 T1: Changed in main CR5 rx2d from 20130399 to 20130315 using missing day value and CR5 Comments.
** 20130586 JC 17APR18 T1: Changed in main CR5 rx2d from 20139999 to 20140307 using CR5 Comments.
** 20130648 JC 17APR18 T1: Changed in main CR5 rx2d from 20140199 to 20140115 using missing day value and CR5 Comments.
** 20130742 JC 17APR18 T1: Changed in main CR5 rx2d from 20149999 to 20140321 using CR5 Comments.
count if rxcheckcat==10 //32 16apr18 - all corrected in main CR5; 1 11jul18 - 20090014 corrected again in main CR5
list pid cr5id rx2 rx2d dxyr ttda if rxcheckcat==10

** rxcheckcat 11: rx2d after rx3d
** 20090020 T1: Changed in main CR5 switched rx1 with rx3 and vice versa. See CR5 Comments.
** 20090024 T1: Changed in main CR5 switched rx2 with rx3 and vice versa. See CR5 Comments.
** 20130165 T1: Changed in main CR5 rx2d from 20140999 to 20140901 using missing day value and CR5 Comments.
** 20130250 T1: Changed in main CR5 switched rx2 with rx3 and vice versa. See CR5 Comments.
** 20130252 T1: Changed in main CR5 switched rx2 with rx3 and vice versa. See CR5 Comments.
count if rxcheckcat==11 //7 16apr18 - all corrected in main CR5; 0 11jul18
list pid cr5id rx2d rx3d dxyr ttda if rxcheckcat==11

** rxcheckcat 12: rx2d after rx4d
** 20130155 T1: Changed in main CR5 rx2d from 20130699 to 20130601 using missing day value and CR5 Comments.
count if rxcheckcat==12 //1 16apr18 - all corrected in main CR5; 0 11jul18
list pid cr5id rx2d rx4d dxyr ttda if rxcheckcat==12

** rxcheckcat 13: rx2d after rx5d
count if rxcheckcat==13 //0 16apr18; 0 11jul18
list pid cr5id rx2d rx5d dxyr ttda if rxcheckcat==13

** rxcheckcat 14: rx3=0-no rx or 9-unk
count if rxcheckcat==14 //0 16apr18; 0 11jul18
list pid cr5id rx1 rx2 rx3 rx3d dxyr ttda if rxcheckcat==14

** rxcheckcat 15: rx3==. & rx3d!=./01jan00
count if rxcheckcat==15 //0 16apr18; 0 11jul18
list pid cr5id rx3 rx3d dxyr ttda if rxcheckcat==15

** rxcheckcat 16: rx3!=0-no rx & rx3!=9-unk & rx3d==./01jan00
** 20080644 JC 17APR18 T1: Changed in main CR5 rx3 from RT to Immuno, rx3d from 99999999 to 20081022 using CR5 Comments.
** 20080689 JC 17APR18 T1: Changed in main CR5 rx3d from 20099999 to 20090415 using CR5 Comments.
** 20080695 JC 17APR18 T1: Changed in main CR5 rx3d from 99999999 to 20080711 using CR5 Comments.
** 20080697 JC 17APR18 T1: Changed in main CR5 rx2d, rx3d from 20089999 to 20080630 using missing day & month values and CR5 Comments.
** 20080769 JC 17APR18 T1: Changed in main CR5 rx2d from 20090599 to 20090501, rx3d from 20090699 to 20090601 using missing day values and CR5 Comments.
** 20080874 JC 17APR18 T1: Changed in main CR5 rx2d, rx3d from 99999999 to 20080630 using missing day & month values and CR5 Comments.
** 20090053 JC 17APR18 T1,T2: Changed in main CR5 removed rx2(chemo),rx2d(99999999),rx3(RT),rx3d(99999999) as no mention of Rx in CR5 Comments.
** 20130274 JC 17APR18 T1: Changed in main CR5 rx2d from 20131099 to 20130901 using missing day, rx3d from 20131099 to 20131013 using CR5 Comments.
** 20130278 JC 17APR18 T1: Changed in main CR5 rx2d, rx3d from 20149999 to 20140630, NRN from 610322-9999 to 610322-0122 using missing day & month values, CR5 Comments and DeathDataDb.
** 20130283 JC 17APR18 T1: Changed in main CR5 rx2d from 20130899 to 20130901, rx3d from 20130899 to 20130901 using missing day and CR5 Comments.
count if rxcheckcat==16 //14 16apr18 - all corrected in main CR5; 0 11jul18
list pid cr5id rx3 rx3d dxyr ttda if rxcheckcat==16

** rxcheckcat 17: rx3d after rx4d
** 20130246 T1: Changed in main CR5 rx3d from 20140499 to 20140401 using missing day value and CR5 Comments.
count if rxcheckcat==17 //1 16apr18 - all corrected in main CR5; 0 11jul18
list pid cr5id rx3d rx4d dxyr ttda if rxcheckcat==17

** rxcheckcat 18: rx3d after rx5d
count if rxcheckcat==18 //0 16apr18; 0 11jul18
list pid cr5id rx3d rx5d dxyr ttda if rxcheckcat==18

** rxcheckcat 19: rx4=0-no rx or 9-unk
count if rxcheckcat==19 //0 16apr18; 0 11jul18
list pid cr5id rx1 rx2 rx3 rx4 rx4d dxyr ttda if rxcheckcat==19

** rxcheckcat 20: rx4==. & rx4d!=./01jan00
count if rxcheckcat==20 //0 16apr18; 0 11jul18
list pid cr5id rx4 rx4d dxyr ttda if rxcheckcat==20

** rxcheckcat 21: rx4!=0-no rx & rx4!=9-unk & rx4d==./01jan00
** 20080001 T1: Changed in main CR5 rx2d from 20089999 to 20080430, switched rx3 and rx4 info, rx3d from 99999999 to 20080430, rx4 from 2 to 8, rx4d from 20089999 to 20081216, othrx1 to 3 and othrx2 to 'RT' using CR5 Comments.
** 20130237 T1: Changed in main CR5 rx4d from 20141299 to 20141201 using missing day value and CR5 Comments.
count if rxcheckcat==21 //2 16apr18 - all corrected in main CR5; 0 11jul18
list pid cr5id rx4 rx4d dxyr ttda if rxcheckcat==21

** rxcheckcat 22: rx4d after rx5d
count if rxcheckcat==22 //0 16apr18; 0 11jul18
list pid cr5id rx4d rx5d dxyr ttda if rxcheckcat==22

** rxcheckcat 23: rx5=0-no rx or 9-unk
count if rxcheckcat==23 //0 16apr18; 0 11jul18
list pid cr5id rx1 rx2 rx3 rx4 rx5 rx5d dxyr ttda if rxcheckcat==23

** rxcheckcat 24: rx5==. & rx5d!=./01jan00
count if rxcheckcat==24 //0 16apr18; 0 11jul18
list pid cr5id rx5 rx5d dxyr ttda if rxcheckcat==24

** rxcheckcat 25: rx5!=. & rx5!=0-no rx & rx5!=9-unk & rx5d==./01jan00
count if rxcheckcat==25 //0 16apr18; 0 11jul18
list pid cr5id rx5 rx5d dxyr ttda if rxcheckcat==25

** rxcheckcat 26: Rx1 before InciD
** 20080004 JC 19apr18 T1: Changed in main CR5 - removed rx1(sx) as incorrect and moved rx2 to rx1 according to CR5 Comments.
** 20080036 JC 19apr18 T1: Changed in main CR5 - removed rx1(sx) as incorrect and moved rx2 to rx1 according to CR5 Comments.
** 20080158 JC 19apr18 T1: Changed in main CR5 InciD from 20080930 to 20080805 as incorrect according to CR5 Comments.
** 20080185 JC 19apr18 T1: Changed in main CR5 InciD from 20081120 to 20081111 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080209 JC 19apr18 T1: Changed in main CR5 InciD from 20080925 to 20080731(DFC) as incorrect according to CR5 Comments.
** 20080457 JC 19apr18 T4: Changed in main CR5 InciD from 20080220 to 20080207 as incorrect according to CR5 Comments.
** 20080564 JC 19apr18 T1: Changed in main CR5 InciD from 20081029 to 20081021 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080706 JC 19apr18 T4: Changed in main CR5 InciD from 20110816 to 20100430, age from 81 to 80 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080711 JC 19apr18 T1: Changed in main CR5 InciD from 20081204 to 20081120 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080800 JC 19apr18 T1: Changed in main CR5 InciD from 20080121 to 20080109 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080851 JC 19apr18 T1,T2: Changed in main CR5 InciD from 20080312 to 20080218 as incorrect according to CR5 Comments.
** 20080918 JC 19apr18 T1: Changed in main CR5 InciD from 20080416 to 20080404 as incorrect according to CR5 Comments.
** 20080926 JC 19apr18 T1: Changed in main CR5 InciD from 20080416 to 20080229 as incorrect according to CR5 Comments.
** 20080934 JC 19apr18 T1: Changed in main CR5 InciD from 20080223 to 20080215 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080947 JC 19apr18 T1: Changed in main CR5 InciD from 20080415 to 20080409 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080948 JC 19apr18 T1: Changed in main CR5 InciD from 20080924 to 20080916 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080952 JC 19apr18 T1: Changed in main CR5 InciD from 20080205 to 20080131 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080953 JC 19apr18 T1: Changed in main CR5 InciD from 20080213 to 20080129 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080954 JC 19apr18 T1: Changed in main CR5 InciD from 20080208 to 20080204 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080959 JC 19apr18 T1: Changed in main CR5 InciD from 20080219 to 20080212 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080961 JC 19apr18 T1: Changed in main CR5 InciD from 20080226 to 20080219 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080963 JC 19apr18 T1: Changed in main CR5 InciD from 20080229 to 20080213 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080975 JC 19apr18 T1: Changed in main CR5 InciD from 20081128 to 20081120 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080977 JC 19apr18 T1: Changed in main CR5 InciD from 20080820 to 20080814 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080982 JC 19apr18 T1: Changed in main CR5 InciD from 20080417 to 20080411 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20080990 JC 19apr18 T1: Changed in main CR5 InciD from 20080516 to 20080430 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20081003 JC 19apr18 T1: Changed in main CR5 InciD from 20080811 to 20080805 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20081005 JC 19apr18 T1: Changed in main CR5 InciD from 20081202 to 20081121 as incorrect according to CR5 Comments.
** 20081007 JC 19apr18 T1: Changed in main CR5 InciD from 20081119 to 20081106 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20081009 JC 19apr18 T1: Changed in main CR5 InciD from 20081008 to 20080930 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20081017 JC 19apr18 T1: Changed in main CR5 InciD from 20080805 to 20080729 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20081021 JC 19apr18 T1: Changed in main CR5 InciD from 20080526 to 20080523 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20081024 JC 19apr18 T1: Changed in main CR5 InciD from 20081231 to 20081114 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20081025 JC 19apr18 T1: Changed in main CR5 InciD from 20080605 to 20080519 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20081056 JC 19apr18 T1: Changed in main CR5 InciD from 20080828 to 20080815 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20081057 JC 19apr18 T1: Changed in main CR5 InciD from 20080909 to 20080901 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20081058 JC 19apr18 T1: Changed in main CR5 InciD from 20080327 to 20080318 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20081062 JC 19apr18 T1: Changed in main CR5 InciD from 20080207 to 20080116 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20081106 JC 19apr18 T1: Changed in main CR5 InciD from 20080523 to 20080429 as incorrect according to CR5 Comments.
** 20081124 JC 19apr18 T1: Changed in main CR5 InciD from 20081121 to 20081107 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20090038 JC 19apr18 T1: Changed in main CR5 InciD from 20090815 to 20090605 as incorrect according to CR5 Comments.
** 20090038 JC 11jul18 T1: Changed in main CR5 InciD from 20090605 to 20080605, dxyr from 2009 to 2008, recstatus from inelig. to confirmed as incorrectly assigned when previously reviewed (see directly above).
** 20130037 JC 19apr18 T1: Changed in main CR5 rx1d from 20130327 to 20140327 as incorrectly assigned by DA in abs and CR5 comments; See CR5 Comments & MasterDb #2114.
** 20130069 JC 19apr18 T1: Changed in main CR5 primay site from 'femur-neck' to 'bone-femur', InciD from 20130325 to 20130301, as incorrectly assigned by DA in abs; See CR5 Comments, IARC Tech Rpt No 40 pg 14(Incidence Date) & MasterDb #1579.
** 20130078 JC 19apr18 T1: Changed in main CR5 InciD from 20080624 to 20080423 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20130102 JC 19apr18 T1: Changed in main CR5 InciD from 20080523 to 20080502 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20130269 JC 19apr18 T1: Changed in main CR5 InciD from 20080321 to 20080320 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20130668 JC 19apr18 T1: Changed in main CR5 InciD from 20080620 to 20080618 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20130695 JC 19apr18 T1: Changed in main CR5 InciD from 20130521 to 20130226 as incorrect according to CR5 Comments.
** 20130778 JC 19apr18 T1: Changed in main CR5 InciD from 20080503 to 20080424 as incorrect according to CR5 Comments and IARC Tech Rpt No 40 pg 14(Incidence Date).
** 20130779 JC 19apr18 T1: Changed in main CR5 InciD from 20131126 to 20130925 as incorrect according to CR5 Comments.
count if rxcheckcat==26 //54 17apr18 - all corrected in main CR5; 1 11jul18 - 20090038 corrected again in main CR5.
list pid cr5id rx1d dot dxyr ttda if rxcheckcat==26

** rxcheckcat 27: Rx2 before InciD
** 20130615 JC 19apr18 T1: Changed in main CR5 InciD from 20131205 to 20130501 using missing day value as incorrect according to CR5 Comments.
count if rxcheckcat==27 //1 17apr18 - corrected in main CR5; 0 11jul18
list pid cr5id rx2d dot dxyr ttda if rxcheckcat==27

** rxcheckcat 28: Rx3 before InciD
count if rxcheckcat==28 //0 17apr18; 0 11jul18
list pid cr5id rx3d dot dxyr ttda if rxcheckcat==28

** rxcheckcat 29: Rx4 before InciD
count if rxcheckcat==29 //0 17apr18; 0 11jul18
list pid cr5id rx4d dot dxyr ttda if rxcheckcat==29

** rxcheckcat 30: Rx5 before InciD
count if rxcheckcat==30 //0 17apr18; 0 11jul18
list pid cr5id rx5d dot dxyr ttda if rxcheckcat==30

** rxcheckcat 31: Rx1 after DLC
** 20080586 JC 19apr18 T1: Changed in main CR5 DLC from 20080619 to 20080729; see CR5 Comments & MasterDb #1934.
** 20081073 JC 19apr18 T1: Changed in main CR5 DLC from 20081207 to 20081211; see CR5 Comments & MasterDb #12 & 2455.
** 20081076 JC 11JUL18 T2,T3: Changed in main CR5 rx1d from 20081099 to 20081007 using MasterDb #2141(ReceivedDate) and CR5 Comments.
** 20130003 JC 11JUL18 T1: Changed in main CR5 DLC from 20130630 to 20130613 as incorrectly assigned when previously reviewed.
count if rxcheckcat==31 //2 17apr18 - all corrected in main CR5; 3 11jul18 - 20081076 changed T2, T3; 20130003 changed (see above)
list pid cr5id rx1d dlc dxyr ttda if rxcheckcat==31

** rxcheckcat 32: Rx2 after DLC
count if rxcheckcat==32 //0 17apr18; 0 11jul18
list pid cr5id rx2d dlc dxyr ttda if rxcheckcat==32

** rxcheckcat 33: Rx3 after DLC
** 20130006 JC 19apr18 T2: Changed in main CR5 DLC from 20130830 to 20160308; see CR5 Comments.
** 20130099 JC 19apr18 T1: Changed in main CR5 DLC from 20140424 to 20140429; see CR5 Comments.
** 20130610 JC 19apr18 T1: Changed in main CR5 DLC from 20130716 to 20140701; see CR5 Comments.
count if rxcheckcat==33 //5 17apr18 - all corrected in main CR5; 0 11jul18
list pid cr5id rx3d dlc dxyr ttda if rxcheckcat==33

** rxcheckcat 34: Rx4 after DLC
** 20080001 JC 11JUL18 T1: Changed in main CR5 DLC from 20080602 to 20081216, recstatus from inelig. to confirmed; see CR5 Comments.
count if rxcheckcat==34 //0 17apr18; 1 11jul18 - 20080001 corrected in main CR5
list pid cr5id rx4d dlc dxyr ttda if rxcheckcat==34

** rxcheckcat 35: Rx5 after DLC
count if rxcheckcat==35 //0 17apr18; 0 11jul18
list pid cr5id rx5d dlc dxyr ttda if rxcheckcat==35

** For below treatment checks (36-40) use checkflag 113 if Rx correctly coded
** rxcheckcat 36: Rx1-5!=hormono & Comments=Cyproterone
count if rxcheckcat==36 //0 18apr18; 0 11jul18
list pid cr5id rx1 rx2 rx3 rx4 rx5 dxyr ttda if rxcheckcat==36
** run above line of code first then use the obs IDs in that list for below display code
** note: the obs IDs are subject to change each time list is run
** display _asis substr(comments[1081], 1, 8000)

/* Below code doesn't display entire contents of CR5 Comments variable
list pid comments if rxcheckcat==37 , notrim
*/

********************************************************* STOPPED HERE ***************************************************************************************

** rxcheckcat 37: Rx1-5!=immuno & Comments=Thalidomide
** 20080812 JC 19apr18 T1: Rx correctly assigned so entered under checkflag 113.
** 20090042 JC 19apr18 T1: Rx correctly assigned so entered under checkflag 113.
count if rxcheckcat==37 //5 18apr18; 4 19apr18 - all flagged in 113; 4 12jul18 - correctly assigned in checkflag113
list pid cr5id rx1 rx2 rx3 rx4 rx5 dxyr ttda if rxcheckcat==37
** Since cases already assigned to checkflag 113 are being repeatedly flagged run below code after above code
count if rxcheckcat==37 & checkflag113==. //0 12jul18
list pid cr5id rx1 rx2 rx3 rx4 rx5 dxyr ttda if rxcheckcat==37 & checkflag113==.
** run above line of code first then use the obs IDs in that list for below display code
** note: the obs IDs are subject to change each time list is run
display _asis substr(comments[1081], 1, 8000)
display _asis substr(comments[1454], 1, 8000)
display _asis substr(comments[1539], 1, 8000)
display _asis substr(comments[1540], 1, 8000)

** rxcheckcat 38: Rx1-5!=immuno & Comments=Rituximab
** 20080312 JC 19apr18 T1: Rx correctly assigned so entered under checkflag 113.
** 20080312 JC 19apr18 T2: Rx already corrected in rxcheckcat 3 above on 17apr18.
** 20080644 JC 19apr18 T1: Rx already corrected in rxcheckcat 16 above on 17apr18.
** 20080700 JC 19apr18 T1: Rx already corrected in rxcheckcat 3 above on 17apr18.
** 20080700 JC 19apr18 T2,T3: Rx correctly assigned so entered under checkflag 113.
** 20090058 JC 19apr18 T1: Rx correctly assigned so entered under checkflag 113.
** 20100007 JC 19apr18 T1: Changed in main CR5 added in rx3(hormono), rx3d(20100727), rx4(immuno), rx4d(20100727) using CR5 Comments and SEER Rx dictionary.
** 20130077 JC 19apr18 T1: Changed in main CR5 added in rx2(hormono), rx2d(20130618), rx3(immuno), rx3d(20131210) using CR5 Comments and SEER Rx dictionary.
count if rxcheckcat==38 //9 18apr18 - 5 changed in main CR5; 4 flagged in 113
list pid cr5id rx1 rx2 rx3 rx4 rx5 dxyr ttda if rxcheckcat==38
** Since cases already assigned to checkflag 113 are being repeatedly flagged run below code after above code
count if rxcheckcat==38 & checkflag113==. //0 12jul18
list pid cr5id rx1 rx2 rx3 rx4 rx5 dxyr ttda if rxcheckcat==38 & checkflag113==.
** run above line of code first then use the obs IDs in that list for below display code
** note: the obs IDs are subject to change each time list is run
display _asis substr(comments[365], 1, 8000)
display _asis substr(comments[366], 1, 8000)
display _asis substr(comments[802], 1, 8000)
display _asis substr(comments[892], 1, 8000)
display _asis substr(comments[893], 1, 8000)
display _asis substr(comments[894], 1, 8000)
display _asis substr(comments[1476], 1, 8000)
display _asis substr(comments[1501], 1, 8000)
display _asis substr(comments[1610], 1, 8000)

** rxcheckcat 39: Rx1-5!=hormono & Comments=Dexamethasone
** 20080053 JC 19apr18 T1: Rx correctly assigned so entered under checkflag 113.
** 20080078 JC 19apr18 T1: Rx correctly assigned so entered under checkflag 113.
** 20080103 JC 19apr18 T2: Rx already corrected in rxcheckcat 3 above on 17apr18.
** 20080117 JC 19apr18 T1: Rx correctly assigned so entered under checkflag 113.
** 20080703 JC 19apr18 T1: Changed in main CR5 added in rx2(hormono), rx2d(20080730) using CR5 Comments and SEER Rx dictionary.
** 20080755 JC 19apr18 T1: Changed in main CR5 added in rx3(hormono), rx3d(20081117) using CR5 Comments and SEER Rx dictionary.
** 20080870 JC 19apr18 T1: Rx correctly assigned so entered under checkflag 113.
** 20080880 JC 19apr18 T1: Changed in main CR5 moved rx2(othrx) to rx3 and added in rx2(hormono), rx2d(20080715) using CR5 Comments and SEER Rx dictionary.
** 20090039 JC 19apr18 T1: Changed in main CR5 added in rx2(hormono), rx2d(20090512) using CR5 Comments and SEER Rx dictionary.
** 20090043 JC 19apr18 T1: Changed in main CR5 added in rx2(hormono), rx2d(20090324) using CR5 Comments and SEER Rx dictionary.
** 20090044 JC 19apr18 T1: Changed in main CR5 moved rx2(RT) to rx3 and added in rx2(hormono), rx2d(20091026) using CR5 Comments and SEER Rx dictionary.
** 20090054 JC 19apr18 T1: Changed in main CR5 added in rx2(hormono), rx2d(20090812) using CR5 Comments and SEER Rx dictionary.
** 20090063 JC 19apr18 T1: Changed in main CR5 moved rx2(RT) to rx3 and added in rx2(hormono), rx2d(20090226) using CR5 Comments and SEER Rx dictionary.
** 20090064 JC 19apr18 T1: Rx correctly assigned so entered under checkflag 113.
** 20130045 JC 19apr18 T1: Changed in main CR5 added in rx3(hormono), rx2d(20130820) using CR5 Comments and SEER Rx dictionary.
** 20130103 JC 19apr18 T1: Changed in main CR5 added in rx2(hormono), rx2d(20130305) using CR5 Comments and SEER Rx dictionary.
** 20130176 JC 19apr18 T1: Changed in main CR5 added in rx2(hormono), rx2d(20131022) using CR5 Comments and SEER Rx dictionary.
** 20130181 JC 19apr18 T1: Rx correctly assigned so entered under checkflag 113.
** 20130192 JC 19apr18 T1: Changed in main CR5 added in rx2(hormono), rx2d(20130225) using CR5 Comments and SEER Rx dictionary.
** 20130229 JC 19apr18 T1: Rx correctly assigned so entered under checkflag 113.
** 20130257 JC 19apr18 T1: Changed in main CR5 added in rx3(hormono), rx3d(20131029) using CR5 Comments and SEER Rx dictionary.
** 20130526 JC 19apr18 T1: Rx correctly assigned so entered under checkflag 113.
** 20130594 JC 19apr18 T1: Changed in main CR5 added in rx2(hormono), rx2d(20131009) using CR5 Comments and SEER Rx dictionary.
count if rxcheckcat==39 //24 18apr18 - 16 changed in main CR5; 8 flagged in 113
** Since cases already assigned to checkflag 113 are being repeatedly flagged run below code after above code
count if rxcheckcat==39 & checkflag113==. //0 12jul18
list pid cr5id rx1 rx2 rx3 rx4 rx5 dxyr ttda if rxcheckcat==39 & checkflag113==.
** run above line of code first then use the obs IDs in that list for below display code
** note: the obs IDs are subject to change each time list is run
display _asis substr(comments[70], 1, 8000)
display _asis substr(comments[98], 1, 8000)
display _asis substr(comments[124], 1, 8000)
display _asis substr(comments[139], 1, 8000)
display _asis substr(comments[897], 1, 8000)
display _asis substr(comments[1018], 1, 8000)
display _asis substr(comments[1138], 1, 8000)
display _asis substr(comments[1148], 1, 8000)
display _asis substr(comments[1450], 1, 8000)
display _asis substr(comments[1455], 1, 8000)
display _asis substr(comments[1457], 1, 8000)
display _asis substr(comments[1471], 1, 8000)
display _asis substr(comments[1481], 1, 8000)
display _asis substr(comments[1482], 1, 8000)
display _asis substr(comments[1572], 1, 8000)
display _asis substr(comments[1640], 1, 8000)
display _asis substr(comments[1738], 1, 8000)
display _asis substr(comments[1743], 1, 8000)
display _asis substr(comments[1744], 1, 8000)
display _asis substr(comments[1755], 1, 8000)
display _asis substr(comments[1795], 1, 8000)
display _asis substr(comments[1850], 1, 8000)
display _asis substr(comments[2130], 1, 8000)
display _asis substr(comments[2216], 1, 8000)

** rxcheckcat 40: Rx1-5!=hormono & Comments=Prednisone
** 20080780 JC 19apr18 T1: Changed in main CR5 rx1d from 20080408 to 20080401 using missing day value, moved rx2(chemo) to rx3 and added in rx2(hormono), rx2d(20080401) using CR5 Comments and SEER Rx dictionary.
** 20080784 JC 19apr18 T1: Changed in main CR5 added in rx2(hormono), rx2d(20081029) using CR5 Comments and SEER Rx dictionary.
** 20090042 JC 19apr18 T1: Changed in main CR5 added in rx2(hormono), rx2d(20090929) using CR5 Comments and SEER Rx dictionary.
** 20090060 JC 19apr18 T1: Changed in main CR5 added in rx2(hormono), rx2d(20081215) using CR5 Comments and SEER Rx dictionary.
count if rxcheckcat==40 //4 19apr18 - all changed in main CR5
list pid cr5id rx1 rx2 rx3 rx4 rx5 dxyr ttda if rxcheckcat==40
** Since cases already assigned to checkflag 113 are being repeatedly flagged run below code after above code
count if rxcheckcat==40 & checkflag113==. //0 12jul18
** run above line of code first then use the obs IDs in that list for below display code
** note: the obs IDs are subject to change each time list is run
display _asis substr(comments[1047], 1, 8000)
display _asis substr(comments[1052], 1, 8000)
display _asis substr(comments[1454], 1, 8000)
display _asis substr(comments[1478], 1, 8000)

** rxcheckcat 41: Rx1-5!=hormono & Comments=Hydrocortisone
** 20080070 JC 19apr18 T1: Changed in main CR5 InciD from 2008118 to 20080930, AdmD from 20081118 to 20080930 rx1 from 0-no rx to 5-hormono, rx1d(20080930), removed norx1 using CR5 Comments and SEER Rx dictionary.
** 20130594 JC 19apr18 T1: Rx already corrected in rxcheckcat 39 above on 19apr18.
count if rxcheckcat==41 //2 19apr18
list pid cr5id rx1 rx2 rx3 rx4 rx5 dxyr ttda if rxcheckcat==41
** Since cases already assigned to checkflag 113 are being repeatedly flagged run below code after above code
count if rxcheckcat==41 & checkflag113==. //0 12jul18
** run above line of code first then use the obs IDs in that list for below display code
** note: the obs IDs are subject to change each time list is run
display _asis substr(comments[90], 1, 8000)
display _asis substr(comments[2215], 1, 8000)

** rxcheckcat 42: Rx1-5!=hormono & Comments=Arimidex
** 20080321 JC 23APR18 T1: Arimidex for 2007 breast ca; not for skin SCC.
** 20090011 JC 23APR18 T1: Arimidex recommended but pt refused.
** 20130175 JC 23APR18 T2: Arimidex for T1 breast ca; not for T2.
count if rxcheckcat==42 //3 23apr18
list pid cr5id rx1 rx2 rx3 rx4 rx5 dxyr ttda if rxcheckcat==42
** Since cases already assigned to checkflag 113 are being repeatedly flagged run below code after above code
count if rxcheckcat==42 & checkflag113==. //0 12jul18
list pid cr5id rx1 rx2 rx3 rx4 rx5 dxyr ttda if rxcheckcat==42 & checkflag113==.
** run above line of code first then use the obs IDs in that list for below display code
** note: the obs IDs are subject to change each time list is run
display _asis substr(comments[381], 1, 8000)
display _asis substr(comments[1420], 1, 8000)
display _asis substr(comments[1736], 1, 8000)

** rxcheckcat 43: Rx1=no rx & Rx2-5!=.
count if rxcheckcat==43 //1 23apr18 - 20130137 was changed in rxcheckcat 4; 0 12jul18
list pid cr5id rx1 rx2 rx3 rx4 rx5 dxyr ttda if rxcheckcat==43



** Check 114 - invalid (Rx1-5)
** Add reviewer comments to those that need to be corrected
/* Not needed as no errors flagged in checkflag 113 as of 19apr18.
replace checkflag114=114 if pid=="" & cr5id=="T1S1"
replace reviewertxt7="JC 16apr2018: pid ... - Update T1's behaviour from 3 to 2 - see morph and staging." ///
		if pid=="..." & cr5id=="T1S1"
*/

** Check 113 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag113=113 if checkflag114!=114



*************************
** Treatments 1-5 Date **
*************************
** Missing dates already captured in checkflags in Rx1-5

** Checkflag 115: Rx1-5 Dates (future date)
count if (rx1d!=. & rx1d>currentdatett) | (rx2d!=. & rx2d>currentdatett) | (rx3d!=. & rx3d>currentdatett) | (rx4d!=. & rx4d>currentdatett) | (rx5d!=. & rx5d>currentdatett) //0 19apr18; 0 12jul18
list pid cr5id rx1d rx2d rx3d rx4d rx5d dxyr ttda if (rx1d!=. & rx1d>currentdatett) | (rx2d!=. & rx2d>currentdatett) | (rx3d!=. & rx3d>currentdatett) | (rx4d!=. & rx4d>currentdatett) | (rx5d!=. & rx5d>currentdatett)
replace checkflag115=115 if (rx1d!=. & rx1d>currentdatett) | (rx2d!=. & rx2d>currentdatett) | (rx3d!=. & rx3d>currentdatett) | (rx4d!=. & rx4d>currentdatett) | (rx5d!=. & rx5d>currentdatett)


***************************
** Other Treatment 1 & 2 **
***************************
** NOTE 1: Treatment only collected at 5 year intervals so treatment collected on 2013 data then 2018 and so on;
** NOTE 2: In upcoming years of data collection (2018 dc year), more rxcheckcat checks will be compiled based on data.

** Check 116 & 117 - invalid (OthRx1&2); Review done visually via lists below and specific checks created (orxcheckcat). 
** Check 116=Reviewed/Corrected by DA/Reviewer; no errors
** Check 117=Invalid (OthRx1&2) generated via orxcheckcat
** First, flag errors and assign as checkflag 117 then
** flag rest of cases as checkflag 116(no errors)
** When running this code on 2014 abstractions then need to use lists that are after the orxcheckcat (scroll down)

							
** Check 117 - invalid(OthRx1&2)

** orxcheckcat 1: OtherRx 1 missing
** 20080206 JC 23APR18 T1: already corrected in rxcheckcat 2 above
** 20080435 JC 23APR18 T2: Changed in main CR5 orx1 from blank to 1(cryo), othrx2 from blank to LIQUID NITROGEN.
** 20080737 JC 23APR18 T2: Changed in main CR5 orx1 from blank to 1(cryo), othrx2 from blank to LIQUID NITROGEN.
** 20080739 JC 23APR18 T2: Changed in main CR5 orx1 from blank to 1(cryo), othrx2 from blank to LIQUID NITROGEN.
count if orxcheckcat==1 //4 23apr18 - all corrected; 0 12jul18
list pid orx1 rx1 rx2 rx3 rx4 rx5 dxyr cr5id dxyr ttda if orxcheckcat==1

** orxcheckcat 2: OtherRx 2 missing
** 20060001 JC 23apr18 T1: Changed in main CR5 othrx2 to RT, removed norx1(symp).
** 20080077 JC 23APR18 T1: already corrected in rxcheckcat 2 above.
** 20080080 JC 23apr18 T1: Changed in main CR5 rx1 from sx to othrx, othrx2 to LAPAROTOMY, CHOLECYSTECTOMY & TRIPLE BYPASS. See CR5 comments.
** 20080109 JC 23APR18 T1: already corrected in rxcheckcat 2 above.
** 20080110 JC 23apr18 T1: Changed in main CR5 othrx2 to RT. See CR5 comments.
** 20080113 JC 23apr18 T1: Changed in main CR5 othrx2 to 99. See CR5 comments.
** 20080245 JC 23APR18 T1: see rxcheckcat 3 above - Changed in main CR5 rx1 from othrx to unk, removed othrx1(treated abroad) in accord with CR5 Comments as treatment suggested, no indication it was not done.
** 20080266 JC 23apr18 T1: Changed in main CR5 rx1 from othrx to no rx, norx1(symp), removed rx1d(20080903) and othrx1(palliative). See CR5 comments.
** 20080296 JC 23apr18 T1: Changed in main CR5 norx1 from blank to symp, removed othrx1(palliative). See CR5 comments.
** 20080309 JC 23APR18 T1: already corrected in rxcheckcat 3 above.
** 20080321 JC 23apr18 T1: Changed in main CR5 othrx2 from blank to RT. See CR5 comments.
** 20080335 JC 23apr18 T1: Changed in main CR5 othrx2 from blank to 99. See CR5 comments.
** 20080352 JC 23apr18 T1: Changed in main CR5 dlc from 20090207 to 20090408, rx1 from no rx to othrx, rx1d from blank to 20080408, othrx2 from blank to RT-BRACHYTHERAPY. See CR5 comments.
** 20080363 JC 23apr18 T2,T3,T4: Changed in main CR5 removed rx2(othrx), rx2d(20080418/20080530-T4),othrx1(cryo). See MasterDb and CR5 comments.
** 20080583 JC 23APR18 T1: already corrected in rxcheckcat 3 above.
** 20080619 JC 23APR18 T1: already corrected in rxcheckcat 3 above.
** 20080642 JC 23apr18 T1: Changed in main CR5 rx1 from unk to othrx, rx1d from blank to 20081104, othrx2 from blank to 99. See CR5 comments.
** 20080682 JC 23apr18 T1: Changed in main CR5 rx1 from unk to othrx, rx1d from blank to 20081219, othrx2 from blank to 99. See CR5 comments.
** 20080753 JC 23apr18 T1: Changed in main CR5 rx1 from sx to othrx, othrx2 from blank to laser ablation. See CR5 comments.
** 20080766 JC 23apr18 T3,T4: Changed in main CR5 othrx2 from blank to liquid nitrogen. See CR5 comments.
** 20080799 JC 23APR18 T1: already corrected in rxcheckcat 3 above.
** 20080818 JC 23APR18 T1: already corrected in rxcheckcat 3 above.
** 20080822 JC 23apr18 T1: Changed in main CR5 othrx2 from blank to gastrojejunostomy. See CR5 comments.
** 20080828 JC 23APR18 T1: already corrected in rxcheckcat 3 above.
** 20080836 JC 23APR18 T1: already corrected in rxcheckcat 3 above.
** 20080838 JC 23APR18 T1: already corrected in rxcheckcat 3 above.
** 20080857 JC 23APR18 T1: already corrected in rxcheckcat 3 above.
** 20080873 JC 23apr18 T1: Changed in main CR5 InciD from 20080623 to 20080618, othrx2 from blank to RT. See CR5 comments.
** 20090064 JC 23APR18 T1: already corrected in rxcheckcat 3 above.
** 20090065 JC 23APR18 T1: already corrected in rxcheckcat 3 above.
count if orxcheckcat==2 //35 23apr18 - all corrected; 0 12jul18
list pid orx1 orx2 dxyr cr5id dxyr ttda if orxcheckcat==2

** orxcheckcat 3: OtherRx1 invalid length
count if orxcheckcat==3 //0 23apr18; 0 12jul18
list pid othtreat1 orx1 dxyr cr5id dxyr ttda if orxcheckcat==3

** orxcheckcat 4: orx2=UNKNOWN
** 20130518 JC 23APR18 T1: already corrected in rxcheckcat 3 above
** 20130534 JC 23apr18 T1: Changed in main CR5 othrx2 from UNKNOWN to 99.
** 20130541 JC 23apr18 T1: Changed in main CR5 othrx2 from UNKNOWN to 99.
count if orxcheckcat==4 //3 23apr18 - 2 changed in main CR5; 0 12jul18
list pid cr5id orx1 orx2 dxyr ttda if orxcheckcat==4


** Check 117 - invalid (OthRx1&2)
** Add reviewer comments to those that need to be corrected
/* Not needed as no errors flagged in checkflag 116 as of 23apr18.
replace checkflag117=117 if pid=="" & cr5id=="T1S1"
replace reviewertxt7="JC 16apr2018: pid ... - Update T1's behaviour from 3 to 2 - see morph and staging." ///
		if pid=="..." & cr5id=="T1S1"
*/

** Check 116 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag116=116 if checkflag117!=117


***************************
** No Treatments 1 and 2 **
***************************
** NOTE 1: Treatment only collected at 5 year intervals so treatment collected on 2013 data then 2018 and so on;
** NOTE 2: In upcoming years of data collection (2018 dc year), more rxcheckcat checks will be compiled based on data.

** Check 118 & 119 - invalid (NoRx1&2); Review done visually via lists below and specific checks created (norxcheckcat). 
** Check 118=Reviewed/Corrected by DA/Reviewer; no errors
** Check 119=Invalid (NoRx1&2) generated via norxcheckcat
** First, flag errors and assign as checkflag 119 then
** flag rest of cases as checkflag 118(no errors)
** When running this code on 2014 abstractions then need to use lists that are after the norxcheckcat (scroll down)

							
** Check 119 - invalid(NoRx1&2)
** 20130352 JC 23APR18 T1: Changed in main CR5 removed space from norx2 so it will import into Stata as a numeric field. Also did the same thing in 2018-03-05_Main Exported Source+Tumour+Patient_excel_JC.xlsx

** norxcheckcat 1: NoRx1 missing
** 20080296 JC 23APR18 T1: already corrected in orxcheckcat 2 above.
** 20080338 JC 23apr18 T1: Changed in main CR5 norx1 from blank to defaulted. See CR5 comments.
** 20080340 JC 23APR18 T1: already corrected in rxcheckcat 1 above.
** 20080340 JC 12JUL18 T1: Changed in main CR5 norx1 from blank to unk as rx plan discussed and suggested but unknown if it was completed. See CR5 Comments.
** 20080352 JC 23APR18 T1: already corrected in orxcheckcat 2 above.
** 20080395 JC 23apr18 T1: Changed in main CR5 norx1 from blank to defaulted. See CR5 comments.
** 20080482 JC 23apr18 T1: Changed in main CR5 rx1 from no rx to unk(no rx documented as having been done overseas). See CR5 comments.
** 20080653 JC 23APR18 T1: already corrected in rxcheckcat 1 above.
count if norxcheckcat==1 //8 23apr18 - all corrected; 0 12jul18
list pid norx1 rx1 rx2 rx3 rx4 rx5 dxyr cr5id dxyr ttda if norxcheckcat==1

** norxcheckcat 2: rx1-5!=0 & norx1!=.
** 20030001 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20060001 JC 23APR18 T1: already corrected in orxcheckcat 2 above.
** 20070001 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20070003 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20070004 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080001 JC 23APR18 T1: already corrected in rxcheckcat 21 above.
** 20080002 JC 23APR18 T1: already corrected in rxcheckcat 3 above.
** 20080003 JC 23APR18 T1: already corrected in rxcheckcat above.
** 20080005 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080006 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080007 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080008 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080009 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080010 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080012 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080013 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080014 JC 23APR18 T1: already corrected in rxcheckcat above.
** 20080015 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080016 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080017 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080019 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080020 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080021 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080022 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080023 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080024 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080025 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080026 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080027 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080028 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080029 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080031 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080032 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080034 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080035 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080037 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080038 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080039 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080040 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080041 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080042 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080043 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080044 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080045 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080046 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080047 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080048 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080049 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080050 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080051 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080054 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080055 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080056 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080057 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080058 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080061 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
** 20080103 JC 23APR18 T1: already corrected in rxcheckcat above.
** 20080143 JC 23APR18 T1: Changed in main CR5 removed norx1(unk).
** 20080553 JC 23APR18 T1: Changed in main CR5 removed norx1(unk).
** 20080567 JC 23APR18 T1: Changed in main CR5 removed norx1(unk).
** 20080620 JC 23APR18 T1: Changed in main CR5 removed norx1(unk).
** 20080831 JC 23APR18 T1: Changed in main CR5 removed norx1(died before rx).
** 20130798 JC 23APR18 T1: Changed in main CR5 removed norx1(NA).
count if norxcheckcat==2 //66 23apr18 - all corrected; 0 12jul18
list pid cr5id norx1 rx1 rx2 rx3 rx4 if norxcheckcat==2

** norxcheckcat 3: norx1==. & norx2!=.
count if norxcheckcat==3 //0 23apr18; 0 12jul18
list pid norx1 rx1 rx2 rx3 rx4 rx5 dxyr cr5id dxyr ttda if norxcheckcat==3

** norxcheckcat 4: NoRx1 invalid length
count if norxcheckcat==4 //0 23apr18; 0 12jul18
list pid notreat1 norx1 dxyr cr5id dxyr ttda if norxcheckcat==4

** norxcheckcat 5: NoRx2 invalid length
count if norxcheckcat==5 //0 23apr18; 0 12jul18
list pid notreat2 norx2 dxyr cr5id dxyr ttda if norxcheckcat==5


** Check 119 - invalid (NoRx1&2)
** Add reviewer comments to those that need to be corrected
/* Not needed as no errors flagged in checkflag 118 as of 23apr18.
replace checkflag119=119 if pid=="" & cr5id=="T1S1"
replace reviewertxt7="JC 16apr2018: pid ... - Update T1's behaviour from 3 to 2 - see morph and staging." ///
		if pid=="..." & cr5id=="T1S1"
*/

** Check 118 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag118=118 if checkflag119!=119


*****************
** TT Reviewer **
*****************
** No checks on this field as review process changed from originally planned


**********************************************************
** BLANK & INCONSISTENCY CHECKS - SOURCE TABLE
** CHECKS 120 - 173
** (1) FLAG POSSIBLE INCONSISTENCIES 
** (2) EXPORT TO EXCEL FOR CANCER TEAM TO CORRECT
**********************************************************

*********************
** Unique SourceID **
*********************
count if sid=="" //0 23apr18; 0 12jul18

************************
** ST Data Abstractor **
************************
** Check 120 - missing
count if stda==. //4 23apr18; 0 12jul18
replace checkflag120=120 if stda==.

** Length check not needed as this field is numeric
** Check 121 - invalid code
count if stda!=. & stda>13 & (stda!=22 & stda!=88 & stda!=98 & stda!=99) //0 23apr18; 0 12jul18
list pid stda cr5id if stda!=. & stda>13 & (stda!=22 & stda!=88 & stda!=98 & stda!=99)
replace checkflag121=121 if stda!=. & stda>13 & (stda!=22 & stda!=88 & stda!=98 & stda!=99)

*****************
** Source Date **
*****************
** Check 122 - missing
count if stdoa==. //4 23apr18; 0 12jul18
replace checkflag122=122 if stdoa==.

** Check 123 - invalid (future date)
** Need to create a variable with current date;
** to be used when cleaning dates
gen currentdst=c(current_date)
gen double currentdatest=date(currentdst, "DMY", 2017)
drop currentdst
format currentdatest %dD_m_CY
label var currentdatest "Current date ST"
count if stdoa!=. & stdoa>currentdatest //0 23apr18; 0 12jul18
replace checkflag123=123 if stdoa!=. & stdoa>currentdatest


*************
** NF Type **
*************
** Check 124 - NFtype missing
count if nftype==. //11 23apr18; 0 12jul18
list pid nftype dxyr cr5id if nftype==.
replace checkflag124=124 if nftype==.

** Check 125 - NFtype length
** Need to create string variable for nftype
gen notiftype=nftype
tostring notiftype, replace
** Need to change all notiftype"." to notiftype""
replace notiftype="" if notiftype=="." //11 23apr18
count if notiftype!="" & length(notiftype)>2 //0 23apr18; 0 12jul18
list pid notiftype nftype dxyr cr5id if notiftype!="" & length(notiftype)>2
replace checkflag125=125 if notiftype!="" & length(notiftype)>2

** Check 126 - NFtype=Other(possibly invalid)
** Discussed with SAF & KWG on 22may2018 and determined that NFType to change to code 15-NFs if NFType='13' AND Dcotor='99' (total of 67 records changed);
** change NFType to code 11-Haem NF if NFType='13' AND Doctor<>'99' (total of 20 records changed).
** IMPORTANT: WHEN IMPORTING BATCH CORRECTIONS - UNTICK 'Do Checks' IN MAIN CR5! WHEN CHECKS ARE RUN THE RECORD STATUS CHANGES.
** saving excel workbook as .txt and then importing into main CR5
count if nftype==13 //87 25apr18; 0 12jul18
list pid nftype dxyr cr5id if nftype==13
replace checkflag126=126 if nftype==13


*****************
** Source Name **
*****************
** NOTE 1: Patient notes only to be seen at 5 year intervals so e.g. notes seen on 2013 data then 2018 and so on;
** NOTE 2: In upcoming years of data collection (2018 dc year), more checks may be compiled based on data.

** Check 127 - Source Name missing (NB: some may have been since corrected in main CR5 by cancer team as this was first run on 24apr18 using 05mar2018 data)
count if sourcename==. //45 24apr18; 0 12jul18
list pid nftype sourcename dxyr cr5id if sourcename==.
replace checkflag127=127 if sourcename==.

** Check 128 & 129 - invalid (sourcename); Review done visually via lists below and specific checks created (sourcecheckcat). 
** Check 128=Reviewed/Corrected by DA/Reviewer; no errors
** Check 129=Invalid (sourcename) generated via sourcecheckcat
** First, flag errors and assign as checkflag 129 then
** flag rest of cases as checkflag 128(no errors)
** When running this code on 2014 abstractions then need to use lists that are after thes sourcecheckcat (scroll down)

							
** Check 129 - invalid(sourcename)

** sourcecheckcat 1: SourceName invalid length
count if sourcecheckcat==1 //0 24apr18; 0 12jul18
list pid cr5id sname sourcename dxyr stda if sourcecheckcat==1

** sourcecheckcat 2: SourceName!=QEH/BVH; NFType=Hospital; dxyr>2013
count if sourcecheckcat==2 //0 24apr18; 0 12jul18
list pid cr5id nftype sourcename dxyr stda if sourcecheckcat==2

** sourcecheckcat 3: SourceName=IPS-ARS; NFType!=Pathology; dxyr>2013
count if sourcecheckcat==3 //0 24apr18; 0 12jul18
list pid cr5id nftype sourcename dxyr stda if sourcecheckcat==3

** sourcecheckcat 4: SourceName=DeathRegistry; NFType!=Death Certif/PM; dxyr>2013
count if sourcecheckcat==4 //0 24apr18; 0 12jul18
list pid cr5id nftype sourcename dxyr stda if sourcecheckcat==4

** sourcecheckcat 5: SourceName!=QEH; NFType=QEH Death Rec/RT bk; dxyr>2013
count if sourcecheckcat==5 //1 24apr18 - flagged below in checkflag 128; 0 12jul18
list pid cr5id nftype sourcename dxyr stda if sourcecheckcat==5

** sourcecheckcat 6: SourceName!=BVH; NFType=BVH bk; dxyr>2013
count if sourcecheckcat==6 //0 24apr18; 0 12jul18
list pid cr5id nftype sourcename dxyr stda if sourcecheckcat==6

** sourcecheckcat 7: SourceName!=Polyclinic; NFType=Poly/Dist.Hosp; dxyr>2013
count if sourcecheckcat==7 //0 24apr18; 0 12jul18
list pid cr5id nftype sourcename dxyr stda if sourcecheckcat==7

** sourcecheckcat 8: SourceName=Other(possibly invalid)
count if sourcecheckcat==8 //86 25apr18; 0 12jul18
list pid cr5id nftype sourcename dxyr stda if sourcecheckcat==8


** Check 129 - invalid (sourcename)
** Add reviewer comments to those that need to be corrected
/* 12jul18 - this list only generating checks for dxyr<2014 so blocked out below
replace checkflag129=129 if sourcecheckcat==8
replace reviewertxt8="JC 25apr2018: possibly invalid as SourceName=Other." if sourcecheckcat==8
replace checkflag129=129 if pid=="20140373" & cr5id=="T1S2"
replace reviewertxt8="JC 24apr2018: pid 20140373 - Update T1S2's source name from blank to 1(QEH)." ///
		if pid=="20140373" & cr5id=="T1S2"
*/

** Check 128 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag128=128 if checkflag129!=129


************
** Doctor **
************
** NOTE 1: Patient notes only to be seen at 5 year intervals so e.g. notes seen on 2013 data then 2018 and so on;
** NOTE 2: In upcoming years of data collection (2018 dc year), more checks may be compiled based on data.

** Check 130 - Doctor missing
** Discussed with SAF & KWG on 22may2018 and determined that Doctor to change from blank to 99 if Doctor=''(total of 222 records changed);
** IMPORTANT: WHEN IMPORTING BATCH CORRECTIONS - UNTICK 'Do Checks' IN MAIN CR5! WHEN CHECKS ARE RUN THE RECORD STATUS CHANGES.
** saving excel workbook as .txt and then importing into main CR5
count if doctor=="" //283 24apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 6 12jul18
list pid consultant doctor dxyr cr5id if doctor==""
replace checkflag130=130 if doctor==""

** Check 131 & 132 - invalid (doctor); Review done visually via lists below and specific checks created (doccheckcat). 
** Check 131=Reviewed/Corrected by DA/Reviewer; no errors
** Check 132=Invalid (doctor) generated via doccheckcat
** First, flag errors and assign as checkflag 132 then
** flag rest of cases as checkflag 131(no errors)
** When running this code on 2014 abstractions then need to use lists that are after thes doccheckcat (scroll down)

							
** Check 132 - invalid(doctor)

** doccheckcat 1: Doctor invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
** IMPORTANT: WHEN IMPORTING BATCH CORRECTIONS - UNTICK 'Do Checks' IN MAIN CR5! WHEN CHECKS ARE RUN THE RECORD STATUS CHANGES.
** Changed in MAIN CR5 all of the 20 cases from doctor="Not Stated" to doctor=99 by exporting source table only as .txt, importing into excel,
** updating doctor to 99, updating comments to "JC 24APR18: Changed Doctor from 'Not Stated' to '99' in accordance with doccheckcat 1,
** saving excel workbook as .txt and then importing into main CR5
** Filter used to export data in main CR5 (231 cases as only source data exported so irrelevant data excluded): Doctor = 'Not Stated'
count if doccheckcat==1 //0 24apr18; 0 12jul18
list pid cr5id doctor dxyr stda if doccheckcat==1


** Check 132 - invalid (doctor)
** Add reviewer comments to those that need to be corrected
/* Not needed as no errors flagged in checkflag 131 as of 24apr18.
replace checkflag132=132 if pid=="..." & cr5id=="..."
replace reviewertxt9="JC 24apr2018: pid 20140373 - Update T1S2's source name from blank to 1(QEH)." ///
		if pid=="..." & cr5id=="..."
*/

** Check 131 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag131=131 if checkflag132!=132


**********************
** Doctor's Address **
**********************
** NOTE 1: Patient notes only to be seen at 5 year intervals so e.g. notes seen on 2013 data then 2018 and so on;
** NOTE 2: In upcoming years of data collection (2018 dc year), more checks may be compiled based on data.

** Check 133 - Doctor's Address missing
** Discussed with SAF & KWG on 22may2018 and determined that DoctorAddress to change from blank to 99 if DoctorAddress=''(total of 144 records changed);
** IMPORTANT: WHEN IMPORTING BATCH CORRECTIONS - UNTICK 'Do Checks' IN MAIN CR5! WHEN CHECKS ARE RUN THE RECORD STATUS CHANGES.
** saving excel workbook as .txt and then importing into main CR5
count if docaddr=="" //113 24apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 6 12jul18
list pid consultant doctor docaddr dxyr cr5id if docaddr==""
replace checkflag133=133 if docaddr==""

** Check 134 & 135 - invalid (docaddr); Review done visually via lists below and specific checks created (docaddrcheckcat). 
** Check 134=Reviewed/Corrected by DA/Reviewer; no errors
** Check 135=Invalid (docaddr) generated via docaddrcheckcat
** First, flag errors and assign as checkflag 135 then
** flag rest of cases as checkflag 134(no errors)
** When running this code on 2014 abstractions then need to use lists that are after thes docaddrcheckcat (scroll down)

							
** Check 135 - invalid(docaddr)

** docaddrcheckcat 1: Doc Address invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
** IMPORTANT: WHEN IMPORTING BATCH CORRECTIONS - UNTICK 'Do Checks' IN MAIN CR5! WHEN CHECKS ARE RUN THE RECORD STATUS CHANGES.
** Changed in MAIN CR5 all of the 20 cases from docaddr="Not Stated"/"NONE" to docaddr=99 by exporting source table only as .txt, importing into excel,
** updating docaddr to 99, updating comments to "JC 24APR18: Changed DoctorAddress from 'Not Stated/NONE' to '99' in accordance with docaddrcheckcat 1,
** saving excel workbook as .txt and then importing into main CR5
** Filter used to export data in main CR5 (69 cases as only source data exported so irrelevant data excluded): DoctorAddress = 'Not Stated'
count if docaddrcheckcat==1 //69 24apr18; 0 12jul18
list pid cr5id doctor docaddr dxyr stda if docaddrcheckcat==1


** Check 135 - invalid (docaddr)
** Add reviewer comments to those that need to be corrected
/* Not needed as no errors flagged in checkflag 134 as of 24apr18.
replace checkflag135=135 if pid=="..." & cr5id=="..."
replace reviewertxt9="JC 24apr2018: pid 20140373 - Update T1S2's source name from blank to 1(QEH)." ///
		if pid=="..." & cr5id=="..."
*/

** Check 134 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag134=134 if checkflag135!=135


*******************
** Record Number **
*******************
** NOTE 1: Patient notes only to be seen at 5 year intervals so e.g. notes seen on 2013 data then 2018 and so on;
** NOTE 2: In upcoming years of data collection (2018 dc year), more checks may be compiled based on data.
** NOTE 3: Met with SAF and KWG on 22may18 and decision made to remove checks for this variable; also removed checkflags from excel export code below.
/*
** Check 136 - Record # missing / Record # missing & nftype=Imaging/PrivPhys/RT
count if recnum=="" //1009 24apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis)
list pid recnum doctor dxyr cr5id if recnum==""
count if recnum=="" & (nftype==6|nftype==7|nftype==10) //1 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis)
replace checkflag136=136 if recnum=="" & (nftype==6|nftype==7|nftype==10)

** Check 137 - Record # invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
count if recnum=="Not Stated"|recnum=="9" //3 24apr18
list pid recnum doctor dxyr cr5id if recnum=="Not Stated"|recnum=="9"
replace checkflag137=137 if recnum=="Not Stated"|recnum=="9"
*/

******************
** CF Diagnosis **
******************
** NOTE 1: Patient notes only to be seen at 5 year intervals so e.g. notes seen on 2013 data then 2018 and so on;
** NOTE 2: In upcoming years of data collection (2018 dc year), more checks may be compiled based on data.

** Check 138 - CF Dx missing / CF Dx missing if nftype!=death~/cyto
** 20130361 JC 24MAY18 T2S1: Changed in main CR5 added 'BREAST, RIGHT, CORE BIOPSY : INVASIVE DUCTAL CARCINOMA'.
** Discussed with SAF & KWG on 22may2018 and determined that CFDx to change from blank to 99 if CFDiagnosis=''(total of 314 records changed);
** IMPORTANT: WHEN IMPORTING BATCH CORRECTIONS - UNTICK 'Do Checks' IN MAIN CR5! WHEN CHECKS ARE RUN THE RECORD STATUS CHANGES.
** saving excel workbook as .txt and then importing into main CR5
count if cfdx=="" //393 24apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 0 12jul18
list pid cfdx doctor dxyr cr5id if cfdx==""
count if cfdx=="" & (nftype!=8 & nftype!=9) //62 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 0 12jul18
count if cfdx=="" & (nftype!=4 & nftype!=8 & nftype!=9) //9 22may18 (NB: discussed with SAF & KWG and added in cfdx is a true missing if NFType!=cyto); 0 12jul18
list pid nftype cfdx doctor dxyr cr5id if cfdx=="" & (nftype!=4 & nftype!=8 & nftype!=9)
replace checkflag138=138 if cfdx=="" & (nftype!=4 & nftype!=8 & nftype!=9)

** Check 139 - CF Dx invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
count if cfdx=="Not Stated"|cfdx=="9" //1 25apr18; 0 12jul18
list pid cfdx dxyr cr5id if cfdx=="Not Stated"|cfdx=="9"
replace checkflag139=139 if cfdx=="Not Stated"|cfdx=="9"

** No more checks as difficult to perform standardized checks on this field as sometimes it has topographic info and sometimes has morphologic info so
** no consistency to perform a set of checks
** See visual lists in 'Specimen' category below

****************
** Lab Number **
****************

** Check 140 - Lab # missing / Lab # missing if nftype=Lab~
count if labnum=="" //676 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 58 12jul18
list pid nftype labnum dxyr cr5id if labnum==""
count if labnum=="" & (nftype>2 & nftype<6) //0 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 0 12jul18
list pid nftype labnum dxyr cr5id if labnum=="" & (nftype>2 & nftype<6)
replace checkflag140=140 if labnum=="" & (nftype>2 & nftype<6)

** Check 141 - Lab # invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
count if labnum=="Not Stated"|labnum=="9" //5 25apr18; 0 12jul18
list pid labnum dxyr cr5id if labnum=="Not Stated"|labnum=="9"
replace checkflag141=141 if labnum=="Not Stated"|labnum=="9"

** No more checks as difficult to perform standardized checks on this field as sometimes it has topographic info and sometimes has morphologic info so
** no consistency to perform a set of checks
** See visual lists in 'Specimen' category below


**************
** Specimen **
**************

** Check 142 - Specimen missing / Specimen missing if nftype=Lab~
count if specimen=="" //637 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 58 12jul18
list pid nftype specimen dxyr cr5id if specimen==""
count if specimen=="" & (nftype>2 & nftype<6) //3 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 2 12jul18
list pid nftype specimen dxyr cr5id if specimen=="" & (nftype>2 & nftype<6)
replace checkflag142=142 if specimen=="" & (nftype>2 & nftype<6)

** Check 143 - Specimen invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
count if specimen=="Not Stated"|specimen=="9" //4 25apr18; 0 12jul18
list pid specimen dxyr cr5id if specimen=="Not Stated"|specimen=="9"
replace checkflag143=143 if specimen=="Not Stated"|specimen=="9"

** No more checks as difficult to perform standardized checks on this field as sometimes it has topographic info and sometimes has morphologic info so
** no consistency to perform a set of checks so need to review via visual lists as noted below
** Below lists used to visually check cfdx, specimen vs top, morph and to compile/categorize specific checks (see morphcheckcat in '1_prep_cancer.do')
** NOTE 1: THIS LIST WAS FIRST RUN ON MOSTLY 2008 & 2013 ABS SO WILL NEED TO COMPILE CHECKS WHEN LISTS RUN ON 2014 ABS (JC 25apr18)
** NOTE 2: When looking at abstraction in Stata Results window and CR5 look for inconsistencies between 
** top, morph, lat, beh, grade, basis, (staging) VS cfdx, specimen, clin dets, md, consrpt
** NOTE 3: JC 25apr18 - I ADDED BELOW LISTS TO MORPH CHECKS IN TUMOUR TABLE TO BE RUN ON 2014 ABS DATA; too difficult to properly run lists otherwise
/*
sort morph pid
** CFDX/SPECIMEN/TOPOG/MORPH CATS 1-5
count if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99") & (morphcat!=. & morphcat<6) //cats1-5:0 25apr18
list pid specimen top morph cr5id if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99") & (morphcat!=. & morphcat<6)
list cfdx if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99") & (morphcat!=. & morphcat<6), notrim

** CFDX/SPECIMEN/TOPOG/MORPH CATS 6-9
count if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99") & (morphcat!=. & morphcat>5 & morphcat<10) //cats 6-9: 0 25apr18
list pid specimen top morph cr5id if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99") & (morphcat!=. & morphcat>5 & morphcat<10)
list cfdx if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99") & (morphcat!=. & morphcat>5 & morphcat<10), notrim

** CFDX/SPECIMEN/TOPOG/MORPH CATS 10-55
count if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99") & (morphcat!=. & morphcat>9) //cats 10-55: 3 25apr18
list pid specimen top morph cr5id if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99") & (morphcat!=. & morphcat>9)
list cfdx if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99") & (morphcat!=. & morphcat>9), notrim

** CFDX/SPECIMEN/TOPOG/MORPH CATS 10-55
** When running list after cleaning 2008 & 2013 data, filter by dxyr (i.e. dxyr>2013)
count if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99") //cats 10-55: 1055 25apr18
list pid top morph dxyr cr5id if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99")
list specimen if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99")
list cfdx if (cfdx!="" & cfdx!="99") & (specimen!="" & specimen!="99")


** Check 141 & 142 - invalid (specimen); Review done visually via lists below and specific checks created (speccheckcat). 
** Check 141=Reviewed/Corrected by DA/Reviewer; no errors
** Check 142=Invalid (specimen) generated via speccheckcat
** First, flag errors and assign as checkflag 142 then
** flag rest of cases as checkflag 141(no errors)
** When running this code on 2014 abstractions then need to use lists that are after thes speccheckcat (scroll down)
						
** Check 142 - invalid(specimen)

** speccheckcat 1: Specimen invalid entry
count if speccheckcat==1 //1 24apr18
list pid cr5id cfdx specimen dxyr ttda if speccheckcat==1

** speccheckcat 2: specimen!=lip & topcat=lip
count if speccheckcat==2 //0 24apr18
list pid cr5id cfdx specimen topcat dxyr ttda if speccheckcat==2

** speccheckcat 3: specimen!=tongue & topcat=tongue
count if speccheckcat==3 //0 24apr18
list pid cr5id cfdx specimen topcat dxyr ttda if speccheckcat==3

** speccheckcat 4: specimen=tonsil & topog!=tonsil
count if speccheckcat==4 //0 24apr18
list pid cr5id cfdx specimen topcat dxyr ttda if speccheckcat==4

** speccheckcat 5: specimen!=gum & topcat=gum
count if speccheckcat==5 //0 24apr18
list pid cr5id cfdx specimen topography dxyr ttda if speccheckcat==5

** speccheckcat 6: specimen!=mouth & topcat=mouth
count if speccheckcat==6 //0 24apr18
list pid cr5id cfdx specimen topography dxyr ttda if speccheckcat==6

** speccheckcat 7: specimen!=palate & topcat=palate
count if speccheckcat==7 //0 24apr18
list pid cr5id cfdx specimen topography dxyr ttda if speccheckcat==7

** speccheckcat 8: specimen!=palate & topcat=palate
count if speccheckcat==8 //0 24apr18
list pid cr5id cfdx specimen topography dxyr ttda if speccheckcat==8



** Check 142 - invalid (specimen)
** Add reviewer comments to those that need to be corrected
/* Not needed as no errors flagged in checkflag 134 as of 24apr18.
replace checkflag142=142 if pid=="..." & cr5id=="..."
replace reviewertxt9="JC 24apr2018: pid 20140373 - Update T1S2's source name from blank to 1(QEH)." ///
		if pid=="..." & cr5id=="..."
*/

** Check 141 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag141=141 if checkflag142!=142
*/


*******************************************
** Sample Taken, Received & Report Dates **
*******************************************
** Check 144 - Sample Date invalid(future date)
count if sampledate!=. & sampledate>currentdatest //0 25apr18; 0 12jul18
list pid cr5id sampledate dxyr stda if sampledate!=. & sampledate>currentdatest
replace checkflag144=144 if sampledate!=. & sampledate>currentdatest

** Check 145 - Received Date invalid (future date)
count if recvdate!=. & recvdate>currentdatest //1 25apr18; 0 12jul18
list pid cr5id recvdate dxyr stda if recvdate!=. & recvdate>currentdatest
replace checkflag145=145 if recvdate!=. & recvdate>currentdatest

** Check 146 - Report Date invalid (future date)
count if rptdate!=. & rptdate>currentdatest //0 25apr18; 0 12jul18
list pid cr5id rptdate dxyr stda if rptdate!=. & rptdate>currentdatest
replace checkflag146=146 if rptdate!=. & rptdate>currentdatest


** Check 147 & 148 - invalid (sampledate,recvdate,rptdate); Review done visually via lists below and specific checks created (rptcheckcat). 
** Check 147=Reviewed/Corrected by DA/Reviewer; no errors
** Check 148=Invalid (sampledate,recvdate,rptdate) generated via rptcheckcat
** First, flag errors and assign as checkflag 148 then
** flag rest of cases as checkflag 147(no errors)
** When running this code on 2014 abstractions then need to use lists that are after thes rptcheckcat (scroll down)
						
** Check 148 - invalid(sampledate,recvdate,rptdate)

** rptcheckcat 1: Sample Date missing
count if rptcheckcat==1 //25 25apr18; now 0 25apr18 (replaced by below rptcheckcats); 0 12jul18
list pid cr5id nftype sampledate recvdate rptdate dxyr stda if rptcheckcat==1

** rptcheckcat 2: Received Date missing
count if rptcheckcat==2 //0 25apr18 (should be 332 but replaced by below rptcheckcats); 0 12jul18
list pid cr5id nftype sampledate recvdate rptdate dxyr stda if rptcheckcat==2

** rptcheckcat 3: Report Date missing
count if rptcheckcat==3 //58 25apr18 (should be 60 but replaced by below rptcheckcats); 3 12jul18
list pid cr5id nftype sampledate recvdate rptdate dxyr stda if rptcheckcat==3

** rptcheckcat 4: sampledate after recvdate
count if rptcheckcat==4 //5 25apr18; 0 12jul18
list pid cr5id sampledate recvdate rptdate dxyr stda if rptcheckcat==4

** rptcheckcat 5: sampledate after rptdate
count if rptcheckcat==5 //13 25apr18; 2 12jul18
list pid cr5id sampledate recvdate rptdate dxyr stda if rptcheckcat==5

** rptcheckcat 6: recvdate after rptdate
count if rptcheckcat==6 //325 25apr18; 0 12jul18
list pid cr5id sampledate recvdate rptdate dxyr stda if rptcheckcat==6

** rptcheckcat 7: sampledate before InciD
count if rptcheckcat==7 //0 25apr18; 0 12jul18
list pid cr5id dot sampledate recvdate rptdate dxyr stda if rptcheckcat==7

** rptcheckcat 8: recvdate before InciD
count if rptcheckcat==8 //0 25apr18; 0 12jul18
list pid cr5id dot sampledate recvdate rptdate dxyr stda if rptcheckcat==8

** rptcheckcat 9: rptdate before InciD
count if rptcheckcat==9 //0 25apr18; 0 12jul18
list pid cr5id dot sampledate recvdate rptdate dxyr stda if rptcheckcat==9

** rptcheckcat 10: sampledate after DLC
count if rptcheckcat==10 //8 25apr18; 6 12jul18
list pid cr5id dlc sampledate recvdate rptdate dxyr stda if rptcheckcat==10

** rptcheckcat 11: sampledate!=. & nftype!=lab~
count if rptcheckcat==11 //0 25apr18; 0 12jul18
list pid cr5id nftype sampledate dxyr stda if rptcheckcat==11

** rptcheckcat 12: recvdate!=. & nftype!=lab~
count if rptcheckcat==12 //0 25apr18; 0 12jul18
list pid cr5id nftype recvdate dxyr stda if rptcheckcat==12

** rptcheckcat 13: rptdate!=. & nftype!=lab~
count if rptcheckcat==13 //0 25apr18; 0 12jul18
list pid cr5id nftype rptdate dxyr stda if rptcheckcat==13


** Check 148 - invalid (sampledate,recvdate,rptdate)
** Add reviewer comments to those that need to be corrected
replace checkflag148=148 if rptcheckcat==3 | rptcheckcat==5 | rptcheckcat==10
**replace checkflag148=148 if (rptcheckcat>2 & rptcheckcat<7) | rptcheckcat==10
replace reviewertxt9="JC 25apr2018: Sample Taken, Received and/or Report Date(s) missing but NF type=Lab~." if rptcheckcat==3
**replace reviewertxt9="JC 25apr2018: Sample Taken Date is AFTER Received Date." if rptcheckcat==4
replace reviewertxt9="JC 25apr2018: Sample Taken Date is AFTER Report Date." if rptcheckcat==5
**replace reviewertxt9="JC 25apr2018: Received Date is AFTER Report Date." if rptcheckcat==6
replace reviewertxt9="JC 25apr2018: Sample Taken Date is AFTER DLC." if rptcheckcat==10
/* Not needed as no errors flagged in checkflag 148 as of 24apr18.
replace checkflag148=148 if pid=="..." & cr5id=="..."
replace reviewertxt9="JC 24apr2018: pid 20140373 - Update T1S2's source name from blank to 1(QEH)." ///
		if pid=="..." & cr5id=="..."
*/

** Check 147 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag147=147 if checkflag148!=148


**********************
** Clinical Details **
**********************
** Check 149 - Clinical Details missing / Clinical Details missing if nftype=Lab~
count if clindets=="" //679 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 60 12jul18
list pid nftype clindets dxyr cr5id if clindets==""
count if clindets=="" & (nftype>2 & nftype<6) //2 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 2 12jul18
list pid nftype clindets dxyr cr5id if clindets=="" & (nftype>2 & nftype<6)
replace checkflag149=149 if clindets=="" & (nftype>2 & nftype<6)

** Check 150 - Clinical Details invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
count if clindets=="Not Stated"|clindets=="NIL"|regexm(clindets, "NONE")|clindets=="9" //5 25apr18; 0 12jul18
list pid clindets dxyr cr5id if clindets=="Not Stated"|clindets=="NIL"|regexm(clindets, "NONE")|clindets=="9"
replace checkflag150=150 if clindets=="Not Stated"|clindets=="NIL"|regexm(clindets, "NONE")|clindets=="9"


**************************
** Cytological Findings **
**************************
** Check 151 - Cytological Findings missing / Cytological Findings missing if nftype=Lab-Cyto
count if cytofinds=="" //1298 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 66 12jul18
list pid nftype cytofinds dxyr cr5id if cytofinds==""
count if cytofinds=="" & (nftype>2 & nftype<6) //621 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 8 12jul18
list pid nftype cytofinds dxyr cr5id if cytofinds=="" & (nftype>2 & nftype<6)
count if cytofinds=="" & nftype==4 //0 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 0 12jul18
list pid nftype cytofinds dxyr cr5id if cytofinds=="" & nftype==4
replace checkflag151=151 if cytofinds=="" & nftype==4

** Check 152 - Cytological Findings invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
count if cytofinds=="Not Stated"|cytofinds=="9" //0 25apr18; 0 12jul18
list pid cytofinds dxyr cr5id if cytofinds=="Not Stated"|cytofinds=="9"
replace checkflag152=152 if cytofinds=="Not Stated"|cytofinds=="9"


*****************************
** Microscopic Description **
*****************************
** Check 153 - MD missing / MD missing if nftype=Lab~
count if md=="" //733 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 64 12jul18
list pid nftype md dxyr cr5id if md==""
count if md=="" & (nftype>2 & nftype<6) //55 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 6 12jul18
list pid nftype md dxyr cr5id if md=="" & (nftype>2 & nftype<6)
count if md=="" & (nftype==3|nftype==5) //2 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 2 12jul18
list pid nftype md dxyr cr5id if md=="" & (nftype==3|nftype==5)
replace checkflag153=153 if md=="" & (nftype==3|nftype==5)

** Check 154 - MD invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
count if md=="Not Stated."|md=="Not Stated"|md=="9" //1 25apr18; 0 12jul18
list pid md dxyr cr5id if md=="Not Stated."|md=="Not Stated"|md=="9"
replace checkflag154=154 if md=="Not Stated."|md=="Not Stated"|md=="9"


*************************
** Consultation Report **
*************************
** NOTE 1: Met with SAF and KWG on 22may18 and decision made to remove checks for this variable; also removed checkflags from excel export code below.
/*
** Check 155 - Consult.Rpt missing / Consult.Rpt missing if nftype=Lab~
count if consrpt=="" //1195 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis)
list pid nftype consrpt dxyr cr5id if consrpt==""
count if consrpt=="" & (nftype>2 & nftype<6) //518 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis)
list pid nftype consrpt dxyr cr5id if consrpt=="" & (nftype>2 & nftype<6)
count if consrpt=="" & (nftype==3|nftype==5) //464 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis)
list pid nftype consrpt dxyr cr5id if consrpt=="" & (nftype==3|nftype==5)
replace checkflag155=155 if consrpt=="" & (nftype==3|nftype==5)

** Check 156 - Consult.Rpt invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
count if consrpt=="Not Stated"|consrpt=="Not Stated."|consrpt=="9" //2 25apr18
list pid consrpt dxyr cr5id if consrpt=="Not Stated"|consrpt=="Not Stated."|consrpt=="9"
replace checkflag156=156 if consrpt=="Not Stated"|consrpt=="Not Stated."|consrpt=="9"
*/

***********************
** Cause(s) of Death **
***********************
** Check 157 - COD missing / COD missing if nftype=Death~
count if cr5cod=="" //1004 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 12 12jul18
list pid nftype cr5cod dxyr cr5id if cr5cod==""
count if cr5cod=="" & (nftype==8|nftype==9) //1 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 0 12jul18
list pid nftype cr5cod dxyr cr5id if cr5cod=="" & (nftype==8|nftype==9)
replace checkflag157=157 if cr5cod=="" & (nftype==8|nftype==9)

** Check 158 - COD invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
count if regexm(cr5cod, "Not")|regexm(cr5cod, "not")|cr5cod=="NIL."|cr5cod=="Not Stated"|cr5cod=="9" //20 25apr18; 3 12jul18
list pid cr5cod dxyr cr5id if regexm(cr5cod, "Not")|regexm(cr5cod, "not")|cr5cod=="NIL."|cr5cod=="Not Stated"|cr5cod=="9"
replace checkflag158=158 if regexm(cr5cod, "Not")|regexm(cr5cod, "not")|cr5cod=="NIL."|cr5cod=="Not Stated"|cr5cod=="9"

** Check 159 - COD invalid entry(lowercase)
count if cr5cod!="99" & cr5cod!="" & regexm(cr5cod, "[a-z]") //15 25apr18; 0 12jul18
list pid cr5cod dxyr cr5id if cr5cod!="99" & cr5cod!="" & regexm(cr5cod, "[a-z]")
replace checkflag159=159 if cr5cod!="99" & cr5cod!="" & regexm(cr5cod, "[a-z]")


/* Not needed but may use in the future
count if cr5cod!="99" & cr5cod!="" & regexm(cr5cod, "^[^a-z]+$") //1009 - this removes any that are not in uppercase
** Below is a list of all non-cancer CODs
count if cr5cod!="99" & cr5cod!="" & cr5cod!="NIL." & cr5cod!="Not Stated." & !strmatch(strupper(cr5cod), "*CANCER*") & !strmatch(strupper(cr5cod), "*OMA*") ///
		 & !strmatch(strupper(cr5cod), "*MALIG*") & !strmatch(strupper(cr5cod), "*TUM*") & !strmatch(strupper(cr5cod), "*LYMPH*") ///
		 & !strmatch(strupper(cr5cod), "*LEU*") & !strmatch(strupper(cr5cod), "*MYELO*") & !strmatch(strupper(cr5cod), "*METASTA*")
** 41
list pid cr5cod if cr5cod!="99" & cr5cod!="" & cr5cod!="NIL." & cr5cod!="Not Stated." & !strmatch(strupper(cr5cod), "*CANCER*") & !strmatch(strupper(cr5cod), "*OMA*") ///
		 & !strmatch(strupper(cr5cod), "*MALIG*") & !strmatch(strupper(cr5cod), "*TUM*") & !strmatch(strupper(cr5cod), "*LYMPH*") ///
		 & !strmatch(strupper(cr5cod), "*LEU*") & !strmatch(strupper(cr5cod), "*MYELO*") & !strmatch(strupper(cr5cod), "*METASTA*")
*/

 
*************************
** Duration of Illness **
*************************
** Check 160 - Duration of Illness missing / Duration of Illness missing if nftype=Death~
count if duration=="" //1349 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 68 12jul18
list pid nftype duration dxyr cr5id if duration==""
count if duration=="" & (nftype==8|nftype==9) //340 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 56 12jul18
list pid nftype duration dxyr cr5id if duration=="" & (nftype==8|nftype==9)
replace checkflag160=160 if duration=="" & (nftype==8|nftype==9)

** Check 161 - Duration of Illness invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
count if regexm(duration, "UNKNOWN")|regexm(duration, "Not")|regexm(duration, "not")|duration=="NIL."|duration=="Not Stated"|duration=="9" //0 25apr18; 0 12jul18
list pid duration dxyr cr5id if regexm(duration, "UNKNOWN")|regexm(duration, "Not")|regexm(duration, "not")|duration=="NIL."|duration=="Not Stated"|duration=="9"
replace checkflag161=161 if regexm(duration, "UNKNOWN")|regexm(duration, "Not")|regexm(duration, "not")|duration=="NIL."|duration=="Not Stated"|duration=="9"

** Check 162 - Duration of Illness invalid entry(lowercase)
count if duration!="99" & duration!="" & regexm(duration, "[a-z]") //3 25apr18; 0 12jul18
list pid duration dxyr cr5id if duration!="99" & duration!="" & regexm(duration, "[a-z]")
replace checkflag162=162 if duration!="99" & duration!="" & regexm(duration, "[a-z]")


*****************************
** Onset to Death Interval **
*****************************
** Check 163 - Onset to Death Interval missing / Onset to Death Interval missing if nftype=Death~
count if onsetint=="" //1349 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 68 12jul18
list pid nftype onsetint dxyr cr5id if onsetint==""
count if onsetint=="" & (nftype==8|nftype==9) //340 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis); 56 12jul18
list pid nftype onsetint dxyr cr5id if onsetint=="" & (nftype==8|nftype==9)
replace checkflag163=163 if onsetint=="" & (nftype==8|nftype==9)

** Check 164 - Onset to Death Interval invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
count if regexm(onsetint, "UNKNOWN")|regexm(onsetint, "Not")|regexm(onsetint, "not")|onsetint=="NIL."|onsetint=="Not Stated"|onsetint=="9" //0 25apr18; 0 12jul18
list pid onsetint dxyr cr5id if regexm(onsetint, "UNKNOWN")|regexm(onsetint, "Not")|regexm(onsetint, "not")|onsetint=="NIL."|onsetint=="Not Stated"|onsetint=="9"
replace checkflag164=164 if regexm(onsetint, "UNKNOWN")|regexm(onsetint, "Not")|regexm(onsetint, "not")|onsetint=="NIL."|onsetint=="Not Stated"|onsetint=="9"

** Check 165 - Onset to Death Interval invalid entry(lowercase)
count if onsetint!="99" & onsetint!="" & regexm(onsetint, "[a-z]") //1 25apr18; 0 12jul18
list pid onsetint dxyr cr5id if onsetint!="99" & onsetint!="" & regexm(onsetint, "[a-z]")
replace checkflag165=165 if onsetint!="99" & onsetint!="" & regexm(onsetint, "[a-z]")


***************
** Certifier **
***************
** NOTE 1: Met with SAF and KWG on 22may18 and decision made to remove checks for this variable; also removed checkflags from excel export code below.
/*
** Check 166 - Certifier missing / Certifier missing if nftype=Death~
count if certifier=="" //1139 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis)
list pid nftype certifier dxyr cr5id if certifier==""
count if certifier=="" & (nftype==8|nftype==9) //130 25apr18 (NB: need to discuss with BNR-C team as a batch correction cannot be done due to unique values for a case-by-case basis)
list pid nftype certifier dxyr cr5id if certifier=="" & (nftype==8|nftype==9)
replace checkflag166=166 if certifier=="" & (nftype==8|nftype==9)

** Check 167 - Certifier invalid ND code
** (Checked data in main CR5 to determine invalid ND values by filtering in CR5 Browse/Edit by Source table, sorted by field, looking at all variables and scrolling through entire field column.)
count if regexm(certifier, "UNKNOWN")|regexm(certifier, "Not")|regexm(certifier, "not")|certifier=="NIL."|certifier=="Not Stated"|certifier=="9" //0 25apr18
list pid certifier dxyr cr5id if regexm(certifier, "UNKNOWN")|regexm(certifier, "Not")|regexm(certifier, "not")|certifier=="NIL."|certifier=="Not Stated"|certifier=="9"
replace checkflag167=167 if regexm(certifier, "UNKNOWN")|regexm(certifier, "Not")|regexm(certifier, "not")|certifier=="NIL."|certifier=="Not Stated"|certifier=="9"

** Check 168 - Certifier invalid entry(lowercase)
count if certifier!="99" & certifier!="" & regexm(certifier, "[a-z]") //1 25apr18
list pid certifier dxyr cr5id if certifier!="99" & certifier!="" & regexm(certifier, "[a-z]")
replace checkflag168=168 if certifier!="99" & certifier!="" & regexm(certifier, "[a-z]")
*/


***********************************
** Admission, DFC & RT Reg Dates **
***********************************
** Check 169 - Admission Date invalid(future date)
count if admdate!=. & admdate>currentdatest //0 25apr18; 0 12jul18
list pid cr5id admdate dxyr stda if admdate!=. & admdate>currentdatest
replace checkflag169=169 if admdate!=. & admdate>currentdatest

** Check 170 - DFC Date invalid (future date)
count if dfc!=. & dfc>currentdatest //1 25apr18; 0 12jul18
list pid cr5id dfc dxyr stda if dfc!=. & dfc>currentdatest
replace checkflag170=170 if dfc!=. & dfc>currentdatest

** Check 171 - RT Date invalid (future date)
count if rtdate!=. & rtdate>currentdatest //0 25apr18; 0 12jul18
list pid cr5id rtdate dxyr stda if rtdate!=. & rtdate>currentdatest
replace checkflag171=171 if rtdate!=. & rtdate>currentdatest

********************************************** NEED TO DISCUSS WITH SAF & KWG RE HOW TO HANDLE BELOW MISSING DATES **************************************************
/*
. count if admdate==.
  1,078

. count if dfc==.
  1,362

. count if rtdate==.
  1,072

. count if admdate==. & dfc==. & rtdate==.
  793

. count if sampledate==. & recvdate==. & rptdate==. & admdate==. & dfc==. & rtdate==.
  124
*/

** Check 172 & 173 - invalid (admdate,dfc,rtdate); Review done visually via lists below and specific checks created (datescheckcat). 
** Check 172=Reviewed/Corrected by DA/Reviewer; no errors
** Check 173=Invalid (admdate,dfc,rtdate) generated via datescheckcat
** First, flag errors and assign as checkflag 173 then
** flag rest of cases as checkflag 172(no errors)
** When running this code on 2014 abstractions then need to use lists that are after thes datescheckcat (scroll down)
						
** Check 173 - invalid(admdate,dfc,rtdate)

** datescheckcat 1: Admission Date missing
count if datescheckcat==1 //931 26apr18; 20 12jul18
list pid cr5id sourcename nftype admdate dfc rtdate dxyr stda if datescheckcat==1

** datescheckcat 2: DFC missing
count if datescheckcat==2 //6 26apr18; 3 12jul18
list pid cr5id sourcename nftype admdate dfc rtdate dxyr stda if datescheckcat==2

** datescheckcat 3: RT Date missing
count if datescheckcat==3 //1 26apr18; 0 12jul18
list pid cr5id sourcename nftype admdate dfc rtdate dxyr stda if datescheckcat==3

** datescheckcat 4: admdate/dfc/rtdate BEFORE InciD
count if datescheckcat==4 //0 26mar18; 0 12jul18
list pid cr5id dot admdate dfc rtdate dxyr stda if datescheckcat==4

** datescheckcat 5: admdate/dfc/rtdate after DLC
count if datescheckcat==5 //0 26mar18; 0 12jul18
list pid cr5id dlc admdate dfc rtdate dxyr stda if datescheckcat==5

** datescheckcat 6: admdate!=. & sourcename!=hosp
count if datescheckcat==6 //65 26mar18; 64 12jul18
list pid cr5id sourcename nftype admdate dfc rtdate dxyr stda if datescheckcat==6

** datescheckcat 7: dfc!=. & sourcename!=PrivPhys/IPS
count if datescheckcat==7 //347 26apr18; 349 12jul18
list pid cr5id sourcename nftype admdate dfc rtdate dxyr stda if datescheckcat==7

** datescheckcat 8: rtdate!=. & nftype!=RT
count if datescheckcat==8 //0 26apr18; 0 12jul18
list pid cr5id sourcename nftype admdate dfc rtdate dxyr stda if datescheckcat==8


** Check 173 - invalid (admdate,dfc,rtdate)
** Add reviewer comments to those that need to be corrected
**replace checkflag173=173 if datescheckcat!=3 & datescheckcat!=4 & datescheckcat!=5 & datescheckcat!=8
replace reviewertxt10="JC 26apr2018: Adm Date missing but Source=QEH/BVH." if datescheckcat==1
replace reviewertxt10="JC 26apr2018: DFC missing but Source=PrivPhys/IPS." if datescheckcat==2
**replace reviewertxt10="JC 26apr2018: RT Date missing but NFType=RT bk." if datescheckcat==3
replace reviewertxt10="JC 26apr2018: Adm Date NOT blank but Source NOT=QEH/BVH." if datescheckcat==6
replace reviewertxt10="JC 26apr2018: DFC NOT blank but Source NOT=PrivPhys/IPS." if datescheckcat==7
/* Not needed as no errors flagged in checkflag 173 as of 24apr18.
replace checkflag173=173 if pid=="..." & cr5id=="..."
replace reviewertxt9="JC 24apr2018: pid 20140373 - Update T1S2's source name from blank to 1(QEH)." ///
		if pid=="..." & cr5id=="..."
*/

** Check 172 for data that is correct as of raw data export '2018-03-05_Main Exported Source+Tumour+Patient_JC.txt' i.e. before 2014 abstractions
replace checkflag172=172 if checkflag173!=173


*****************
** ST Reviewer **
*****************
** No checks on this field as review process changed from originally planned


save "data\clean\2014_cancer_flagged.dta" ,replace
label data "BNR-Cancer Corrections"
notes _dta :These data prepared for 2014 ABS phase
