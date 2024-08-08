proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data.xlsx"
dbms= xlsx
out= Score0
replace;
run;

proc print data= Score0;
run;

proc sql;
create table Score1 as
select Name, gender
from Score0;
quit;

proc print data= Score1;
run;

proc sql;
create table Score2 as
select Name, Score1, Score2, Score3
from Score0;
quit;

proc print data= Score2;
run;

proc sql;
create table ScoreG as 
Select * from 
Score1 as S1 , Score2 as S2
where S1.name = S2.name;
quit;

proc print data= ScoreG;
title "ScoreG";
run;

Proc Sql;
create table ScoreGi as 
select * from
Score1 as S1 inner join Score2 as S2
on S1.name = S2.name;
quit;

proc print data= ScoreGi;
title "ScoreGi";
run;

proc Sql;
create table Scoregbhv as 
select name, gender, total=sum(Score1,Score2,Score3)
from Score0
group by gender 
having Score1 <= 82;
quit;



















