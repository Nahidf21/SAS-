/* 
coding exercise:
1. Use data set ‘scoredata1’ generated from the coding exercise for section ‘work with data’ :

Or you may generate 'scoredata1' directly using the code below:

proc import datafile = "/folders/myfolders/score_data_miss777" 
DBMS = xlsx out = scoredata0 replace ;
run;
data scoredata1;
set scoredata0;
   ARRAY sc (3) score1 score2 score3;    
   ARRAY new (3) ns1 ns2 ns3; 
   DO i = 1 TO 3;                       
      IF sc(i) = 777 THEN new(i) =.;   
      Else if sc(i) NE 777 then new(i) = sc(i);
   END;  
averagescore = mean (ns1, ns2, ns3);
run; 
 
2. Sort data by Gender, Averagecore; Print the sorted data set

3. Generate frequency tables for all character variables excluding Name

4. Generate statistic outputs for Ns1,2,3 and Averagecore by Gender using Proc Means and Proc Univariate
 */


proc import datafile = "/home/u63883623/My Work/SQL/Udemy/Data/score_data_miss777" 
DBMS = xlsx out = scoredata0 replace ;
run;
data scoredata1;
set scoredata0;
   ARRAY sc (3) score1 score2 score3;    
   ARRAY new (3) ns1 ns2 ns3; 
   DO i = 1 TO 3;                       
      IF sc(i) = 777 THEN new(i) =.;   
      Else if sc(i) NE 777 then new(i) = sc(i);
   END;  
averagescore = mean (ns1, ns2, ns3);
run;

proc sort data= scoredata1;
by gender averagescore;

proc print data= scoredata1;
run;

proc freq data= scoredata1;
table gender/missing;
run;

proc means data= scoredata1;
var Ns1-Ns3 averagescore;
by gender;
where gender ne "";
run;

proc univariate data= scoredata1;
var Ns1-Ns3 averagescore;
by gender;
where gender ne " ";
run;