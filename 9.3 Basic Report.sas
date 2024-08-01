/* Genarel Report  */
proc import datafile="/home/u63883623/My Work/SQL/Udemy/Data/FunRun_data_id_class.xlsx"
dbms= xlsx
out= Funrun
replace;
run;

proc print data= Funrun noobs;
run;

 
proc print data= Funrun obs= "Boservetion";
run;

proc print data= Funrun ;
id Name;
run;


proc print data= Funrun sumlabel = "SubTotal" grandtotal_label= "Grand Total";
var name gender Stu_id class fund;
by class;
sum fund;
id class;
run;

