/* Marges */
/* One to one marge without reletions */

/* Merge Operetions */

data Customers;
	input Custno $ CustName $ PhoneNo;
	cards;
C101 Nahid 3462778750
C102 Marzia 3462778349
C103 Nipun 3467229834
;

data Branchs;
	input BranchNo $ Locetion $;
	Cards;
B101 Dhaka
B102 Thakurgaon
B103 Chaitagaon
;

data Products;
	input ProdID $ ProdName $;
	cards;
P101 Apple
P102 HP
P103 Dell
;
Run;

/* Now do marge with out reletion */


data Records;
	merge Customers Branchs Products;
run;
title1 "Merge Operations";
title2 "Table Customers";
proc print data = Customers;
run;
title;
title3 "Table Branchs";
proc print data = Branchs;
run;
title;
title4 "Table Products";
proc print data = Products;
run;
title;

title5 "Merge The three tables without reletion - One to One merge";
title6 "Side by side";

proc print data = Records;
run;


/* One to One Merge using Relations */

data Products;
	input ProdID $ ProdName $;
	cards;
P101 Apple
P102 HP
P103 Dell
;

Data Prices;
	input ProdID $ ProdPrice;
	cards;
P101 1000
P102 750
P103 800
P104 560
;
Run;

/* Merge one to one by using relations */
title1 "Merge one to one by using relations ";

title2 "Products Table";
proc print data= products;
run;
title;

title3 "Price Table";
proc print data= Prices;
run;
title;

/* Now merge */
data Product_Price_With_Reletion;
	merge Products Prices;
	by ProdID;
run;

data Product_Price_without_Reletion;
	merge Products Prices;
run;
title4 "Now Merge one to one using relations";

proc print data= Product_Price_With_Reletion;
run;
title;

title4 "Now Merge one to one with out relations";

proc print data= Product_Price_without_Reletion;
run;
title;

/* One to many merge using relations */


data Customers;
	input Custno $ CustName $ PhoneNo;
	cards;
C101 Nahid 3462778750
C102 Marzia 3462778349
C103 Nipun 3467229834
C104 Lipa 3451992350
C105 Neelove 3452667389
;

proc sort data = Customers;
	by CustNo;
run;

title "Customers Table";
proc print;
run;
title;


data Cust_Trans;
	input CustNo $ Month Quantity;
	cards;
C101 1 20
C102 1 13
C103 1 17
C104 1 15
C101 3 20
C102 3 13
C103 3 17
C104 3 15
C101 2 20
C102 2 13
C103 2 17
C104 2 15
;
run;

proc sort data = Cust_Trans;
	by CustNo;
run;

title "Cust_Trans Table";
proc print;
run;
title;

/* One to many Merge with Relations */

data cust_details_trans;
	merge Customers Cust_Trans;
	by CustNo;
run;

title "One To Many Merge With Relation";
proc print data = cust_details_trans;
run;
title;


/* Many To One */

data cust_details_trangetions;
	merge Cust_trans Customers ;
	by CustNo;
run;

proc sort;
	by CustNo Month;
run; 

Title " Many To one Merge using Relations";

proc print;
run;
title;


						/* Many to many merge using relations */
						
						
						
						
						

data Customers;
	input Custno $ CustName $ PhoneNo;
	cards;
C101 Nahid 3462778750
C102 Marzia 3462778349
C103 Nipun 3467229834
C104 Lipa 3451992350
C105 Neelove 3452667389
C101 Nahid 3462778750
C102 Marzia 3462778349
C103 Nipun 3467229834
C104 Lipa 3451992350
C105 Neelove 3452667389
;

proc sort data = Customers;
	by CustNo;
run;

title "Customers Table";
proc print;
run;
title;


data Cust_Trans;
	input CustNo $ Month Quantity;
	cards;
C101 1 20
C102 1 13
C103 1 17
C104 1 15
C101 3 20
C102 3 13
C103 3 17
C104 3 15
C101 2 20
C102 2 13
C103 2 17
C104 2 15
;
run;

proc sort data = Cust_Trans;
	by CustNo;
run;


title1 "Cust_Trans Table";
proc print;
run;
title;



/* Many To Many */

data cust_details_trangetions;
	merge Cust_trans Customers ;
	by CustNo;
run;

proc sort;
	by CustNo Month;
run; 

title "Many to Many Relations";

proc print;
run;
title;



						/* Logical Variable or traking variable */

data Products;
	input ProdID $ ProdName $;
	cards;
P101 Apple
P102 HP
P111 Dell
P113 Asser
P105 Asus
;
proc sort;
	by ProdID;
run;

title "Products Table";

proc print;
run;
title;

Data Prices;
	input ProdID $ ProdPrice;
	cards;
P101 1000
P102 750
P103 800
P104 560
P106 732
P109 873
;
Run;

title "Price Table";
proc print;
run;
title;

/* Logical variable  */

data Prod_details;
	merge Products(in= var) Prices;
	by ProdID;
	if var=1;
run;

title "Merging with Logical Variable Left Join";
proc print;
run;


data Prod_details;
	merge Products Prices(in= var);
	by ProdID;
	if var=1;
run;

title "Merging with Logical Variable Right Join";
proc print;
run;








