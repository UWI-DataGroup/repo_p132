** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			    bros_01_01.do
    //  project:				        BROS stroke surveillance (2000-2004)
    //  analysts:						    Ian HAMBLETON
    // 	date last modified	    23-JAN-2019
    //  algorithm task			  Preparing the BROS stroke dataset

    ** General algorithm set-up
    version 15
    clear all
    macro drop _all
    set more 1
    set linesize 80

    ** Set working directories: this is for DATASET and LOGFILE import and export
    ** DATASETS to encrypted SharePoint folder
    local datapath "X:\The University of the West Indies\DataGroup - repo_data/data_p132"
    ** LOGFILES to unencrypted OneDrive folder
    local logpath "X:\The University of the West Indies\repo_datagroup/repo_p131"

    ** Close any open log fileand open a new log file
    capture log close
    cap log using "`logpath'\bros_01_01", replace
** HEADER -----------------------------------------------------

// -------------------------------------------------------------------------------------
// BRIEF HISTORY of DATASET
// v0.1 by Ian Hambleton
//
// Principal Investigator: Anselm Hennis
// Local Investigators: David Corbin, Henry Fraser, Glenda Gay
//
// Definitive dataset and associated documentation lost when x486 study PC
// suffered corrupt hard drive. This discovery made in 2006 by IRH, two years after
// end of data collection. No known local backup had been made by the study investigators
// at the time of loss.
//
// Hard copy information all still exists.
//
// The current file was recovered by IRH from colleagues at Kings College,
// London (Nigel Smeeton - now retired)
// The recovered file seems messy to me. This series of do-files attempts to:
//      - clean and label dataset variables
//      - check variables for completeness
//      - check variables accuracy where possible (checks against published papers)
//      - all published papers (I believe) were analysed by London team.
//
// This cleaning and tidying process makes use of an Operations Manual from the
// South London Community Stroke Registry (version: updated July 2001)
// The design of BROS was based on this registry and CRFs were similar.
// -------------------------------------------------------------------------------------
// (1) In this first do file I create a minimal clean dataset containing basic event
//     demographics. This dataset will be used when matching to a series of
//     subsequent datasets containing different additional blocks of BROS information
//
// (2) Variables are grouped as follows:
//     SECTION  1. (prefix s1_) Characteristics and Dates
//     SECTION  2. (prefix s2_) Stroke Severity and Health Outcomes
//     SECTION  3. (prefix s3_) Pre-existing conditions
//     SECTION  4. (prefix s4_) Resource Use
//     SECTION  5. (prefix s5_) Spatial and Temporal
//
// (3) OTHER DATA
//     For the next data release we will prepare the following sectons:
//     (A) NOTIFICATION SOURCES
//     (B) PARTICIPANTS MEDICATIONS
//     (C) ADLs / IADLs
// -------------------------------------------------------------------------------------


** LOAD DATASET
use "`datapath'\version02\1-input\bros_final_3_year_w_initials_at_1yr_2yr_aug_24_2006", clear

** We use the baseline CRF to inform variable inclusion choices

** Event ID
rename registra eid
label var eid "Unique event ID"


** --------------------------------------------------------------------------
** SECTION ONE
** CHARACTERISTICS AND DATES
** Date of birth
rename datebirt dob
label var dob "Date of birth"

** Date of stroke
rename datestr dos
label var dos "Date of stroke"

** Date restriction (strokes between 2001 and 2004)
keep if dos<=d(31dec2004)
sort dos

** date of death
rename datedeat dod
label var dod "Date of death"

** Status at 3 months
rename month3 status3m
label var status3m "Status at 3 months"
label define status3m 0 "dead 3m" 1 "alive - visit" 2 "alive - no visit" 3 "lost",modify
label values status3m status3m

** Date of 3-month follow-up
rename todaysda dof3m
label var dof3m "Date of 3-month follow-up"

** Status at 1-year
rename oneyrfu status1y
label var status1y "Status at 1 year"
label define status1y 1 "alive" 2 "dead 3m" 3 "dead 1y" 4 "lost" 6 "unk",modify
label values status1y status1y

** Date of 1-year follow-up
rename y1todays dof1y
label var dof1y "Date of 1-year follow-up"

** Status at 2-years
rename y2data status2y
label var status2y "Status at 2 years"
label define status2y 1 "alive" 2 "dead 3m" 3 "dead 1y" 4 "dead 2y" 5 "lost" 6 "project end",modify
label values status2y status2y

** Date of 2-year follow-up
rename y2todays dof2y
label var dof2y "Date of 2-year follow-up"

** sex
rename gender sex
label var sex "Participant sex (1=m, 2=f)"

** Age at stroke (in years)
drop age
gen age = (dos - dob)/365.25
label var age "Age at stroke in years"

** Age to the nearest year
gen agey = int(age)
label var agey "Age to the nearest year"

** 5-year age groups
gen age5 = recode(agey, 14,19,24,29,34,39,44,49,54,59,64,69,74,79,84,110)
recode age5 14=1 19=2 24=3 29=4 34=5 39=6 44=7 49=8 54=9 59=10 64=11 69=12 74=13 79=14 84=15 110=16
label define age5 1  "<15"    2 "15-19"  3 "20-24"  4 "25-29" ///
                  5  "30-34"  6 "35-39"  7 "40-44"  8 "45-49" ///
                  9  "50-54" 10 "55-59" 11 "60-64" 12 "65-69" ///
                  13 "70-74" 14 "75-79" 15 "80-84" 16 "85+" , modify
label values age5 age5
label var age5 "Age in 5-year groups"


** 10-year age groups
gen age10 = recode(agey, 14,24,34,44,54,64,74,84,110)
recode age10 14=1 24=2 34=3 44=4 54=5 64=6 74=7 84=8 110=9
label define age10  1  "<15"    2 "15-24"  3 "25-34"  4 "35-44"  5 "45-54"  ///
                  6 "55-64" 7 "65-74" 8 "75-84" 9 "85+" , modify
label values age10 age10
label var age10 "Age in 10-year groups"


** Socioeconomic status
** Not yet implemented

** Ethnic group
rename ethnicgr ethnic
label var ethnic "Ethnic group"

** height
tostring height, replace
tostring height1, replace
gen str ht = height + "." + height1
replace ht = "." if ht=="..."
destring ht, replace
replace ht = . if ht>2
label var ht "Height in m"

** weight
rename weight wt
label var wt "Weigt in kg"

** Weight recalled or measured
gen wr = .
replace wr = 1 if measured==2
replace wr = 2 if recall==2
label var wr "Weight measured or recalled"
label define wr 1 "measured" 2 "recall",modify
label values wr wr


** --------------------------------------------------------------------------
** SECTION TWO
** STROKE SEVERITY and HEALTH OUTCOMES

** Stroke subtype
** (TACI, pACI, POCI, LACI, infarction - unspecified, PICH SAH, unclassified)
rename finalstr subtype
label var subtype "Stroke subtype: final diagnosis"

** Glasgow coma scale
drop gcs
rename levelcon gcs
label var gcs "Glasgow Coma Scale"

** Swallow test (dysphagia)
rename swallowi swallow
label var swallow "The swallow test (dysphagia)"

** Incontenence at time of stroke
rename incontin ic
label var ic "Urinary incontinence"

** Barthel score pre- and post- stroke
rename barthels bart_pre
rename barthel1 bart5d
label var bart_pre "Barthel score: pre-stroke"
label var bart5d "Barthel score: 5-10 days post-stroke"

** Barthel score (at 3m, 1yr, 2yr)
rename m3barthe bart3m
label var bart3m "Barthel score: 3 months"
rename y1barth bart1y
label var bart1y "Barthel score: 1 year"
rename y2barthe bart2y
label var bart2y "Barthel score: 2 years"

** Frenchay score (at 3m, 1yr, 2yr)
** not yet implemented

** NIH 15-item stroke score
rename totalsco nih_score
label var nih_score "The NIH 15-item stroke scale"
note nih_score: the 15-item stroke score includes the following
note nih_score: LOC. alert (0), drowsy (1), stuprous (2), comatose (3)
note nih_score: LOC QUESTIONS. month (1), age (2)
note nih_score: LOC COMMANDS. open and close eyes (1), grip and release non-parietic hand (2)
note nih_score: BEST GAZE. normal (0), partial gaze palsy (1), forced deviation (2)
note nih_score: BEST VISUAL. no visual loss (0), partial hemianopia (1), complete hemianopia (2)
note nih_score: FACIAL PALSY. normal (0), minor (1), partial (2), complete (3)
note nih_score: BEST MOTOR - ARM. no drift (0), drift (1), cannot resist gravity (2), no effort against gravity (3)
note nih_score: BEST MOTOR - LEG. no drift (0), drift (1), cannot resist gravity (2), no effort against gravity (3)
note nih_score: PLANTAR REFLEX. normal (0), equivocal (1), extensor (2), bilateral extensor (3)
note nih_score: LIMB ATAXIA. absent (0), present upper/lower (1), present both (2)
note nih_score: SENSORY. normal (0), partial loss (1), dense loss (2)
note nih_score: NEGLECT. no neglect (0), partial (1), complete (2)
note nih_score: DYSARTHIA. normal articulation (0), mild/mod dysarthria (1), unintelligible or worse (2)
note nih_score: BEST LANGUAGE (APHASIA). no aphasia (0), mild/mod aphasia (1), severe aphasia (2), mute (3)

** Self-reported health status
** Heath status at 3 months
rename healthst hs3m
label var hs3m "Health status at 3m"

** Health status at 1 year
rename y1health hs1y
label var hs1y "Health status at 1y"


** --------------------------------------------------------------------------
** SECTION THREE
** Pre-existing conditions

** Hypertension History in records
rename hyperten hist1
label var hist1 "History of hypertension"
** Angina history in records
rename angina hist2
label var hist2 "History of angina"
** MI history in records
rename myocardi hist3
label var hist3 "History of MI"
** CHF history in records
rename congesti hist4
label var hist4 "History of CHF"
** PVD history in records
rename peripher hist5
label var hist5 "History of PVD"
** Atrial Fibrillation history in records
rename atrialfi hist6
label var hist6 "History of atrial fibrillation"
** Hypercholesteraemia history in records
rename hypercho hist7
label var hist7 "History of hypercholesteraemia"

** diabetes
rename diabetic hist8
label var hist8 "History of diabetes"
label define hist8 1 "no" 2 "yes,diet" 3 "yes,oral" 4 "yes,insulin" 5 "yes,both" 6 "UNK", modify
label values hist8 hist8

** TIA history in records
rename tia hist9
label var hist9 "History of TIA"
** SCD history in records
rename sicklece hist10
label var hist10 "History of SCD"

** Smoker
drop smoke
rename smoker smoke
mvdecode smoke, mv(4=.)
label var smoke "Smoking history"

** Alcohol intake
rename alcoholi ai
label var ai "Alcohol intake (IU/week)"

** --------------------------------------------------------------------------
** SECTION FOUR
** RESOURCE USE

** HOSPITAL

** Hospital admission
rename admissio had
label var had "Hospital Admission"
mvdecode had, mv(3=.)


** Length of hospital stay if admitted
** Uses date of admission and date of discharge
rename dateadmi doad
rename datedisc dodis
label var doad "Date admitted to hospital"
label var dodis "Date of dicharge from hospital"
gen lohs = dodis - doad
label var lohs "Length of hospital stay (in days)"

** CT or MRI performed?
rename ctormri ct
label var ct "CT or MRI performed?"

** Date of CT/MRI scan
rename datescan dosc
label var dosc "Date of CT/MRI scan"

** Living Location
label define liv 	1 "private h/h alone"		///
					2 "private h/h not alone"	///
					3 "sheltered home"			///
					4 "residential home"			///
					5 "nursing home"			///
					6 "district hosp"			///
					7 "private hosp"			///
					8 "death"					///
					9 "in hosp", modify
** PRE-STROKE
rename livingco liv_pre
mvdecode liv_pre, mv(0 9=.)
label var liv_pre "Pre-stroke living situation"
label values liv_pre liv

** Discharge destination
rename discharg ddest
mvdecode ddest, mv(9=.)
label var ddest "Discharge destination"
label values ddest liv

** Living Location AT 3 MONTHS
rename m3living liv3m
mvdecode liv3m, mv(7=.)
replace liv3m = 8 if status3m==0
label var liv3m "Living situation at 3m"
label values liv3m liv

** Living Location AT 1 YEAR
rename y1living liv1y
mvdecode liv1y, mv(7 9=.)
replace liv1y = 8 if status1y==2|status1y==3
label var liv1y "Living situation at 1y"
label values liv1y liv

** Living Location AT 2 YEARS
rename y2living liv2y
mvdecode liv2y, mv(7 9=.)
replace liv2y = 8 if status2y==2|status2y==3|status2y==4
label var liv2y "Living situation at 2y"
label values liv2y liv


** Social Networks at 3m
** AT 3 MONTHS
* neededhe, someonet, seeneigh, seerelat, seefriend,

** If you needed help, do you have anyone to turn to?
rename neededhe sn1
label var sn1 "If you need help, do you have someone to turn to?"

** Do you have someone who shows that they care about you?
rename someonet sn2
label var sn2 "Do you have someone who shows that they care about you?"

** Do you see as much of your neighbours as you would like?
rename seeneigh sn3
label var sn3 "Do you see as much of your neighbours as you would like?"

** Do you see as much of your relatives as you would like?
rename seerelat sn4
label var sn4 "Do you see as much of your relatives as you would like?"

** Do you see as much of your friends as you would like?
rename seefrien sn5
label var sn5 "Do you see as much of your friends as you would like?"


** --------------------------------------------------------------------------
** SECTION FIVE
** The following have not been used in analyses before
** GIS-RELEVANT INFORMATION ?
** Parish of residence
label var parish "Parish of participant residence"

** Stroke timings
** Is time of stroke definite?
rename istimest timed
label var timed "Is time of stroke definite?"
** IF NO, did patient wake up with symptoms?
rename patientw timew
label var timew "Did patient wake up with symptoms?"
** Time of first stroke symptoms
rename timefirs timef
label var timef "Time of first stroke symptoms"
** Time of arrival to QEH/FMH
rename timearri timea
label var timea "Time of arrival to QEH/FMH"

** Section 1. Characteristics and Dates
addstub dos dob dod doad dodis lohs, stub(s1_)
addstub dof3m status3m dof1y status1y dof2y status2y, stub(s1_)
addstub sex age agey age5 age10 ethnic , stub(s1_)
addstub had ht wt wr, stub(s1_)
addstub primarys, stub(s1_)

** Section 2. Stroke Severity and Health Outcomes
addstub subtype ct dosc, stub(s2_)
addstub swallow ic bart_pre bart5d bart3m, stub(s2_)
addstub gcs bart1y bart2y nih_score, stub(s2_)
addstub hs3m hs1y, stub(s2_)

** Section 3. Pre-existing conditions
addstub hist1 hist2 hist3 hist4 hist5 hist6 hist7 , stub(s3_)
addstub hist8 hist9 hist10, stub(s3_)
addstub smoke ai, stub(s3_)

** Section 4. Resource Use
addstub ddest liv_pre liv3m liv1y liv2y , stub(s4_)
addstub sn1 sn2 sn3 sn4 sn5, stub(s4_)

** Section 5. Spatial and Temporal
addstub parish timed timew timef timea, stub(s5_)


#delimit ;
order eid s1_dos s1_dob s1_dod s1_primarys s1_had s1_doad s1_dodis s1_lohs
      s1_dof3m s1_status3m s1_dof1y s1_status1y s1_dof2y s1_status2y
      s1_sex s1_age s1_agey s1_age5 s1_age10 s1_ethnic
	  s1_ht s1_wt s1_wr
	  s2_subtype s2_ct s2_dosc
	  s2_gcs s2_swallow s2_ic s2_bart_pre s2_bart5d s2_bart3m
	  s2_bart1y s2_bart2y s2_nih_score s2_hs3m s2_hs1y
	  s3_hist1 s3_hist2 s3_hist3 s3_hist4 s3_hist5 s3_hist6 s3_hist7
	  s3_hist8 s3_hist9 s3_hist10
	  s3_smoke s3_ai
	  s4_liv_pre s4_ddest s4_liv3m s4_liv1y s4_liv2y
	  s4_sn1 s4_sn2 s4_sn3 s4_sn4 s4_sn5
      s5_parish s5_timed s5_timew s5_timef s5_timea;

keep  eid s1_dos s1_dob s1_dod s1_primarys s1_had s1_doad s1_dodis s1_lohs
      s1_dof3m s1_status3m s1_dof1y s1_status1y s1_dof2y s1_status2y
      s1_sex s1_age s1_agey s1_age5 s1_age10 s1_ethnic
	  s1_ht s1_wt s1_wr
	  s2_subtype s2_ct s2_dosc
	  s2_gcs s2_swallow s2_ic s2_bart_pre s2_bart5d s2_bart3m
	  s2_bart1y s2_bart2y s2_nih_score s2_hs3m s2_hs1y
	  s3_hist1 s3_hist2 s3_hist3 s3_hist4 s3_hist5 s3_hist6 s3_hist7
	  s3_hist8 s3_hist9 s3_hist10
	  s3_smoke s3_ai
	  s4_liv_pre s4_ddest s4_liv3m s4_liv1y s4_liv2y
	  s4_sn1 s4_sn2 s4_sn3 s4_sn4 s4_sn5
      s5_parish s5_timed s5_timew s5_timef s5_timea;
#delimit cr

sort eid
label data "BROS archived data. April-2011"
datasignature set
save "`datapath'\version02\2-working\bros_apr_2011", replace

** CLOSE LOG FILE AND END THE DO-FILE
* log close
exit
