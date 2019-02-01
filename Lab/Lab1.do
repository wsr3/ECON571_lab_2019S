***********************
*Introduction to Stata*
*      2/1/2019       *
***********************


********************************
*0. Typical header of a do-file*
********************************
clear  /*clear memory*/ 
cd C:/Users/wsr/Dropbox/2019S/571/ECON571_lab_2019S  /*change working directory*/
// cd D:/Dropbox/2019S/571/ECON571_lab_2019S
set more off  /*keep scrolling when running do-file*/
log using tutorial, text replace  /*create log file*/
* Must add 'log close' in the end of the do-file



**********************
*1. Comments and Help*
**********************

//comment...

*comment...

/* 
...and 
comment
*/

//help summarize



***************
*2. Calculator*
***************
display "Hello World."
display 2 + 2
display log(2) + log(0.5)



********************
*3. Data management*
********************
** Basic data management
set obs 30
set seed 123
generate ones = 1  /*generate variable by row*/
generate u = rnormal()  /*standard normal*/
generate x = rnormal(2, 2)
generate index = _n  /*convenient way to get indices*/
generate N = _N  /*convenient way to get no. observations*/
replace N = 1 if index < 10 | index > 20
rename N size
drop size  /*delete variable*/
keep u index x  /*only keep these variables*/
generate y = 0.5 * x + u

** Input data
clear
input gpa act
	  2.8 21
	  3.4 24
	  3.0 26
	  3.5 27
	  3.6 29
end

** Macro and loop
local my_varlist gpa act
foreach v of varlist `my_varlist' {
	summarize `v'
}

local colors red blue green
foreach c in `colors' {
	display "`c'"
	}
	
forvalues i = 1/3 {
	display `i'
	}

local i 1
while `i' <= 5 {
    display `i++'
}


** Descriptive statistics
sysuse auto, clear
describe
summarize
summarize price, detail
return list  /* return after summarize*/
scalar mean_price = r(mean)
sum price if foreign == 1
sum price if foreign ~= 1
codebook rep78
list if missing(rep78)
drop if rep78 == .
tabulate foreign
tabulate foreign, sum(mpg)
sort foreign
sort foreign price
corr mpg weight
bysort foreign: corr mpg weight


** More Data manipulation
*** Missing values
generate highprice = 1 if price >= 10000
replace highprice = 0 if highprice == .
// or use mvencode to encode missing values
// mvencode highprice, mv(0)

*** Max, sum, round
egen maxprice = max(price)
egen sumprice = sum(price)
generate gear_ratio1 = round(gear_ratio, 1)

*** Substring
generate make_head = substr(make, 1, 2)
generate make_tail = substr(make, 3, .)

*** Convert string variables
tostring mpg, gen(mpg_str)
destring mpg_str, gen(mpg_num)

*** Append
// 1st dataset
sysuse auto, clear
keep if foreign == 1
save auto_foreign, replace
// 2nd dataset
sysuse auto, clear
keep if foreign == 0
append using auto_foreign
erase auto_foreign.dta  /* delete datafile on disk */

*** Merge
sysuse auto, clear
keep make price
save auto_1, replace

sysuse auto, clear
keep make displacement
merge 1:1 make using auto_1
erase auto_1.dta

*** Reshape
webuse reshape1, clear
drop ue*  /* any variable starts with "ue" */
reshape long inc, i(id) j(year) /*wide to long*/
reshape wide inc, i(id) j(year) /*long to wide*/

*** Creating summarized datasets
webuse college, clear
collapse (mean) mean_gpa = gpa mean_hour = hour (sd) sd_gpa = gpa sd_hour = hour, by(year)
list



**********
*4. Graph*
**********
sysuse auto, clear
twoway scatter mpg weight
twoway scatter mpg weight, by(foreign)
generate log_price = log(price)
twoway histogram log_price


log close





/*
RESOURCES:
https://stats.idre.ucla.edu/stata/modules/
http://www.cpc.unc.edu/research/tools/data_analysis/statatutorial
*/


/*
PRACTICE
1. Load the "auto" dataset. Keep the variables: "make", "price", "mpg", "rep78".
2. Drop the observations with missing values in "rep78".
3. Keep only the first three letters of the "make" variable, and keep only cars made by "AMC", "Buick" and "Chev".
4. Generate a dummy variable indicating "highmpg", at the cut-off of mean mpg.
5. Summarize and plot the histograms of the prices by highmpg.
*/
