proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/Weight_loss.xlsx"
dbms= xlsx
out = Weight0
replace;
run;

proc print data= Weight0;
run;

proc sort data= Weight0 out= Weight1;
by gender;
run;

ods noproctitle;
proc freq data= weight1;
table gender*(weight0 weight1 weight2)*walk_steps/ nocum nopercent nocol norow ;
run;
ods _all_ close;

