Proc import datafile="/home/u63883623/My Work/Udemy SAS Advanced Programming/Data/sale_state.xlsx"
dbms= xlsx
out= SaleState0
replace;
run;

proc print data= SaleState0;
run;

data S_state0;
set SaleState0;
call symput("Title", "Report on sale in States");
run;

proc sql;
select 
max(round(mean(saleCA1, SaleCA2, SaleCA3),.1)) as max_ca,
min(round(mean(saleCA1, SaleCA2, SaleCA3),.1)) as min_ca
into : max_ca, :min_ca
from S_State0;
quit;

proc print data= S_state0;
title " &title Minimum Sale mean: &max_ca and Minimum Sale mean: &min_ca";
run;

