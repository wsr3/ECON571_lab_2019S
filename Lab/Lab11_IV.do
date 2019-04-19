/*
Just identified
y = 3*x + u
x = 0.5*z + 0.2*u + error
*/
clear all
set obs 10000
gen u = rnormal()
gen z = rnormal()
gen x = 0.5*z + 0.2*u + rnormal()
gen y = 3*x + u
reg y x
ivregress 2sls y (x = z)
estat firststage
estat endogenous


/*
Over identified
y = 3*x + u
x = 0.5*z1 + 0.5*z2 + 0.2*u + error
*/
clear all
set obs 10000
gen u = rnormal()
gen z1 = rnormal()
gen z2 = rnormal()
gen z3 = rnormal()
gen x = 0.5*z1 + 0.5*z2 + 0.2*u + rnormal()
gen y = 3*x + u
reg y x
ivregress 2sls y (x = z1 z2 z3)
estat firststage
estat endogenous
estat overid


/*
Weak IV
y = 3*x + u
x = 0.02*z1 + 0.02*z2 + 0.2*u + error
*/
clear all
set obs 10000
gen u = rnormal()
gen z1 = rnormal()
gen z2 = rnormal()
gen x = 0.02*z1 + 0.02*z2 + 0.2*u + rnormal()
gen y = 3*x + u
reg y x
ivregress 2sls y (x = z1 z2)
estat firststage
estat endogenous
estat overid
