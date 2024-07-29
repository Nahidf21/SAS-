/*  Interleaving  */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data_id_partial.xlsx"
dbms= XLSX
out = data1
replace;
run;


proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data_id.xlsx"
dbms= XLSX
out = data2
replace;
run;

proc print data= data1;
title "Data1";
run;

proc print data= data2;
title "Data2";
run;

/* first short the data  */
proc sort data= data1;
by stu_id;
run;

proc sort data= data2;
by stu_id;
run;

data interleave;
set data1 data2;
by stu_id;
run;

proc print data= interleave;
title "interleave";
run;

/* Match Merging  */

Data MatchData;

merge data1 data2;
by stu_id;
run;

proc print data= MatchData;
title "Match Data";
run;


/* Types Of match merge */

/* One to one merge, One to many merge, and many to many merge */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data_id_partial_score4_genderNA.xlsx"
dbms= XLSX
out = data01
replace;
run;

proc sort data= data01;
by stu_id;
run;

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data_id.xlsx"
dbms= XLSX
out = data02
replace;
run;

proc sort data= data02;
by stu_id;
run;

data MAA;
merge data02 data01;
by stu_id;
run;

/* Rename veriable and when we merge  */
data MMA;
merge data01 data02 (rename= (gender = gender_02));
by stu_id;
run;

data MMA;
merge data02 data01 (rename= (gender = gender_01));
by stu_id;
run;

/* Unmatched Observations  */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data_id_partial_score4_genderNA.xlsx"
dbms= XLSX
out = data01
replace;
run;

proc sort data= data01;
by stu_id;
run;

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data_id.xlsx"
dbms= XLSX
out = data02
replace;
run;

proc sort data= data02;
by stu_id;
run;


data Match1(drop= Stu_id);
merge Data02(in= A drop= score3) Data01(In= B drop= Score4);
by Stu_id;
if A=1 and B=0;
run;

/* Here we can say that, If we want to keep specific data velues from a table and  */
/* remove common observetions from the table then we can apply (IN= 1 or 0) IN=1 means */
/* keep this observetions and IN=0 means remove this observetions. */

proc print data= Match1;
title "Match";
run;
proc print data= data01;
title "Data1";
run;
proc print data= data02;
title "Data2";
run;












