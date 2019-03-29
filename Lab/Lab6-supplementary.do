clear all
set more off
cd C:/Users/wsr/Dropbox/2019S/571/ECON571_lab_2019S/Lab
//cd D:/Dropbox/2019S/571/ECON571_lab_2019S/Lab
log using logs/Lab6-supplimentary, text replace

***** Omitted variable bias *****
use data/WAGE1, clear
* Check the correlations
corr lwage female tenure
* Assume the true model is log(wage) = b1 + b2*female + b3*tenure
reg lwage female tenure
scalar b2 = _b[female]
scalar b3 = _b[tenure]
* Omit tenure: log(wage) = a1 + a2*female
reg lwage female
scalar a2 = _b[female]
* Auxiliary model: tenure = c1 + c2*female
reg tenure female
scalar c2 = _b[female]

display "The true b2 is: " b2
display "The estimated b2 that is biased is: " a2
display "The bias of tenure is b3*c2: " b3*c2


***** Near multicolinearity *****
use data/multicoll, clear
corr y x1 x2
reg y x1 x2
* Evidence of near multicolinearity: 
* t stats for x1 and x2 are small but the overall F is large
vif
* As a post-estimation diagnosis, VIF is quite large.



log close
