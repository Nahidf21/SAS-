/* Arrays are two types  */
/* 1. One Dimension Arry - Run the process in column wise */
/* 2. Two or multi Dimension Arry - Run the process in column and row wise */

/* Example one Dimension Arry */

data OneDimension;
	input ProdCode $ M1 M2 M5 M4 M3;
	cards;
	P101 12 13 12 14 13
	P102 21 12 . 17 12
	P103 20 43 12 32 .
	P101 . 13 12 14 13
	P102 21 . 13 . 12
	P103 20 43 12 32 18
	;
run;


/* sorted */

data qq;
	set OneDimension;
	keep M1-M4;
run;

/* Stacked */

data qq;
	set OneDimension;
	keep M1--M4;
run;

/* Replace Missing Values in multiple variables */
data Sales_replace;
	set OneDimension;
	Array apple (5) M1-M5;
	
	do i= 1 to 5;
	if apple(i)=. Then apple(i)=0;
	end;
	Drop i;
run; 
	
/* Now I want to put mean of the each column value in the missing values for the specific columns */

data Sales_replace_mean;
	set onedimension;
	Array apple(5) M1-M5;
	
	
	do i= 1 to 5;
	if apple(i)=. then apple(i)= max(of m1-m2);
	end;
	drop i;
run; 

proc print data = Sales_replace_mean;
run;

/* Taking values from previous column */

data Sales_rece_pre;
	set onedimension;
	array apple(6) M1-M6;
	
	do i= 2 to 6;
	if apple(i)=. then apple(i) = apple(i-1);
	end;
	drop i;
run;
	
proc print data = onedimension;
run;
	
proc print data = Sales_rece_pre;
run;

/* day -2 */

data OneDimension;
	input ProdCode $ M1 M2 M5 M4 M3;
	cards;
	P101 12 13 12 14 13
	P102 21 12 . 17 12
	P103 20 43 12 32 .
	P101 . 13 12 14 13
	P102 21 . 13 . 12
	P103 20 43 12 32 18
	;
run;
	

data fill_missing;
	set OneDimension;
	Array apple(*) M1-M5;
	
	do i=1 to dim(apple);
	if apple(i)=. then apple(i)=0;
	end;
	drop i
	run;
	proc print data = fill_missing;
run;

/* Try for cerecter variables  */

data OneDimension;
	input ProdCode $ M1 M2 M5 M4 M3;
	cards;
	P101 12 13 12 14 13
	P102 21 12 . 17 12
	P103 20 43 12 32 .
	. . 13 12 14 13
	P102 21 . 13 . 12
	P103 20 43 12 32 18
	;
run;	
	
	
data char_missing;
	set onedimension;
	array apple(*) _numeric_;
	
	do i=1 to dim(apple);
		if apple(i)=. then apple(i)=0;
		end;
		drop i;
	run;
	


data char_missing;
	set onedimension;
	array num(*) m1-m5;
	array_dim = dim(num);
	put "Dim of the array num = array_dim";
/* 	keep array_dim; */
	run;

/* Transpose data; */

data vs;
infile cards;
input SubID Visit Test $ Units ;
cards;
101 1 HR 72 
102 . HR 70 
103 1 HR .  
101 3 DBP 80 
. 1 DBP 82 
103 . DBP .  
101 1 SBP 123 
102 2 SBP .   
103 1 SBP 123 
;
run;


proc sort data=vs out= vs_out;
	by subid visit;
run;

Proc Transpose data= vs_out out=vs_transpose(drop=_name_);
ID test;
Var units;
by subid visit;
run;

proc print data= vs_transpose noobs;
run;

/* Temporary array */

data temporary_array;
	set vs;
	array real_array(3) Subid Visit Units;
	array temp(3) _temporary_ (123 3 95);
	
	do i= 1 to dim(real_array);
	if real_array(i)=. then real_array(i)=temp(i);
	end;
	drop i;
	run;
	
proc print;
run;

/* Here we fill the missing values now lets transpoce the data */
proc sort data= temporary_array;
	by SubID Visit;
run;

proc print;
run;

proc transpose data= temporary_array out= transport_clean(rename= (Subid= ID) drop= _name_);
	ID test;
	var Units;
	by SubID Visit;
	run;
proc print;
	run;

/* Now lets fill the missong data */

data clean_data;
	set transport_clean;
	array real(3) HR SBP DBP;
	array temp(3) _temporary_ (74 82 92);
	
	do i = 1 to dim(real);
	if real(i)=. then real(i)= temp(i);
	end;
	drop i;
	run;
	
	proc print;
	run;



/* Chetegorical data */

data Ae;
Input SubID Visit $ Aeterm $;
Cards;

101 Visit1 Headache
102 Visit1 Fever
103 Visit1 Cold
102 Visit2 Vomiting
101 Visit2 Headache
102 Visit3 Fever
103 Visit2 Cold
102 Visit4 Vomiting
101 Visit3 Headache
102 Visit5 Fever
106 Visit3 Cold
107 Visit6 Vomiting
108 Visit4 Headache
112 Visit7 Fever
116 Visit4 Cold
102 Visit8 Vomiting
;
run;

Proc sort out= Ae_sort;
by SubID;
run;

proc transpose data= Ae_sort out= At_data(drop= _name_);
ID visit;
var Aeterm;
by SubID;
run;

data clean;
	set At_data;
	array real(*) Visit1-Visit8;
	
	do i= 1 to dim(real);
	if real(i)="" then real(i)="_";
	end;
	drop i;
	run;
proc print;
run;


/* two dimensional arrays */

Data ProdPrice;
	input ProdCode $ m1-m3/m4-m6;
	array real(2,3) m1-m6;
	do i = 1 to 2;
		do j = 1 to 3;
			real(I,j)= round(real(I,j),0.1);
		end;
	end;
	drop i j;
	 cards;
	P101 23.45 22.56 26.23 
         26.23 24.34 25.67
    P102 45.23 43.21 23.12 
         32.12 23.12 12.78
    P103 24.32 21.12 23.12 
         77.33 12.34 23.12
	 run;
	
proc print;
run;
	
	
	
data ProdPrice;
    input ProdCode $ m1-m3 m4-m6;
    array real(2,3) m1-m6;
    
    do i = 1 to 2;
        do j = 1 to 3;
            real(i,j) = round(real(i,j), 0.1);
        end;
    end;
    drop i j;
    cards;
    P101 23.45 22.56 26.23 
         26.23 24.34 25.67
    P102 45.23 43.21 23.12 
         32.12 23.12 12.78
    P103 24.32 21.12 23.12 
         77.33 12.34 23.12
    ;
run;

proc print data=ProdPrice;
run;