clear all
set more off
cd C:/Users/wsr/Dropbox/2019S/571/ECON571_lab_2019S/Lab
use data/wage1

* WLS
* Weight is educ
* Generate weighted varaibles
gen w=1/(educ)^0.5
gen wlwage=lwage*w
gen wfemale=female*w
gen weduc=educ*w
gen wexper=exper*w
gen wexpsq=expersq*w 
* Estimate weighted least squares (WLS) model
reg wlwage weduc wfemale wexper wexpsq w, noc 


* FGLS
* Estimate reg
use data/wage1, clear
drop if educ==0
qui reg lwage educ female exper expersq
predict e, residual
gen logesq=ln(e*e)
qui reg logesq educ female exper expersq
predict esqhat
gen omega=exp(esqhat)
* Generate weighted varaibles
gen w=1/(omega)^0.5
gen wlwage=lwage*w
gen wfemale=female*w
gen weduc=educ*w
gen wexper=exper*w
gen wexpsq=expersq*w
* Estimate Feasible GLS (FGLS) model
reg wlwage weduc wfemale wexper wexpsq w, noc
