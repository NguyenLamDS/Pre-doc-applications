********************************************************************************
********************************************************************************
** Milestones and Endogenous Feedback in Promoting Cooperation
** Authors: Nguyen Lam
** Supervisors: Nisvan Erkal, Boon Han Koh
********************************************************************************
********************************************************************************
/*
Description:
File is used to clean data .DTA files for analysis.
*/
********************************************************************************
/*
Descriptions of files used:
- Input:
	(1) Data/merged-main.dta 
- Output:
	(1) Data/cleaned.dta: 
		cleaned files to be used for analysis
	(2) Data/cleaned-combined.dta:
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

local path "E:/OneDrive - The University of Melbourne/Nguyên/UniMel/Attempt/Prof.Nisvan/Milestones - Endogenous choice/Data/STATA"
********************************************************************************

********** PREAMBLE **********

cd "`path'"
drop _all
set more off
set seed 12345

********************************************************************************

********** UPDATE NUMBER OF SEQUENCES AND ROUNDS & CONDITIONAL TASK PARAMETERS HERE **********

// global num_seq=10
global num_rounds=6
global contribution_max=90
global milestone_interval=15
global num_prac_seq = 2
global cond_min=0
global cond_max=30
global cond_int=2


********************************************************************************
********** FOR PILOT 1 AND 2: DID NOT RECORD PARTICIPANT_VARS **********
********************************************************************************
// use "Data/merged-main", clear
use "Data/merged-main", clear


** Update variable names **
rename ID ID
rename participantlabel p_label
rename p_label_num p_label_num
rename sessionconfigvcm treat_vcm
rename sessionconfiginterval treat_interval
rename k_outcome1playeris_dropout is_dropout_2
rename sessioncode  sessioncode
rename sessionlabel   sessionlabel
rename sessionconfigprob_endo prob_endo
rename sessionconfigprob_exo_milestone prob_exo_milestone
rename participantis_dropout is_dropout
rename participantseq_num seq_num
rename participantdropout dropout
rename a_instructions_i1playernum_click part1_ctrl_num_attempts_1
rename v74 part1_ctrl_num_attempts_2
rename v75  part1_ctrl_num_attempts_3
rename v76 part1_ctrl_num_attempts_4
rename v77 part1_ctrl_num_attempts_5
rename v78  part1_ctrl_num_attempts_6
rename b_pre_voting_sequence1groupid_in group_pre_voting
rename v86   cont_pre_vt_1
rename v87  cont_pre_vt_2
rename v88   cont_pre_vt_3
rename v89     cont_pre_vt_4
rename v90  cont_pre_vt_5
rename v98   payoff_i
rename v91  cont_pre_vt_6
rename v136  part2_fb_ctrl_num_attempts_1
rename v137  part2_fb_ctrl_num_attempts_2
rename v138  part2_fb_ctrl_num_attempts_3
rename v139  part2_fb_ctrl_num_attempts_4
rename v140  part2_fb_ctrl_num_attempts_5
rename v141 part2_fb_ctrl_num_attempts_6
rename v142 part2_fb_ctrl_num_attempts_7
rename v143 part2_fb_ctrl_num_attempts_8
rename v144 part2_fb_ctrl_num_attempts_9
rename v145 part2_fb_ctrl_num_attempts_10
rename v155  cont_prac_1_1
rename v156    cont_prac_1_2
rename v157    cont_prac_1_3
rename v158  cont_prac_1_4
rename v159   cont_prac_1_5
rename v160 cont_prac_1_6
rename v183  cont_prac_2_1
rename v184   cont_prac_2_2
rename v185   cont_prac_2_3
rename v186   cont_prac_2_4
rename v187  cont_prac_2_5
rename v188   cont_prac_2_6
rename f_instructions_ii_voting1playern part2_vt_ctrl_num_attempts_1
rename v213  part2_vt_ctrl_num_attempts_2
rename v214   part2_vt_ctrl_num_attempts_3
rename g_endogenous_sequence1playerchos chosen_feedback
rename g_endogenous_sequence1playerchoo choose_time
rename v222  choose_milestone
rename g_endogenous_sequence1playerpref preference_scale
rename g_endogenous_sequence1groupendo_ endo_feedback
rename g_endogenous_sequence1groupexo_f exo_feedback
rename v244  endo_time
rename v245   endo_milestone
rename g_endogenous_sequence1groupexo_t exo_time
rename g_endogenous_sequence1groupexo_m exo_milestone
rename g_endogenous_sequence1groupid_in group_post_voting
rename v226   cont_post_vt_1
rename v227  cont_post_vt_2
rename v228  cont_post_vt_3
rename v229 cont_post_vt_4
rename v230   cont_post_vt_5
rename v238   payoff_ii
rename v231  cont_post_vt_6
rename h_cond_coop_task1playernum_click part3_ctrl_num_attempts_1
rename v275  part3_ctrl_num_attempts_2
rename v276  part3_ctrl_num_attempts_3
rename v277    part3_ctrl_num_attempts_4
rename h_cond_coop_task1playerpayoff_ii payoff_iii
rename h_cond_coop_task1groupid_in_subs group_id_iii
rename h_cond_coop_task1playeruncond_co uncond_contribution
rename h_cond_coop_task1playeroption_0 cond_contribution_0
rename h_cond_coop_task1playeroption_2 cond_contribution_2
rename h_cond_coop_task1playeroption_4 cond_contribution_4
rename h_cond_coop_task1playeroption_6 cond_contribution_6
rename h_cond_coop_task1playeroption_8 cond_contribution_8
rename h_cond_coop_task1playeroption_10 cond_contribution_10
rename h_cond_coop_task1playeroption_12 cond_contribution_12
rename h_cond_coop_task1playeroption_14 cond_contribution_14
rename h_cond_coop_task1playeroption_16 cond_contribution_16
rename h_cond_coop_task1playeroption_18 cond_contribution_18
rename h_cond_coop_task1playeroption_20 cond_contribution_20
rename h_cond_coop_task1playeroption_22 cond_contribution_22
rename h_cond_coop_task1playeroption_24 cond_contribution_24
rename h_cond_coop_task1playeroption_26 cond_contribution_26
rename h_cond_coop_task1playeroption_28 cond_contribution_28
rename h_cond_coop_task1playeroption_30 cond_contribution_30
rename h_cond_coop_task1playercontribut contribution_iii
rename h_cond_coop_task1playerprivate_a private_account_iii
rename h_cond_coop_task1playercondition conditional_cooperator
rename h_cond_coop_task1grouptotal_othe total_uncond_coop_iii
rename h_cond_coop_task1groupaverage_ot average_uncond_coop_iii
rename h_cond_coop_task1groupgroup_acco group_account_iii
rename i_preference_survey1playerrisk_i risk_invest
rename i_preference_survey1playerrisk_k risk_keep
rename i_preference_survey1playerrisk_p risk_payoff
rename i_preference_survey1playerrisk_s risk_success
rename i_preference_survey1playerrisk_q risk_qualitative
rename i_preference_survey1playertrust_ trust_qualitative
rename i_preference_survey1playerpr_qua pr_qualitative
rename i_preference_survey1playernr_qua nr_qualitative
rename j_survey1playeryear_birth year_birth
rename j_survey1playerfemale female
rename j_survey1playerstudy_field study_field
rename j_survey1playerstudy_lvl study_lvl
rename j_survey1playergpa gpa
rename j_survey1playernationality nationality
rename j_survey1playerother_nationality other_nationality
rename j_survey1playercountry_born country_born
rename j_survey1playerother_country_bor other_country_born
rename j_survey1playerethnicity ethnicity
rename j_survey1playeryears_lived_austr years_lived_australia
rename j_survey1playerpast_experiments past_experiments
rename j_survey1playerdecisions_clear decisions_clear
rename j_survey1playerearnings_clear earnings_clear
rename j_survey1playercomments_unclear comments_unclear
rename j_survey1playervideo_clear video_clear
rename j_survey1playercompare_written compare_written
rename j_survey1playervideo_comments video_comments
rename j_survey1playervote_feedback vote_feedback
rename j_survey1playervote_feedback_exp vote_feedback_explain
rename j_survey1playervote_change vote_change
rename j_survey1playervote_change_expla vote_change_explain
rename j_survey1playerfeedback_usefulne feedback_usefulness
rename j_survey1playerfeedback_effect feedback_effect
rename j_survey1playerfeedback_effect_e feedback_effect_explain
rename j_survey1playerpartiii_explain partiii_explain
rename k_outcome1playerpayoff_task payoff_task
rename k_outcome1playerpayoff_final payoff_final

** Creating missing values **

//Actual feedback in part II.
gen no_feedback = 0
gen time_feedback = exo_time|endo_time
gen milestone_feedback = exo_milestone|endo_milestone
order no_feedback time_feedback milestone_feedback, after(prob_exo_milestone)

//Feedback in practice sequence
gen feedback_type_prac_1 = "T_feedback"
gen feedback_type_prac_2 = "M_feedback"
order feedback_type_prac_1, before(cont_prac_1_1)
order feedback_type_prac_2, before(cont_prac_2_1)

// Number of CQ answered correctly on the first attempt
egen correct_1st_attmp = anycount(*ctrl_num_attempts*), values(1)
order correct_1st_attmp, before(payoff_final)


// Accumlatated contributions and other contributions in pre-voting sequence
gen cont_accum_run = 0
gen other_cont_accum_run = 0
foreach y of numlist 1/$num_rounds {
	gen cont_accum_pre_vt_`y' = cont_pre_vt_`y' + cont_accum_run
	replace cont_accum_run = cont_accum_pre_vt_`y'
	bysort group_pre_voting sessioncode: egen group_cont_pre_vt_`y' = total(cont_pre_vt_`y')
	gen other_cont_pre_vt_`y' = group_cont_pre_vt_`y' - cont_pre_vt_`y'
	gen other_cont_accum_pre_vt_`y' = other_cont_pre_vt_`y' + other_cont_accum_run
	replace other_cont_accum_run = other_cont_accum_pre_vt_`y' 
	order cont_accum_pre_vt_`y' other_cont_pre_vt_`y' other_cont_accum_pre_vt_`y', after(cont_pre_vt_`y')
}
drop cont_accum_run other_cont_accum_run group_cont_pre_vt*


// Accumlatated contributions and other contributions in post-voting sequence
gen cont_accum_run = 0
gen other_cont_accum_run = 0
foreach y of numlist 1/$num_rounds {
	gen cont_accum_post_vt_`y' = cont_post_vt_`y' + cont_accum_run
	replace cont_accum_run = cont_accum_post_vt_`y'
	bysort group_post_voting sessioncode: egen group_cont_post_vt_`y' = total(cont_post_vt_`y')
	gen other_cont_post_vt_`y' = group_cont_post_vt_`y' - cont_post_vt_`y'
	gen other_cont_accum_post_vt_`y' = other_cont_post_vt_`y' + other_cont_accum_run
	replace other_cont_accum_run = other_cont_accum_post_vt_`y' 
	order cont_accum_post_vt_`y' other_cont_post_vt_`y' other_cont_accum_post_vt_`y', after(cont_post_vt_`y')
}
drop cont_accum_run other_cont_accum_run group_cont_post_vt*


// Accumulated contributions in practice tasks
foreach x of numlist 1/$num_prac_seq {
	local temp1 = 4
	local temp2 = 6
	local temp3 = 8
	local temp4 = 10
	local temp5 = 12
	local temp6 = 14
	gen cont_accum_run = 0
	gen other_cont_accum_run = 0 
	foreach r of numlist 1/$num_rounds {
		gen cont_accum_prac_`x'_`r' = cont_prac_`x'_`r' + cont_accum_run
		replace cont_accum_run = cont_accum_prac_`x'_`r'
		gen other_cont_prac_`x'_`r' = `temp`r''
		gen other_cont_accum_prac_`x'_`r' = other_cont_accum_run + other_cont_prac_`x'_`r'
		replace other_cont_accum_run = other_cont_accum_prac_`x'_`r'
		order cont_accum_prac_`x'_`r' other_cont_prac_`x'_`r' other_cont_accum_prac_`x'_`r', after(cont_prac_`x'_`r' )
	}
	drop cont_accum_run
	drop other_cont_accum_run
}

// Milestone that is reached in each round
foreach x in pre_vt post_vt prac_1 prac_2 {
	foreach r of numlist 1/$num_rounds {
		foreach m of numlist $milestone_interval($milestone_interval)$contribution_max {
			gen target`m'_`x'_0 = 0
			local Lr = `r' - 1
			gen target`m'_`x'_`r' = target`m'_`x'_`Lr' + ((cont_accum_`x'_`r' + other_cont_accum_`x'_`r') >= `m')
			drop target`m'_`x'_0
		}
		order target*_`x'_`r', after(other_cont_accum_`x'_`r')
	}
}

** Drop redundant variables **
drop seq_num

********************************************************************************
********** FOR SESSIONS THAT RECORD PARTICIPANT_VARS **********
********************************************************************************

** Uncomemnt code below if the data has participant_vars **

*********************

// use "Data/merged-main", clear
//
// ** Update variable names **
// foreach y of numlist 1/$num_rounds {
// 	rename contribution_pre_voting_`y' cont_pre_vt_`y'
// 	rename contribution_accum_pre_voting_`y' cont_accum_pre_vt_`y'
// 	rename other_contribution_pre_voting_`y' other_cont_pre_vt_`y'
//	
// 	rename contribution_prac_1_`y' cont_prac_1_`y'
// 	rename contribution_accum_prac_1_`y' cont_accum_prac_1_`y'
// 	rename other_contribution_prac_1_`y' other_cont_prac_1_`y'
// 	rename contribution_prac_2_`y' cont_prac_2_`y'
// 	rename contribution_accum_prac_2_`y' cont_accum_prac_2_`y'
// 	rename other_contribution_prac_2_`y' other_cont_prac_2_`y'
//
// 	rename contribution_post_voting_`y' cont_post_vt_`y'
// 	rename contribution_accum_post_voting_`y' cont_accum_post_vt_`y'
// 	rename other_contribution_post_voting_`y' other_cont_post_vt_`y'
//	
// 	foreach m of numlist $milestone_interval($milestone_interval)$contribution_max {
// 		rename target`m'_pre_voting_`y' target`m'_pre_vt_`y'
// 		rename target`m'_post_voting_`y' target`m'_post_vt_`y'
// 	}	
// }
//
// rename other_contribution_accum_pre_vot other_cont_accum_pre_vt_1
// rename v29 other_cont_accum_pre_vt_2
// rename v39 other_cont_accum_pre_vt_3
// rename v49 other_cont_accum_pre_vt_4
// rename v59 other_cont_accum_pre_vt_5
// rename v70 other_cont_accum_pre_vt_6
// rename other_contribution_accum_prac_1_ other_cont_accum_prac_1_1
// rename v104 other_cont_accum_prac_1_2
// rename v114 other_cont_accum_prac_1_3
// rename v124 other_cont_accum_prac_1_4
// rename v134 other_cont_accum_prac_1_5
// rename v144 other_cont_accum_prac_1_6
// rename other_contribution_accum_prac_2_ other_cont_accum_prac_2_1
// rename v165 other_cont_accum_prac_2_2
// rename v175 other_cont_accum_prac_2_3
// rename v185 other_cont_accum_prac_2_4
// rename v195 other_cont_accum_prac_2_5
// rename v205 other_cont_accum_prac_2_6
// rename other_contribution_accum_post_vo other_cont_accum_post_vt_1
// rename v241 other_cont_accum_post_vt_2
// rename v251 other_cont_accum_post_vt_3
// rename v261 other_cont_accum_post_vt_4
// rename v271 other_cont_accum_post_vt_5
// rename v282 other_cont_accum_post_vt_6
//
//
// rename payoff_rg risk_payoff
// rename rg_success risk_success
//
// rename ctrl_num_clicks_i_1 part1_ctrl_num_attempts_1
// rename ctrl_num_clicks_i_2 part1_ctrl_num_attempts_2
// rename ctrl_num_clicks_i_3 part1_ctrl_num_attempts_3
// rename ctrl_num_clicks_i_4 part1_ctrl_num_attempts_4
// rename ctrl_num_clicks_i_5 part1_ctrl_num_attempts_5
// rename ctrl_num_clicks_i_6 part1_ctrl_num_attempts_6
// rename ctrl_num_clicks_ii_feedback_1 part2_fb_ctrl_num_attempts_1
// rename ctrl_num_clicks_ii_feedback_2 part2_fb_ctrl_num_attempts_2
// rename ctrl_num_clicks_ii_feedback_3 part2_fb_ctrl_num_attempts_3
// rename ctrl_num_clicks_ii_feedback_4 part2_fb_ctrl_num_attempts_4
// rename ctrl_num_clicks_ii_feedback_5 part2_fb_ctrl_num_attempts_5
// rename ctrl_num_clicks_ii_feedback_6 part2_fb_ctrl_num_attempts_6
// rename ctrl_num_clicks_ii_feedback_7 part2_fb_ctrl_num_attempts_7
// rename ctrl_num_clicks_ii_feedback_8 part2_fb_ctrl_num_attempts_8
// rename ctrl_num_clicks_ii_feedback_9 part2_fb_ctrl_num_attempts_9
// rename ctrl_num_clicks_ii_feedback_10 part2_fb_ctrl_num_attempts_10
// rename ctrl_num_clicks_ii_voting_1 part2_vt_ctrl_num_attempts_1
// rename ctrl_num_clicks_ii_voting_2 part2_vt_ctrl_num_attempts_2
// rename ctrl_num_clicks_ii_voting_3 part2_vt_ctrl_num_attempts_3
// rename ctrl_num_clicks_iii_1 part3_ctrl_num_attempts_1
// rename ctrl_num_clicks_iii_2 part3_ctrl_num_attempts_2
// rename ctrl_num_clicks_iii_3 part3_ctrl_num_attempts_3
// rename ctrl_num_clicks_iii_4 part3_ctrl_num_attempts_4
//
// ** Drop redundant variables **
// drop no_feedback_practice time_practice milestone_practice prac_seq_counter seq_num

*********************

** Import labels and create cleaned dataset **
do "2-doFiles/cl-label"

** Convert variable types **
// True/false

** Uncomemnt code below if the data has participant_vars **
// foreach x of varlist is_dropout time_feedback milestone_feedback ///
// choose_time choose_milestone endo_feedback endo_time endo_milestone exo_time exo_milestone conditional_cooperator {
// 	replace `x'="1" if `x'=="True"
// 	replace `x'="0" if `x'=="False"
// 	destring `x', replace
// }
// destring compare_written, replace

// Feedback mechanism
label define feedback_lbl 1 "Timebased feedback" 2 "Milestone feedback", replace
foreach x of numlist 1 2{
	replace feedback_type_prac_`x' = "1" if feedback_type_prac_`x' == "T_feedback"
	replace feedback_type_prac_`x' = "2" if feedback_type_prac_`x' == "M_feedback"
	destring feedback_type_prac_`x', replace
	label values feedback_type_prac_`x' feedback_lbl
}
label values chosen_feedback feedback_lbl 

// Agree/disagree
foreach x of varlist decisions_clear earnings_clear video_clear {
	replace `x'="4" if `x'=="Strongly Agree"
	replace `x'="3" if `x'=="Agree"
	replace `x'="2" if `x'=="Disagree"
	replace `x'="1" if `x'=="Strongly Disagree"
	destring `x', replace
	label define agree_lbl 4 "SA" 3 "A"  2 "D" 1 "SD", replace
	label values `x' agree_lbl
}

** Drop participants who are dropouts in the dataset
drop if is_dropout

** Generate variables **
// Session ID and ID 
sort sessionlabel p_label_num
egen sessionID=group(sessionlabel)
order sessionID, after(ID)
label var sessionID "Session ID"
replace ID=_n

// Majority vote outcome
bysort group_post_voting sessionID: egen team_choose_time = total(choose_time)
bysort group_post_voting sessionID: egen team_choose_milestone = total(choose_milestone)
replace team_choose_time = team_choose_time >= 2
replace team_choose_milestone = team_choose_milestone >= 2
order team_choose_time team_choose_milestone, after(choose_milestone)

label var team_choose_time "Majority of team members choose time-based feedback"
label var team_choose_milestone "Majority of team members choose milestone feedback"

//Group contributions
foreach x of numlist 1/$num_rounds {
	foreach y in pre_vt post_vt prac_1 prac_2 {
		if "`y'" == "pre_vt" {
			local lb = "Part I (pre-voting)"
		}
		if "`y'" == "post_vt" {
			local lb = "Part II (post-voting)"
		}
		if "`y'" == "prac_1" {
			local lb = "Practice 1"
		}
		if "`y'" == "prac_2" {
			local lb = "Practice 2"
		}
		gen group_cont_`y'_`x' = cont_`y'_`x' + other_cont_`y'_`x' 
		gen group_cont_accum_`y'_`x' = cont_accum_`y'_`x' + other_cont_accum_`y'_`x' 
		order group_cont_`y'_`x' group_cont_accum_`y'_`x', after(other_cont_accum_`y'_`x')
		label var group_cont_`y'_`x' "Group contributions (`lb' Round `x')"
		label var group_cont_accum_`y'_`x' "Accumulated group contributions (`lb' Round `x')"
	}
}


// Treatment dummy
gen treatment=.
replace treatment=1 if endo_time & team_choose_time
replace treatment=2 if exo_time & team_choose_time
replace treatment=3 if exo_milestone & team_choose_time
replace treatment=4 if endo_milestone & team_choose_milestone
replace treatment=5 if exo_time & team_choose_milestone
replace treatment=6 if exo_milestone & team_choose_milestone

label var treatment "Treatment"
order treatment, after(milestone_feedback)

label define treatment_lbl 1 "T-Endo-T" 2 "T-Exo-T"3 "T-Exo-M" 4 "M-Endo-M" 5 "M-Exo-T" 6 "M-Exo-M", replace
label values treatment treatment_lbl

// RT percent
gen risk_invest_perc=risk_invest/10*100
label var risk_invest_perc "% endowment invested in risk task"
order risk_invest_perc, after(risk_invest)

// Survey responses
gen age=2023-year_birth
label var age "Age"
order age, after(year_birth)

gen economics=.
replace economics=1 if study_field=="Commerce (Economics)"
replace economics=0 if study_field!="Commerce (Economics)"
label var economics "Economics major"
order economics, after(study_field)

gen undergraduate=.
gen postgraduate=.
replace undergraduate=1 if strpos(study_lvl, "undergraduate")
replace undergraduate=0 if undergraduate==.
replace postgraduate=1 if strpos(study_lvl, "Graduate student")
replace postgraduate=0 if postgraduate==.
label var undergraduate "Undergraduate student"
label var postgraduate "Postgraduate student"
order undergraduate postgraduate, after(study_lvl)

gen australian=.
replace australian=1 if nationality=="Australian"
replace australian=0 if nationality!="Australian"
label var australian "Australian"
order australian, after(nationality)

replace gpa = "." if strpos(gpa, "Not applicable")
replace gpa = "1" if strpos(gpa, "N")
replace gpa = "2" if strpos(gpa, "P")
replace gpa = "3" if strpos(gpa, "H3")
replace gpa ="4" if strpos(gpa, "H2B")
replace gpa = "5" if strpos(gpa, "H2A")
replace gpa = "6" if strpos(gpa, "H1")
destring gpa, replace
label define gpa_lbl 1 "N (0%-49%)" 2 "P (50%-64%)" 3 "H3 (65%-69%)" 4 "H2B (70%-74%)" 5 "H2A (75%-79%)" 6 "H1 (80%-100%)", replace
label values gpa gpa_lbl

label define vote_feedback_lbl 0 "Not remember" 1 "Timebased feedback" 2 "Milestone feedback", replace
label values vote_feedback vote_feedback_lbl

label define vote_change_lbl 1 "Timebased feedback" 2 "Milestone feedback", replace
label values vote_change vote_change_lbl


save "Data/cleaned-main", replace



********************************************************************************

** Classify subjects into conditional cooperators, free-riders, and others
	
use "Data/cleaned-main", clear

// Generate rho and p-values from spearman's correlation
local N=_N

reshape long cond_contribution_, i(ID) j(hypothetical_average)
rename cond_contribution_ cond_contribution

gen cond_rho=.
gen cond_pvalue=.
gen cond_numobs=.

forvalues i=1/`N' {
	*disp(`i')
	qui spearman cond_contribution hypothetical_average if ID==`i'
	qui replace cond_pvalue=r(p) if ID==`i'
	qui replace cond_rho=r(rho) if ID==`i'
	qui replace cond_numobs=r(N) if ID==`i'
}

// Classify individuals based on their rho and pvalue (threshold < 0.01)
gen cond_cooperator= cond_rho>0 & cond_pvalue<0.01
by ID: egen total_cond_contribution=total(cond_contribution)
gen free_rider= total_cond_contribution==0
gen other_type= cond_cooperator==0 & free_rider==0
gen cond_type=.
replace cond_type=1 if cond_cooperator
replace cond_type=2 if free_rider
replace cond_type=3 if other_type

label define type_lbl 1 "Conditional cooperator" 2 "Free-rider" 3 "Others", replace
label values cond_type type_lbl
label var cond_rho "Spearman correlation for conditional cooperation"
label var cond_pvalue "Spearman correlation p-value for rho != 0"
label var cond_numobs "Spearman correlation # observations used for calculation"
label var cond_type "Type based on conditional cooperation task"
label var cond_cooperator "Conditional cooperator"
label var free_rider "Free-rider"
label var other_type "Neither conditional cooperator nor free-rider"

keep if hypothetical_average==0
keep ID cond_rho cond_pvalue cond_numobs cond_type cond_cooperator free_rider other_type

save "temp.dta", replace

// Merge data with main dataset
use "Data/cleaned-main", clear
merge 1:1 ID using "temp.dta"
drop _merge
order cond_rho cond_pvalue cond_numobs cond_type cond_cooperator free_rider other_type, after(average_uncond_coop_ii)

erase "temp.dta"

save "Data/cleaned-main", replace

********************************************************************************

** Create panel dataset where unit of time is part(I or II)-round **

use "Data/cleaned-main", clear

// Reshape by round
reshape long ///
	cont_pre_vt_ cont_accum_pre_vt_ other_cont_pre_vt_ other_cont_accum_pre_vt_ group_cont_pre_vt_ group_cont_accum_pre_vt_ target15_pre_vt_ target30_pre_vt_ target45_pre_vt_ target60_pre_vt_ target75_pre_vt_ target90_pre_vt_ ///
	cont_prac_1_ cont_accum_prac_1_ other_cont_prac_1_ other_cont_accum_prac_1_ group_cont_prac_1_ group_cont_accum_prac_1_ target15_prac_1_ target30_prac_1_ target45_prac_1_ target60_prac_1_ target75_prac_1_ target90_prac_1_ ///
	cont_prac_2_ cont_accum_prac_2_ other_cont_prac_2_ other_cont_accum_prac_2_ group_cont_prac_2_ group_cont_accum_prac_2_ target15_prac_2_ target30_prac_2_ target45_prac_2_ target60_prac_2_ target75_prac_2_ target90_prac_2_ ///
	cont_post_vt_ cont_accum_post_vt_ other_cont_post_vt_ other_cont_accum_post_vt_ group_cont_post_vt_ group_cont_accum_post_vt_ target15_post_vt_ target30_post_vt_ target45_post_vt_ target60_post_vt_ target75_post_vt_ target90_post_vt_ ///
	, i(ID) j(round)
	
// Reshape by sequence
gen IDtemp=_n
foreach x in pre_vt post_vt prac_1 prac_2  {
	rename cont_`x'_ cont_`x'
	rename cont_accum_`x'_ cont_accum_`x'
	rename other_cont_`x'_ other_cont_`x'
	rename other_cont_accum_`x'_ other_cont_accum_`x'
	rename group_cont_`x'_ group_cont_`x'
	rename group_cont_accum_`x'_ group_cont_accum_`x'
	rename target15_`x'_ target15_`x'
	rename target30_`x'_ target30_`x'
	rename target45_`x'_ target45_`x'
	rename target60_`x'_ target60_`x'
	rename target75_`x'_ target75_`x'
	rename target90_`x'_ target90_`x'
}
rename group_pre_voting group_temp_pre_vt
rename group_post_voting group_temp_post_vt 

reshape long ///
	group_temp_ cont_ cont_accum_ other_cont_ other_cont_accum_ group_cont_ group_cont_accum_ target15_ target30_ target45_ target60_ target75_ target90_ ///
	, i(IDtemp) j(part) string
	
replace group_temp_ = 0 if group_temp_ == . //Group ID in practice tasks.
replace part = "1" if part  == "pre_vt"
replace part = "2" if part == "post_vt"
replace part = "-1" if part == "prac_1"
replace part = "-2" if part == "prac_2"
destring part, replace
label define part_lbl -1 "Practice Task 1" -2 "Practice Task 2" 1 "Part I (before voting)" 2 "Part II (after voting)"
label values part part_lbl

drop IDtemp
order ID, first
label var part "Part"
label var round "Round"

rename group_temp_ group
rename cont_ cont
rename cont_accum_ cont_accum
rename other_cont_ other_cont
rename other_cont_accum_ other_cont_accum
rename group_cont_ group_cont
rename group_cont_accum_ group_cont_accum

foreach x of numlist 15 30 45 60 75 90 {
	rename target`x'_ target`x'
}

label var group "Group"
label var cont "Contribution"
label var cont_accum "Accumulated contribution"
label var other_cont "Others' contribution"
label var other_cont_accum "Accumulated others' contribution"
label var group_cont "Group contribution"
label var group_cont_accum "Accumulated group contribution"
label var target15 "Met 15% milestone"
label var target30 "Met 30% milestone"
label var target45 "Met 45% milestone"
label var target60 "Met 60% milestone"
label var target75 "Met 75% milestone"
label var target90 "Met 90% milestone"

// Create unique group ID at part-sequence level
sort sessionlabel part group round ID
egen GroupID=group(sessionlabel part group)
order GroupID, first
label var GroupID "Group # (unique ID in dataset)"

sort sessionlabel part group round ID

save "Data/cleaned-panel-main", replace

********************************************************************************

** Check treatment numbers **

use "Data/cleaned-main", clear

tab treatment