proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/allscore.xlsx" 
		dbms=xlsx out=Allscore0 replace;
run;

proc print data=allscore0;
run;

proc import 
		datafile="/home/u63883623/My Work/SQL/Udemy/Data/score_data_id.xlsx" 
		dbms=xlsx out=ScoreID0 replace;
run;

proc print data=ScoreID0;
run;

proc sql;
	create table AllScore1 as select stuid, math from AllScore0;
quit;

proc sql;
	create table Score_data1 as select Stu_id, Score2 from ScoreID0;
quit;

proc sql;
	create table ScoreJoinA as select * from AllScore1 as as1 inner join 
		Score_data1 as SD1 on as1.stuID=sd1.stu_id;
quit;

proc sql;
	create table ScoreJoinB as select * from AllScore1 as as1 left join 
		Score_data1 as SD1 on as1.stuID=sd1.stu_id;
quit;

proc sql;
	CREATE TABLE from_allscore1 AS SELECT stu_id, stuid, math, score2 FROM 
		score_data1 AS sd1 RIGHT JOIN allscore1 AS as1 ON stu_id=stuid;
quit;

proc sql;
	create table ScoreJoinC as select * from AllScore1 as as1 full join 
		Score_data1 as SD1 on as1.stuID=sd1.stu_id;
quit;

proc sql;
   CREATE TABLE two AS
   SELECT stu_id, stuid, math, score2
   FROM score_data1 AS sd1 FULL JOIN  allscore1 AS as1
   ON stu_id =  stuid;
quit;