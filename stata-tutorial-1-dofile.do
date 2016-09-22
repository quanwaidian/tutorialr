/*Commenting:
Notice the three ways of commenting 
* comments a full line
// comments the rest of the line
/* starts a long comment, which is finished by */ (sort of like parentheses) */

cap log close //close any open log file, close the log at the end of execution
set more off //print the full output, rather than stopping when it is too long

cd "U:\StataTraining" //change directories so you don't need to type the full file path

//Log the session
//Make sure you include .log or .txt in your filename
//If you forget to, it saves in .smcl format, which most programs can't read. 
//You can translate a .smcl file: translate TrainingPartI.smcl TrainingPartI.log
//The replace option OVERWRITES	an existing log file
log using "TrainingPartI.log", replace

//open the data file - the clear command CLOSES any open dataset WITHOUT SAVING
use "census.dta", clear

//summarize the file and its variables
describe
describe pop*
describe medage death marriage
list in 1/5
//browse

********************Creating Variables*************************
gen pop_kids = poplt5 + pop5_17
gen pop18_64= pop18p - pop65p
gen death_rate=death/pop
gen divorce_ratio=divorce/marriage

//label them 
label var pop_kids "total pop below 18 yrs"
label var pop18_64 "total pop 18 - 64 yrs"
label var death_rate "proportion of pop that died"
label var divorce_ratio "divorces / marriages"

******************Summary Statistics*************************
//summary statistics for 18-64 yr old population
sum pop18_64
sum pop18_64, d

//additional population summary statistics
sum pop, d

//number of states in each region
tab region
tab region, nol //see the values rather than labels

//use a program to create the percent urban variable and 
//the urbanicity variable
do "urbanicity.do"

//number of states in each urbanicity category by region
tab region urban

//statistics for just region 1
sum pop if region==1, d
sum death if urban==1   

*******************Command Structure********************
//statistics by region & urban
bys region: sum pop, d
bys urban: sum death
//median by region
tabstat pop, by(region) stat(med)
//mean by urbanicity 
tabstat death, by(urban) stat(mean)

//help tabstat //get more information on the tabstat command

//summary statistics by region for three variables
tabstat pop death marriage, by(region) stat(mean, med, p10, p90)

//display sets of observations
//list //prints all variables for all observations in the file
list state death //prints the value of state & death variables for all observations
list if region==3 //prints all variables for observations from the south region
list state death if region==3 //prints state & death for observations from the south region
list state death, mean N //does the same as “list state death”, but also prints mean and N
bys region: list state death //prints state & death, sorted by the four region categories


**********************Logical Operations*******************
//examples using logical conditions
tabstat death if region==3, stat(sum)

	
tabstat perct_urban if pop<=1000000, stat(med N) 
tabstat perct_urban if pop>1000000 & pop<5000000, stat(med N)
tabstat perct_urban if pop>=5000000, stat(med N)

list state perct_urban if pop<=1000000
list state perct_urban if pop>1000000 & pop<5000000
list state perct_urban if pop>=5000000

