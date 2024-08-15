proc import datafile="/home/u63883623/My Work/Udemy SAS Base/Data/score_data_id.xlsx"
dbms= xlsx
out= scoreID
replace;
run;
proc print data= ScoreID;
run;

/*Call Symput */

options symbolgen;
data Score1;
set ScoreID;
call symput("Student" || left(Stu_id), trim(name));
run;

%let stu_id=2;

proc print data= Score1;
where stu_id = &Stu_id;
var name gender Score1 score2 Score3;
title "Individual Student Score Informetion for Student &Stu_id";
footnote "Student Informetion for &&student&Stu_id";
run;

options nosymbolgen;