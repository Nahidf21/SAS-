/* Adapted from "A 1.2 Macro.sas" — original used PROC IMPORT of
   score_data.xlsx; replaced here with an equivalent inline sample
   (same Score1/Score2/Score3/Gender shape) so the macro definitions
   below run unmodified. */

data Score0;
    input Name $ Gender $ Score1 Score2 Score3;
    datalines;
Nahid m 92 88 95
Marzia f 78 82 75
Abid m 65 70 68
Sadia f 88 91 85
Rafi m 55 60 58
Tania f 99 95 97
Kamal m 72 74 71
Nadia f 61 58 63
;
run;

* this is macro veriable;
%let gnd = f;

data Score1;
set Score0;
where gender = "&gnd";
run;

%macro score_mean(out_mean=);
    proc means data=Score0 mean noprint;
        var Score1 Score2 Score3;
        output out=TempMeanScores mean=MeanScore1 MeanScore2 MeanScore3;
    run;

    data &out_mean;
        set TempMeanScores(keep=MeanScore1 MeanScore2 MeanScore3);
    run;
%mend score_mean;

%score_mean(out_mean= Mea);

%macro score_mean1(out_mean1=);

    proc means data=Score0 mean maxdec=1;
        var &out_mean1;
    run;

%mend score_mean1;

%Score_mean1(out_mean1= Score1);
%Score_mean1(out_mean1= Score2);
%Score_mean1(out_mean1= Score3);

proc print data=Score1;
	title "Female Students (macro variable &gnd)";
run;

proc print data=Mea;
	title "Macro-Computed Mean Scores";
run;
