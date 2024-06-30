use airline_database;

show tables;

desc maindata;

explain maindata;

select count(*) from maindata;

select * from maindata;

select year,Month,Day from maindata;

-- Alter the table to add a new column for the date
alter table maindata add column date_column date;

-- using safe update mode to update a table
set sql_safe_updates=0;

-- Update the new column by constructing a date
update maindata set date_column = date(CONCAT(year, '-', month, '-', day));

select date_column from maindata; -- date column created 

-- Alter the table to add a new column for the Month_name
alter table maindata add column Month_name char(9);

-- Update the new column by constructing a month name
update maindata set month_name = monthname(date_column);

-- Alter the table to add a new column for the date
alter table maindata add column Quarter_column varchar(2);

-- Update the new column by constructing a Quarter_column
update maindata set Quarter_column = quarter(date_column);

-- Alter the table to add a new column for the YearMonth
alter table maindata add column YearMonth varchar(8);

-- Update the new column by constructing a YearMonth
update maindata set YearMonth = date_format(date_column,'%Y %b');

-- Alter the table to add a new column for the Weekday_No 
alter table maindata add column Weekday_No Int;

-- Update the new column by constructing a Weekday_No
update maindata set Weekday_No = IF(DAYOFWEEK(date_column) = 1, 7, DAYOFWEEK(date_column) - 1);

-- Alter the table to add a new column for the Week_day_Name 
alter table maindata add column Week_day_Name VARCHAR(9);

-- Update the new column by constructing a Week_day_Name
UPDATE maindata
SET Week_day_Name = CASE
    WHEN DAYOFWEEK(date_column) = 1 THEN 'Sunday'
    WHEN DAYOFWEEK(date_column) = 2 THEN 'Monday'
    WHEN DAYOFWEEK(date_column) = 3 THEN 'Tuesday'
    WHEN DAYOFWEEK(date_column) = 4 THEN 'Wednesday'
    WHEN DAYOFWEEK(date_column) = 5 THEN 'Thursday'
    WHEN DAYOFWEEK(date_column) = 6 THEN 'Friday'
    ELSE 'Saturday'
END;

-- Alter the table to add a new column for the Financial_Month 
alter table maindata add column Financial_Month int;

-- Update the new column by constructing a Financial_Month
UPDATE maindata
SET Financial_Month = 
    CASE 
        WHEN MONTH(date_column) >= 4 THEN MONTH(date_column) - 3
        ELSE MONTH(date_column) + 9
    END;

select year,month,day,date_column,Month_name,quarter_column,YearMonth,Weekday_No,Week_day_Name,Financial_Month from maindata;

-- Alter the table to add a new column for the Financial_Quarter 
ALTER TABLE maindata ADD COLUMN Financial_Quarter INT;

-- Update the new column with the financial quarter information
UPDATE maindata
SET Financial_Quarter = 
    CASE 
        WHEN month BETWEEN 1 AND 3 THEN 1
        WHEN month BETWEEN 4 AND 6 THEN 2
        WHEN month BETWEEN 7 AND 9 THEN 3
        ELSE 4
    END;

-- Alter the table to add a new column for the Financial_Quarter_Text 
ALTER TABLE maindata ADD COLUMN Financial_Quarter_Text varchar(2);

-- Update the new column with the financial quarter information
UPDATE maindata
SET Financial_Quarter_Text = 
    CASE 
        WHEN month BETWEEN 1 AND 3 THEN 'Q1'
        WHEN month BETWEEN 4 AND 6 THEN 'Q2'
        WHEN month BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END;
-- Final Output
SELECT 
    year,
    month,
    day,
    date_column,
    Month_name,
    quarter_column,
    YearMonth,
    Weekday_No,
    Week_day_Name,
    Financial_Month,
    Financial_Quarter_Text
FROM
    maindata;
