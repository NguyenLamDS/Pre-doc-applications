********************************************************************************
********************************************************************************
** Milestones and Endogenous Feedback in Promoting Cooperation
** Authors: Nguyen Lam
** Supervisors: Nisvan Erkal, Boon Han Koh
********************************************************************************
********************************************************************************
/*
Description:
File is used to extract data from raw .CSV format into .DTA files for analysis.
Needs to be run only once, at the beginning of analysis stage.
*/
********************************************************************************
/*
Descriptions of files used:
- Input:
	+ For pilot 1 and pilot 2:
	(1) 1-RawData/all_apps_wide
	Did not contains participant_vars
	+ For other sessions:
	(1) 1-RawData/outcome.csv
	End app data; contains participant_vars; downloaded from oTree; merged across multiple sessions.
- Output:
	(1) Data/merged-pilot-main.dta
*/
********************************************************************************
/*
Change Log:
*/
********************************************************************************

********** CHANGE DIRECTORY HERE **********

// Root folder is your corresponding Dropbox/STATA folder.
// Uncomment corresponding directories below.
// Directory will be used throughout rest of file, so subsequent paths do not need to be updated.

local path "E:\OneDrive - The University of Melbourne\Nguyên\UniMel\Attempt\Prof.Nisvan\Milestones - Endogenous choice\Data\STATA"
********************************************************************************

********** PREAMBLE **********

cd "`path'"
drop _all
set more off
set seed 12345

** create directory to store main data files
cap mkdir "Data"


********************************************************************************
********** FOR PILOT 1 AND 2: DID NOT RECORD PARTICIPANT_VARS **********
********************************************************************************

********** EXTRACT DATA **********

cd "`path'"

** import app data for python cleaning 
import delimited "1-RawData/all_apps_wide.csv", clear

keep participantlabel sessionconfigvcm sessionconfiginterval k_outcome1playeris_dropout sessioncode  sessionlabel   sessionconfigprob_endo sessionconfigprob_exo_milestone participantis_dropout participantseq_num participantdropout a_instructions_i1playernum_click v74 v75  v76 v77 v78  b_pre_voting_sequence1groupid_in v86 v87 v88 v89 v90 v98 v91 v136 v137 v138 v139 v140 v141 v142 v143 v144 v145 v155  v156 v157 v158 v159 v160 v183 v184 v185 v186 v187 v188  f_instructions_ii_voting1playern v213 v214  g_endogenous_sequence1playerchos g_endogenous_sequence1playerchoo v222 g_endogenous_sequence1playerpref g_endogenous_sequence1groupendo_ g_endogenous_sequence1groupexo_f v244 v245  g_endogenous_sequence1groupexo_t g_endogenous_sequence1groupexo_m g_endogenous_sequence1groupid_in v226  v227 v228  v229 v230  v238  v231 h_cond_coop_task1playernum_click v275 v276 v277    h_cond_coop_task1playerpayoff_ii h_cond_coop_task1groupid_in_subs h_cond_coop_task1playeruncond_co h_cond_coop_task1playeroption_0 h_cond_coop_task1playeroption_2 h_cond_coop_task1playeroption_4 h_cond_coop_task1playeroption_6 h_cond_coop_task1playeroption_8 h_cond_coop_task1playeroption_10 h_cond_coop_task1playeroption_12 h_cond_coop_task1playeroption_14 h_cond_coop_task1playeroption_16 h_cond_coop_task1playeroption_18 h_cond_coop_task1playeroption_20 h_cond_coop_task1playeroption_22 h_cond_coop_task1playeroption_24 h_cond_coop_task1playeroption_26 h_cond_coop_task1playeroption_28 h_cond_coop_task1playeroption_30 h_cond_coop_task1playercontribut h_cond_coop_task1playerprivate_a h_cond_coop_task1playercondition h_cond_coop_task1grouptotal_othe h_cond_coop_task1groupaverage_ot h_cond_coop_task1groupgroup_acco i_preference_survey1playerrisk_i i_preference_survey1playerrisk_k i_preference_survey1playerrisk_p i_preference_survey1playerrisk_s i_preference_survey1playerrisk_q i_preference_survey1playertrust_ i_preference_survey1playerpr_qua i_preference_survey1playernr_qua j_survey1playeryear_birth j_survey1playerfemale j_survey1playerstudy_field j_survey1playerstudy_lvl j_survey1playergpa j_survey1playernationality j_survey1playerother_nationality j_survey1playercountry_born j_survey1playerother_country_bor j_survey1playerethnicity j_survey1playeryears_lived_austr j_survey1playerpast_experiments j_survey1playerdecisions_clear j_survey1playerearnings_clear j_survey1playercomments_unclear j_survey1playervideo_clear j_survey1playercompare_written j_survey1playervideo_comments j_survey1playervote_feedback j_survey1playervote_feedback_exp j_survey1playervote_change j_survey1playervote_change_expla j_survey1playerfeedback_usefulne j_survey1playerfeedback_effect j_survey1playerfeedback_effect_e j_survey1playerpartiii_explain k_outcome1playerpayoff_task k_outcome1playerpayoff_final

gen p_label_num = substr(participantlabel, 2, .) 
destring p_label_num, replace

** filter out participants who did not complete the study
// NOTE: comment this line for testing data (no prolific ID)
drop if missing(p_label_num) 


order participantlabel p_label_num sessionconfigvcm sessionconfiginterval k_outcome1playeris_dropout sessioncode sessionlabel sessionconfigprob_endo sessionconfigprob_exo_milestone, first
sort sessionlabel p_label_num
gen ID=_n
order ID, first

// save "Data/merged-main.dta", replace
save "Data/merged-main.dta", replace


********************************************************************************
********** FOR SESSIONS THAT RECORD PARTICIPANT_VARS **********
********************************************************************************

********** EXTRACT DATA **********

cd "`path'"

** import app data for python cleaning 
import delimited "1-RawData/outcome.csv", clear

** rename key vars
rename participantlabel p_label // for identifying participants who completed exp
rename playerparticipant_vars p_vars // variable that contains all choice data
rename playertreat_vcm treat_vcm // treatment variable (VCM)
// rename playertreat_timebased treat_time // treatment variable (time-based feedback)
rename playertreat_interval treat_interval // treatment variable (interval length between milestones)
rename playeris_dropout is_dropout_2 // identifies whether participant dropped out
	
** filter out participants who did not complete the study
// NOTE: comment this line for testing data (no prolific ID)
drop if missing(p_label) 
drop if missing(p_vars)

//NOTE: For testing data only, comment this line for actual data
// drop if participant_is_bot != 1 


** keep vars that are needed for python cleaning OR session identifiers
keep p_label p_vars treat_vcm treat_interval is_dropout sessioncode sessionlabel

** export temporarily for use in python script
export delimited using "extract_python.csv", replace

** clear STATA dataset
drop _all

** use python script to extract choice data from p_vars and store as separate CSV files
* NOTE: UPDATE path in extract.py file

python script "2-doFiles/extract-main.py"


********************************************************************************
********** SAVE AS .DTA FILES **********

** import CSV files into STATA .dta format, delete temp files
cd "`path'"
insheet using "Data/merged-main.csv", names delim(,) clear

//NOTE: For testing only; Comment this line for actual data.
//gen p_label_num = .  
//NOTE: Uncomment these two lines for actual data.
gen p_label_num = substr(p_label, 2, .) 
destring p_label_num, replace

order p_label p_label_num treat_vcm treat_interval is_dropout_2 sessioncode sessionlabel prob_endo prob_exo_milestone, first
sort sessionlabel p_label_num
gen ID=_n
order ID, first

save "Data/merged-main.dta", replace
drop _all
erase "extract_python.csv"
