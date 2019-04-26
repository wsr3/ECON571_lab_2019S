clear all
set more off
// cd C:/Users/wsr/Dropbox/2019S/571/ECON571_lab_2019S/Lab
cd D:/Dropbox/2019S/571/ECON571_lab_2019S/Lab
use data/consump

tsset year /*declare time series*/

* Equation 1
reg gc gc_1
predict r1, r
gen l_r1 = l.r1
reg r1 l_r1

* Equation 2
reg gc gc_1 gy_1 l.i3 l.inf
predict r2, r
gen l_r2 = l.r2
reg r2 l_r2
