clear all
set more off
cd C:/Users/wsr/Dropbox/2019S/571/ECON571_lab_2019S/Lab
// cd D:/Dropbox/2019S/571/ECON571_lab_2019S/Lab
use data/mathpnl

* Ignoring the fixed effects
reg math4 y93 y94 y95 y96 y97 y98 lrexpp lenrol lunch

* Fit the differenced model
xtset distid year /*declare panel data*/
gen d_math4 = math4 - l.math4
gen d_lrexpp = lrexpp - l.lrexpp
gen d_lenrol = lenrol - l.lenrol
gen d_lunch = lunch - l.lunch
reg d_math4 y94 y95 y96 y97 y98 d_lrexpp d_lenrol d_lunch /*y93 is dropped*/
