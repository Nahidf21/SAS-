/* Read data delimited by blanks  */

data data_blanks;
infile "/home/u63883623/My Work/SQL/Udemy/Data/DATA_blanks.txt" dlm= "";
input Name $ Gender $ Age Weight;
run;

proc print data = data_blanks;
run; 

/* Read data delimited by commas */

data data_commas;
infile "/home/u63883623/My Work/SQL/Udemy/Data/DATA_commas.csv" dlm= ",";
input Name $ Gender $ Age Weight;
run;

proc print data = data_commas;
run;

/* Read Data delimited by column  */ 
/* delimiter */

data data_column;
infile "/home/u63883623/My Work/SQL/Udemy/Data/DATA_column.txt";
input 
Name $ 1-5
Gender $ 6
Weight 7 - 9
DOB $ 10 - 19
;
run;

proc print data= data_column;
run;

/* Read Data delimited by column  */ 
/* Informate */

data data_column;
infile "/home/u63883623/My Work/SQL/Udemy/Data/DATA_column.txt";
input 
Name $ 5.
Gender $ 1.
Weight 3.
DOB mmddyy10.;
*format dob date9.;
run;

proc print data= data_column;
format dob date9.;
run;

/* How to create a permanent data set */

libname Raw_Data "/home/u63883623";

data raw_data.student_info;
input 
Name $ 6. 
Age 2.
DOB mmddyy10.;
format DOB date9.;
cards;
Nahid 212/21/2021
Marzia3111/21/2022
Abid  2701/21/2021
Sadia 3004/21/2024
;

run;

proc print data= raw_data.student_info;
run;

/* Import data from Proc stape  */

proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/excel_data.xlsx"
DBMS= xlsx out= xlsx_data replace;
run;

proc print;
title "Normal Proc Import Statement"
run;
/* Enable the getnames options in the proc import statement  */

proc import datafile = "/home/u63883623/My Work/SQL/Udemy/Data/excel_data.xlsx"
DBMS = xlsx out= Xlsx_data1 replace;
getnames= on;
run;

proc print;
title "Getnames on";
format score_raw 2.;
run;
/* Specific Sheet if we have multiple sheets in a single xlsx file */

proc import datafile = "/home/u63883623/My Work/SQL/Udemy/Data/excel_data.xlsx"
DBMS = xlsx out= Xlsx_data2 replace;
sheet="name_class";
run;

proc print;
title "Sheet";
run;
/* We can select specific area of data from a xlsx file using 
range statement in proc import statement */

proc import datafile = "/home/u63883623/My Work/SQL/Udemy/Data/excel_data.xlsx"
DBMS= xlsx out= xlsx_range replace;
range= "name_class$A1:B4";
run;
proc print;
title "Range";
run;

/* Proc import Read data Delimited external data files  */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/DATA_blanks.txt"
	out = blank_delimiters
	dbms= dlm
	replace;
	guessingrows= 2;
	delimiter= "";
	getnames=no;
run;

proc print;
run;

/* if we have unusefull collumns then we can remove thouse columns from data stap */

data blanks_data;
	set blank_delimiters;
	drop var5;
run;

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/DATA_commas.csv"
	dbms= dlm
	out = data_commas
	replace;
	delimiter= ",";
	guessingrows=2;
	getnames=no;
run;



proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/other_del_data.txt"
	dbms= DLM
	out = data_other
	replace;
	delimiter= ":";
	guessingrows=2;
	getnames= on;
run; 

/* If we have unusefull row the we can clean this row using if condition */
data clean_dataOther;
	set data_other;
	if var1 = "" then delete;
run;

/* Coding exercise: Formatted input  */

data formatted_data;
	infile "/home/u63883623/My Work/SQL/Udemy/Data/Patient_HD_age.txt";
	input
	Pid 1.
	Sdate mmddyy10.
	Edate mmddyy10.
	age 2.
	;
run;


proc print data= formatted_data ;
	format sdate Edate date9.; 
	new_age = Edate - Sdate;
	
run;

libname NewData "/home/u63883623";

data newdata.formatted_data;
	set formatted_data;
run;


/* direct approch or the shortcut approch this approch is good for time saving */
data newdata.formatted_data1;
	infile "/home/u63883623/My Work/SQL/Udemy/Data/Patient_HD_age.txt";
	input
	Pid 1.
	Sdate mmddyy10.
	Edate mmddyy10.
	age 2.
	;
	format sdate edate date9.;
run;





