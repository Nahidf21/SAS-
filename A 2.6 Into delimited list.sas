proc import datafile="/home/u63883623/My Work/Udemy SAS Base/Data/score_data_id.xlsx"
dbms= xlsx
out= Score0
replace;
proc print data= Score0;
run;

proc sql;
select distinct gender 
into : gen separated by ' '
from Score0;
quit;

proc sort data= score0;
by gender;
run;

proc means data= Score0 mean maxdec=0;
var Score1 Score2 Score3;
title "The class of gender are &gen";
by gender;
run;


/* Another Example */

proc import datafile="/home/u63883623/My Work/Udemy SAS Base/Data/score_data_id_class.xlsx"
dbms= xlsx
out= Score3
replace;
proc print data= Score3;
run;

proc sql;
select distinct class
into : cl sepatated by " "
from Score3;
quit;

proc means data= Score3 mean;
title "The class are &cl";
var Score1 Score2 Score3;
by class;
run;