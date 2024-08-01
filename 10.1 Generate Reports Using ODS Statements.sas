/* ODS Statements  */
 
proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/score_data.xlsx"
dbms= xlsx
out= Score0
replace;
run;

proc sort data= Score0;
by gender;
run;

proc freq data= Score0 ;
by gender;
run;

ods pdf file= "/home/u63883623/My Work/SQL/Udemy/Data/out/score.pdf";
ods rtf file= "/home/u63883623/My Work/SQL/Udemy/Data/out/score.rtf";

proc freq data= Score0 ;
by gender;
run;

ods _all_ close;

/* ODS XLSX */

proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/score_data.xlsx"
dbms= xlsx
out= Score0
replace;
run;

proc sort data= Score0;
by gender;
run;

ods excel file= "/home/u63883623/My Work/SQL/Udemy/Data/out/ Score.xlsx"
				options(sheet_interval = "bygroup"
				sheet_label = "Gender="
				embedded_titles="Yes"
				embed_titles_once="Yes");
title "Summery of Scores By Gender";
ods noproctitle;
proc means data= Score0 Maxdec=1 n mean max min;
	by gender;
	var Score1-Score3;
	where gender ne "";
run;

ods _all_ close;


/* 
Coding Exercise
section: ODS
Coding Exercise:
data:
sale_by_state.xlsx
instruction:
1. create Excel report using ODS
2. each Excel sheet is created for each state
3. report sale average/mean for 3 sale variables sale 1- 3
*/

proc import datafile=" /home/u63883623/My Work/SQL/Udemy/Data/sale_by_state.xlsx"
dbms= xlsx
out= Sale0
replace;
run;

proc print data= Sale0;
run;

proc sort data= Sale0;
by State;
run;

ods excel file= "/home/u63883623/My Work/SQL/Udemy/Data/Sale.xlsx"
	options(sheet_interval = "bygroup"
				sheet_label = "State="
				embedded_titles="Yes"
				embed_titles_once="Yes");
ods noproctitle;
proc means data= sale0 mean;
by State;
var Sale1 - Sale3;
run;
ods _ALL_ CLOSE;




















			 