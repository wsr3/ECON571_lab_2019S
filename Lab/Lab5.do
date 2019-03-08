clear all
set more off
cd C:/Users/wsr/Dropbox/2019S/571/ECON571_lab_2019S/Lab
//cd D:/Dropbox/2019S/571/ECON571_lab_2019S/Lab
log using logs/Lab6, text replace
use data/kielmc

* Data description here
* http://fmwww.bc.edu/ec-p/data/wooldridge/kielmc.des
keep if year == 1981 /*Only keep 1981*/

* Run the full model
reg lprice c.ldist##c.ldist c.age##c.age larea baths c.lintst##c.lintst ///
	wind c.dist#c.wind

* Jointly test the four variables that appear to be insignificant 
* Check -help fvvarlist- for more about variable prefix
testparm c.lintst##c.lintst wind c.dist#c.wind

log close
