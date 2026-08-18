/* Adapted from "8.1 Merging.sas" — original used PROC IMPORT of
   score_data_id_partial.xlsx and score_data_id.xlsx; replaced here
   with two equivalent inline samples sharing a stu_id key so the
   interleave/match-merge logic below runs unmodified. */

data data1;
    input stu_id Name $ Gender $ Score1 Score2;
    datalines;
1 Nahid m 92 88
2 Marzia f 78 82
3 Abid m 65 70
4 Sadia f 88 91
;
run;

data data2;
    input stu_id Name $ Gender $ Score1 Score2 Score3;
    datalines;
1 Nahid m 92 88 95
2 Marzia f 78 82 75
3 Abid m 65 70 68
4 Sadia f 88 91 85
5 Rafi m 55 60 58
6 Tania f 99 95 97
;
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

/* Unmatched Observations  */

data Match1(drop= Stu_id);
merge Data2(in= A drop= score3) Data1(In= B drop= Score2);
by Stu_id;
if A=1 and B=0;
run;

proc print data= Match1;
title "Match (rows only in data2, not data1)";
run;
