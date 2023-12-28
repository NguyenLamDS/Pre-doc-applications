********************************************************************************
********************************************************************************
** Milestones and Endogenous Feedback in Promoting Cooperation
** Authors: Nguyen Lam
** Supervisors: Nisvan Erkal, Boon Han Koh
********************************************************************************
********************************************************************************
/*
Description:
File contains all the analysis that are presented in the thesis.
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

cap mkdir "Graphs/paper"
cap mkdir "Tables/paper"
cap mkdir "Logs/paper"



********************************************************************************
** Team contribution in part I **
** Total team contributions at the end of sequence, by treatment in part II **
********************************************************************************

use "Data/cleaned-panel-main", clear
keep if part == 1
keep if round == 6
duplicates drop GroupID, force

gen treat2 = 1 if endo_feedback
replace treat2 = 2 if  exo_time
replace treat2 = 3 if exo_milestone

gen lb = .
gen ub = .
foreach i of numlist 1/3 {
	ci mean group_cont_accum if treat2 == `i'
	replace lb = r(lb) if treat2 == `i'
	replace ub = r(ub) if treat2 == `i'
}

collapse (mean) group_cont_accum lb ub, by(treat2)

gen group = treat2*2 - 1


twoway (bar group_cont_accum group, color(gs9)) ///
		(rcap ub lb group, color(black)) ///
		, ///
		xscale(range(0 6.25)) yscale(range(0 60)) ///
		xtitle(" ") xlabel(1 "Endo" 3 "Exo-T" 5 "Exo-M", noticks labsize(medium)) ///
		ytitle("Accumulated Team Contributions", size(medsmall)) ylabel(0(20)60, labsize(medium) angle(horizontal)) ///
		legend(off) ///
		graphregion(color(white)) bgcolor(white)
graph export "Graphs/paper/cont_parti_end.png", replace
window manage close graph _all
	

		
********************************************************************************
** Team contribution in part I **
** Team contributions in each round, by treatment in part II **
********************************************************************************

use "Data/cleaned-panel-main", clear
keep if part == 1
duplicates drop GroupID round, force


gen ub = .
gen lb = .
gen treat2 = 1 if endo_feedback
replace treat2 = 2 if  exo_time
replace treat2 = 3 if exo_milestone

foreach treat of numlist 1/3 {
	foreach x of numlist 1/6 {
		ci mean group_cont if round == `x' & treat2 == `treat'
		replace lb = r(lb) if round == `x' & treat2 == `treat'
		replace ub = r(ub) if round == `x' & treat2 == `treat'
	}
}
collapse (mean) group_cont lb ub, by(round treat2)


twoway (connected group_cont round if treat == 1, color(gs3) msymbol(circle) lpattern(solid)) ///
		(connected group_cont round if treat == 2, color(gs3) msymbol(Dh) lpattern(longdash)) ///
		(connected group_cont round if treat == 3, color(gs3) msymbol(Th) lpattern(dash_dot)) ///
		, ///
		xscale(range(1 6)) yscale(range(0 20)) ///
		xtitle("Round", size(medsmall)) xlabel(1(1)6, labsize(medium)) ///
		ytitle("Average Team Contributions", size(medsmall)) ylabel(0(5)20, labsize(medium) angle(horizontal)) ///
		legend(order(1 "Endo" 2 "Exo-T" 3 "Exo-M") row(1)) ///
		graphregion(color(white)) bgcolor(white)
graph export "Graphs/paper/cont_parti_by_round.png", replace
window manage close graph _all



********************************************************************************
** Feedback Preference **
********************************************************************************

// Overall
use "Data/cleaned-main", clear

ci proportion choose_time
gen lb_t = r(lb)
gen ub_t = r(ub)
ci proportion choose_milestone
gen lb_m = r(lb)
gen ub_m = r(ub)

collapse (mean) choose_time choose_milestone lb* ub*
gen group_t = 1
gen group_m = 3

twoway (bar choose_time group_t, color(gs7)) ///
		(bar choose_milestone group_m, color(gs10)) ///
		(rcap ub_t lb_t group_t, lcolor(black)) ///
		(rcap ub_m lb_m group_m, lcolor(black)) ///
		, ///
		xscale(range(0 4)) yscale(range(0 1)) ///
		xtitle(" ") xlabel(1 "Time-based" 3 "Milestone", noticks labsize(medlarge)) ///
		ytitle("% subjects") ylabel(0(0.2)1, labsize(medlarge) angle(horizontal)) ///
		legend(off) ///
		graphregion(color(white)) bgcolor(white)
graph export "Graphs/paper/feedback_choice.png", replace
window manage close graph _all


// By types
use "Data/cleaned-main", clear

gen lb_t = .
gen ub_t = .
gen lb_m = .
gen ub_m = .

foreach x of numlist 1/3 {
	ci proportion choose_time if cond_type == `x'
	replace lb_t = r(lb) if cond_type == `x'
	replace ub_t = r(ub) if cond_type == `x'
	ci proportion choose_milestone if cond_type == `x'
	replace lb_m = r(lb) if cond_type == `x'
	replace ub_m = r(ub) if cond_type == `x'
}

collapse (mean) choose_time choose_milestone lb* ub*, by(cond_type)
gen group_t = 1 + (cond_type-1)*3
gen group_m = 2 + (cond_type-1)*3

twoway (bar choose_time group_t, fcolor(gs7) lcolor(gs7)) ///
		(bar choose_milestone group_m, fcolor(gs10) lcolor(gs10)) ///
		(rcap ub_t lb_t group_t, lcolor(black)) ///
		(rcap ub_m lb_m group_m, lcolor(black)) ///
		, ///
		xscale(range(0 9)) yscale(range(0 1)) ///
		xtitle(" ") xlabel(1.5 "Conditional Cooperators" 4.5 "Self-interested" 7.5 "Other", noticks labsize(medsmall)) ///
		ytitle("% subjects") ylabel(0(0.2)1, labsize(medium) angle(horizontal)) ///
		legend(order(1 "Time-based" 2 "Milestone")) ///
		graphregion(color(white)) bgcolor(white)
graph export "Graphs/paper/feedback_choice_bytype.png", replace
window manage close graph _all



********************************************************************************
** Feedback preference **
** Correlation with outcome of Part II **
********************************************************************************

// Correlation with other members' contributions in part II.
use "Data/cleaned-main", clear
gen change_dummy = vote_change != chosen_feedback

graph twoway (scatter group_cont_accum_post_vt_6 change_dummy if chosen_feedback == 1, msymbol(circle) mfcolor(none) mlcolor(red%80) msize(medlarge)) ///
		(scatter group_cont_accum_post_vt_6 change_dummy if chosen_feedback == 2, msymbol(diamond) mcolor(gs5%60) msize(medlarge)) ///
		, ///
		xscale(range(-0.5 1.5)) yscale(range(0 80)) ///
		xtitle("") xlabel(0 "Same feedback" 1 "Different feedback", noticks labsize(medium)) ///
		ytitle("Accumulated team contributions", size(medsmall)) ylabel(0(20)80, labsize(medium) angle(horizontal)) ///
		legend(order(- "Initial vote:" 1 "Time-based" 2 "Milestone") row(1)) ///
		graphregion(color(white)) bgcolor(white)
graph export "Graphs/paper/vote_change_vs_accum_team_cont.png", replace
window manage close graph _all



********************************************************************************
** Team contribution in part II **
** Total team contributions, by treatments: Endo vs Exo-T and Exo-M from EKL **
********************************************************************************
use "Data/cleaned-panel-main", clear
keep if part == 2
keep if round == 6
keep if endo_feedback == 1
duplicates drop GroupID, force

ci mean group_cont_accum
gen lb = r(lb)
gen ub = r(ub)
collapse (mean) group_cont_accum lb ub (count) n_group = group_cont_accum

tempfile temp
save `temp'

use "Data/milestone-project-panel", clear
keep if sequence == 1
keep if round == 6
keep if treat_time | (treat_milestone & treat_interval == 15) //Keep T and M15 treatments
duplicates drop GroupID, force

gen lb = .
gen ub = .
foreach x of numlist 1/4 {
	ci mean group_contribution_accum if treatment == `x'
	replace lb = r(lb) if treatment == `x'
	replace ub = r(ub) if treatment == `x'
}
collapse (mean) group_contribution_accum lb ub, by(treatment)
rename group_contribution_accum group_cont_accum

append using `temp'
replace treatment = 0 if treatment == .

gen group = 1 if treatment == 0  	//Endogenous
replace group = 3 if treatment == 1 	//T
replace group = 5 if treatment == 2		//M15


twoway (bar group_cont_accum group, color(gs9)) ///
		(rcap lb ub group, color(black)) ///
		, ///
		xscale(range(0 6)) yscale(range(0 60)) ///
		xtitle(" ") xlabel(1 "Endo" 3 "Exo-T" 5 "Exo-M", noticks labsize(medsmall)) ///
		ytitle("Accumulated Team Contributions", size(medsmall)) ylabel(0(15)60, labsize(medium) angle(horizontal)) ///
		legend(off) ///
		graphregion(color(white)) bgcolor(white)
graph export "Graphs/paper/cont_partii_endo_vs_exoEKL.png", replace
window manage close graph _all


********************************************************************************
** Team contribution in part II **
** Team contributions in each round, by treatment: Endo vs Exo-T and Exo-M from EKL **
********************************************************************************
use "Data/cleaned-panel-main", clear
keep if part == 2
keep if endo_feedback
gen treat = 1
duplicates drop GroupID round, force


tempfile temp
save `temp'

use "Data/milestone-project-panel", clear
keep if sequence == 1
keep if treat_time | (treat_milestone & treat_interval == 15) //Keep T and M15 treatments
duplicates drop GroupID round, force

rename group_contribution group_cont 
gen treat = 2 if treat_time 
replace treat = 3 if treat_milestone 

append using `temp', force

gen ub = .
gen lb = .
foreach x of numlist 1/6 {
	foreach y of numlist 1/6 {
		ci mean group_cont if treat == `x' & round == `y'
		replace lb = r(lb) if treat == `x' & round == `y'
		replace ub = r(ub) if treat == `x' & round == `y'
	}
}

collapse (mean) group_cont lb ub (count) n_group = group_cont, by(treat round)


twoway (connected group_cont round if treat == 1, color(gs3) msymbol(O) lpattern(solid)) ///
		(connected group_cont round if treat == 2, color(gs3) msymbol(Dh) lpattern(longdash)) ///
		(connected group_cont round if treat == 3, color(gs3) msymbol(Sh) lpattern(dash_dot)) ///
		, ///
		xscale(range(1 6)) yscale(range(0 20)) ///
		xtitle("Round", size(medsmall)) xlabel(1(1)6, labsize(medium)) ///
		ytitle("Average Team Contributions", size(medsmall)) ylabel(0(5)20, labsize(medium) angle(horizontal)) ///
		legend(order(1 "Endo" 2 "Exo-T" 3 "Exo-M") row(1)) ///
		graphregion(color(white)) bgcolor(white)
graph export "Graphs/paper/cont_partii_by_round_EndovsExo.png", replace
window manage close graph _all


********************************************************************************
********************************************************************************
********************************************************************************
** Regression Analysis **
********************************************************************************
********************************************************************************
********************************************************************************


********************************************************************************
** Part I contributions by treatments in Part II. **
********************************************************************************

// Total team contributions
use "Data/cleaned-panel-main", clear
keep if part == 1
keep if round == 6
duplicates drop GroupID, force

gen treat2 = 1 if endo_feedback
replace treat2 = 2 if  exo_time
replace treat2 = 3 if exo_milestone

reg group_cont_accum i.treat2 if treat2 == 1 | treat2 == 2, vce(robust)  //Endo vs Exo-T
reg group_cont_accum i.treat2 if treat2 == 1 | treat2 == 3, vce(robust)	//Endo vs Exo-M
reg group_cont_accum i.treat2 if treat2 == 2 | treat2 == 3, vce(robust)	//Exo-T vs Exo-M

ranksum group_cont_accum if treat2 == 1 | treat2 == 2, by(treat2)
ranksum group_cont_accum if treat2 == 1 | treat2 == 3, by(treat2)
ranksum group_cont_accum if treat2 == 2 | treat2 == 3, by(treat2)


********************************************************************************
** Feedback Preferences **
********************************************************************************

// All participants: binomial probability test
use "Data/cleaned-main", clear
bitest choose_time == 0.5, detail

// Feedback choice by type - Fisher exact test
tab chosen_feedback cond_type, exact


********************************************************************************
** Feedback Preferences **
** Individual chracteristics **
********************************************************************************
use "Data/cleaned-main", clear

foreach x of varlist risk_invest risk_invest_perc risk_qualitative trust_qualitative pr_qualitative nr_qualitative {
	egen `x'_std = std(`x')
	order `x'_std, after(`x')
}

replace female = . if female < 0

// Label those who are serious in making decision.
gen serious = 1 if preference_scale < 3 & choose_time == 1
replace serious = 1 if preference_scale > 3 & choose_milestone == 1
replace serious = 0 if serious == .

//LPM 
reg choose_milestone risk_invest_perc risk_qualitative_std trust_qualitative_std pr_qualitative_std nr_qualitative_std i.cond_cooperator i.free_rider i.economics age i.female if female >= 0, vce(robust)
outreg2 using "Tables\paper\fb_preferences", ///
	label alpha(0.01, 0.05, 0.1) dec(3)  ///
	addtext("Exclude inconsistent votes", "No") ///
	ctitle("LPM") ///
	title("Feedback preference") ///
	replace excel 

reg choose_milestone risk_invest_perc risk_qualitative_std trust_qualitative_std pr_qualitative_std nr_qualitative_std i.cond_cooperator i.free_rider i.economics age i.female if serious == 1 & female >= 0, vce(robust)
outreg2 using "Tables\paper\fb_preferences", ///
	label alpha(0.01, 0.05, 0.1) dec(3)  ///
	addtext("Exclude inconsistent votes", "Yes") ///
	ctitle("LPM") ///
	title("Feedback preference") ///
	append excel 

// Probit model
probit choose_milestone risk_invest_perc risk_qualitative_std trust_qualitative_std pr_qualitative_std nr_qualitative_std i.cond_cooperator i.free_rider i.economics age i.female if female >= 0, vce(robust)
margins, dydx(*) post
outreg2 using "Tables\paper\fb_preferences", ///
	label alpha(0.01, 0.05, 0.1) dec(3)  ///
	addtext("Exclude inconsistent votes", "No") ///
	ctitle("Probit") ///
	title("Feedback preference") ///
	append excel 
	
probit choose_milestone risk_invest_perc risk_qualitative_std trust_qualitative_std pr_qualitative_std nr_qualitative_std i.cond_cooperator i.free_rider i.economics age i.female if serious == 1 & female >= 0, vce(robust)
margins, dydx(*) post
outreg2 using "Tables\paper\fb_preferences", ///
	label alpha(0.01, 0.05, 0.1) dec(3)  ///
	addtext("Exclude inconsistent votes", "Yes") ///
	ctitle("Probit") ///
	title("Feedback preference") ///
	append excel 

	
********************************************************************************
** Feedback Preferences **
** Correlation with the outcome of Part II **
********************************************************************************
// Difference in mean

use "Data/cleaned-main", clear
gen change_dummy = vote_change != chosen_feedback
sum group_cont_accum_post_vt_6 if change_dummy == 0
sum group_cont_accum_post_vt_6 if change_dummy == 1

// Probit model
// Label those who are serious in making decision.
gen serious = 1 if preference_scale < 3 & choose_time == 1
replace serious = 1 if preference_scale > 3 & choose_milestone == 1
replace serious = 0 if serious == .

probit change_dummy group_cont_accum_post_vt_6, vce(robust)
margins, dydx(*)
probit change_dummy group_cont_accum_post_vt_6 if serious == 1, vce(robust)
margins, dydx(*)


********************************************************************************
** Part II: Total team contribution, Endo vs Exo-T vs Exo-M **
********************************************************************************

** Summary Table **
use "Data/cleaned-panel-main", clear
keep if part == 2
keep if round == 6
duplicates drop GroupID, force

gen lb = .
gen ub = .
foreach x of numlist 1/6 {
	ci mean group_cont_accum if treatment == `x'
	replace lb = r(lb) if treatment == `x'
	replace ub = r(ub) if treatment == `x'
}
collapse (mean) group_cont_accum lb ub (sd) sd_cont = group_cont_accum (count) n_group = group_cont_accum, by(treatment)
list


** t-test **
use "Data/cleaned-panel-main", clear
keep if part == 2
keep if round == 6
duplicates drop GroupID, force

reg group_cont_accum i.treatment if treatment == 1 | treatment == 2, vce(robust) //T-Endo-T vs T-Exo-T
reg group_cont_accum i.treatment if treatment == 1 | treatment == 3, vce(robust) //T-Endo-T vs T-Exo-M
reg group_cont_accum i.treatment if treatment == 2 | treatment == 3, vce(robust) //T-Exo-T vs T-Exo-M


********************************************************************************
** Part II: Total team contribution, Endo vs Exo-T vs Exo-M **
** Exogenous treatments are from EKL **
********************************************************************************
// Combine data
use "Data/cleaned-panel-main", clear
keep if part == 2
keep if round == 6
keep if endo_feedback 
duplicates drop GroupID, force
gen treat = 1 if endo_feedback
keep group_cont_accum treat 

tempfile temp
save `temp'

use "Data/milestone-project-panel", clear
keep if sequence == 1
keep if round == 6
keep if treat_time | (treat_milestone & treat_interval == 15) //Keep T and M15 treatments
duplicates drop GroupID, force

gen treat = 2 if treat_time 
replace treat = 3 if treat_milestone 
rename group_contribution_accum group_cont_accum
keep group_cont_accum treat

append using `temp'
label define treat_lbl 1 "Endo" 2 "Exo-T-ekl" 3 "Exo-M-ekl"
label val treat treat_lbl

//t-test
reg group_cont_accum i.treat if treat == 1 | treat == 2, vce(robust) //Endo vs Exo-T-ekl
reg group_cont_accum i.treat if treat == 1 | treat == 3, vce(robust) //Endo vs Exo-M-ekl
reg group_cont_accum i.treat if treat == 2 | treat == 3, vce(robust) //Exo-T-ekl vs Exo-M-ekl
ranksum group_cont_accum if treat == 1 | treat == 2, by(treat) exact
ranksum group_cont_accum if treat == 1 | treat == 3, by(treat) exact
ranksum group_cont_accum if treat == 2 | treat == 3, by(treat) exact


********************************************************************************
** Part II: Team contribution in each round, Endo vs Exo-T vs Exo-M **
** Exogenous treatments are from EKL **
********************************************************************************
// Combine data
use "Data/cleaned-panel-main", clear
keep if part == 2
keep if endo_feedback
gen treat = 1 if endo_feedback
collapse group_cont treat, by(GroupID round)

tempfile temp
save `temp'

use "Data/milestone-project-panel", clear
do "2-doFiles/an-fb-prediction"
keep if sequence == 1
keep if treat_time | (treat_milestone & treat_interval == 15) //Keep T and M15 treatments

gen treat = 2 if treat_time 
replace treat = 3 if treat_milestone 
rename group_contribution group_cont
collapse group_cont treat, by(GroupID round)

append using `temp', gen(temp)
label define treat_lbl 1 "Endo" 2 "Exo-T-ekl" 3 "Exo-M-ekl"
label val treat treat_lbl
egen GroupID2 = group(GroupID temp)

//Regression analysis
foreach t of numlist 1/6 {
	dis in red "Endo vs Exo-T - round `t'"
	reg group_cont i.treat if (treat == 1| treat == 2) & round == `t', vce(robust) // Endo vs Exo-T-ekl
	dis in red "Endo vs Exo-M - round `t'"
	reg group_cont i.treat if (treat == 1| treat == 3) & round == `t', vce(robust) // Endo vs Exo-M-ekl
	dis in red "Exo-T vs Exo-M - round `t'"
	reg group_cont i.treat if (treat == 2| treat == 3) & round == `t', vce(robust) // Exo-T-ekl vs Exo-M-ekl
}


********************************************************************************
** Part II: Contribution in each treatment branch + team preference**
** Summary Table, EKL data, predicting team preference **
********************************************************************************
use "Data/cleaned-panel-main", clear
keep if part == 2
keep if round == 6
keep if endo_feedback
duplicates drop GroupID, force

gen lb = .
gen ub = .
foreach x of numlist 1/6 {
	ci mean group_cont_accum if treatment == `x'
	replace lb = r(lb) if treatment == `x'
	replace ub = r(ub) if treatment == `x'
}
collapse (mean) group_cont_accum lb ub (sd) sd_cont = group_cont_accum (count) n_group = group_cont_accum, by(treatment)

tempfile temp
save `temp'

use "Data/milestone-project-panel", clear
do "2-doFiles/an-fb-prediction"
keep if sequence == 1
keep if round == 6
keep if treat_time | (treat_milestone & treat_interval == 15) //Keep T and M15 treatments
duplicates drop GroupID, force
replace treatment =  2 if team_choose_time & treat_time
replace treatment =  3 if team_choose_time & treat_milestone
replace treatment =  5 if team_choose_milestone & treat_time
replace treatment =  6 if team_choose_milestone & treat_milestone
rename group_contribution_accum group_cont_accum

gen lb = .
gen ub = .
foreach x of numlist 1/6 {
	ci mean group_cont_accum if treatment == `x'
	replace lb = r(lb) if treatment == `x'
	replace ub = r(ub) if treatment == `x'
}

collapse (mean) group_cont_accum lb ub (sd) sd_cont = group_cont_accum (count) n_group = group_cont_accum, by(treatment)

append using `temp'
label define treatment_lbl 1 "T_Endo_T" 2 "T_Exo_T" 3 "T_Exo_M" 4 "M_Endo_M" 5 "M_Exo_T" 6 "M_Exo_M", replace
label val treatment treatment_lbl
sort treatment
list

					********************************************************************************
** Decomposition: Feedback effect, democracy effect and randomization error **
** Endo vs Exo-M from the EKL **
********************************************************************************
use "Data/cleaned-panel-main", clear
keep if part == 2
keep if round == 6
keep if endo_feedback == 1 //Keep endogenous feedback only
gen treat = 1 if endo_time
replace treat = 4 if endo_milestone
duplicates drop GroupID, force

keep group_cont_accum treat

tempfile temp
save `temp'

use "Data/milestone-project-panel", clear
do "2-doFiles/an-fb-prediction"
keep if sequence == 1
keep if round == 6
keep if treat_time | (treat_milestone & treat_interval == 15) //Keep T and M15 treatments
bysort GroupID: egen num_free_riders = total(free_rider)
bysort GroupID: egen num_cond_cooperator = total(cond_cooperator)
duplicates drop GroupID, force

gen treat = 2 if team_choose_time & treat_time
replace treat = 3 if team_choose_time & treat_milestone
replace treat = 5 if team_choose_milestone & treat_time
replace treat = 6 if team_choose_milestone & treat_milestone

rename group_contribution_accum group_cont_accum
keep group_cont_accum treat


append using `temp'
label define treat_lbl 1 "T_Endo_T" 2 "T_Exo_T" 3 "T_Exo_M" 4 "M_Endo_M" 5 "M_Exo_T" 6 "M_Exo_M"
label val treat treat_lbl

foreach x of numlist 1/6 {
	if `x' == 1 {
		local lb "T_Endo_T"
	}
	if `x' == 2 {
		local lb "T_Exo_T"
	}
	if `x' == 3 {
		local lb "T_Exo_M"
	}
	if `x' == 4 {
		local lb "M_Endo_M"
	}
	if `x' == 5 {
		local lb "M_Exo_T"
	}
	if `x' == 6 {
		local lb "M_Exo_M"
	}
	dis "`lb'"
	sum group_cont_accum if treat == `x'
	return list
	scalar c_`lb' =  r(mean)
	scalar n_`lb' =  r(N)
}

scalar g_T_Endo = n_T_Endo_T/(n_T_Endo_T + n_M_Endo_M)
scalar g_M_Endo = n_M_Endo_M/(n_T_Endo_T + n_M_Endo_M)
scalar g_T_Exo_M = n_T_Exo_M/(n_T_Exo_M + n_M_Exo_M)
scalar g_M_Exo_M = n_M_Exo_M/(n_T_Exo_M + n_M_Exo_M)

scalar total_effect = g_T_Endo*c_T_Endo_T + g_M_Endo*c_M_Endo_M ///
					- g_T_Exo_M*c_T_Exo_M - g_M_Exo_M*c_M_Exo_M
scalar randomization_error = (g_T_Endo - g_T_Exo_M)*c_T_Endo_T ///
							+ (g_M_Endo - g_M_Exo_M)*c_M_Endo_M
scalar feedback_effect = g_T_Exo_M*(c_T_Exo_T - c_T_Exo_M) 
scalar democracy_effect = g_T_Exo_M*(c_T_Endo_T - c_T_Exo_T) ///
							+ g_M_Exo_M*(c_M_Endo_M - c_M_Exo_M)
scalar list _all		


********************************************************************************
** Decomposition: Feedback effect, democracy effect and randomization error **
** Endo vs Exo-M from the current study **
********************************************************************************
use "Data/cleaned-panel-main", clear
keep if part == 2
keep if round == 6
duplicates drop GroupID, force

foreach x of numlist 1/6 {
	if `x' == 1 {
		local lb "T_Endo_T"
	}
	if `x' == 2 {
		local lb "T_Exo_T"
	}
	if `x' == 3 {
		local lb "T_Exo_M"
	}
	if `x' == 4 {
		local lb "M_Endo_M"
	}
	if `x' == 5 {
		local lb "M_Exo_T"
	}
	if `x' == 6 {
		local lb "M_Exo_M"
	}
	dis "`lb'"
	sum group_cont_accum if treatment == `x'
	return list
	scalar c_`lb' =  r(mean)
	scalar n_`lb' =  r(N)
}

scalar g_T_Endo = n_T_Endo_T/(n_T_Endo_T + n_M_Endo_M)
scalar g_M_Endo = n_M_Endo_M/(n_T_Endo_T + n_M_Endo_M)
scalar g_T_Exo_M = n_T_Exo_M/(n_T_Exo_M + n_M_Exo_M)
scalar g_M_Exo_M = n_M_Exo_M/(n_T_Exo_M + n_M_Exo_M)

scalar total_effect = g_T_Endo*c_T_Endo_T + g_M_Endo*c_M_Endo_M ///
					- g_T_Exo_M*c_T_Exo_M - g_M_Exo_M*c_M_Exo_M
scalar randomization_error = (g_T_Endo - g_T_Exo_M)*c_T_Endo_T ///
							+ (g_M_Endo - g_M_Exo_M)*c_M_Endo_M
scalar feedback_effect = g_T_Exo_M*(c_T_Exo_T - c_T_Exo_M) 
scalar democracy_effect = g_T_Exo_M*(c_T_Endo_T - c_T_Exo_T) ///
							+ g_M_Exo_M*(c_M_Endo_M - c_M_Exo_M)
scalar list _all



