/* Array  */
proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data.xlsx"
dbms= XLSX 
out = Score0
replace;
run;

data array;
	set Score0;
	
	array aone{3} Score1 Score2 Score3;
	
	do i = 1 to 3;
		if aone{i} = . then aone{i}= 999;
		if aone{i} = 69 then aone{i}= 699;
	end;
run;


/* Arry Variable */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data_miss999.xlsx"
dbms= XLSX
out = score0
replace;
run;

data score1 (drop= i);
	set score0 ;
	array col{3} _numeric_;
	
	do i= 1 to dim(col);
	if col(i)= 999 then col(i)=.;
	end;
	Avg_score = mean(score1, Score2, Score3);
	format Avg_Score 2.;
	
run;

data Score2 (drop= p);
	set score1;
	array col2{3} score1 Score2 Score3;
	array Avg_dif(3);
	do p = 1 to dim(col2);
	avg_dif(p)= col2(p) - Avg_score;
	format Avg_score avg_dif1 - avg_dif3 2.;
 end;