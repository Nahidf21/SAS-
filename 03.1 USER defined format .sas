/* Extra User Defined Format Functions  */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/Proc+format_CNTLIN.xlsx"
	dbms= xlsx 
	out= formatDATA
	replace;
run;


data fmt;
retain fmtname "$states";
length start $2 label $2;
input Start $  label $;
cards;
01 TX
02 CA
03 NC
;
run;


proc format CNTlin= fmt;
run;

data New_formate;
	set formatData;
	format state $states.;
run;


/* other way  */

proc format;

value $StateFmt "01" = "TX"
				"02"= "FL"
				"03" = "LA"
				;
run;

data stateFmt2;
set formatData;
format state $stateFmt.;
run;

/* Examples Practice */
proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/Sale.xlsx"
dbms= xlsx
out = sale0
replace;
run;
proc print;
run;


data sale1;
set sale0;

AvgSale = mean(sale_m1, Sale_m2, Sale_m3);
label Emid = "Employee ID"
	  sale_m1 = "Sale in Jan"
	  sale_m2 = "sale in Feb"
	  sale_m3 = "Sale in Mar"
	  AvgSale = "AvgSale of 1st Quarter1"
	  ;
format avgSale  sale_m1 -- sale_m3 dollar10.2;
run;


proc print data= Sale1 label;
run;

/* Another Example Practice */
libname USDFMT "/home/u63883623/My Work/SQL/Udemy/Data";

proc format library=usdfmt;
	value SaleGroup low -< 700 = "Need Improvement"
					700 -< 900 = "Good"
					900 - high = "Top Sale"
					;
run; 

options fmtsearch= (usdfmt, work, libraries);

proc print data= sale1 label;
format AvgSale SaleGroup.;
run; 











