proc import datafile= "/home/u63883623/My Work/Udemy SAS Base/Data/score_data.xlsx"
dbms= xlsx
out= Score0
replace;
run;

proc print data= Score0;
run;

* this is macro veriable;
%let gnd = f;

data Score1;
set Score0;
where gender = "&gnd";
run;


