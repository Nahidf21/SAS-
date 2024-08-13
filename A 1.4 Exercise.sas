proc import datafile="/home/u63883623/My Work/Udemy SAS Advanced Programming/Data/score_data_miss_birthdate_new.xlsx"
dbms= xlsx
out= ScoreB
replace;
run;

options symbolgen;
%let s= Score;
proc freq data=ScoreB;
table &s.1 &s.2;
run;
options nosymbolgen;

libname Advance "/home/u63883623/My Work/Udemy SAS Advanced Programming/Data";

proc import datafile="/home/u63883623/My Work/Udemy SAS Advanced Programming/Data/score_data_miss_birthdate_new.xlsx"
dbms= xlsx
out= Advance.ScoreBirthdate
replace;
run;

%let ad = Advance;
%let area = "Southeast";
%let reptitle = * Sales Report for &area Area *;
footnote "This is the example of Macro Control Libray date &sysdate9";
proc print data= &ad..ScoreBirthdate;
var Score1 Score2;
title "&reptitle";
run;
footnote ;

/* 
Coding Exercise
SAS Macro

Section: Macro Variables and Macro Functions

Coding Exercise:



data:

score_month1.xlsx

score_month2.xlsx

score_month3.xlsx

instruction:

1. Import Excel data files into SAS and create permanent SAS data sets (library SD)

create User-Defined Macro Variable to replace the external Excel data file names

in Proc import;

2. Print out data sets:

create User-Defined Macro Variable to replace the SAS data names in Proc Print

3. use automatic macro variables &systime &sysday &sysdate9 to display

the date of the SAS invocation in Title statement in Proc Print

the SAS data sets' names need to be in UPCASE in Title statement

4. use SAS system option SYMBOLGEN to display Macro Variable Values in the SAS Log
 */

options symbolgen;

%let lb= Advance;

libname &lb "/home/u63883623/My Work/Udemy SAS Advanced Programming/Data";
proc import datafile= "/home/u63883623/My Work/Udemy SAS Advanced Programming/Data/score_month1.xlsx"
dbms= xlsx
out = &lb..Month1
replace;
run;

proc import datafile= "/home/u63883623/My Work/Udemy SAS Advanced Programming/Data/score_month2.xlsx"
dbms= xlsx
out = &lb..Month2
replace;
run;

proc import datafile= "/home/u63883623/My Work/Udemy SAS Advanced Programming/Data/score_month3.xlsx"
dbms= xlsx
out = &lb..Month3
replace;
run;


%macro print(M=);
title "%upcase(Data from &M and &systime &sysday &sysdate9 )";
    proc print data=&lb..&M;
    run;
%mend print;

%print(M=Month1);
%print(M=Month2);
%print(M=Month3);
title;

options symbolgen;
















