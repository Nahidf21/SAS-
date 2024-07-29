data donors1;
input ID Type $ Units;
cards;

2304 O 16
1129 A 48
1129 A 50
1129 A 57
2486 B 63
;
run;

data donors2;
input ID Code Units;
cards;
6488 65 27
1129 63 32
5438 62 39
2304 61 45
1387 64 67
;
run;

proc sort data=donors1;
by id;
run;
proc sort data=donors2;
by id;
run;
proc print data= donors1;
title "Table1";
run;
proc print data= donors2;
title "Table2";
run;

data merging0;
	merge donors1 donors2;
	by id;
run;

data merging1;
	merge donors1 (in= A) donors2(in=B);
	by id;
	if A=1 and B=1;
run;
proc print data= merging0;
title "Table3";
run;


data actor1;
input Actor $ Prop $;
cards;
Curly Anvill
Larry Ladder
Moe Poker
;
run;

data actor2;
input Actor $ Prop $;
cards;
Curly Ladder
Moe Pliers
;
run;

data merg1;
Set Actor1 Actor2;
run;

data merg1by;
Set Actor1 Actor2;
by Actor;
run;

proc print data= merg1;
run;

proc print data= merg1by;
run;


Data health1;
input ID Sex $;
Cards;
1129 F
1274 F
1387 F
2304 F
2486 F
;
run;

Data health2;
input ID Height;
Cards;
1129 61
1387 64
2304 61
;
run;

data merged;
	merge health1(in = in1) health2(in = in2);
	by id;
	if in1 and in2;
	run;
	
	
	
/* coding exercise: */

/* data: */
/* score_data_id_class.xlsx: student-level info */
/* class_info.xlsx: class-level info */
/* instruction: */
/* merge class information to student-level data by variable class. */
/* Only the observations with class-level information will */
/* be kept in the merged data. */

proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/score_data_id_class.xlsx"
dbms= xlsx
out = Student_info
replace;
run;

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/class_info.xlsx"
dbms= xlsx
out = Class_info
replace;
run;

proc sort data= Student_info;
by class;
run;
proc sort data=class_info;
by class;
run;

proc print data= student_info;
run;
proc print data= class_info;
run;

data Merge1;
	merge Student_info (in = A) class_info (in =B );
	by class;
	if A=1 and B=1;
run;





