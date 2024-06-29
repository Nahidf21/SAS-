/* Conditional Processing  */
/* If condition Then Action */
/* In Simple If statement we can get a single action in a time. */
/* but In IF do statement we can oparet or create two action. */
/* IF condition Then DO one or many action */

/* Example : IF Then statement */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data.xlsx"
	dbms= XLSX
	out = data_ifThen
	replace;
run;

proc print;
run;

data data_ifthen1;
    set data_ifThen;

    AvgScore = mean(Score1, Score2, Score3);
    format AvgScore 5.2 Grade $4.;
    
    if AvgScore >= 80 and AvgScore <= 89 then do;
        Grade = "B";
        Level = 3;
    end;
    else if AvgScore >= 70 and AvgScore <= 79 then do;
        Grade = "C";
        Level = 2;
    end;
    else if AvgScore >= 90 then do;
        Grade = "A";
        Level = 4;
    end;
    else do;
        Grade = "Pass";
        Level = 1;
    end;

    Grade = upcase(Grade);
    Gender = upcase(Gender);

    if not missing(Score1) and not missing(Score2) and not missing(Score3) then Take = "Complete";
    else Take = "Not Complete";
run;

/* length keyword  */

data score_length;
	set data_ifthen;
	length gender_full $ 7;
	if gender = "m" then gender_full = "Male";
	else gender_full = "Female";
run;
	
/* Subsetting if statement  */

data score_m;
	set data_ifThen;
	if gender = "f" then delete;
run;

data score_f;
	set data_ifThen;
	if gender = "f";
run;

/* Practice code */

proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data_miss777.xlsx"
	dbms= XLSX
	out = ScoreData0
	replace;
Run;


Data ScoreData1;
	set ScoreData0;
	format AvgScore 5.2;
	if score1 = 777 then score1 = .;
	else Score1 = Score1;
	if Score2 = 777 Then Score2 = .;
	else Score2 = Score2;
	if Score3 = 777 Then Score3 = .;
	else Score3 = Score3;
	
	AvgScore = mean(Score1, Score2, Score3);
	If AvgScore >= 90 Then Grade = "A";
	else if AvgScore >= 80 and AvgScoer <= 89 Then Grade = "B";
	else if AvgScore >= 70 and AvgScoer <= 79 Then Grade = "C";
	else if AvgScore >= 60 and AvgScoer <= 69 Then Grade = "B";
	else Grade = "F";
	
run;



proc import datafile= "/home/u63883623/My Work/SQL/Udemy/Data/score_data.xlsx"
	dbms= XLSX
	out = ScoreData0
	replace;
run;
	

libname Score "/home/u63883623";

data Score.ScoreData;
	set ScoreData0;
run;




















	
	
	
	
	
	