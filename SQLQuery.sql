create database project
use project

SELECT * from [dbo].[Depression+Student+Dataset]

----------------------------------------------------------------
--CLEANING AND PREPARING THE DATA: Gender Column
----------------------------------------------------------------

--counting each gender
SELECT Gender,count(*) from [dbo].[Depression+Student+Dataset]
GROUP BY Gender

--update name of the table
UPDATE [dbo].[Depression+Student+Dataset]
set Gender = 'F' where Gender = 'Female'

UPDATE [dbo].[Depression+Student+Dataset]
set Gender = 'M' where Gender = 'Male'

--checking for NULL & BLANK values in the column
SELECT * from [dbo].[Depression+Student+Dataset]
WHERE Gender is NULL --can see.. there are no such records

--checking for BLANK
SELECT * from [dbo].[Depression+Student+Dataset]
WHERE Gender = '' --again i have no records

---------------------------------------------------------------------------
--ADDING THE 'AGE_GROUP' column
---------------------------------------------------------------------------
SELECT age,count(*) from [dbo].[Depression+Student+Dataset]
GROUP BY age
ORDER BY age desc

--Giving alias name to counted column ("No Column Name")
SELECT age,count(*)[Count] from [dbo].[Depression+Student+Dataset]
GROUP BY age
ORDER BY age desc

--Adding a new column: Age_Group
ALTER TABLE [dbo].[Depression+Student+Dataset]
ADD Age_Group varchar(max)

select * from [dbo].[Depression+Student+Dataset]

--UPDATE (Age_Group) new column which i just created and containes all the null values
UPDATE [dbo].[Depression+Student+Dataset]
set age_group = 
case when Age between 18 and 24 then 'A1'
Else case when age between 25 and 30 then 'A2'
else 'A3' end end

--I want to know about the count of the records for each one of the distinct AgeGroup value (A1 kitne?.. A2 kitne?..A3 kitne?)
select age_group,count(*) from [dbo].[Depression+Student+Dataset]
group by age_group

SELECT * FROM [dbo].[Depression+Student+Dataset]

------------------------------------------------------------------------------------------------------------------------------
--Want to view the details of different column: Column Details Overview
------------------------------------------------------------------------------------------------------------------------------

--Viewing the distinct name that we have available in this table
select * from INFORMATION_SCHEMA.columns where table_name 
like 'Depression+Student+Dataset'

--I want to view the column distribution for different columns, (Corresponding count will eb also represented there)
	--i will run these below simple select statements to get better understanding, better idea of distinct kind of values available in each of the column,
		--and it will also help us understand about the frequency of each one of the values occuring in a given column.
select Academic_Pressure,count(*) from [dbo].[Depression+Student+Dataset]
group by Academic_Pressure 
--we can see that, rating is given on the scale of 1 to 5 

select Study_Satisfaction,count(*) from [dbo].[Depression+Student+Dataset]
group by Study_Satisfaction
--5 different kind of values 1 to 5 and also i can see, we do not have any NULL..BLANKS..or any EMPTY

select Sleep_Duration,count(*) from [dbo].[Depression+Student+Dataset]
group by Sleep_Duration --(5-6hrs, 7-8hrs,less than 5, less than 8)

select Dietary_Habits,count(*) from [dbo].[Depression+Student+Dataset]
group by Dietary_Habits --(divided into 3 habbits: Healthy, Moderate, Unhealthy)

select Have_you_ever_had_suicidal_thoughts,count(*) from [dbo].[Depression+Student+Dataset]
group by Have_you_ever_had_suicidal_thoughts --(only 2 distict values: 0 and 1) 0 means no. 1 means Yes, they had sucidal thoughts.

select Study_Hours,count(*) from [dbo].[Depression+Student+Dataset]
group by Study_Hours --( 0 to 12 hrs) and again there are no NUNS or BLANKS here.

select Financial_Stress,count(*) from [dbo].[Depression+Student+Dataset]
group by Financial_Stress --(5 distinct values: 1 to 5) and no NUNS and BLANKS

select Family_History_of_Mental_Illness,count(*) from [dbo].[Depression+Student+Dataset]
group by Family_History_of_Mental_Illness --(2 distinct values: 0(no mental illness), 1(yes..there is history of mental illness)

select Depression,count(*) from [dbo].[Depression+Student+Dataset]
group by Depression --(0: student had not faced problem of depression while 1: means student facing the problem of depression)

---------------------------------------------------------------------------------------------------------------------------------------
--ADDING INDEX COLUMN
---------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM [Depression+Student+Dataset]
--Interest in adding an index column using which will be able to identify each record. 
	--So I can use the concept of identity column for that and we can create or add a new column to this dataset.
alter table [Depression+Student+Dataset]
add Index_Column int identity(1,1) 
--so that the value will start from 1 in this column and for each new row, 1 will be incremented

--------------------------------------------------------------------------------------------------------------------------------------
--UPDATING DEPRESSION COLUMN (BY CHANGING THE DATA TYPE OF DEPRESSION COLUMN)
--------------------------------------------------------------------------------------------------------------------------------------
UPDATE [Depression+Student+Dataset]
set Depression = 'No' where Depression = 0
--ERROR: Msg 245, Level 16, State 1, Line 113. Conversion failed when converting the varchar value 'No' to data type bit.


--Solving this Error
Select * from INFORMATION_SCHEMA.columns where TABLE_NAME LIKE 'Depression+Student+Dataset'
	--we can see the Depression column datatype is 'bit'. So, we have to first modify this column & its datatype can be modified to varchar.
	--And then will try to execute this above UPDATE statment.

ALTER TABLE [Depression+Student+Dataset]
ALTER COLUMN DEPRESSION VARCHAR(MAX)
--Now, Lets try to execute UPDATE statement

UPDATE [Depression+Student+Dataset]
set Depression = 'No' where Depression = 0

UPDATE [Depression+Student+Dataset]
set Depression = 'Yes' where Depression = '1'

SELECT depression,count(*) FROM [Depression+Student+Dataset] group by Depression -- Yes:250, No:252

------------------------------------------------------------------------------------------------------------------------------------------------
--**********************************************************************************************************************************************
------------------------------------------------------------------------------------------------------------------------------------------------
--checking the server name
SELECT @@SERVERNAME AS 'Server Name';
