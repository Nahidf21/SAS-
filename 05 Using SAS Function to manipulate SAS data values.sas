/* SAS Date Functions */
proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/SAS+date.xlsx" 
		dbms=XLSX out=Score0 replace;
run;

/* Here I will apply date functions  */

data score1;
	set Score0;
	*options yearcutoff=1980;
	DOB_Year = year(DOB);
	DOB_Month = Month(DOB);
	DOB_Day = Day(DOB);
	DOB_WeekDay = Weekday(DOB);
	QTR_Date = QTR(DOB);
	label DOB_WeekDay = "Date_of_Birth";
run; 

/* Lets only pick  weekend Its a wrong entry cause No body have 
Permission to enter school in Weekend  */

data weekdays;
	set Score1;
	if DOB_WeekDay in (1,7);
run;

/* Date and Today Function: and  INTCK Function:   */

Proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/SAS+date.xlsx"
dbms= xlsx
out= date0
replace;
run;

Data date1;
	set date0;
	format Today_date1 Today_date2 date11.;
	Today_date1 = today();
	Today_date2= date();
	* INTCK Function: ;
	Years = INTCK("Year",Start_date,today());
	Months = INTCK("Month", Start_date, Today());
	Days = INTCK("Day",Start_date,Today());
run;


/* 
DATDIF and YADIF Function: 
The DATDIF and YADIF functions calculate the difference in days 
and years between two SAS dates.
Generel form:
DATDIF(start_date, end_date, basis);
YRDIF(Start_date, end_date, basis);
*/

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/SAS+date.xlsx"
dbms= XLSX
out = data0
replace;
run;

data data1;
	set data0;
	
	year_ACT_ACT = YRDIF(DOB, today(), "ACT/ACT");
	year_ACT_yer360 = YRDIF(DOB, '08JUN2024'd, "ACT/360");
	year_30_yer360 = YRDIF(DOB, '08JUN2024'd, "30/360");
	year_ACT_yer365 = YRDIF(DOB, '08JUN2024'd, "ACT/365");
	
	Day_ACT_ACT = DATDIF(DOB, today(), "ACT/ACT");
	Day_30_360 = DATDIF(DOB, '08JUN2024'd, "30/360");
	Days = INTCK("day", DOB, today());
	Years = INTCK("year", DOB, today());
	
run;

/* 
Coding Exercise
section: work with SAS dates

Coding Exercise:

data:

patient_HD.xlsx

instruction:

1. extract the year of patients administered to hospital

2. calculate the number of days that patients stayed in hospital in two ways

3. creating a var containing today's date as analysis date 

*/

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/Patient_HD.xlsx"
dbms= XLSX
out = PatientData0
replace;
run;

data PatientData1;
	set PatientData0;
	format Reporting_date date9.;
	* extract the year of patients administered to hospital;
	Patient_administered_year =  Year(Start_date);
	*calculate the number of days that patients stayed in hospital in two ways;
	Total_number_of_days1 = INTCK("Day", Start_date, End_date);
	Total_number_of_days2 = DATDIF(Start_date, End_date, "ACT/ACT");
	*creating a var containing today's date as analysis date;
	Reporting_date = today();
	
run;
	
proc print data= PatientData1;
run;
	







