/* Adapted from "07.1 Array.sas" — original used PROC IMPORT of
   score_data_miss999.xlsx; replaced here with an equivalent inline
   sample (same Score1/Score2/Score3 shape, with a 999 sentinel for
   missing values) so the array logic below runs unmodified. */

data Score0;
    input Name $ Gender $ Score1 Score2 Score3;
    datalines;
Nahid m 92 88 999
Marzia f 78 999 75
Abid m 999 70 68
Sadia f 88 91 85
Rafi m 55 60 58
Tania f 99 95 97
Kamal m 999 74 71
Nadia f 61 58 63
;
run;

data array;
	set Score0;

	array aone{3} Score1 Score2 Score3;

	do i = 1 to 3;
		if aone{i} = . then aone{i}= 999;
		if aone{i} = 69 then aone{i}= 699;
	end;
run;

/* Arry Variable */

data score1 (drop= i);
	set score0 ;
	array col{3} _numeric_;

	do i= 1 to dim(col);
	if col(i)= 999 then col(i)=.;
	end;
	Avg_score = mean(score1, Score2, Score3);
	format Avg_Score 2.;

run;

data Score2 (drop= p);
	set score1;
	array col2{3} score1 Score2 Score3;
	array Avg_dif(3);
	do p = 1 to dim(col2);
	avg_dif(p)= col2(p) - Avg_score;
	format Avg_score avg_dif1 - avg_dif3 2.;
 end;
run;

proc print data=array;
	title "999 Sentinel Replaced With 699 Where It Was 69";
run;

proc print data=score2;
	title "Missing-Sentinel Cleaned, Average and Deltas Computed";
run;
