use airline_database;
select * from maindata;
desc maindata;

-- 2. Find the load Factor percentage on a yearly , Quarterly , Monthly basis ( Transported passengers / Available seats)

SELECT 
    YEAR(date_column) AS Year,
    QUARTER(date_column) AS Quarter,
    month AS Month,
    SUM(transported_passengers) AS Total_Transported_Passengers,
    SUM(available_seats) AS Total_Available_Seats,
    CONCAT(TRUNCATE(SUM(transported_passengers) / SUM(available_seats) * 100,2),'%') AS Load_Factor_Percentage
FROM 
    maindata
GROUP BY 
    YEAR(date_column), QUARTER(date_column),month
    ORDER BY 
    YEAR(date_column), QUARTER(date_column),month;

-- 3 Find the load Factor percentage on a Carrier Name basis ( Transported passengers / Available seats)

SELECT 
    Carrier_Name,
    CONCAT(TRUNCATE(SUM(transported_passengers) / SUM(available_seats) * 100,
                2),
            '%') AS Load_Factor_Percentage
FROM
    maindata
GROUP BY Carrier_Name;

-- 4. Identify Top 10 Carrier Names based passengers preference 

SELECT 
    Carrier_Name,
    CONCAT(round(SUM(transported_passengers) / 1000000,2), ' million') AS Total_Passengers
FROM
    maindata
GROUP BY Carrier_Name
ORDER BY Total_Passengers DESC
LIMIT 10;

-- 5 Display top Routes ( from-to City) based on Number of Flights 

SELECT 
     From_To_City, COUNT(Airline_ID) AS No_of_Flights
FROM
    maindata
GROUP BY From_To_City
ORDER BY COUNT(Airline_ID) DESC ; 

-- 6 Identify the how much load factor is occupied on Weekend vs Weekdays.

SELECT 
    CASE WHEN DAYOFWEEK(date_column) IN (2, 3, 4, 5, 6) THEN 'Weekday' ELSE 'Weekend' END AS Day_Type,
    concat(round(Avg(transported_passengers / available_seats) * 100,2),'%') AS Avg_Load_Factor 
FROM 
    maindata
GROUP BY 
    CASE WHEN DAYOFWEEK(date_column) IN (2, 3, 4, 5, 6) THEN 'Weekday' ELSE 'Weekend' END;

-- 7 Identify number of flights based on Distance group

SELECT 
    CASE 
        WHEN Distance BETWEEN 0 AND 200 THEN '0-500 miles'
        WHEN Distance BETWEEN 501 AND 1000 THEN '501-1000 miles'
        WHEN Distance BETWEEN 1001 AND 1500 THEN '1001-1500 miles'
        ELSE 'Over 1500 miles'
    END AS Distance_Group,
    COUNT(airline_id) AS Number_of_Flights
FROM 
    maindata 
GROUP BY 
    Distance_Group 
ORDER BY 
    Distance_Group;

select Distance_Group_ID,Distance from maindata order by Distance_Group_ID desc;

-- 7 Identify number of flights based on Distance group
SELECT 
    Distance_Group_ID,
    COUNT(airline_id) AS Number_of_Flights
FROM 
    maindata 
GROUP BY 
    Distance_Group_ID 
ORDER BY 
    Distance_Group_ID;
    
-- To find the flights between Source Country, Source State, Source City to Destination Country , Destination State, Destination City
SELECT 
    *
FROM 
    maindata 
WHERE 
    Origin_Country = 'United States' AND 
    Origin_State = 'Alaska' AND 
    Origin_City = 'Red Dog, AK' AND 
    Destination_Country = 'United States' AND 
    Destination_State = 'Alaska' AND 
    Destination_City = 'Kotzebue, AK';
