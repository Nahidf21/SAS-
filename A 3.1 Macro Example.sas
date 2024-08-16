proc import datafile="/home/u63883623/My Work/Udemy SAS Advanced Programming/Data/score_data_miss_birthdate_new.xlsx"
dbms= xlsx
out= Score_bd
replace;
run;

proc print data= Score_bd;
run;

options mprint mlogic;
options symbolgen;
%macro Mean(vars,Gn);
proc sort data= Score_bd;
by &gn;
run;

proc means data= Score_bd mean;
title "The variables are &vars";
var &vars;
class &gn;
run;
%mend mean;
ods noproctitle;
title " This is an example of Basic Macro";
%mean(Score1 Score2 Score3,gender);
options nosymbolgen;