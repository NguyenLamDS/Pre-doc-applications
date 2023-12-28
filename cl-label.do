********************************************************************************
********************************************************************************
** Milestones and Endogenous Feedback in Promoting Cooperation
** Authors: Nguyen Lam
** Supervisors: Nisvan Erkal, Boon Han Koh
********************************************************************************
********************************************************************************
/*
Description:
Label file 
*/
********************************************************************************
/*
Change Log:
*/
********************************************************************************
/*
Use these forloop lines:
foreach y of numlist 1/$num_rounds {
	...
}

foreach x of numlist 1/$num_seq {
	foreach y of numlist 1/$num_rounds {
		...
	}
}

foreach z of numlist $cond_min($cond_int)$cond_max {
	...
}
*/
********************************************************************************

***** INSTRUCTIONS: DO NOT RUN THIS FILE. THIS IS BEING CALLED BY CL-CLEAN.DO *****

label var ID "ID"
label var p_label "Participant ID in session"
label var p_label_num "Participant ID in session (numeric)"
label var treat_vcm "VCM"
label var treat_interval "Interval between milestones"
label var is_dropout_2 "Participant dropped out (verify)"
label var sessioncode "Session code"
label var sessionlabel "Session label"
label var prob_endo "Probability the computer considers team' votes"
label var prob_exo_milestone "Probability the computer chooses milestone feedback given that feedback is eoxgenous"
label var is_dropout "Participant dropped out"
label var no_feedback "Receive no feedback in Part II"
label var time_feedback "Receive time-based feebdack in Part II"
label var milestone_feedback "Receive milestone feedback in Part II"
label var dropout "Participant dropped out (description)"

label var part1_ctrl_num_attempts_1 "# attempts in Part I comprehension Q1"
label var part1_ctrl_num_attempts_2 "# attempts in Part I comprehension Q2"
label var part1_ctrl_num_attempts_3 "# attempts in Part I comprehension Q3"
label var part1_ctrl_num_attempts_4 "# attempts in Part I comprehension Q4"
label var part1_ctrl_num_attempts_5 "# attempts in Part I comprehension Q5"
label var part1_ctrl_num_attempts_6 "# attempts in Part I comprehension Q6"
label var group_pre_voting "Group ID in Part I"

foreach y of numlist 1/$num_rounds {
	label var cont_pre_vt_`y' "Contribution (Part I (pre-voting) Round `y')"
	label var cont_accum_pre_vt_`y' "Accumulated contribution (Part I (pre-voting) Round `y')"
	label var other_cont_pre_vt_`y' "Others' contribution (Part I (pre-voting) Round `y')"
	label var other_cont_accum_pre_vt_`y' "Accumulated others' contribution (Part I (pre-voting) Round `y')"
	foreach z of numlist $milestone_interval($milestone_interval)$contribution_max {
		label var target`z'_pre_vt_`y' "Met `z'% milestone (Part I (pre-voting) Round `y')"
	}
}
label var payoff_i "Part I payoff"

label var part2_fb_ctrl_num_attempts_1 "# attempts in Part II comprehension Q1 about feedback"
label var part2_fb_ctrl_num_attempts_2 "# attempts in Part II comprehension Q2 about feedback"
label var part2_fb_ctrl_num_attempts_3 "# attempts in Part II comprehension Q3 about feedback"
label var part2_fb_ctrl_num_attempts_4 "# attempts in Part II comprehension Q4 about feedback"
label var part2_fb_ctrl_num_attempts_5 "# attempts in Part II comprehension Q5 about feedback"
label var part2_fb_ctrl_num_attempts_6 "# attempts in Part II comprehension Q6 about feedback"
label var part2_fb_ctrl_num_attempts_7 "# attempts in Part II comprehension Q7 about feedback"
label var part2_fb_ctrl_num_attempts_8 "# attempts in Part II comprehension Q8 about feedback"
label var part2_fb_ctrl_num_attempts_9 "# attempts in Part II comprehension Q9 about feedback"
label var part2_fb_ctrl_num_attempts_10 "# attempts in Part II comprehension Q10 about feedback"

label var feedback_type_prac_1 "Feedback mechanism in the first practice task"
label var feedback_type_prac_2 "Feedback mechanism in the first practice task"

foreach x of numlist 1/$num_prac_seq {
	foreach y of numlist 1/$num_rounds {
		label var cont_prac_`x'_`y' "Contribution (Practice `x' Round `y')"
		label var cont_accum_prac_`x'_`y' "Accumulated contribution (Practice `x' Round `y')"
		label var other_cont_prac_`x'_`y' "Others' contribution (Practice `x' Round `y')"
		label var other_cont_accum_prac_`x'_`y' "Accumulated others' contribution (Practice `x' Round `y')"
		foreach z of numlist $milestone_interval($milestone_interval)$contribution_max {
			label var target`z'_prac_`x'_`y' "Met `z'% milestone (Practice `x' Round `y')"
		}
	}
}

label var part2_vt_ctrl_num_attempts_1 "# attempts in Part II comprehension Q1 about voting"
label var part2_vt_ctrl_num_attempts_2 "# attempts in Part II comprehension Q2 about voting"
label var part2_vt_ctrl_num_attempts_3 "# attempts in Part II comprehension Q3 about voting"
label var chosen_feedback "Feedback mechanism that the participant voted for"
label var choose_time "Voted for time-based feedback"
label var choose_milestone "Voted for milestone feedback"
label var preference_scale "How strongly participants prefer time-based feedback or milestone feedback"
label var endo_feedback "Endogenous feedback"
label var exo_feedback "Exogenous feedback"
label var endo_time "Endogenous time-based feedback"
label var endo_milestone "Endogenous milestone feedback"
label var exo_time "Exogenous time-based feedback"
label var exo_milestone "Exogenous milestone feedback"

label var group_post_voting "Group ID in Part II"

foreach y of numlist 1/$num_rounds {
	label var cont_post_vt_`y' "Contribution (Part II (post-voting) Round `y')"
	label var cont_accum_post_vt_`y' "Accumulated contribution (Part II (post-voting) Round `y')"
	label var other_cont_post_vt_`y' "Others' contribution (Part II (post-voting) Round `y')"
	label var other_cont_accum_post_vt_`y' "Accumulated others' contribution (Part II (post-voting) Round `y')"
	foreach z of numlist $milestone_interval($milestone_interval)$contribution_max {
		label var target`z'_post_vt_`y' "Met `z'% milestone (Part II (post-voting) Round `y')"
	}
}
label var payoff_ii "Part II payoff"


label var part3_ctrl_num_attempts_1 "# attempts in Part III comprehension Q1"
label var part3_ctrl_num_attempts_2 "# attempts in Part III comprehension Q2"
label var part3_ctrl_num_attempts_3 "# attempts in Part III comprehension Q3"
label var part3_ctrl_num_attempts_4 "# attempts in Part III comprehension Q4"
label var payoff_iii "Part III payoff"
label var group_id_iii "Group ID in Part III"
label var uncond_contribution "Part III unconditional contribution"

foreach z of numlist $cond_min($cond_int)$cond_max {
	label var cond_contribution_`z' "Part III conditional contribution (given `z')"
}

label var contribution_iii "Part III: actual contribution"
label var private_account_iii "Part III: # tokens left in private account"
label var conditional_cooperator "Part III: conditional decisions implemented"
label var total_uncond_coop_iii "Part III: total unconditional contributions made by group members"
label var average_uncond_coop_iii "Part III: average unconditional contributions made by group members"
label var group_account_iii "Part II: total final amount in group account"

label var risk_invest "Amount invested in risk task"
label var risk_keep "Amount kept in risk task"
label var risk_payoff "Risk task payoff"
label var risk_success "Whether investment in risk task was successful"
label var risk_qualitative "Whether participant is willing to take risks (1: Not willing; 10: Very willing)"
label var trust_qualitative "Whether participant assumes that people have only the best intentions (1: Not at all; 10: Always)"
label var pr_qualitative "Value of wine bottle to reciprocate nice behaviour of others"
label var nr_qualitative "Whether participant is willing to punish unfair behavior (1: Not willing; 10: Very willing)"

label var year_birth "Year of birth"
label var female "Female"
label var study_field "Field of study"
label var study_lvl "Year level of study"
label var gpa "Average GPA"
label var nationality "Nationality"
label var other_nationality "Nationality (other)"
label var country_born "Country born in"
label var other_country_born "Country born in (other)"
label var ethnicity "Ethnicity"
label var years_lived_australia "Years lived in Australia"
label var past_experiments "# past experiments"
label var decisions_clear "Whether instructions regarding decisions participants had to made were clear"
label var earnings_clear "Whether instructions regarding determination of payoffs were clear"
label var comments_unclear "Any specific parts of instructions that were unclear"
label var video_clear "Whether videos regarding two feedback options were useful"
label var compare_written "Instructions formats participants prefer (1=Video,2=Written, 3=Indifferent)"
label var video_comments "Any specific parts of the videos that could be improved"
label var vote_feedback "Whether participant remembered the feedback option they voted for"
label var vote_feedback_explain "Explanation why participant chose that feedback option"
label var vote_change "Feedback option that participant will choose if they vote again"
label var vote_change_explain "Explanation of their feedback choice if they vote again"
label var feedback_usefulness "Whether participant found feedback in Part II useful"
label var feedback_effect "Whether participant's decisions in Part II were affected by feedback"
label var feedback_effect_explain "Explanation of how participant's decisions in Part II were affected by feedback"
label var partiii_explain "Factors affecting contributions in conditional cooperation task"
label var payoff_task "Part chosen for payment"
label var payoff_final "Final earnings (AUD)"

label var correct_1st_attmp "# comprehension questions correctly answered on the first attempt"