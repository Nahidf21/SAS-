proc import datafile="/home/u63883623/My Work/Udemy SAS Advanced Programming/Data/score_data_miss_birthdate_new.xlsx"
dbms= xlsx
out= Score_birth
replace;
run;

proc print data= Score_birth;
run;

options mprint mlogic;
%macro print(vars=,gender=);
proc print data= Score_birth;
%if &gender = %then %do;
var &vars;
%end;
%else %if &vars = %then %do;
var &gender;
%end;
%else %do;
var &gender &vars;
%end;
%mend print;


%print(vars= Score1 Score2 Score3, gender=)
%print(gender= gender)
%print(vars= Score1 Score2 Score3,gender= gender);

options nosymbolgen;

