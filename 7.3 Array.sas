/* Assigning Initial Values to Arrays */
/* Array name{dimension} <elements> (initial values); */


proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data_miss999.xlsx"
dbms= xlsx out= Score0
replace;
run;

data Score1;
set Score0;
	
	Array SCR{3} score1 Score2 Score3;
	do i= 1 to 3;
	if SCR{i}=999 then SCR{i}=.;
	end;
Avg_score = round(mean(Score1, Score2, Score3),.2);
drop i;
run;

proc means data= Score1;
var score1 Score2 Score3;
run;

/* Colum wise mean */
/* 79.50 , 81.90, 80.81 */

data Score3;
Set Score1;
	Array SCR1{3} Score1 Score2 Score3;
	Array AvgScore{3}  (79.50, 81.90, 80.81);
	Array ScrDiff{3};
	do i= 1 to 3;
		ScrDiff{i}= SCR1{i}- AvgScore{i};
		end;
		drop i;
run;
	