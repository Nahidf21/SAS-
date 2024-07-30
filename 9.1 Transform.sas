/* Transform  */

proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/score_data_id.xlsx"
dbms= xlsx
out= Score0
replace;

proc print data= Score0;
run;

libname StuScore "/home/u63883623/My Work/SQL/Udemy/Data";

data StuScore.transpos;
set Score0;
	Array col{3} Score1-Score3;
	Do i= 1 to 3;
	All_score = col{i};
	*output;
/* 	ignore the missing values */
	if all_Score ne . then output;
	end;
	keep name Stu_id all_score i;
run;

proc print data= Stuscore.Transpos;
run;

/* Revarce  */

proc sort data= stuscore.transpos out= manyper;
	by stu_id i;
run;

proc print data= manyper;
run;

data stuscore.oneper;
	set manyper;
	by stu_id i;
	array score{3};
	retain Score1-Score3;
	
	if first.stu_id then call missing (of score1-score3);
	
	score{i} = all_score;
	if last.stu_id then output;
	keep name stu_id Score1-Score3;
run;

proc print;
run;


data Score1;
input name $ id itime Score;
cards;
nahid 111 1 89
nahid 111 2 32
nahid 111 3 .
marzia 112 1 90
marzia 112 3 92
ferdous 113 1 .
ferdous 113 3 90
khan 114 1 90
khan 114 2 .
khan 114 3 95
dhaka 115 1 87
dhaka 115 2 91
dhaka 115 3 80
thakurgaon 116 1 89
;
run;

proc print data= Score1;
run;

data oneper;
	set Score1;
	by id itime;
	array scores{3} Scores1-Scores3; /* Define the array with the corresponding variables */
	retain Scores1-Scores3;
	
	if first.id then call missing(of Scores1-Scores3); /* Correctly reference the retained variables */
	
	scores{itime} = score; /* Use itime to index into the array */
	if last.id then output;
	
	keep name id Scores1-Scores3;
run;

proc print data=oneper;
run;

 


data oneper1;
	set Score1;
	by id itime;
	array scores{3} Scores1-Scores3; /* Define the array with the corresponding variables */
	*retain Scores1-Scores3;
	scores{itime} = score;
run;
	
data oneper2;
	set Score1;
	by id itime;
	array scores{3} Scores1-Scores3; /* Define the array with the corresponding variables */
	retain Scores1-Scores3;
	scores{itime} = score;
run; 

proc print data=oneper1;
proc print data=oneper2;
run;












