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
Over identified with valid IVs
y = 3*x + u
x = 0.5*z1 + 0.5*z2 + 0.2*u + error
*/
clear all
set obs 10000
gen u = rnormal()
gen z1 = rnormal()
gen z2 = rnormal()
gen x = 0.5*z1 + 0.5*z2 + 0.2*u + rnormal()
gen y = 3*x + u
reg y x
ivregress 2sls y (x = z1 z2)
estat firststage
estat endogenous
estat overid


/*
Over identified with one invalid IV
y = 3*x + u
x = 0.5*z1 + 0.5*z2 + 0.2*u + error
z2 = 0.1*u + error
*/
clear all
set obs 10000
gen u = rnormal()
gen z1 = rnormal()
gen z2 = 0.1*u + rnormal()
gen x = 0.5*z1 + 0.5*z2 + 0.2*u + rnormal()
gen y = 3*x + u
reg y x
ivregress 2sls y (x = z1 z2)
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
