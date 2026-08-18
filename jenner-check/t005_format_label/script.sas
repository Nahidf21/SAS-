/* Adapted from "03 Create labels and formate.sas" — original used
   PROC IMPORT of score_data.xlsx; replaced here with an equivalent
   inline sample (same Score1/Score2/Score3/Gender shape) so the
   label/format logic below runs unmodified. The permanent-library
   PROC FORMAT section (libname MyFrmt) is omitted since it wrote to
   a hardcoded local path; the WORK-library proc format below
   demonstrates the same user-defined format technique. */

data ScoreData0;
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

Data ScoreData1;
set Scoredata0;
label Score1 = "Math Score"
	  Score2 = "Physic Score"
	  Score3 = "Chamistry Score"
	  ;
run;

Proc print data= ScoreData1 Label;
run;

Proc print data= ScoreData0 Label Split= "*";
Label Score1 = "Math*Score"
	  Score2 = "Physic*Score"
	  Score3 = "Chemistry*Score"
	  ;
run;

Proc means data= ScoreData1 mean;
class gender;
var score1 score2 score3;
output out = Gender_sum median= ;
run;

proc print data= Gender_sum label;
var Gender score1 score2 score3;
run;

/* User defined formate statement  */

proc format;

	value $gender  "m" = "Male"
		           "f" = "Female"
		           other = "Missing"
		           ;
    Value Score  51 -< 60 = "D"
    			 61 -< 70 = "C"
    			 71 -< 80 = "B"
    			 81 - High= "A"
    			 other = "Missing";
run;

proc print data = ScoreData0;
format gender $gender. Score1 Score.;
title "User-Defined Formats Applied";
run;
