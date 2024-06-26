/* import xlsx file */
proc import datafile= "/home/u63883623/My Work/SQL/score_data_id.xlsx"
	dbms= xlsx out= score_data;
run;

proc sql;
	create table ScoreData0 as
		select stu_id,
			   gender,
			   name
		from score_data
		where gender in ('m');
quit;

/* if you are not use create key word then you dont get any spacific table  */
/* you will get the output on the result window */

proc sql;
	select stu_id,
		   gender,
		   name
	from score_data
	where gender in ("m");
quit;

proc sql;
	create table ScoreAll as
		select *
		from score_data
		where gender in ('m');
quit;



/* lecture 02 */
/* join */
proc import datafile= "/home/u63883623/My Work/SQL/score_data_id_no_gender_1l.xlsx"
	dbms= xlsx out= Score_dataNG;
run;

proc print data= Score_dataNG;
run;

proc import datafile = "/home/u63883623/My Work/SQL/score_data_id_gender_only_1l.xlsx"
	dbms= xlsx out = Score_dataG;
run;

proc print data= Score_dataG;
run;

/* Using keyword join */

proc sql; 
	create table inner_sql as
	select 
	ng.name,
	ng.score1,
	ng.score2,
	ng.score3,
	ng.stu_id,
	g.gender
	from Score_dataNG as ng inner join Score_dataG as g
	on ng.stu_id = g.stu_id;
quit;
	

data info_test;
	input name $ id gender $;
	cards;
	nahid 1 M
	marjia 2 F
	sadia 3 F
	Abid 4 M
	Khan 4 M
	Nipun 5 M
	;
run;

data score_test;
	input id score;
	cards;
	1 23
	2 21
	3 24
	4 23
	5 25
	5 21
	6 27
	;
run;
	
/* inner join 	 */
proc sql;
	create table inner_test as
	select i.Id, i.Name, s.Score
	from info_test as i inner join score_test as s
	on i.id = s.id
	;
quit;
	
/* full join	 */
proc sql;
	create table full_test as
	select s.Id, i.Name, s.Score
	from info_test as i full join  score_test as s
	on i.id = s.id
	;
quit;

/* left join */
proc sql;
	create table left_test as 
	select i.name, s.id, s.score
	from info_test as i left join score_test as s
	on s.id= i.id
	;
quit; 

/* right join */

proc sql;
	create table right_test as 
	select i.name, s.id, s.score
	from info_test as i right join score_test as s
	on i.id = s.id;
quit;


/* union join  */ 
/* this join is not importent , its a vertical join  */


proc sql;
	create table union_test as 
	select i.name, i.id, s.id, s.score
	from info_test as i union join score_test as s
	;
quit;



	
	
	
	
	
	