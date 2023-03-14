/* 
Q1. Create new schema as alumni
*/

create database if not exists alumni;




use alumni;



/*

Import all .csv files into MySQL

*/


# Answer --> In Screenshots


/*

- Q3.Run SQL command to see the structure of six tables

*/


desc college_a_hs;
desc college_a_se;
desc college_a_sj;
desc college_b_hs;
desc college_b_se;
desc college_b_sj;

SELECT * FROM college_a_hs limit 1000;




/*


Q4.Display first 1000 rows of tables 
(College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) with Python.
-- It Is Peroform On python(Jyupter Notebook)


*/






/*

Q5.Import first 1500 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) into MS Excel.
-- -- It Is Peroform On MS Excel

*/


/*

Q6.Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values.

*/
select * from college_a_hs where RollNo is not null 
and LastUpdate is not null and Name is not null 
and  FatherName is not null and MotherName is not  null 
and Batch is not  null  
and Degree is not null and PresentStatus is not null 
and HSDegree is not null and EntranceExam is not  null
and Institute is not null and Location is not null;


/*

Q7.Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.


*/


select * from college_a_se where RollNo is not null 
and LastUpdate is not null and Name is not null 
and  FatherName is not null and MotherName is not  null 
and Batch is not  null  
and Degree is not null and PresentStatus is not null 
and Organization is not null and Location is not null;




/*



Q8.Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.


*/


select * from college_a_sj where RollNo is not null 
and LastUpdate is not null and Name is not null 
and  FatherName is not null and MotherName is not  null 
and Batch is not  null  
and Degree is not null and PresentStatus is not null 
and Organization is not null and Designation is not  null;


/*

Q9.Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.

*/
select * from college_b_hs where RollNo is not null 
and LastUpdate is not null and Name is not null 
and  FatherName is not null and MotherName is not  null 
and Batch is not  null  
and Degree is not null and PresentStatus is not null 
and HSDegree is not null and EntranceExam is not  null
and Institute is not null and Location is not null ;



/*

Q10.Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.

*/


select * from college_b_se where RollNo is not null 
and LastUpdate is not null and Name is not null 
and  FatherName is not null and MotherName is not  null 
and Batch is not  null  
and Degree is not null and PresentStatus is not null 
and Organization is not null and Location is not  null;


/*

Q11.Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.

*/
select * from college_b_sj where RollNo is not null 
and LastUpdate is not null and Name is not null 
and  FatherName is not null and MotherName is not  null 
and Batch is not  null  
and Degree is not null and PresentStatus is not null 
and Organization is not null and Designation is not  null;




/*

Q12.Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views

*/
SELECT LOWER(Name),LOWER(FatherName),LOWER(MotherName) FROM College_A_HS_V;
SELECT LOWER(Name),LOWER(FatherName),LOWER(MotherName) FROM College_A_Se_V;
SELECT LOWER(Name),LOWER(FatherName),LOWER(MotherName) FROM College_A_Sj_V;
SELECT LOWER(Name),LOWER(FatherName),LOWER(MotherName) FROM College_B_HS_V;
SELECT LOWER(Name),LOWER(FatherName),LOWER(MotherName) FROM College_B_Se_V;
SELECT LOWER(Name),LOWER(FatherName),LOWER(MotherName) FROM College_B_Sj_V;



/*

Q13.Import the created views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) into MS Excel and make pivot chart for location of Alumni.
-- It Is Peroform On MS Excel

*/



/*

Q14.Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.

*/

DROP PROCEDURE IF EXISTS get_name_collegeA;
DELIMITER $$
CREATE PROCEDURE get_name_collegeA 
(
         INOUT name1 TEXT(40000)
)
BEGIN 
    DECLARE na INT DEFAULT 0;
    DECLARE namelist VARCHAR(16000) DEFAULT "";
    
    DECLARE namedetail 
           CURSOR FOR
				SELECT Name FROM college_a_hs UNION SELECT Name FROM college_a_se UNION SELECT Name FROM college_a_sj;
                
	DECLARE CONTINUE HANDLER 
            FOR NOT FOUND SET na =1;
            
	OPEN namedetail;
    
    getame :
         LOOP
         FETCH FROM namedetail INTO namelist;
         IF na = 1 THEN
              LEAVE getame;
		END IF;
        SET name1 = CONCAT(namelist,";",name1);
        
        END LOOP getame;
        CLOSE namedetail;
END $$
DELIMITER ;

SET @Name = "";
CALL get_name_collegeA(@Name);
SELECT @Name Name;


/*


Q.15 Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.

*/


DROP PROCEDURE IF EXISTS get_name_collegeB;
DELIMITER $$
CREATE PROCEDURE get_name_collegeB 
(
         INOUT name1 TEXT(40000)
)
BEGIN 
    DECLARE na INT DEFAULT 0;
    DECLARE namelist VARCHAR(16000) DEFAULT "";
    
    DECLARE namedetail 
           CURSOR FOR
				SELECT Name FROM college_b_hs UNION SELECT Name FROM college_b_se UNION SELECT Name FROM college_b_sj;
                
	DECLARE CONTINUE HANDLER 
            FOR NOT FOUND SET na =1;
            
	OPEN namedetail;
    
    getame :
         LOOP
         FETCH FROM namedetail INTO namelist;
         IF na = 1 THEN
              LEAVE getame;
		END IF;
        SET name1 = CONCAT(namelist,";",name1);
        
        END LOOP getame;
        CLOSE namedetail;
END $$
DELIMITER ;

SET @Name = "";
CALL get_name_collegeB(@Name);
SELECT @Name Name;
 






/*


Q16.Calculate the percentage of career choice of College A and College B Alumni (w.r.t Higher Studies, Self Employed and Service/Job)


*/

SELECT "Higher Studies" Present_status,
(COUNT(college_a_hs.RollNo) /(college_a_hs.RollNo))*100 College_A_Persentage,
(COUNT(college_b_hs.RollNo)/(college_b_hs.RollNo))*100 College_B_Persentage  
FROM college_a_hs CROSS JOIN college_b_hs 
UNION
SELECT "Self Empolyment" Present_status,
(COUNT(college_a_se.RollNo) /(college_a_se.RollNo))*100 College_A_Persentage,
(COUNT(college_b_se.RollNo)/(college_b_se.RollNo))*100 College_B_Persentage
FROM college_a_se 
CROSS JOIN 
college_b_se 
UNION
SELECT "Service Job" Present_status,
(COUNT(college_a_sj.RollNo) /(college_a_sj.RollNo))*100 College_A_Persentage,
(COUNT(college_b_sj.RollNo)/(college_b_sj.RollNo))*100 College_B_Persentage 
FROM college_a_sj 
CROSS JOIN 
college_b_sj;











