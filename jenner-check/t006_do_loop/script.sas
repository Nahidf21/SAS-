/* Adapted from "06 Do While Until Loop.sas" — the DO-loop section is
   self-contained (no external data), so it runs unmodified below.
   The leading PROC IMPORT of SAS+date.xlsx (unused by this section)
   is omitted. */

/* Basic Do loop */
Data do_data1 (drop= x Incriment year);
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

data Do_loop_list;

	do year = "Nahid Ferdous","Ferdous Marzia","This IS";
	Find_key = Scan(Year,1);
	output;
	end;
run;

/* while  */

data while_loop;
	year = 0;
	Number_of_Year = 0;
	do while (Year <= 29);
		year +1;
		Number_of_Year = Number_of_Year + 1 ;
		output;
	end;
	drop year;
run;

/* Until */
data until_loop;
	year = 0;
	Number_of_Year = 0;
	do until (Year >= 29);
		year +1;
		Number_of_Year = Number_of_Year + 1 ;
		output;
	end;
run;

/* Coding Exercise: salary growth until it reaches $100,000,
   3% increase per year, starting at $60,000 */
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

proc print data=do_data1;
	title "Salary Growth Over 10 Years (Do Loop)";
run;

proc print data=while_loop;
	title "While Loop Count";
run;

proc print data=Exam;
	title "Years To Reach $100,000 Salary";
run;
