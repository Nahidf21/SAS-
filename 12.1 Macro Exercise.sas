proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/allscore.xlsx"
dbms= xlsx
out= AllScore
replace;
run;


proc print data= AllScore;
run;

%let Scoret= Read;

%macro print (gnd = ,Score =  );
ods noproctitle;
proc univariate data= AllScore ;
var &Score ;
where gender = "&gnd";
title "&Scoret and &Score";
run;
ods _ALL_ CLOSE;
%mend print;

%print(gnd=m ,Score = math )
%print(gnd=f ,Score = write )
%print(gnd=f ,Score = Science )