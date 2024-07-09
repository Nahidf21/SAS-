/* Do loop  */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/SAS+date.xlsx"
dbms= XLSX
out = do_data0
replace;
run;


/* Basic Do loop */
Data do_data1 (drop= x Incriment year);
	*set do_data0;
	Present_salary = 50000;
	Incriment = .01;
	year = 0;
	do x = 0 to 10;
		Incriment_inYear = Incriment*Present_salary ;
		Present_salary = Present_salary + (Incriment*Present_salary);
		year_of_experiance = year + 1;
		year = Year +1;
		output;
	end;
	
run;
		
/* Do loop with by statement  */

data Do_loop_by;
	
	do year = 1 to 20 by 4;
	output;
	end;
run;

/* Do loop with list */

data Do_loop_by;
	
	do year = "Nahid Ferdous","Ferdous Marzia","This IS";
	Find_key = Scan(Year,1);
	output;
	end;
run;


/* while  */

data while;
	year = 0;
	Number_of_Year = 0;
	do while (Year <= 29);
		year +1;
		Number_of_Year = Number_of_Year + 1 ;
		output;
	end;
	drop year;
run;


/* Until; */
data while;
	year = 0;
	Number_of_Year = 0;
	do until (Year >= 29);
		year +1;
		Number_of_Year = Number_of_Year + 1 ;
		output;
	end;
run;


/* 
Coding Exercise
Section: Generating data with DO loops

coding exercise:

instruction:

1. compute each year's salary you will have

if you start with $60,000 at a 3% increase rate per year for 5 years.

2. Conditionally Executing DO Loops:

how many years it will take the salary to reach $100,000 per year

if the salary increase 3% each year, again the initial salary is $60,000. 

*/


data Exam;
	format Salary dollar10.2;
	Salary = 60000;
	incriment = 3/100;
	year = 0;
	do until (Year >= 5);
	salary + incriment * salary;
	year +1;
	output;
 end;
run;

/* Part 02 */
data Exam;
	format Salary dollar10.2;
	Salary = 60000;
	incriment = 3/100;
	year = 0;
	do until (Salary >= 100000);
	salary + incriment * salary;
	year +1;
	if Salary <= 100000;
	output;
 end;
 	
run;






