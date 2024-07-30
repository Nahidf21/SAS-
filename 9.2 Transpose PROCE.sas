/* Transpose PROCE */

proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/score_data_id.xlsx"
dbms= xlsx
out= Score0
replace;
run;


proc sort data= Score0;
by stu_id;
run;
proc print data= Score0;
run;

proc transpose data= Score0 out = Score_trans;
	by stu_id;
	var Score1-Score2;
run;

proc print data= Score_trans;
run;

proc transpose data= Score0 out = Score_trans (rename= (_Name_= Score_types COL1= Score Stu_id= Student_ID) 
								drop= _LABEL_ where= (Score ne .));
	by stu_id name gender;
	var Score1-Score2;
run;

proc print data= Score_trans;
run;

/* Subject to one object */

proc transpose data= Score_trans prefix= New
			   out= Score_retranspos (drop= _name_);
	by Student_id name gender;
	id Score_types;
	var Score;
run;


 
/* 
instruction:

0. change value 9999 to missing (periods)

1. transform data from one record per PID (patient ID)

to multiple record per PID using Proc Transpose

2. Values of 3 weight vars (weight0 weight1 weight2)

will be transposed

3. all vars in the input data will be included in the transposed data 
*/

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/Weight_loss.xlsx"
dbms= xlsx
out= Weight0
replace;
run;

proc print data= Weight0;
run;

data Weight_cl (drop= i);
set Weight0;
	Array wt{3} weight0-weight2;
	Do i = 1 to 3;
	
	if wt{i}= 9999 then wt{i} = .;
	end;
run;

proc sort data= Weight_cl;
by pid walk_steps;
run;

proc transpose data= Weight_cl 
			   out= Weight_tr (rename= (_name_= Types col1= All_Score) drop= _LABEL_) ;
	by pid gender walk_steps;
	var weight0-weight2 ;
run;










