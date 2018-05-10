

* Final Paper

* use dprobit predictive probabilities, tobit, make sure to have the correct lower and upper bounds

* pc = hhid, household id



* Set-up

clear

set mem 100m

cd "F:\4.1\985\985d\"



* Run ChildData, HouseholdData, PBSData, Merge dofiles

use "Data\Data_Modified\CHPDataNewVarII_GK1.dta", clear

log using "Documents\Ec985_Paper_AC_Nov19_PartI_GK2.log", replace

* Variable generation

gen logconexp = log(conexp)

gen lceclinics = logconexp*nearclinicC

gen inschool_nearclinicC = inschool*nearclinicC

gen consult_nearclinicC = consulted*nearclinicC

gen logconexp = log(conexp)

gen lceclinics = logconexp*nearclinicC

gen inschool_nearclinicD = inschool*nearclinicD

gen immunized2 = bcg + measles + polio

gen inschool_nearclinicC = inschool*nearclinicC

gen dkmnclinic = distkm*nearclinicC

gen twomeals = .

replace twomeals = 1 if b10_9 == 1

replace twomeals = 0 if b10_9 == 2

gen consulted = .

replace consulted = 1 if i5_2 == 1

replace consulted = 0 if i5_2 == 2

gen clinicconsult = nearclinic*consulttype

* Gradation Variables 2

* clinic within 1 km



gen <1km = 1

replace <1km = 0 if nearclinicD == 0

gen 1+km = 1

replace 1+km = 0 if nearclinicD == 0

gen 2+km = 1

replace 2+km = 0 if nearclinicC == 0

gen 3+km = 1

replace 3+km = 0 if nearclinicC == 0







* Gradation

* Clinic within 1 km

gen onekm = 1

replace onekm = 0 if nearclinicD == 0

* Was nearclinicD greater than 2 km?

* Clinic within 1-2 km

gen twokm = 1

replace twokm = 0 if nearclinicC == 0

replace twokm = 0 if nearclinicD >= 1

* Clinic within 2-3 km

gen threekm = 1

replace threekm = 0 if nearclinicB == 0

replace threekm = 0 if nearclinicC >= 1

replace threekm = 0 if nearclinicD >= 1

* Clinic greater than 3 km away

gen minthreekm = 1

replace minthreekm = 0 if nearclinicB >= 1

replace minthreekm = 0 if nearclinicC >= 1

replace minthreekm = 0 if nearclinicD >= 1



* clinic within 3-5 km

gen fivekm = 1

replace fivekm = 0 if nearclinicA == 0

replace fivekm = 0 if nearclinicB >= 0

replace fivekm = 0 if nearclinicC >= 0

replace fivekm = 0 if nearclinicD >= 0



gen inschool_nearclinicC = inschool*nearclinicC

gen dkmnclinic = distkm*nearclinicC

save "Data\Data_Modified\CHPDataNewVarII_GK2.dta", replace

use "Data\Data_Modified\CHPDataNewVarII_GK2.dta", clear



* Table 1

* Row 1: Comparison groups,

* Immunization rates across groups (8)

ttest immunized, by(group2km) unequal unpaired

ttest bcg, by(group2km) unequal unpaired

ttest dpt, by(group2km) unequal unpaired

ttest opv, by(group2km) unequal unpaired

ttest measles, by(group2km) unequal unpaired

ttest polio, by(group2km) unequal unpaired

ttest minonevaccine, by(group2km) unequal unpaired

ttest imcard, by(group2km) unequal unpaired

ttest age, by(group2km) unequal unpaired

* age = age of anyone

* minor = age for those children under the age of 18

ttest minor, by(group2km) unequal unpaired



* Socioeconomic variables across groups (9)

ttest inschool, by(group2km) unequal unpaired

ttest elect, by(group2km) unequal unpaired

ttest livestock, by(group2km) unequal unpaired

ttest conexp, by(group2km) unequal unpaired

* monthly total consumer expenditure

ttest sickperson, by(group2km) unequal unpaired

ttest hhsize, by(group2km) unequal unpaired

ttest medpay, by(group2km) unequal unpaired

* drop later

ttest twomeals, by(group2km) unequal unpaired



* Health Outcomes across groups



replace mobfed = . if mobfed == -999

replace mobfed = . if mobfed == -777

ttest mobfed, by(group2km) unequal unpaired

ttest lowhb, by(group2km) unequal unpaired

* below < 10 g/dl (grams per deciliter)

* normal range for children: 11-13 gm/dl

* we defined it as low if children have less than 10 gm/dl (grams per deciliter)



ttest healthlad, by(group2km) unequal unpaired

ttest diarrhea, by(group2km) unequal unpaired

ttest vomit, by(group2km) unequal unpaired

ttest retarded, by(group2km) unequal unpaired

ttest handi, by(group2km) unequal unpaired



replace squat = . if squat == 997

replace squat = . if squat == 998

ttest squat, by(group2km) unequal unpaired

* cough in the last 30 days

ttest cough, by(group2km) unequal unpaired



* Tendency to use government doctors across groups

* did you consult nayone about the conditions the child experienced in the last 30 days

ttest consulted, by(group2km) unequal unpaired

* type of doctor consulted for any of the conditions experienced in the last 30 days - consulted government doctor

ttest consulttype, by(group2km) unequal unpaired

* type of doctor at birth

ttest doctype, by(group2km) unequal unpaired



*unused doctor use and type variables

ttest clinicconsult, by(group2km) unequal unpaired

* interaction term between nearclinic and consulted type

ttest feelbetter, by(group2km) unequal unpaired

* did hte child feel better after consultation?

ttest medication, by(group2km) unequal unpaired

* did the child finish teh medicine/treatment?

ttest medfinished, by(group2km) unequal unpaired

* why did this child interrupt the treatment?

ttest otherconsult, by(group2km) unequal unpaired

* did you consult anyone else?

ttest govdn, by(group2km) unequal unpaired

* government doctor and nurse vs. private at birth

ttest nursetype, by(group2km) unequal unpaired

* type of nurse consulted at birth



* unused tb and cough measures

ttest tbtime, by(group2km) unequal unpaired

* was the child diagnosed with tb first in the past year? 

ttest coughtwoweeks, by(group2km) unequal unpaired

* cough continuing for two weeks?

ttest tb, by(group2km) unequal unpaired

* diagnosed with tb

ttest tbtreat, by(group2km) unequal unpaired

* received tb treatment in the past year?

ttest coughcontinues, by(group2km) unequal unpaired

* still suffering from cough?

* tb and cough measures

ttest tbtest, by(group2km) unequal unpaired

* tested for tb



* Test of differences across groups when sample size restricted to self-employed farmers

ttest immunized if b5_2 == 1, by(group2km) unequal unpaired

ttest minonevaccine if b5_2 == 1, by(group2km) unequal unpaired

ttest imcard if b5_2 == 1, by(group2km) unequal unpaired

ttest minor if b5_2 == 1, by(group2km) unequal unpaired

ttest inschool if b5_2 == 1, by(group2km) unequal unpaired

ttest elect if b5_2 == 1, by(group2km) unequal unpaired

ttest livestock if b5_2 == 1, by(group2km) unequal unpaired

ttest conexp if b5_2 == 1, by(group2km) unequal unpaired

ttest sickperson if b5_2 == 1, by(group2km) unequal unpaired

ttest hhsize if b5_2 == 1, by(group2km) unequal unpaired

ttest medpay if b5_2 == 1, by(group2km) unequal unpaired

ttest twomeals if b5_2 == 1, by(group2km) unequal unpaired

ttest consulttype if b5_2 == 1, by(group2km) unequal unpaired

ttest doctype if b5_2 == 1, by(group2km) unequal unpaired



* Complete set of variables to be used

* immunized bcg dpt opv measles polio minonevaccine imcard

* age minor inschool mobfed lowhb squat healthlad diarrhea vomit cough retarded handi

* elect livestock conexp sickperson hhsize twomeals consulted

* excluded medpay consulttype doctype

log close



set mem 100m

cd "F:\4.1\985\985d\"

use "Data\Data_Modified\CHPDataNewVarII_GK2.dta", clear

* for Macs

* use "/Volumes/TREKSTOR/4.1/985/985d/Data/Data_Modified/CHPDataNewVarIIFinal_GK1.dta"



log using "Documents\Ec985_Paper_AC_Nov19_PartII_GK2.log", replace



* Table 2

* Regressions with immunized or tb as outcome variable and nearclinicC as the explanatory variable

reg immunized twokm threekm minthreekm, r cluster(locationid)

estimates store immunizedall

reg immunized twokm threekm minthreekm if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store immunized

reg immunized twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store immunizedcontrols

reg bcg twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store bcg

reg polio twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store polio

reg measles twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store measles

reg dpt twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store dpt

reg opv twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store opv

* Control experiment. If the child is in school, then there should be less of an effect since most children in school must get their immunization shots

* Restricted to children who are in school

reg immunized twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1 & inschool == 1, r cluster(locationid)

estimates store inschool



estimates table immunizedall immunized immunizedcontrols inschool, b(%7.4f) star(.10 .05 .01) stats(N r2_a)

estimates table bcg polio measles dpt opv, b(%7.4f) star(.10 .05 .01) stats(N r2_a)







* Table 3A, same as Table 2 (regressions 1-2), with tobit

tobit immunized twokm threekm minthreekm if age < 19 & b5_2 == 1, ll(-.00001) ul(6) r cluster(locationid)

mfx compute

estimates store timmunized

tobit immunized twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, ll(-.00001) ul(6) r cluster(locationid)

mfx compute

estimates store timmunizedcontrols

estimates table timmunized timmunizedcontrols, b(%7.4f) star(.10 .05 .01) stats(N r2_a)

*Table 3B, same as Table 2, with dprobit

dprobit bcg twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store pbcg

dprobit polio twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store ppolio

dprobit measles twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store pmeasles

dprobit dpt twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store pdpt

dprobit opv twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store popv

estimates table pbcg ppolio pmeasles pdpt popv, b(%7.4f) star(.10 .05 .01) stats(N r2_a)



* Table 4, other health outcomes

reg healthlad twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store healthlad

reg squat twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store squat

reg tbtest twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store tbtest

reg lowhb twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store lowhb

reg diarrhea twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store diarrhea

reg vomit twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store vomit

reg handi twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store handi

reg retarded twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store retarded

reg tb twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store tb

*reg tbtreat twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r cluster(locationid)

*estimates store tbtreat

estimates table healthlad squat tbtest lowhb diarrhea vomit, b(%7.4f) star(.10 .05 .01) stats(N r2_a)

log close



---

estimates table handi retarded tb, b(%7.4f) star(.10 .05 .01) stats(N r2_a)

---



* Table 5: Robustness checks



* Restricted to households with an immunization card.

reg immunized twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1 & imcard == 1, r cluster(locationid)

estimates store immcard

estimates table inschool immcard, b(%7.4f) star(.10 .05 .01) stats(N r2_a)



* Analyzing the Public Health Clinics

* Summary statistics

use "Data\Datasets\PBSData.dta", clear

drop pb510_996s pb510_996s_h pb510 pb59 pb59_h pb58_4 pb58_3 pb58_2 pb58_0 pb57 pb56_996s pb56_996s_h pb56 pb55 pb55_h pb54_4 pb54_3 pb54_2 pb54_1 pb54_0 pb53 pb52_996s pb52_996s_h pb52 pb51 pb51_h pb442_38_996s pb442_38_996s_h pb442_38_996b pb442_38_996a pb442_38_8b pb442_38_8a pb442_38_7b pb442_38_7a pb442_38_6b pb442_38_6a pb442_38_5b pb442_38_5a pb442_38_4b pb442_38_4a pb442_38_3b pb442_38_3a pb442_38_2b pb442_38_2a pb442_38_1b pb442_38_1a

* type of facility

rename pb01 facilitytype

replace facilitytype = . if facilitytype == 996

* # villages facility serves

rename pb02 novillages

* # people facility serves

rename pb016 nopeople

* health issues that camps address

* family planning

gen famplanning = pb213_1

gen immun = pb213_2

gen std = pb213_3

gen genhealth = pb213_4

gen eyes = pb213_5

* how far medical officer's home is from facility

* 1. doctor/medical officer

gen distdoc = pb218_1

* 2. compounder or male nurse

gen distcomp = pb218_2

* 3. pharmacist

gen distpharm = pb218_3

* 4. Multipurpose worker

gen distmult = pb218_4

* 5. ANM

gen distanm = pb218_5

* 6. staff nurse

gen distnurse = pb218_6



* dummies for facility type

* community health centers

gen chc = 0

replace chc = 1 if facilitytype == 1

* public health centers

gen phc = 0

replace phc = 1 if facilitytype == 2

* aid post

gen aidpost = 0

replace aidpost = 1 if facilitytype == 3

* subcenter - under phc domain

gen subcentre = 0

replace subcentre = 1 if facilitytype == 4

* how far facility is from the pHC that heads this clinic?

gen facilityphc = pb09

keep facilitytype novillages famplanning immun std genhealth eyes distdoc distcomp distpharm distmult distanm distnurse nopeople chc phc aidpost subcentre facilityphc

save "Data\Data_Modified\PBSDataNewVar_GK1.dta", replace



log using "Documents\Ec985_Paper_AC_Nov19_PartIII_GK2.log", replace

use "Data\Data_Modified\PBSDataNewVar_GK1.dta", clear

reg novillages chc, r

estimates store vchc

reg novillages phc, r

estimates store vphc

reg novillages aidpost, r

estimates store vaidpost

reg novillages subcentre, r

estimates store vsubcentre

estimates table vchc vphc vaidpost vsubcentre, b(%7.4f) star(.10 .05 .01) stats(N r2_a)

reg nopeople chc, r

estimates store pchc

reg nopeople phc, r

estimates store pphc

reg nopeople aidpost, r

estimates store paidpost

reg nopeople subcentre, r

estimates store psubcentre

estimates table pchc pphc paidpost psubcentre, b(%7.4f) star(.10 .05 .01) stats(N r2_a)

reg novillages facilityphc, r

estimates store novillagesfc

reg nopeople facilityphc, r

estimates store nopeoplefc

estimates table novillagesfc nopeoplefc, b(%7.4f) star(.10 .05 .01) stats(N r2_a)

log close



-------



* Table 6

* Control for proximity to a private clinic



* Robustness Check 1. The effect might be larger for households that brought their child to a clinic in the past 30 days 

* Households that care enough about thier child's health to consult a doctor in the past 30 days, likely got vaccinated

reg immunized onekm twokm threekm minthreekm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1 & consulted == 1, r cluster(locationid)

estimates store consult



reg immunized distkm logconexp livestock hhsize minor inschool elect if age < 19 & b5_2 == 1, r

estimates store distkm

estimates table distkm, b(%7.4f) star(.10 .05 .01) stats(N r2_a)



* Naive regressions

* assuming that it's random - might just move to be near a hospital or clinic for the child's sake

reg immunized nearclinicC, r

estimates store reg1



* Alternative estimation without controls

* Restrict to self-employed agriculture, cluster within a village/hamlet, restrict age to under 19 (minors)

* Use tobit regression with upper limit 5 and lower limit 0

reg immunized nearclinicC if age < 19 & b5_2 == 1

estimates store reg2



reg immunized nearclinicC logconexp lceclinics livestock hhsize minor if age < 19 & b5_2 == 1

estimates store reg3

* very significant, p = .04





estimates table reg1 reg2 reg3 reg4, b(%7.4f) star(.10 .05 .01) stats(N r2_a)



* Table 2A

reg immunized nearclinicD, r

estimates store reg1a



* Alternative estimation without controls

* Restrict to self-employed agriculture, cluster within a village/hamlet, restrict age to under 19 (minors)

* Use tobit regression with upper limit 5 and lower limit 0

reg immunized nearclinicD if age < 19 & b5_2 == 1

estimates store reg2a



reg immunized nearclinicD logconexp lceclinics livestock hhsize minor if age < 19 & b5_2 == 1

estimates store reg3a

* very significant, p = .04



reg immunized nearclinicD inschool_nearclinicD inschool livestock logconexp lceclinics hhsize minor if age < 19 & b5_2 == 1

estimates store reg4a



estimates table reg1a reg2a reg3a reg4a, b(%7.4f) star(.10 .05 .01) stats(N r2_a)



* Table 2B. With electricity and child in school as control variables as well



reg immunized nearclinicC inschool_nearclinicC inschool elect logconexp lceclinics livestock hhsize minor if age < 19 & b5_2 == 1

estimates store electcontrol

estimates table electcontrol, b(%7.4f) star(.10 .05 .01) stats(N r2_a)





* Table 3

* Same 3 regressions with distkm as explanatory variable + interaction term between that and nearclinicC



reg immunized distkm nearclinicC

estimates store reg6



reg immunized distkm nearclinicC if age < 19 & b5_2 == 1

estimates store reg7



reg immunized distkm nearclinicC dkmnclinic logconexp lceclinics livestock hhsize minor if age < 19 & b5_2 == 1

estimates store reg8



reg immunized nearclinicC inschool_nearclinicC inschool livestock logconexp lceclinics hhsize minor if age < 19 & b5_2 == 1

estimates store reg9



* Should I add more control variables?

estimates table reg6 reg7 reg8 reg9, b(%7.4f) star(.10 .05 .01) stats(N r2_a)



* Table 4

* Same regressions, now in Tobit



tobit immunized nearclinicC, ll(-.00001) ul(6) r cluster(locationid)

mfx compute

estimates store reg11



tobit immunized nearclinicC if age < 19 & b5_2 == 1, ll(-.00001) ul(6) r cluster(locationid)

mfx compute

estimates store reg12



tobit immunized nearclinicC livestock logconexp lceclinics hhsize minor if age < 19 & b5_2 == 1, ll(-.00001) ul(6) r cluster(locationid)

mfx compute

estimates store reg13



tobit immunized nearclinicC inschool_nearclinicC inschool livestock logconexp lceclinics hhsize minor if age < 19 & b5_2 == 1, ll(-.00001) ul(6) r cluster(locationid)

mfx compute

estimates store reg14



estimates table reg11 reg12 reg13 reg14, b(%7.4f) star(.10 .05 .01) stats(N r2_a)



* Table 5

* Same regressions from before, in Tobit



reg immunized distkm nearclinicC

estimates store reg16



reg immunized distkm nearclinicC if age < 19 & b5_2 == 1

estimates store reg17



reg immunized distkm nearclinicC dkmnclinic logconexp lceclinics livestock hhsize minor if age < 19 & b5_2 == 1

estimates store reg18



reg immunized distkm nearclinicC dkmnclinic inschool_nearclinicC inschool logconexp lceclinics livestock hhsize minor if age < 19 & b5_2 == 1

estimates store reg19



* Should I add more control variables?

estimates table reg16 reg17 reg18 reg19, b(%7.4f) star(.10 .05 .01) stats(N r2_a)







* Table 7: Robustness check 2

*no matter what slight variation in the varaibles there are - should still hold up



* slight variation in outcome variable - only using 3/5 immunization shots, outcome should still be robust

tobit immunized2 nearclinicC livestock logconexp lceclinics hhsize minor if age < 19 & b5_2 == 1, ll(-.00001) ul(6) r cluster(locationid)

mfx compute

estimates store immunized2

estimates table immunized2



dprobit minonevaccine nearclinicC livestock logconexp lceclinics hhsize minor if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store minonevaccine

dprobit imcard nearclinicC livestock logconexp lceclinics hhsize minor if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store imcard

dprobit bcg nearclinicC livestock logconexp lceclinics hhsize minor if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store bcg

dprobit dpt nearclinicC livestock logconexp lceclinics hhsize minor if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store dpt

dprobit opv nearclinicC livestock logconexp lceclinics hhsize minor if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store opv

dprobit measles nearclinicC livestock logconexp lceclinics hhsize minor if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store measles

dprobit polio nearclinicC livestock logconexp lceclinics hhsize minor if age < 19 & b5_2 == 1, r cluster(locationid)

estimates store polio

estimates table minonevaccine imcard bcg, b(%7.4f) star(.10 .05 .01) stats(N r2_a)

estimates table dpt opv measles polio, b(%7.4f) star(.10 .05 .01) stats(N r2_a)



Table 8: other health measures

* Regressions with immunized as the outcome variable, imcard or other health measures of the child as outcome variable

* Graphs

* Figure 1a

table immunized nearclinicC

* Figure 1b

graph bar immunized, over(nearclinicC) title("Avg. # Vaccines vs. # of Clinics within 2km") ytitle("Avg # of Vaccines Received")



* Figure 2a

table immunized nearclinicC if b5_2 == 1

* Figure 2b

graph bar immunized if b5_2 == 1, over(nearclinicC) title("Avg. # Vaccines vs. # of Clinics within 2km") ytitle("Avg # of Vaccines Received")



* Figure 3

graph pie group2km, over(nearclinicC)

* title: Breakdown of Number of Clinics in the Area



* Figure 4. Boxplot

graph box hhsize if b5_2 == 1, over(group2km) title("Total number of Household Members")

graph box conexp if b5_2 == 1, over(group2km) title("Household Monthly Expenditures")



graph box immunized if b5_2 == 1, over(nearclinicC)

title("Boxplot: Avg. # Vaccines vs. # of Clinics in 2km") ytitle("Avg # of Vaccines Received")



* Figure 5

reg immunized nearclinicC livestock conexp hhsize minor if age < 19 & b5_2 == 1, r cluster(locationid)

avplot nearclinicC

graph save plot_immunized_nearclinicC title("Partial Residuals Plot of Immunization Score on Number of Clinics")





log using "Documents\Ec985_Paper_Tables_Child_GK1.log", replace

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





* Tables


