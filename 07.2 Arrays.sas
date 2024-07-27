/* check arry  */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/Chara_data.xlsx"
dbms= XLSx
out= Char0
replace;

run; 


data Char1;
    set char0;
    
    array list{2} month day;
    array name_id{2} $12 _temporary_; /* Define a temporary character array for results */
    
    do i = 1 to 2;
    if i = 1 then (
        if list{i} >= 9 then name_id{i} = "Its good";
        else name_id{i} = "Its Bad";);
    else if i = 2 then (
    	if list{i} >= 9 then name_id{i} = "Its good";
        else name_id{i} = "Its Bad";);
        
    end;

    
    
run;


data Char1;
    set char0;
    
    array list{2} month day;
    array name_id{2} $12; /* Define a character array for results */
    
    do i = 1 to 2;
        if i = 1 then do;
            if list{i} >= 9 then name_id{i} = "Its good Month";
            else name_id{i} = "Its Bad Month";
        end;
        else if i = 2 then do;
            if list{i} >= 15 then name_id{i} = "Its good Day";
            else name_id{i} = "Its Bad Day";
        end;
    end;

    /* Assign the results to new variables */
/*     Name_Outcome_Month = name_id{1}; */
/*     Name_Outcome_Day = name_id{2}; */
    
run;

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/Chara_data.xlsx"
dbms= XLSx
out= Char0
replace;

run; 

proc print data= Char0;
run;

data logic0;
set char0;

	
	raw_score1 = input(raw_score,3.) ;
	array SCR{2} raw_score1 score;
	array scr_t{2} ;

	do i = 1 to 2;
		if i =1 then do;
			if SCR{i} =. then SCR{i}= 666;
			end;
		else if i =2 then do;
			if scr{i}= . then scr{i} = 777;
			end;
		end;
	drop raw_score;
run;




data char1;
set char0;
raw_score1 = input(raw_score, 3.);
drop raw_score;
run;

proc means data=char1 noprint;
    var raw_score1 score;
    output out=means_data mean=mean_raw_score1 mean_score;
run;


data logic0;
set char0;

	raw_score1 = input(raw_score,3.) ;
	array SCR{2} raw_score1 score;
	array scr_t{2} _temporary_;

	do i = 1 to 2;
		if i =1 then do;
			if SCR{i} =. then SCR{i}= 77.2;
			end;
		else if i =2 then do;
			if scr{i}= . then scr{i} = 77.3;
			end;
		end;
	
	new_Raw_Score = raw_score1;
	New_Score = score;
	drop raw_score i score raw_score1;
	keep new_Raw_Score New_score;
run;

