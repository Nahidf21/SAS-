proc import datafile= "/home/u63883623/My Work/Udemy SAS Base/Data/score_data.xlsx"
dbms= xlsx
out= Score0
replace;
run;

proc print data= Score0;
run;

* this is macro veriable;
%let gnd = f;

data Score1;
set Score0;
where gender = "&gnd";
run;
options nosymbolgen;


%macro score_mean;

proc means data= Score0;
var Score1 Score2 Score3;
run;

%mend;

%score_mean;

data scoreM;
set %score_mean;
run;

%macro score_mean;
    proc means data=Score0 mean noprint;
        var Score1 Score2 Score3;
        output out=MeanScores mean=MeanScore1 MeanScore2 MeanScore3;
    run;
%mend;

%score_mean;

proc print data= MeanScores;
run;

data scoreM;
    set MeanScores;
run;

/* 
The Macro peramiter is called macro variabl
*/



%macro score_mean(out_mean = );
    proc means data=Score0 mean noprint ;
        var Score1 Score2 Score3;
        output out= TempMeanScores ;
        run;
        
        data &out_mean;
        set TempMeanScores(keep= MeanScore1 meanScore2 meanScore3);
        run;
%mend score_mean;




%Score_mean(out_mean= Mea);




%macro score_mean(out_mean=);
    proc means data=Score0 mean noprint;
        var Score1 Score2 Score3;
        output out=TempMeanScores mean=MeanScore1 MeanScore2 MeanScore3;
    run;

    data &out_mean;
        set TempMeanScores(keep=MeanScore1 MeanScore2 MeanScore3);
    run;
%mend score_mean;

/* Call the macro */
/* Automatic Macro variable providet by sas 
&sysdate &sysdate9 &systime e.t.c
 */
%score_mean(out_mean=Mea);

%macro score_mean1(out_mean1=);
	footnote "create date &systime &sysdate";
    proc means data=Score0 mean maxdec=1;
        var &out_mean1;
    run;

%mend score_mean1; 

options symbolgen;
%Score_mean1(out_mean1= Score1);
%Score_mean1(out_mean1= Score2);
%Score_mean1(out_mean1= Score3);

options nosymbolgen;




/* 
From the Symbolgen option we can identyfy the macro in the 
log window.
 */

%let x= Score1 Score2 Score3;

proc means data= Score0;
var &x;
run;

%put &x;
%put "The X= &x";

/* 
The %put help us to give details informetion in the log
result.
*/

/* 
%str() this is called sas Macro Quoting Function
*/
options symbolgen;
%let the_mean = %str(proc means data= Score0 mean; run;);
&the_mean;
options nosymbolgen;



options symbolgen;
%let x1= Score1 Score2;

%let mean_moreControl = proc means data= Score0 mean %str(;) var &x1 %str(;) run %str(;);

&mean_moreControl;

options nosymbolgen;

Options symbolgen;
ods noproctitle;
%let x1= Score3;
%let s= %Str(;);
%let mean = proc means data= Score0 mean &s var &x1 &s 
			title "The Mean of &x1 " &s run &s ;
&mean;
run;
ods _ALL_ CLOSE;
options nosymbolgen;


/* 
%upcase Statement
 */


%let M_string = m;

data ScoreM;
set Score0;
where name contains "&M_string";
run;


%let M_string = "m";
data ScoreM;
set Score0;
where name contains %upcase(&M_string);
run;

proc import datafile="/home/u63883623/My Work/Udemy SAS Advanced Programming/Data/score_data_miss_birthdate_new.xlsx"
dbms= xlsx
out = ScoreB0
replace;
run;

/* SubStr macro function */
%let bdate= 31Jul2007;

proc print data= ScoreB0;
where birthdate between "01Jan2007"d and "31%substr(&bdate,3)"d;
run;

/* 
%Scan(agrument,position)
 */

%let arg= Aug/2017;

proc print data = ScoreB0;
Title "The month name %scan(&arg,1)";
where birthdate between "05Feb2007"d and "31%scan(&arg,1)2007"d;
run;







