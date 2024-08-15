proc import datafile="/home/u63883623/My Work/Udemy SAS Base/Data/score_data_id.xlsx"
dbms= xlsx
out= Score0
replace;
proc print data= Score0;
run;


options symbolgen;

data score1;
set score0;
call symput("student1" || left(Stu_id), trim(Name));
run;

data score2;
set Score1;
where stu_id = 5;
Student_name_macro = symget("Student" || left(Stu_id));

run;

%let Stu_id= 5;  * we need to create a macro variable for executing the Symput function;
proc print data= Score1;
where stu_id =&Stu_id;
title " &&Student1&Stu_id";
footnote "Student Informetion for &&student1&Stu_id";
run;

