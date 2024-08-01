proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/score_data_miss777.xlsx"
dbms= xlsx
out= Score0
replace;
run;

Data Score;
	set score0;
	Avg_Score = mean(Score1, Score2, Score3);
	putlog "Error: " Score1= Score2= Score3= Avg_Score= 5.2;
	*Error "Error: " Score1= Score2= Scpre3= Avg_Score= 5.2;
	if Avg_Score >=60;
run;

/* Error Check using Error */

data Score1;
	set Score0;
	Array Sc{3} Score1-Score3;
	Do i = 1 to 3;
	
	if sc{i}= 777 then sc{i}= .;
	end;
	Avg_Score = mean(Score1, Score2, Score3);
	error "Error check : " name= Score1= Score2= Score3= Avg_Score= 5.2;
	if Avg_Score <60;
	where score1 and score2 and score3 ne .;
run;


/* Error Check Using Putlog */

data Score1;
	set Score0;
	Array Sc{3} Score1-Score3;
	Do i = 1 to 3;
	
	if sc{i}= 777 then sc{i}= .;
	end;
	Avg_Score = mean(Score1, Score2, Score3);
	putlog "Error check : " name= Score1= Score2= Score3= Avg_Score= 5.2;
	if Avg_Score <60;
	where score1 and score2 and score3 ne .;
run;