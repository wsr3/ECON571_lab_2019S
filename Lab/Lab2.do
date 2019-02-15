clear all
set more off
cd C:/Users/wsr/Dropbox/2019S/571/ECON571_lab_2019S/Lab
log using logs/Lab2, text replace


* Input data
input gpa  act
	  2.8  21
	  3.4  24
	  3.0  26
   	  3.5  27
	  3.6  29
	  3.0  25
	  2.7  25
	  3.7  30
end
gen student = _n


* Regression
regress act gpa


* Get coefficients and standard errors
ereturn list
scalar b_gpa = _b[gpa]
scalar se_gpa = _se[gpa]
display "The coefficient of GPA is " b_gpa
display "The s.e. of GPA is " se_gpa


* Prediction
set obs 10
quietly summarize gpa
replace gpa = r(mean) in 9
replace gpa = 3 in 10
*help predict
*option stdf for individual prediction error
*option stdp for mean pred error

* Get critical t value
gen t = invttail(6, 0.025) in 9/10

log close
