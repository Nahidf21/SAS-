proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/Chara_data1.xlsx" 
		dbms=XLSX out=test replace;
run;

proc print;
run;

data scan;
	set test;
	SC_file_outD=Scan(full_name, 2);
	SC_file_WithD=Scan(full_name, 2, " ,/");
	Name_ch=Name ||"/"||put(Score, 4.1);
	name_SubSTR=substr(Full_name, 5, 6);
	name_SubSTR_oc=substr(Full_name, 5);
run;

proc print;
	var Full_name SC_file_outD SC_file_WithD name_SubSTR name_SubSTR_oc;
run;

proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/Chara_data1.xlsx" 
		dbms=XLSX out=test replace;
run;

data phone_number;
	set test;
	imdex_f=index(phone, "408");
run;

data phone_number;
	set test;
	index_number=index(phone, "408");
	*if index_number = 1;

	if index_number >1;
run;

/*
section: Modifying character and numeric data values

coding Exercise:

data:

chara_data2.xlsx; variable DOB is a character var in this data set.

Instruction:

1. creating new vars DOB_year, DOB_month, DOB_day by

Extracting year and day from var DOB using Scan function

Extracting month from var DOB using Substr function

2. creating new vars DOB_new1, DOB_new2 by concatenating

vars DOB_year, DOB_month, DOB_day using TRIM and CATX function

the new values will be in the form of 2007, 9, 23

3. Using Tranwrd function to replace 'missing' with ' 'in var raw_score

4. Using Index function to search for 2007 in the values of DOB,

then to create a subset data CD2

*/
Proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/Chara_data2.xlsx" 
		dbms=XLSX out=Char_data0 replace;
run;

proc print data=char_data0;
run;

/*
1. creating new vars DOB_year, DOB_month, DOB_day by

Extracting year and day from var DOB using Scan function

Extracting month from var DOB using Substr function
*/
data char_data1;
	set char_data0;
	DOB_year=Scan(DOB, 3, "/");
	DOB_Day=Scan(DOB, 2, "/");
	DOB_Month=subSTR(DOB, 1, 1);
run;

/*
2. creating new vars DOB_new1, DOB_new2 by concatenating

vars DOB_year, DOB_month, DOB_day using TRIM and CATX function

the new values will be in the form of 2007, 9, 23

*/
Data Char_data2;
	set char_data1;
	DOB_new1=Trim(DOB_Year)||","|| Trim(DOB_day)||","|| Trim(DOB_Month);
	DOB_new2=CATX(",", DOB_Year, DOB_day, DOB_Month);
run;

/*
3. Using Tranwrd function to replace 'missing' with ' 'in var raw_score
*/
Data Char_data3;
	Set Char_data2;
	raw_Score=Tranwrd(raw_Score, "missing", " ");
	put raw_score=;
run;

/* 
4. Using Index function to search for 2007 in the values of DOB,

then to create a subset data CD2

*/


Data Char_data4;
	set char_data3;
	CD2 = index(DOB, "2007");
	if CD2 >0;
run;






























