/* Create view */
proc sql;
	create view work.nq as select name from sashelp.class;
	run;

proc print data=work.nq;
run;

/* all the libraries are here  */
libname _all_ list;

/* class 3 */
/* infile statement */
data MyDm;
	infile cards;
	input SubID Age Name $ Sex $ Color $;
	cards;
1 20 Nahid Male Black
2 21 Abid Male Blue
;
run;

proc print data = MyDm;
run;

/* Delimiter */

data mydata2;
infile cards dlm= "  ,";
input name $ age sex $;
cards;
nahid,20,male
marzia,  19 female
;
run; 

data Story;
infile datalines dlm = ",";
length Sex $ 100;
format age dollar.;
informat age best8;
label age = "Age with dollar";
label Name = "Your Name";
input Name $ Age  Sex $;

datalines;
Nahid ,21,Male Gender
Marzia,19,Female Gender
;
run;


proc print data = Story;
run;

/* print with lable */
proc print data = Story label;
run;


/*you can add label in print statement  */

proc print data = Story label;
label Sex = "My Gender"; 
run;

/* you can change Index and selct spacific colloumns in print statements  */

proc print data = Story noobs label; /* 
if you use no obs the you did not see the number of observetions */
label Sex = "My Gender"; 
Id name;
var age sex;
run;



							/* Attribute */

data Story;
infile datalines dlm = ",";
attrib name length= $6 Age length= 3 sex length= $14; /* Atrib keyword */
format age dollar.; /* add formate */
/* informat age best8; */
label age = "Age with dollar";
label Name = "Your Name";
input Name $ Age  Sex $;

datalines;
Nahid ,21,Male Gender
Marzia,19,Female Gender
;
run;

/* you cant see the number of observetions */
proc print noobs;
run;

/* you can see the number of observetions  */
proc print;
run;

data Story;
infile datalines dlm = ",";
attrib name length= $6 Age length= 3 format= dollar. sex length= $14; 
label age = "Age with dollar";
label Name = "Your Name";
input Name $ Age  Sex $;

datalines;
Nahid ,21,Male Gender
Marzia,19,Female Gender
;
run;

proc print label;
var name age;
run;


						/* sas byte limitetion 32 byte */
						
data num;
infile cards;
input crd;
cards;
123456789012123456789012
6789012123456
345678901212345
2123456789012
;
run;

proc print;
run;

							/* Input methods name input  */
							
data  name_input;
infile cards;
attrib name length= $10 age length= 3 income length= 5 format= dollar.;
input name= $ age= income = ; 
cards;
name= nahid age= 23 income= 86000
age= 21 name= marzia income= 95000
;
run;

proc print;
run;

					/* Formate input methode  */

/* Column skip pointer (+n) */
/* Column Hold pointer (@n) */
/* Column range pointer (n.) */
/* Column skip pointer (+n) here n represents skip number of columns. */
/* Column Hold pointer (@n) here n represents number of collumns. */
/* Column range pointer (n.) here n represents read number of columns. */


data student;
infile cards;
input student_id 4.  name $ 6.  age 14.;
cards;
1234nahid 21
1236marzia19
;
run;

proc print;
run;

data student;
infile cards;
input @1 student_id 4.  @5 name $ 10.  @11 age 14.;
cards;
1234 nahid  21
1236 marzia  19
;
run;

proc print;
run;














