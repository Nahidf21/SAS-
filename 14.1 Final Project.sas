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



proc means data= Weight1 ;
var weight0 weight1 weight2 walk_steps;
run;

/* 
From this analysis we can say, weight1 and weight2 are caring some abnormal data points
 */

ods noproctitle;
proc freq data= weight1;
table gender*(weight0 weight1 weight2)*walk_steps/ nocum nopercent nocol norow ;
run;
ods _all_ close;

/* 
From this analysis we can say, weight1 and weight2 are caring some abnormal data points
and the abnormal value is 9999
 */

/* Data Cleaning Stape  */

data weight2;
	set weight1;
	Array wt{2} weight1 weight2;
	
	do i= 1 to 2;
	if wt{i}= 9999 then wt{i}= .;
	end;
run;

data weight3;
	set weight2;
	wd1 = weight0 - weight1;
	wd2 = weight0- weight2;
	wd12 = weight1 - weight2;
	keep gender walk_steps wd2 ;
run;

proc sort data= weight3;
by walk_steps;
run;

proc means data= weight3;
class walk_steps;
var wd2;
run;

proc freq data= weight3;
table walk_steps*wd2/ nocol nocum nopercent norow;
run;

data ws_group;
	set weight3;
	length wg $ 25;
	if walk_steps < 5000 then WG = "less_then5k";
	else if walk_steps <= 10000 and walk_steps >= 5000 then WG = "5000 - 10000";
	else WG = "Greater Then 10000";
	
run;


data ws_group1;
	set ws_group;
	
	if wd2 <= 0 and wd2 ne . then Losing = "Not losing weight";
	else if  wd2 > 5 then Losing = "greater than 5lb";
	else if wd2<= 5 and wd2 >0 then Losing = "Less then 5lb";
	else Losing = "Missing";
run;

libname Project "/home/u63883623/My Work/SQL/Udemy/Data";

data project.Weight_loos;
	set ws_group1;
run;

title "The Final Result Of the Weight Loos Analysis";
proc freq data= project.weight_loos;
table WG*Losing/ nocol norow  ;
run;
title;













