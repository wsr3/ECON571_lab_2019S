clear all
set more off
// cd C:/Users/wsr/Dropbox/2019S/571/ECON571_lab_2019S/Lab
cd D:/Dropbox/2019S/571/ECON571_lab_2019S/Lab
log using logs/Lab8, text replace
use data/loanapp
* http://fmwww.bc.edu/ec-p/data/wooldridge/loanapp.des

* Check for missing values
codebook approve male black hispan atotinc yjob unem hrat married ///
	dep sch chis pubrec mortno vr

eststo clear
* Unrestricted model
probit approve i.male i.black i.hispan atotinc yjob unem hrat i.married ///
	dep i.sch i.chis i.pubrec i.mortno i.vr if ~missing(male black hispan atotinc yjob unem hrat married dep sch chis pubrec mortno vr)
* Marginal effects at the mean
margins, dydx(*) atmeans
* Average marginal effects
margins, dydx(*)

est store unr
scalar ll_unr = e(ll)

* Find 95% critical value
scalar chi2_cv = invchi2tail(5, 0.05)

/* 
Run the restricted model and retrieve log_likelihood to construct
lr = 2 * (loglike_unr - loglike_res).
Compare the results with -lrtest-
Run the restricted model by adding 
-if ~missing(male blac hispan atotinc yjob unem hrat married dep sch chis pubrec mortno vr)-
to make sure the two models use the same observations.
*/


log close
