/*			
			Adverse labor market outcomes and hate crimes
			
Instructions: this do file provides a complete list of codes to replicate 
the key tables and figures in this paper. Once you set the correct directory
from where you can access all the raw files, just execute the do file. 
*/


*				 Set the directory and load the raw data 

cd "C:\Users\moonc\Desktop\Social Sciences and Humanities Open (Final)\replication\raw_data"
use "raw-data.dta", clear 		

* Using STATA 16 or higher, please install the following packages:
ssc install ranktest
ssc install xtpmg, replace
ssc install ivreg2
ssc install xtivreg2
ssc install estout 
ssc install xtabond2


						* Compute the key variables 

	gen hate= (totalnumberofincidentsreported/ populationcovered)*100000
	label var hate "The hate crime rate per 100,000"
	
    gen cU= (initial_claims/ population)*100	
	label var cU "The initial unemployment claims rate"

	gen arrests=(police_arrests/ population)					
	label var arrests "Arrests rate per capita"					

	gen adjhate = (hate/.4)	
	label var adjhate "Measurement-error adjusted hate crime rate"
	
	gen mwage= log(minimum_wage)
	label var mwage "Log-level of the minimum wage"

	gen hprice=log(HPINDEX)
	label var hprice "Log-level of the FHFA house price index"
	
	gen density=log(population/area)
	label var density "Log-level population per square miles"
	
	
							* Set up the panel data
							
keep years states U out cU hate adjhate arrests mwage hprice density growth guns						
save "final-data.dta", replace

encode states, gen(sc)	
xtset sc years


/*______________________________________________________________________________
							 I.  Benchmark results 
________________________________________________________________________________
*/

* A.(Unemployment rate) 

xtabond2 hate l1.hate c.U##c.U i.years mwage, gmm(l1.hate, lag(1 2) collapse) gmm(c.U##c.U,lag(2 2) collapse) iv(i.years mwage) r orthogonal small two 
estimates store gmm1 

xtabond2 hate l1.hate c.U##c.U  i.years hprice, gmm(l1.hate, lag(1 1) collapse) gmm(c.U##c.U ,lag(2 2) collapse) iv(i.years hprice) r orthogonal small two 
estimates store gmm2 

xtabond2 hate l1.hate c.U##c.U  i.years arrests if states !="Florida", gmm(l1.hate, lag(1 1) collapse) gmm(c.U##c.U,lag(2 2) collapse) iv(i.years arrests) r orthogonal small two 
estimates store gmm3 
* Note that Florida is not included in this regression, because it did not report arrests until 2017. 
* Note that arrest data for wisconsin is zero in 2000, we treat this as a missing observation.  

xtabond2 hate l1.hate c.U##c.U i.years guns, gmm(l1.hate, lag(1 1) collapse) gmm(c.U##c.U,lag(2 2) collapse) iv(i.years guns) r orthogonal small two
estimates store gmm4 

* B. (Measurement-error adjusted hate crime estimates) 

xtabond2 adjhate l1.adjhate c.U##c.U i.years mwage, gmm(l1.adjhate, lag(1 2) collapse) gmm(c.U##c.U,lag(2 2) collapse) iv(i.years mwage) r orthogonal small two 
estimates store robust1

xtabond2 adjhate l1.adjhate c.U##c.U  i.years hprice, gmm(l1.adjhate, lag(1 1) collapse) gmm(c.U##c.U ,lag(2 2) collapse) iv(i.years hprice) r orthogonal small two 
estimates store robust2 

xtabond2 adjhate l1.adjhate c.U##c.U  i.years arrests if states !="Florida", gmm(l1.adjhate, lag(1 1) collapse) gmm(c.U##c.U,lag(2 2) collapse) iv(i.years arrests) r orthogonal small two 
estimates store robust3
* Note that Florida is not included in this regression, because it did not report arrests until 2017. 
* Note that arrest data for wisconsin is zero in 2000, we treat this as a missing observation.  

xtabond2 adjhate l1.adjhate c.U##c.U i.years guns, gmm(l1.adjhate, lag(1 1) collapse) gmm(c.U##c.U,lag(2 2) collapse) iv(i.years guns) r orthogonal small two
estimates store robust4

********************************************************************************

* B. (Initial unemployment claims rate) 


xtabond2 hate l1.hate c.cU##c.cU i.years mwage, gmm(l1.hate, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years mwage) r orthogonal small two 
estimates store gmm5 

xtabond2 hate l1.hate c.cU##c.cU i.years hprice, gmm(l1.hate, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years hprice) r orthogonal small two 
estimates store gmm6 

xtabond2 hate l1.hate c.cU##c.cU i.years arrests if states !="Florida", gmm(l1.hate, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years arrests) r orthogonal small two 
estimates store gmm7 
* Note that Florida is not included in this regression, because it did not report arrests until 2017. 
* Note that arrest data for wisconsin is zero in 2000, we treat this as a missing observation.  

xtabond2 hate l1.hate c.cU##c.cU i.years guns, gmm(l1.hate, lag(1 2) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years guns) r orthogonal small two
estimates store gmm8 
 
* (Measurement-error adjusted hate crime estimates) 

xtabond2 adjhate l1.adjhate c.cU##c.cU i.years mwage, gmm(l1.adjhate, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years mwage) r orthogonal small two 
estimates store robust5 

xtabond2 adjhate l1.adjhate c.cU##c.cU i.years hprice, gmm(l1.adjhate, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years hprice) r orthogonal small two 
estimates store robust6 

xtabond2 adjhate l1.adjhate c.cU##c.cU i.years arrests if states !="Florida", gmm(l1.adjhate, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years arrests) r orthogonal small two 
estimates store robust7 
* Note that Florida is not included in this regression, because it did not report arrests until 2017. 
* Note that arrest data for wisconsin is zero in 2000, we treat this as a missing observation.  

xtabond2 adjhate l1.adjhate c.cU##c.cU i.years guns, gmm(l1.adjhate, lag(1 2) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years guns) r orthogonal small two
estimates store robust8 
 
********************************************************************************

* C. (% of adults out of labor force) 

xtabond2 hate l1.hate c.out##c.out i.years mwage, gmm(l1.hate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 4) collapse) iv(i.years mwage) r orthogonal small two 
estimates store gmm9

xtabond2 hate l1.hate c.out##c.out i.years hprice, gmm(l1.hate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 5) collapse) iv(i.years hprice) r orthogonal small two 
estimates store gmm10

xtabond2 hate l1.hate c.out##c.out i.years arrests if states !="Florida", gmm(l1.hate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 6) collapse) iv(i.years arrests) r orthogonal small two 
estimates store gmm11
* Note that Florida is not included in this regression, because it did not report arrests until 2017. 
* Note that arrest data for wisconsin is zero in 2000, we treat this as a missing observation.
  
xtabond2 hate l1.hate c.out##c.out i.years guns, gmm(l1.hate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 5) collapse) iv(i.years guns) r orthogonal small two
estimates store gmm12
  
* (Measurement-error adjusted hate crime estimates) 

xtabond2 adjhate l1.adjhate c.out##c.out i.years mwage, gmm(l1.adjhate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 4) collapse) iv(i.years mwage) r orthogonal small two 
estimates store robust9

xtabond2 adjhate l1.adjhate c.out##c.out i.years hprice, gmm(l1.adjhate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 5) collapse) iv(i.years hprice) r orthogonal small two 
estimates store robust10

xtabond2 adjhate l1.adjhate c.out##c.out i.years arrests if states !="Florida" , gmm(l1.adjhate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 6) collapse) iv(i.years arrests) r orthogonal small two 
estimates store robust11
* Note that Florida is not included in this regression, because it did not report arrests until 2017. 
* Note that arrest data for wisconsin is zero in 2000, we treat this as a missing observation.  

xtabond2 adjhate l1.adjhate c.out##c.out i.years guns, gmm(l1.adjhate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 5) collapse) iv(i.years guns) r orthogonal small two
estimates store robust12
  

********************************************************************************
* Table 1

esttab gmm1 gmm2 gmm3 gmm4 gmm5 gmm6 gmm7 gmm8 gmm9 gmm10 gmm11 gmm12 using table1.tex, star(* 0.10 ** 0.05 *** .01)  cells(b(fmt(3) star) ci(fmt(3) par))replace

*Table 2
esttab robust1 robust2 robust3 robust4 robust5 robust6 robust7 robust8 robust9 robust10 robust11 robust12 using table2.tex, star(* 0.10 ** 0.05 *** .01)  cells(b(fmt(3) star) ci(fmt(3) par))replace


/*______________________________________________________________________________
							II. U-shaped test (Table 3)
________________________________________________________________________________
*/

********************************************************************************
* 								A. Unemployment rate
********************************************************************************

* Column (2), Table 1

xtabond2 hate l1.hate c.U##c.U  i.years hprice, gmm(l1.hate, lag(1 1) collapse) gmm(c.U##c.U ,lag(2 2) collapse) iv(i.years hprice) r orthogonal small two 
estimates store gmm7 

*  What is the turning point?
nlcom (U_star: -_b[U]/(2*_b[c.U#c.U]))

* Endpoints
scalar l = 2.07
scalar h = 13.7

********************************************************************************
* Gamma(l): marginal effect evaluated at the lower endpoint

nlcom (Gamma_l: _b[U] + (2)*(l)*_b[c.U#c.U])



* Extracting the coefficient of the marginal effect for the lower endpoint
matrix b = r(b)
scalar Gamma_l = b[1,1]

* Extracting the variance of the marginal effect for the lower endpoint from the covariance-variance matrix
matrix V = r(V)
matrix list V

* Computing the standard error by taking the squared root of the variance 
scalar se_l = sqrt(V[1,1])
display se_l

* Computing the test statistic
scalar Z_l = Gamma_l/se_l
display Z_l

* One-sided test: (cdf for the standard normal distribution)
scalar p_l = normal(Z_l)
display p_l

*******************************************************************************

* Gamma(h): marginal effect evaluated at the upper endpoint

nlcom (Gamma_h: _b[U] + (2)*(h)*_b[c.U#c.U])

* Extracting the coefficient of the marginal effect at the higher endpoint
matrix b = r(b)
scalar Gamma_h = b[1,1]
display Gamma_h 

* Extracting the variance of the marginal effect for the higher endpoint from the covariance-variance matrix
matrix V = r(V)
matrix list V

* Computing the standard error by taking the squared root of the variance 
scalar se_h = sqrt(V[1,1])
display se_h

* Computing the test statistic
scalar Z_h = Gamma_h/se_h

* One-sided test (1- cdf of the standard normal distribution)
scalar p_h = 1 - normal(Z_h)
display p_h

********************************************************************************
* Intersection-union test

scalar ushape = max(p_l, p_h)
display ushape

********************************************************************************
*					 B. Initial Unemployment Claims Rate
********************************************************************************

* Column (6), Table 1

xtabond2 hate l1.hate c.cU##c.cU i.years hprice, gmm(l1.hate, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years hprice) r orthogonal small two 


*  What is the turning point?
nlcom (cU_star: -_b[cU]/(2*_b[c.cU#c.cU]))

* Endpoints

scalar l = 1.36
scalar h = 19.8

* Gamma(l): marginal effect evaluated at the lower endpoint

nlcom (Gamma_l: _b[cU] + (2)*(l)*_b[c.cU#c.cU])
display Gamma_l


* Extracting the coefficient of the marginal effect for the lower endpoint

matrix b = r(b)
scalar Gamma_l = b[1,1]
display Gamma_l 

* Extracting the variance of the marginal effect for the lower endpoint from the covariance-variance matrix
matrix V = r(V)
matrix list V


* Computing the standard error by taking the squared root of the variance 
scalar se_l = sqrt(V[1,1])
display se_l


* Computing the test statistic
scalar Z_l = Gamma_l/se_l
display Z_l


* One-sided test (cumulative standard normal distribution)
scalar p_l = normal(Z_l)
display p_l

*******************************************************************************
* Gamma(h): marginal effect evaluated at the higher endpoint

nlcom (Gamma_h: _b[cU] + (2)*(h)*_b[c.cU#c.cU])


* Extracting the coefficient of the marginal effect for the higher endpoint
matrix b = r(b)
scalar Gamma_h = b[1,1]
display Gamma_h 


* Extracting the variance of the marginal effect for the higher endpoint from the covariance-variance matrix
matrix V = r(V)
matrix list V

* Computing the standard error by taking the squared root of the variance 
scalar se_h = sqrt(V[1,1])
display se_h

* Computing the test statistic
scalar Z_h = Gamma_h/se_h
display Z_h

* One-sided test: (1 - cdf of the standard normal distribution)
scalar p_h = 1 - normal(Z_h)
display p_h

********************************************************************************

* Intersection-union test

scalar ushape = max(p_l, p_h)
display ushape


********************************************************************************
* 					C. Proportion of adults out of the labor force
********************************************************************************
* Column (10), Table 1

xtabond2 hate l1.hate c.out##c.out i.years hprice, gmm(l1.hate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 5) collapse) iv(i.years hprice) r orthogonal small two 
estimates store gmm7 

*  What is the turning point?
nlcom (out_star: -_b[out]/(2*_b[c.out#c.out]))

* Endpoints
scalar l = 24.7
scalar h = 46.70

********************************************************************************
* Gamma(l): marginal effect evaluated at the lower endpoint

nlcom (Gamma_l: _b[out] + (2)*(l)*_b[c.out#c.out])
display Gamma_l


* Extracting the coefficient of the marginal effect at the lower endpoint
matrix b = r(b)
scalar Gamma_l = b[1,1]

* Extracting the variance of the marginal effect of the lower endpoint from the covariance-variance matrix
matrix V = r(V)
matrix list V

* Computing the standard error by taking the squared root of the variance 
scalar se_l = sqrt(V[1,1])
display se_l

* Computing the test statistic
scalar Z_l = Gamma_l/se_l
display Z_l

* One-sided test: (cummalative standard normal distribution)
scalar p_l = normal(Z_l)
display p_l

********************************************************************************
* Gamma(h): marginal effect evaluated at the higher endpoint

nlcom (Gamma_h: _b[out] + (2)*(h)*_b[c.out#c.out])

* Extracting the coefficient of the marginal effect for the higher endpoint
matrix b = r(b)
scalar Gamma_h = b[1,1]
display Gamma_h 

* Extracting the variance of the marginal effect of the higher endpoint from the covariance-variance matrix
matrix V = r(V)
matrix list V

* Computing the standard error by taking the squared root of the variance 
scalar se_h = sqrt(V[1,1])
display se_h  

* Computing the test statistic
scalar Z_h = Gamma_h/se_h
display Z_h 

* One-sided test: (1 - cdf of the standard normal distribution)
scalar p_h = 1 - normal(Z_h)
display p_h

********************************************************************************
* Intersection-union test

scalar ushape = max(p_l, p_h)
display ushape


/*______________________________________________________________________________ 
								III. Bracketing Check 		
							       FE < GMM < OLS
________________________________________________________________________________					
*/

* Panel fixed-effect model
xtreg hate l1.hate mwage c.cU##c.cU i.years, r fe
estimates store bracket1 

* system GMM model 
xtabond2 hate l1.hate c.cU##c.cU i.years mwage, gmm(l1.hate, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years mwage) r orthogonal small two 
estimates store bracket2 

* Pooled OLS model 
reg hate l1.hate mwage c.cU##c.cU i.years, r
estimates store bracket3 

esttab bracket1 bracket2 bracket3 using table4.tex, star(* 0.10 ** 0.05 *** .01)  cells(b(fmt(3) star) ci(fmt(3) par))replace


/*_____________________________________________________________________________ 

			IV.	Panel Fixed Effects 2SLS Estimator (additional robustness)
_______________________________________________________________________________
*/
* Generating quadratic terms 

gen cUsq= cU^2
gen outsq= out^(2)
gen Usq= U^2

* Generate time dummies
tab years, gen(time_) 

xtivreg2 hate l2.hate time_1 time_2 time_3 time_4 time_5 time_6 time_7 time_8 time_9 time_10 time_11 time_12 time_13 time_14 time_15 time_16 time_17 time_18 time_19 time_20 (U Usq = l4.U l4.Usq mwage), r fe first
 estimates store panel1

xtivreg2 hate l2.hate time_1 time_2 time_3 time_4 time_5 time_6 time_7 time_8 time_9 time_10 time_11 time_12 time_13 time_14 time_15 time_16 time_17 time_18 time_19 time_20 (cU cUsq = l5.cU l5.cUsq  mwage), r fe first
 estimates store panel2
 

xtivreg2 hate l2.hate time_1 time_2 time_3 time_4 time_5 time_6 time_7 time_8 time_9 time_10 time_11 time_12 time_13 time_14 time_15 time_16 time_17 time_18 time_19 time_20 (out outsq = l4.out l4.outsq mwage), r fe first
 estimates store panel3

* Table 5

esttab panel1 panel2 panel3 using table5.tex, star(* 0.10 ** 0.05 *** .01)  cells(b(fmt(3) star) ci(fmt(3) par))replace


/*______________________________________________________________________________ 

								V. Robustness check
________________________________________________________________________________
*/

xtabond2 hate l1.hate c.U##c.U i.years mwage growth, gmm(l1.hate growth, lag(1 2) collapse) gmm(c.U##c.U,lag(2 2) collapse) iv(i.years mwage) r orthogonal small two 
estimates store check1

xtabond2 hate l1.hate c.cU##c.cU i.years mwage growth, gmm(l1.hate growth, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years mwage) r orthogonal small two 
estimates store check2

xtabond2 hate l1.hate c.out##c.out i.years mwage growth, gmm(l1.hate growth, lag(1 1) collapse) gmm(c.out##c.out,lag(2 5) collapse) iv(i.years mwage) r orthogonal small two 
estimates store check3

xtabond2 hate l1.hate c.U##c.U i.years mwage density, gmm(l1.hate density, lag(1 2) collapse) gmm(c.U##c.U,lag(2 2) collapse) iv(i.years mwage) r orthogonal small two 
estimates store check4

xtabond2 hate l1.hate c.cU##c.cU i.years mwage density, gmm(l1.hate density, lag(1 7) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years mwage) r orthogonal small two 
estimates store check5

xtabond2 hate l1.hate c.out##c.out i.years mwage density, gmm(l1.hate density, lag(1 1) collapse) gmm(c.out##c.out,lag(2 5) collapse) iv(i.years mwage) r orthogonal small two 
estimates store check6


esttab check1 check2 check3 check4 check5 check6 using table6.tex, star(* 0.10 ** 0.05 *** .01)  cells(b(fmt(3) star) ci(fmt(3) par))replace

/*_____________________________________________________________________________ 

								VI. Summary Statistics
_______________________________________________________________________________
*/


* Summary Statistics (Table 6)

program define xtsum2, eclass

syntax varlist

foreach var of local varlist {
    xtsum `var'

    tempname mat_`var'
    matrix mat_`var' = J(3, 5, .)
    matrix mat_`var'[1,1] = (`r(mean)', `r(sd)', `r(min)', `r(max)', `r(N)')
    matrix mat_`var'[2,1] = (., `r(sd_b)', `r(min_b)', `r(max_b)', `r(n)')
    matrix mat_`var'[3,1] = (., `r(sd_w)', `r(min_w)', `r(max_w)', `r(Tbar)')
    matrix colnames mat_`var'= Mean "Std. Dev." Min Max "N/s/T-bar"
    matrix rownames mat_`var'= `var' " " " "

    local matall `matall' mat_`var'
    local obw `obw' overall between within
}

if `= wordcount("`varlist'")' > 1 {
    local matall = subinstr("`matall'", " ", " \ ",.)
    matrix allmat = (`matall')
    ereturn matrix mat_all = allmat
}
else ereturn matrix mat_all = mat_`varlist'
ereturn local obw = "`obw'"

end

xtsum2 hate adjhate U cU out mwage hprice arrests guns growth density
esttab e(mat_all) using table7.tex, mlabels(none) labcol2(`e(obw)') varlabels(r2 " " r3 " ")  replace






/*	
________________________________________________________________________________	
	
							VIII. Table 8 (Robustness Check)
								
We remove the states that have missing or zero hate crimes estimates data in order
to examine how sensitive the empirical results are to these issues. 
  
________________________________________________________________________________					
*/	

preserve
drop if states=="Alabama"| states=="Arkansas" |states=="Mississippi" | states=="Wyoming" | states=="New Jersey"


xtabond2 hate l1.hate c.U##c.U i.years mwage, gmm(l1.hate, lag(1 2) collapse) gmm(c.U##c.U,lag(2 2) collapse) iv(i.years mwage) r orthogonal small two 
estimates store gmm10 

xtabond2 hate l1.hate c.U##c.U  i.years hprice, gmm(l1.hate, lag(1 1) collapse) gmm(c.U##c.U ,lag(2 2) collapse) iv(i.years hprice) r orthogonal small two 
estimates store gmm20 

xtabond2 hate l1.hate c.U##c.U  i.years arrests if states !="Florida", gmm(l1.hate, lag(1 1) collapse) gmm(c.U##c.U,lag(2 2) collapse) iv(i.years arrests) r orthogonal small two 
estimates store gmm30 
* Note that Florida is not included in this regression, because it did not report arrests until 2017. 
* Note that arrest data for wisconsin is zero in 2000, we treat this as a missing observation.  

xtabond2 hate l1.hate c.U##c.U i.years guns, gmm(l1.hate, lag(1 1) collapse) gmm(c.U##c.U,lag(2 2) collapse) iv(i.years guns) r orthogonal small two
estimates store gmm40 


xtabond2 hate l1.hate c.cU##c.cU i.years mwage, gmm(l1.hate, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years mwage) r orthogonal small two 
estimates store gmm50 

xtabond2 hate l1.hate c.cU##c.cU i.years hprice, gmm(l1.hate, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years hprice) r orthogonal small two 
estimates store gmm60 

xtabond2 hate l1.hate c.cU##c.cU i.years arrests if states !="Florida", gmm(l1.hate, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years arrests) r orthogonal small two 
estimates store gmm70 
* Note that Florida is not included in this regression, because it did not report arrests until 2017. 
* Note that arrest data for wisconsin is zero in 2000, we treat this as a missing observation.  

xtabond2 hate l1.hate c.cU##c.cU i.years guns, gmm(l1.hate, lag(1 2) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years guns) r orthogonal small two
estimates store gmm80 


xtabond2 hate l1.hate c.out##c.out i.years mwage, gmm(l1.hate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 4) collapse) iv(i.years mwage) r orthogonal small two 
estimates store gmm90

xtabond2 hate l1.hate c.out##c.out i.years hprice, gmm(l1.hate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 5) collapse) iv(i.years hprice) r orthogonal small two 
estimates store gmm100

xtabond2 hate l1.hate c.out##c.out i.years arrests if states !="Florida", gmm(l1.hate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 6) collapse) iv(i.years arrests) r orthogonal small two 
estimates store gmm110
* Note that Florida is not included in this regression, because it did not report arrests until 2017. 
* Note that arrest data for wisconsin is zero in 2000, we treat this as a missing observation.
  
xtabond2 hate l1.hate c.out##c.out i.years guns, gmm(l1.hate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 5) collapse) iv(i.years guns) r orthogonal small two
estimates store gmm120
  
esttab gmm10 gmm20 gmm30 gmm40 gmm50 gmm60 gmm70 gmm80 gmm90 gmm100 gmm110 gmm120 using table8.tex, star(* 0.10 ** 0.05 *** .01)  cells(b(fmt(3) star) ci(fmt(3) par))replace

  
  
  
restore 



/*	
________________________________________________________________________________	
	
								IX. U-shaped Plots 
________________________________________________________________________________					
*/	

*******************************************************************************
 * 	A.	 U-shaped (1)
*******************************************************************************
xtabond2 hate l1.hate c.cU##c.cU i.years hprice, gmm(l1.hate, lag(1 1) collapse) gmm(c.cU##c.cU,lag(2 2) collapse) iv(i.years hprice) r orthogonal small two 


nlcom (cU_star: -_b[cU]/(2*_b[c.cU#c.cU]))


* We are going to save the estimation sample as follows 
capture drop sampledata
gen byte sampledata = e(sample)

* Let's compute the the 5th and 99th percentile 
centile cU if sampledata==1, centile(5 99) 

* Then we can store the percentiles as follows 
local 5th  = r(c_1)
local 99th = r(c_2)


* In order to improve the visual, we can set the range of the x-axis as follows
local bins = (`99th' - `5th')/70
 
* Let's plot the marginal effect by restricting the predictions to the 5th and 99th percentile
margins, at(cU= (`5th' (`bins')`99th'))
marginsplot, recast(line) recastci(rarea) xline(11.10944, lpattern(dash) lcolor(purple) lwidth(medium)) name(shape_1, replace) ///
ciopts(color(lavender%20))

* The distribution of unemployment
hist cU if sampledata==1, freq xline(11.10944, lpattern(dash) lcolor(purple) lwidth(medium)) ///
xline(`5th', lpattern(dash) lcolor(gs5)) xline(`99th', lpattern(dash) lcolor(gs5)) fcolor(lavender%20) name(dist_1, replace)




*******************************************************************************
 * B.	 U-shaped (2)
*******************************************************************************
xtabond2 hate l1.hate c.out##c.out i.years hprice, gmm(l1.hate, lag(1 1) collapse) gmm(c.out##c.out,lag(2 5) collapse) iv(i.years hprice) r orthogonal small two 

* Let's check the turn
nlcom (out_star: -_b[out]/(2*_b[c.out#c.out]))


* We want to plot the predictions based on the sample data  
capture drop sampledata
gen byte sampledata = e(sample)

* Let's compute the the 5th and 99th percentile 
centile out if sampledata==1, centile(5 99) 

* Then we can store the percentiles as follows 
local 5th  = r(c_1)
local 99th = r(c_2)


* In order to improve the visual, we can set the range of the x-axis as follows
local bins = (`99th' - `5th')/70
 

* Let's plot the marginal effect by resticting the predictions to the 5th and 99th percentile
margins, at(out= (`5th' (`bins')`99th'))
marginsplot, recast(line) recastci(rarea) xline(36.39381, lpattern(dash) lcolor(purple) lwidth(medium)) name(shape_2, replace) ///
ciopts(color(lavender%20))


* The distribution of the proportion of people out of the labor force   
hist out if sampledata==1, freq xline(36.39381, lpattern(dash) lcolor(purple) lwidth(medium)) ///
xline(`5th', lpattern(dash) lcolor(gs5)) xline(`99th', lpattern(dash) lcolor(gs5)) fcolor(lavender%20) name(dist_2, replace)

********************************************************************************
* U-shape plots
graph combine shape_1 shape_2, row(2)


/*
											End
_________________________________________________________________________________________________________________________________
*/


* Thank you, 
* Anything is possible in Jesus Christ.
