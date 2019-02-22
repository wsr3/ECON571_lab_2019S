clear all
set more off
cd C:/Users/wsr/Dropbox/2019S/571/ECON571_lab_2019S/Lab
//cd D:/Dropbox/2019S/571/ECON571_lab_2019S/Lab
log using logs/Lab4, text replace

* Load data
/* 
Check for description of the dataset
https://www.wiley.com/legacy/wileychi/verbeek2ed/datasets.html
*/
use data/housing.dta

* Generate log transformed variables
gen lprice = log(price)
gen llotsize = log(lotsize)

* Generate squared variables
gen llotsize2 = llotsize^2

* Generate dummy variables
gen D10 = 1 if stories > 1
replace D10 = 0 if D10 == .

* Generate interaction variables
gen bd_bath = bedrooms * bathrms
gen bd_D10 = bedrooms * D10

* Run the "unrestricted model"
regress lprice llotsize llotsize2 bedrooms bathrms bd_bath bd_D10 ///
	i.recroom i.fullbase i.airco i.prefarea i.D10
* Save R2 and SSE for test
scalar r2_unr = e(r2)
scalar sse_unr = e(rss)

/*
Alternative way to conveniently run the regression with interactions
regress lprice c.llotsize##c.llotsize c.bedrooms##c.bathrms c.bedrooms##i.D10 ///
	i.recroom i.fullbase i.airco i.prefarea
"#" for interaction term, "##" includes original variables and interaction
*/

* Run the "restricted model" ommitting bd_bath and bd_D10
regress lprice llotsize llotsize2 bedrooms bathrms ///
	i.recroom i.fullbase i.airco i.prefarea i.D10
scalar r2_res = e(r2)
scalar sse_res = e(rss)


/*
F = ((R2_unr-R2_res)/q) / ((1-R2_unr)/(n-k))
  = ((SSE_res-SSE_unr)/q) / (SSE_unr/(n-k))
F ~ F_{q, n-k}
Find critical value using -invFtail(q, n-k, p)-

Need to calculate F manually for this homework.
Confirm the result with built-in command -test- 
*/

log close
