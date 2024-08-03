proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data.xlsx"
dbms= xlsx
out= Score0
replace;
run;

%macro info;
	Score0
%mend info;

proc print data= %info;
title "%info";
run;

%macro print;
	proc print data= %info;
title "%info";
run;

%mend print;

%print;

%macro Summery;
	
	proc means data= Score0 Mean min max maxdec=2;
	var Score1 Score2 Score3;
	run;

%mend Summery;

%Summery;


Proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/sale_by_state.xlsx"
out= Sale_State
dbms= xlsx
replace;
run;

proc sort data= Sale_State;
by state;
run;

proc freq data= Sale_State;
by State;
run;