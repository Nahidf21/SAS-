proc import datafile="/home/u63883623/My Work/Udemy SAS Base/Data/score_data_id.xlsx"
dbms= xlsx
out= Score0
replace;
proc print data= Score0;
run;

options symbolgen;
proc sql noprint;
select Stu_id, name 
into :SID1-:SID5 , :SN1-:SN5
from Score0;
%put _user_;
quit;

proc print data= Score0;
var Name Score1-Score3 Gender;
where Stu_id = &SID5;
title "The Informetion of the Student ID = &SID5";
footnote "The Name of the student is &SN5";
run;

options nosymbolgen;