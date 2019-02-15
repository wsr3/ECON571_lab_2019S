clear all
set more off
//cd C:/Users/wsr/Dropbox/2019S/571/ECON571_lab_2019S
cd D:/Dropbox/2019S/571/ECON571_lab_2019S/Lab
log using logs/Lab3, text replace

* Load data
use data/housing.dta

* Generate log transformed variables
gen lprice = log(price)
gen llotsize = log(lotsize)

* Label variables 
label var lprice "log(price)"

* Run regression
regress lprice llotsize bedrooms bathrms recroom fullbase airco prefarea stories



* Output summary and regression tables with -estout- package
* Install the package online
//ssc install estout, replace
eststo clear /*clear stored output*/
estpost summarize lprice llotsize bedrooms bathrms recroom fullbase airco ///
	prefarea stories
* Use -esttab- to generate tables
* Remember to close the file before writing it
esttab using results/lab3.rtf, title(Summary statistics) ///
	cells("mean(fmt(2)) sd(fmt(2))") replace label
	
* Use prefix -eststo:- to store results in memory
eststo clear /*clear stored output*/
eststo: quietly regress lprice llotsize bedrooms bathrms recroom fullbase ///
	airco prefarea stories
eststo: quietly regress lprice llotsize bedrooms bathrms recroom fullbase 
esttab using results/lab3.rtf, star(* 0.1 ** 0.05 *** 0.01) ///
	title(Regression results) replace label append 
	
log close
