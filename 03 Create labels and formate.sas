/* Create Label */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data.xlsx"
DBMS = XLSX
out = ScoreData0
Replace;
run;

Data ScoreData1;
set Scoredata0;
label Score1 = "Math Score"
	  Score2 = "Physic Score"
	  Score3 = "Chamistry Score"
	  ;
run;

Proc print data= ScoreData1 Label;
run; 

Proc print data= ScoreData0 Label Split= "*";
Label Score1 = "Math" * "Score"
	  Score2 = "Physic" * "Score"
	  Score3 = "Chemistry" * "Score"
	  ;
run; 

Proc means data= ScoreData1 mean;
class gender; 
var score1 score2 score3;
output out = Gender_sum median= ;
run;

proc print data= Gender_sum label;
var Gender score1 score2 score3;
run;


/* Assining Formats To Variables  */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data_miss.xlsx"
dbms= xlsx 
out= ScoreDataM0
replace;
run;

data ScoreDataM1;
set ScoreDataM0;
TotalScore = sum(Score1, Score2, Score3);
AveScore = mean(Score1, Score2, Score3);
*GenderU = upcase(Gender);
format AveScore 5.2;
run;

proc print data= ScoreDataM1;
format AveScore 4.1;
var GenderU Score1 Score2 Score3 AveScore TotalScore;
Run; 

/* User defined formate statement  */

proc format;

	value $gender  "m" = "Male"
		           "f" = "Female"
		           other = "Missing"
		           ;
    Value Score  51 -< 60 = "D"
    			 61 -< 70 = "C"
    			 71 -< 80 = "B"
    			 81 - High= "A"
    			 other = "Missing";
run; 
	

proc print data = ScoreDataM1;
run;
	
proc print data = ScoreDataM1;
format gender $gender. AveScore Score.;
run;

/* How to Save my User defined formate permanentely  */

libname MyFrmt "/home/u63883623/My Work/SQL/Udemy/MY Format";

proc format library= myfrmt;
	value $gender "m"= "Male"
				  "f"= "Female"
				  other = "Missing";
				  
	value ScoreM 51 -< 60 = "D"
    			   61 -< 70 = "C"
    			   71 -< 80 = "B"
    			   81 - High= "A"
    			   other = "Missing";
run;

/* Check your formate librayes internal logic  */

proc format library=Myfrmt fmtlib;
run;


proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data_miss.xlsx"
dbms= xlsx 
out= ScoreDataM0
replace;
run;

data ScoreDataM1;
set ScoreDataM0;
TotalScore = sum(Score1, Score2, Score3);
AveScore = mean(Score1, Score2, Score3);
*GenderU = upcase(Gender);
format AveScore 5.2;
run;

libname myfrmt "/home/u63883623/My Work/SQL/Udemy/MY Format";
options fmtsearch= (myfrmt work library);

proc print data= ScoreDataM1;
format gender $gender. AveScore  ScoreM.;
run;


/* Try with another dataset  */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/DATA_commas.csv"
dbms= dlm
out = CSV_data
replace;
getnames=no;
delimiter= ","

run;

/* cleane the CSV file and label the variables */
data csv_clean;
set csv_Data;
if var2 = " " then var2= "F";
if var3 = . then var3= 40;
label var1 = "Name"
	  Var2 = "Gender"
	  var3 = "Math Score"
	  Var4 = "Chamestry Score"
	  ;
AvgScore = mean(Var4, Var3);
run;

/* Create a permanent user defined format libray */

libname myfrmt "/home/u63883623/My Work/SQL/Udemy/MY Format";
proc format library= Myfrmt;
	value Avg 70 -<80 = "Low"
		      81 -<90 = "Mide"
		      91 - high = "Max"
		      ;
run; 

/* This will show the newly created format libray informetions */
proc format library= Myfrmt fmtlib;
run;

/* SAS never autometicall search use defined library  */
/* so We need to add format search statement to search  */
/* our created library */

options fmtsearch=(Myfrmt work library);

proc print data= csv_clean label;
format AvgScore Avg.;
run;






