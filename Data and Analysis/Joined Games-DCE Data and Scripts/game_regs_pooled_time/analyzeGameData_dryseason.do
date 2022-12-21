clear all

use gameData

drop if totalroundsgame < 16
drop if round == 1
drop if round == 2

//drop the only 2 games run in low-clim conditions
drop if session == 104 
drop if session == 209

replace session = 215 if session == 209 & gameid == "1"



encode gameid, generate(game_number)
gen mean_grass_live_n = real(mean_grass_live)
gen var_grass_live_n = real(var_grass_live)
gen mean_grass_cut_n = real(mean_grass_cut)
gen var_grass_cut_n = real(var_grass_cut)
gen rainfall_m1_n = real(rainfall_m1)
gen rainfall_m2_n = real(rainfall_m2)
gen mean_grass_public_used_n = real(mean_grass_public_used)
gen mean_grass_shared_used_n = real(mean_grass_shared_used)
gen frac_shared_used_n = real(frac_shared_used)

gen conflictCount = p1_case_3_4 + p2_case_3_4 + p3_case_3_4 + p4_case_3_4 

merge m:1 p1name using quest_plus_DCE_coeffs_pooled_time, keepusing(datenum age sex_n herd1 good1 bad1 alltime1  workMale workFemale q1_predce q2_predce q3_predce q4_predce main_animal doyougrowanycrops_) generate(p1_merge)
encode doyougrowanycrops_, generate(p1_grow_crops)
drop doyougrowanycrops_
rename age p1_age
rename herd1 p1_herd1
rename good1 p1_good1
rename bad1 p1_bad1
rename alltime1 p1_alltime1
//rename comm1 p1_comm1
rename workMale p1_workMale
rename workFemale p1_workFemale
rename q1_predce p1_q1
rename q2_predce p1_q2
rename q3_predce p1_q3
rename q4_predce p1_q4
rename main_animal p1_animal
rename sex_n p1_sex
merge m:1 p2name using quest_plus_DCE_coeffs_pooled_time, keepusing(age sex_n herd1 good1 bad1 alltime1  workMale workFemale q1_predce q2_predce q3_predce q4_predce main_animal doyougrowanycrops_) generate(p2_merge)
encode doyougrowanycrops_, generate(p2_grow_crops)
drop doyougrowanycrops_
rename age p2_age
rename herd1 p2_herd1
rename good1 p2_good1
rename bad1 p2_bad1
rename alltime1 p2_alltime1
//rename comm1 p2_comm1
rename workMale p2_workMale
rename workFemale p2_workFemale
rename q1_predce p2_q1
rename q2_predce p2_q2
rename q3_predce p2_q3
rename q4_predce p2_q4
rename main_animal p2_animal
rename sex_n p2_sex
merge m:1 p3name using quest_plus_DCE_coeffs_pooled_time, keepusing(age sex_n herd1 good1 bad1 alltime1  workMale workFemale q1_predce q2_predce q3_predce q4_predce main_animal doyougrowanycrops_) generate(p3_merge)
encode doyougrowanycrops_, generate(p3_grow_crops)
drop doyougrowanycrops_
rename age p3_age
rename herd1 p3_herd1
rename good1 p3_good1
rename bad1 p3_bad1
rename alltime1 p3_alltime1
//rename comm1 p3_comm1
rename workMale p3_workMale
rename workFemale p3_workFemale
rename q1_predce p3_q1
rename q2_predce p3_q2
rename q3_predce p3_q3
rename q4_predce p3_q4
rename main_animal p3_animal
rename sex_n p3_sex
merge m:1 p4name using quest_plus_DCE_coeffs_pooled_time, keepusing(age sex_n herd1 good1 bad1 alltime1  workMale workFemale q1_predce q2_predce q3_predce q4_predce main_animal doyougrowanycrops_) generate(p4_merge)
encode doyougrowanycrops_, generate(p4_grow_crops)
drop doyougrowanycrops_
rename age p4_age
rename herd1 p4_herd1
rename good1 p4_good1
rename bad1 p4_bad1
rename alltime1 p4_alltime1
//rename comm1 p4_comm1
rename workMale p4_workMale
rename workFemale p4_workFemale
rename q1_predce p4_q1
rename q2_predce p4_q2
rename q3_predce p4_q3
rename q4_predce p4_q4
rename main_animal p4_animal
rename sex_n p4_sex

drop if session ==  .

gen mean_age = (p1_age + p2_age + p3_age + p4_age) / 4
gen mean_herd1 = (p1_herd1 + p2_herd1 + p3_herd1 + p4_herd1) / 4
gen mean_good1 = (p1_good1 + p2_good1 + p3_good1 + p4_good1) / 4
gen mean_bad1 = (p1_bad1 + p2_bad1 + p3_bad1 + p4_bad1) / 4
gen mean_alltime1 = (p1_alltime1 + p2_alltime1 + p3_alltime1 + p4_alltime1) / 4

gen mean_workMale = (p1_workMale + p2_workMale + p3_workMale + p4_workMale) / 4
gen mean_workFemale = (p1_workFemale + p2_workFemale + p3_workFemale + p4_workFemale) / 4
gen mean_q1 = (p1_q1 + p2_q1 + p3_q1 + p4_q1) / 4
gen mean_q2 = (p1_q2 + p2_q2 + p3_q2 + p4_q2) / 4
gen mean_q3 = (p1_q3 + p2_q3 + p3_q3 + p4_q3) / 4
gen mean_q4 = (p1_q4 + p2_q4 + p3_q4 + p4_q4) / 4
gen frac_sheep = ((p1_animal == 1) + (p2_animal == 1) + (p3_animal == 1) + (p4_animal == 1)) / 4
gen frac_crops = ((p1_grow_crops == 2) + (p2_grow_crops == 2) + (p3_grow_crops == 2) + (p4_grow_crops == 2)) / 4

gen frac_female = ((p1_sex == 1) + (p2_sex == 1) + (p3_sex == 1) + (p4_sex == 1)) / 4

//local player_vars "mean_age frac_female frac_sheep frac_crops mean_herd1 mean_good1 mean_bad1 mean_alltime1 mean_workMale mean_workFemale mean_q1 mean_q2 mean_q3 mean_q4"
local player_vars_1 "mean_age frac_female frac_sheep frac_crops"
local player_vars_2 "mean_herd1 mean_good1 mean_bad1 mean_alltime1"
local player_vars_3 "mean_q1 mean_q2 mean_q3 mean_q4"
local player_vars_4 "mean_workMale mean_workFemale "

drop if round < 6
drop if round > 8

reg mean_grass_shared_used_n datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) replace
reg mean_grass_shared_used_n `player_vars_1' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_grass_shared_used_n `player_vars_2' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_grass_shared_used_n `player_vars_3' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_grass_shared_used_n `player_vars_4' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_grass_shared_used_n `player_vars_1' `player_vars_2' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 

reg mean_grass_cut_n datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_grass_cut_n `player_vars_1' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_grass_cut_n `player_vars_2' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_grass_cut_n `player_vars_3' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_grass_cut_n `player_vars_4' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_grass_cut_n `player_vars_1' `player_vars_2' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 

reg conflictCount datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg conflictCount `player_vars_1' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg conflictCount `player_vars_2' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg conflictCount `player_vars_3' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg conflictCount `player_vars_4' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg conflictCount `player_vars_1' `player_vars_2' datenum round rainfall rainfall_m1_n rainfall_m2_n mean_animals, cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 

reg mean_animals datenum round rainfall rainfall_m1_n rainfall_m2_n , cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_animals `player_vars_1' datenum round rainfall rainfall_m1_n rainfall_m2_n , cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_animals `player_vars_2' datenum round rainfall rainfall_m1_n rainfall_m2_n , cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_animals `player_vars_3' datenum round rainfall rainfall_m1_n rainfall_m2_n , cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_animals `player_vars_4' datenum round rainfall rainfall_m1_n rainfall_m2_n , cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
reg mean_animals `player_vars_1' `player_vars_2' datenum round rainfall rainfall_m1_n rainfall_m2_n , cluster(session) 
estat ic
matrix out=r(S)
local AIC=out[1,5]
outreg2 using gameRegs_drySeason.xls, addstat(AIC, `AIC') stats(coef) 
