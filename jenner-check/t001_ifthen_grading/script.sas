/* Adapted from "02 Work With Data.sas" — original used
   PROC IMPORT of score_data.xlsx; replaced here with an equivalent
   inline sample carrying the same Score1/Score2/Score3/Gender shape
   so the grading logic below runs unmodified. */

data data_ifThen;
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

data data_ifthen1;
    set data_ifThen;

    AvgScore = mean(Score1, Score2, Score3);
    format AvgScore 5.2 Grade $4.;

    if AvgScore >= 80 and AvgScore <= 89 then do;
        Grade = "B";
        Level = 3;
    end;
    else if AvgScore >= 70 and AvgScore <= 79 then do;
        Grade = "C";
        Level = 2;
    end;
    else if AvgScore >= 90 then do;
        Grade = "A";
        Level = 4;
    end;
    else do;
        Grade = "Pass";
        Level = 1;
    end;

    Grade = upcase(Grade);
    Gender = upcase(Gender);

    if not missing(Score1) and not missing(Score2) and not missing(Score3) then Take = "Complete";
    else Take = "Not Complete";
run;

/* length keyword  */

data score_length;
	set data_ifthen1;
	length gender_full $ 7;
	if gender = "M" then gender_full = "Male";
	else gender_full = "Female";
run;

/* Subsetting if statement  */

data score_m;
	set data_ifThen;
	if gender = "f" then delete;
run;

data score_f;
	set data_ifThen;
	if gender = "f";
run;

proc print data=data_ifthen1;
	title "Graded Scores";
run;

proc print data=score_length;
	title "With Gender Full Name";
run;

proc print data=score_f;
	title "Female Only";
run;
