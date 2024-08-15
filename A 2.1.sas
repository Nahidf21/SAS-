libname Advance "/home/u63883623/My Work/Udemy SAS Advanced Programming/Data";

data score0;
set Advance.scorebirthdate;
run;
proc print;
run;

options symbolgen;
%let g= gender;
%let s= score;
%let S0 = Score0;
ods noproctitle;
footnote "File Date: &systime &sysdate9";
proc freq data= &S0;
table gender * &s.1 &s.2/ nopercent nocum norow nocol;
run;
ods _all_ close;
options nosymbolgen;
footnote;


proc sql;
create table Score0 as
select *, 
       round(mean(Score1, Score2, Score3),.1) as Mean_Scores,
       max(calculated Mean_Scores) as max_Mean,
       round(min(calculated Mean_Scores),1) as min_Mean
from Advance.Scorebirthdate;
quit;

options symbolgen;
data score1;
set Score0;
call symput("Foot", "The maximum and Minimum mean value");
call symput("Max", Max_mean);
call symput("Min",Min_mean);
if Score1 <= &Min then do Score1_lebel= "Bellow mean Score";
end;
else do Score1_lebel= "Above Mean Score";
end;
where Score1 and score2 and Score3 ne .;
drop Max_mean Min_Mean;
run;


proc print data= Score1;
title "The Score Basic Summery for Score1";
footnote "&foot &max and &min";
run;

options nosymbolgen;











