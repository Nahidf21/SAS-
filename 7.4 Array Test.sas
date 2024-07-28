/* instruction: */
/*  */
/* using Array to replacing 'missing' with blanks in vars */
/*  */
/* read math science write */
/*  */
/* then convert the character vars read math science write */
/*  */
/* to numeric vars */




proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/allscore_miss_text.xlsx"
dbms= xlsx
out= allScore0
replace;
run;

data allScore1;
set allscore0;

Array var{4} read math science write;
Array num{4} readN mathN ScienceN writeN;
do i = 1 to 4;

if var{i}= "missing" then var{i}= "";
/* converting chr variable to numerical variable */
num{i} = input(var{i},4.1);
end;
drop read math science write i;
/* read = input(read,4.1); */
/* math = input(math,4.1); */
/* science = input(science,4.1); */
/* write = input(write,4.1); */

run;





/* data: */
/*  */
/* sale_state.xlsx */
/*  */
/* sale in CA: variables saleCA1 saleCA2 saleCA3 */
/*  */
/* sale in TX: variables saleTX1 saleTX2 saleTX3 */
/*  */
/*  */
/*  */
/* instruction: */
/*  */
/* 1. using two dimensional array to calculate */
/*  */
/* total sale for each state (CA, TX) of each year */
/*  */
/* 2. Print the output with dollar format */


proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/sale_state.xlsx"
dbms= xlsx
out = Sale_state0
replace;
run;

proc print data= Sale_state0;
run;


data Sale_state1;
set Sale_state0;
	
	Array state{2,3} saleCA1 saleCA2 saleCA3 saleTX1 saleTX2 saleTX3;
	Array ST{2} CA TX;
	Do i= 1 to 2;
	ST{i}=0;
	Do j = 1 to 3;
	ST{i} = ST{i} + state{i,j};
	end;
	end;
	format CA TX dollar10.;
	drop i j;
	
run;
	
	
	
proc print data= Sale_state1;
run;
	








