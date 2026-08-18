/* Adapted from "9.2 Transpose PROCE.sas" — original used PROC IMPORT
   of score_data_id.xlsx; replaced here with an equivalent inline
   sample (same stu_id/Name/Gender/Score1/Score2 shape) so the
   transpose logic below runs unmodified. */

data Score0;
    input stu_id Name $ Gender $ Score1 Score2;
    datalines;
1 Nahid m 92 88
2 Marzia f 78 82
3 Abid m 65 70
4 Sadia f 88 91
;
run;

proc sort data= Score0;
by stu_id;
run;

proc print data= Score0;
title "Original Wide Data";
run;

proc transpose data= Score0 out = Score_trans;
	by stu_id;
	var Score1-Score2;
run;

proc print data= Score_trans;
title "Long Format";
run;

proc transpose data= Score0 out = Score_trans (rename= (_Name_= Score_types COL1= Score Stu_id= Student_ID)
								drop= _LABEL_ where= (Score ne .));
	by stu_id name gender;
	var Score1-Score2;
run;

proc print data= Score_trans;
title "Long Format With Renamed Columns";
run;

/* Subject to one object */

proc transpose data= Score_trans prefix= New
			   out= Score_retranspos (drop= _name_);
	by Student_id name gender;
	id Score_types;
	var Score;
run;

proc print data=Score_retranspos;
title "Re-transposed Back To Wide";
run;
