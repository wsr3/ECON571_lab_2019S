clear all
set more off
cd C:/Users/wsr/Dropbox/2018S/571/Econ571_Lab
log using logs/Lab9, text replace
use data/loanapp
* Check the following description of the dataset
* http://fmwww.bc.edu/ec-p/data/wooldridge/loanapp.des

* Check data
codebook approve black hispan unem hrat married chis pubrec mortno vr

* Probit
probit approve i.black i.hispan unem hrat i.married i.chis i.pubrec i.mortno i.vr
predict yhat_probit

* OLS
reg approve i.black i.hispan unem hrat i.married i.chis i.pubrec i.mortno i.vr
predict yhat_ols

* Correlation
correlate yhat_probit yhat_ols

* Count yhat_ols, excluding missing values.
count if yhat_ols ~= .
count if yhat_ols > 1 & yhat_ols ~= .
count if yhat_ols < 0 & yhat_ols ~= .

* Plot predictions
twoway scatter yhat_ols yhat_probit, xtitle(probit predictions) ytitle(lpm predictions)

log close
