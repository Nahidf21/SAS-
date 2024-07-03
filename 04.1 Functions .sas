						/* TranWRD Function  */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/Chara_data1.xlsx"
dbms= XLSX
out= ScoreData0
replace;
run;
proc print data= ScoreData0;
run;

data Score_clean;
set ScoreData0;
length New_Phone $ 12;
New_Phone = TRANWRD(Phone,"000","408");
NEw_FullName = TRANWRD(Full_name, ",", "");

run;


               /* Modifying Numeric Values With Functions */
              
proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data.xlsx"
dbms= XLSX
out= ScoreData0
replace;
run;
proc print data= ScoreData0;
run;

/* INT and ROUND FUNCTION */
data Score_clean;
set ScoreData0;
AvgScore_INT = int(mean(Score1, Score2,Score3));
AvgScore_round_1 = round(mean(Score1, Score2,Score3),1);
AvgScore_round_dot1 = round(mean(Score1, Score2,Score3),.1);

run;

					/* Smallest $ Largest Function */
					
proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data.xlsx"
dbms= XLSX
out= ScoreData0
replace;
run;
proc print data= ScoreData0;
run;

data maxminvalues;
set Scoredata0;
Maximum_value = Max(Score1,Score2,Score3);
Minimum_Value = Min(Score1,Score2, Score3);
Small_2nd_Score = Smallest(2,Score1, Score2, Score3);
Largest_2nd_Score = Largest(2,Score1, Score2, Score3);
run; 


/* Rand Function  */

data k1;
	do i=1 to 10;
	rand_num1 = rand("Uniform");
	rand_num2 = rand("Uniform", 1,10);
	output;
end;
run;


						/* Streaminit Function  */
						
data k1;
	call streaminit(8); * this is the seed; 
	do i=1 to 10;
	rand_num1 = rand("integer", 0,1);
	*rand_num2 = rand("Uniform", 1,10);
	output;
end;
run;












