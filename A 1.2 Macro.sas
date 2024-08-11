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
%score_mean(out_mean=Mea);

%macro score_mean1(out_mean1=);

    proc means data=Score0 mean maxdec=1;
        var &out_mean1;
    run;

%mend score_mean1; 


%Score_mean1(out_mean1= Score1);
%Score_mean1(out_mean1= Score2);
%Score_mean1(out_mean1= Score3);























