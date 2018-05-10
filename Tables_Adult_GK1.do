* Regressions for the Adult Dataset

* Set-up

clear

set mem 500m

cd "F:\4.1\985\985d\"

use "Data\Data_Modified\AHPDataMerged_Collapsed_NewVar_GK1.dta", clear

* Cleaned up Dataset - now running regressions and creating tables



* Table 1: Differences

* Table 2



* Expenditures & parental education on LHS

reg logconexp onekmcl twokmcl threekmcl fourkmcl fivekmcl livestock hhsize elect literate female, r cluster(locationid)

estimates store exp



reg motherliterate onekmcl twokmcl threekmcl fourkmcl fivekmcl livestock hhsize elect literate female logconexp, r cluster(locationid)

estimates store motherliterate



reg fatherliterate onekmcl twokmcl threekmcl fourkmcl fivekmcl livestock hhsize elect literate female logconexp, r cluster(locationid)

estimates store fatherliterate



* Effect of incremental distance to the nearest clinic on Health Outcomes

* Regressions with health outcomes as the dependent variables, distance as explanatory variables, and household and socioeconomic factors as control variables



reg TBdiagnosis onekmcl twokmcl threekmcl fourkmcl fivekmcl livestock hhsize elect literate female logconexp, r cluster(locationid)

estimates store TBdiagnosis



reg hypertension onekmcl twokmcl threekmcl fourkmcl fivekmcl livestock hhsize elect literate female logconexp, r cluster(locationid)

estimates store hypertension



reg healthlad onekmcl twokmcl threekmcl fourkmcl fivekmcl livestock hhsize elect literate female logconexp, r cluster(locationid)

estimates store healthlad



reg lowhb onekmcl twokmcl threekmcl fourkmcl fivekmcl livestock hhsize elect literate female logconexp, r cluster(locationid)

estimates store lowhb



log using "Documents\Ec985_Paper_Tables_Adult_GK1.log", replace

* Table I

* Column I: Log monthly consumer expenditures are the outcome variable

* Column II: Literacy of the mother

* Column III: Literacy of the father

estimates table exp motherliterate fatherliterate, b(%7.4f) star(.10 .05 .01) stats(N r2_a)



* Table II

* Column I: Diagnosis of TB

* Column II: Hypertension

* Column III: Self-rating on health ladder

* Column IV: Anemia Rates

estimates table TBdiagnosis hypertension healthlad lowhb, b(%7.4f) star(.10 .05 .01) stats(N r2_a)

log close




