/* 
SAS Macro

Section: Creating and Using Macro Programs

Coding Exercise:

data:

Score_Month1.xlsx

Score_Month2.xlsx

Score_Month3.xlsx

Score_Month4.xlsx

Score_Month5.xlsx

instruction:

1. create a macro program by using positinal parameters

to import five Excel data file into SAS

2. create a macro program by using keyword parameters

to claculate mean of variable 'Score' in each data 

3. use SAS system options MPRINT MLOGIC to display information about

the execution of a macro in the SAS log

4. using %Do loop to create same score mean outputs from 5 data sets as #2
*/

options mlogic mprint;
%macro readraw(first,last, sc);
%local month;
%do month = &first %to &last;

proc import datafile= "/home/u63883623/My Work/Udemy SAS Advanced Programming/Data/score_month&month"
dbms= xlsx
out= month&month
replace;
run;

proc means data= month&month mean;
var &sc;
class month;
%if &month =1 %then %do;
title "&month.st Month";
%end;
%if &month =2 %then %do;
title "&month.nd Month";
%end;
%if &month =3 %then %do;
title "&month.rd Month";
%end;
%if &month >3 %then %do;
title "&month.th Month";
%end;
run;
%end;
%mend readraw;

%readraw(1,3,Score)