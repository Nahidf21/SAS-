/* SCAN Function  */
/* Separate a charecter value and obtain a specifid word/ String */



					/* Convert Charecter data to numerical data */
					/* Convert numerical data to charecter data */
					
					
proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/Convert+Data.xlsx" 
		dbms=XLSX out=ScoreData0 replace;
run;

proc print;
run;

/* character to numeric  */
data ScoreData1;
	set ScoreData0;

	/* Auto COnversion */
	Score_AutoC=raw_score * 1;

	/* Conversion using input function */
	Score_Number=input(Raw_score, 7.);
run;

/* Numeric to chatagorical */
data ScoreData2;
	set ScoreData0;

	/* 	Auto Conversion */
	Gender_AutoC=gender||'/'||gender_code;

	/* 	using put function */
	gender_Character=put(gender_code, 8.);
run;

proc print;
run;

						/* Lets work with SCAN Function*/
						
proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/Chara_data.xlsx" 
		dbms=XLSX out=ChData0 replace;
proc print;
run;

data ChData1;
	set chdata0;
	First_Name=SCAN(full_name, 1, ",: ");
	Last_Name=SCAN(full_name, 2, ",: ");

	/* Concatenate */
	NameC=catx(" ", First_name, Last_name);
	NameM=First_name||""||Last_name;
run;

						/* SubSTR function  */
						
						
proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/Chara_data1.xlsx" 
		dbms=XLSX out=ChData0 replace;
run;

proc print data=ChData0;
run;

data ChData1;
	set chData0;
	Extract=SubSTR(phone, 1, 3);

	If Extract="000" then
		SubSTR(Phone, 1, 3)="111";
run;





				/* Trim And CATx functions used for Trim and concatenate Character Variables  */
				

Proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/Chara_data.xlsx"
dbms= XLSX
out = ChData0
replace;
run;
proc print data = ChData0;
run;

data ChData1;
set chData0;

First_name = Scan(Full_name,1, " ,:");
Last_name = Scan(Full_name,2," ,:");
ProperName1 = First_name||" "||Last_name;
ProperName2 = trim(First_name)||", "||trim(Last_name);
ProperName3 = CATx(", ",First_name, Last_name);
run; 

proc print data= ChData1;
run;



								/* Index Function */


Proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/Chara_data1.xlsx"
dbms= XLSX
out = ChData0
replace;
run;
proc print data = ChData0;
run;


data ChData1;
set ChData0;

Index_S_num = index(upcase(name), "S");
Index_SA_num = index(upcase(name), "SA");
Index_Tim_num = index(upcase(name), "TIM");
Index_Phone_code = index(phone, "408");
if index_phone_code = 1;

run;



									/* Find Function  */
/* 					The Index function and the find function are same */
/* 							but Find function has the modifier */


Proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/Chara_data1.xlsx"
dbms= XLSX
out = ChData0
replace;
run;
proc print data = ChData0;
run;


data ChData1;
set chdata0;

Find_m = find(name,"m");
Find_m_with_Upper = find(name,"m","i");
find_m_with_upper_Start = find(name, "m","i",2);
find_m_with_upper_Start_riv = find(name, "a","i",-4);
run;

proc print data= chdata1;
run;


/* 									Upcase , LowCase and propcase*/


Proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/Chara_data1.xlsx"
dbms= XLSX
out = ChData0
replace;
run;
proc print data = ChData0;
run;

data ChData1;
set ChData0;

Up_name = upcase(Full_name);
Low_name = lowcase(Full_name);
pro_name = Propcase(Full_name," :,");
drop name;
run;














