proc import datafile="/home/u63883623/My Work/Udemy SAS Base/Data/score_data_id.xlsx"
dbms= xlsx
out= Score0
replace;
proc print data= Score0;
run;

proc sql;
select 
max(mean(Score1, Score2, score3)) as max1,
round(min(mean(Score1, Score2, Score3)),1) as min1
into : Max , : Min
from Score0;
quit;

proc print data= Score0;
where Score2 >= &min;
title " The Maximum and minimum value is &max and &min";
run;

