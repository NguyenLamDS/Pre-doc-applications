*****************
** Milestones, and Endogenous Feedback in Promoting Cooperation **
** Authors: Nguyen Lam **
*****************

*****************
** Descriptions **
This folder contains coding sample file(s) submitted to support my applications for pre-doctoral programs in Economics.
These files were used to clean and analyse data for my Honours thesis at the University of Melbourne.
*****************

*****************
** Compositions **
There are 5 files in total:
 - cl-extract.do and extract-main.py: they are used to extract raw data from CSV format into DTA files.
	They need to run only once, at the beginning of the analysis stage.
	I used Stata and integrated Python to extract variables of interest.
 - cl-clean.do: this file is used to clean the raw data.
	The output will be cleaned datasets ready for analysis.
 - cl-label.do: this file is used to label variables.
	It is run internally in cl-clean.do.
 - an-paper.do: this file contains codes to reproduce all graphs and statistical analyses presented in my thesis.
*****************

*****************
** Execution **
Execute the files in the following order: 
	--> cl-extract.do (run only once)
	--> cl-clean.do (run only once)
	--> an-paper.do
*****************

*****************
** Note **
You may not be able to run those files succesfully since they require data as inputs.
However, I am not allowed to share the data yet since the project is still in progress.
*****************


