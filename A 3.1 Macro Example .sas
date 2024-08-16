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

proc means data= Score_bd mean nonobs;
title1 "The variables are &vars";
title2 " This is an example of Basic Macro with three numerical variables and one categorical variable";
var &vars;
class &gn;
run;
%mend mean;
ods noproctitle;

%mean(Score1 Score2 Score3,gender);
options nosymbolgen;

options mprint mlogic;
options symbolgen;
%macro Mean(vars,Gn);
proc sort data= Score_bd;
by &gn;
run;

proc means data= Score_bd mean;
title1 "The variables are &vars";
title2 " This is an example of Basic Macro with three numerical variables and one categorical variable";
var &vars;
by &gn;
run;
%mend mean;
ods noproctitle;

%mean(Score1 Score2 Score3,gender);
options nosymbolgen;
