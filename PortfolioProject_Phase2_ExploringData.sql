--Phase 2: Exploring Data

-- Checking if table exists
SELECT 
 table_name
FROM 
 INFORMATION_SCHEMA.TABLES
WHERE 
 table_name = 
 '2022_TRIP_DATA';


 -- View table
SELECT *
FROM 
 "2022_TRIP_DATA"

-- Find the number of rides by casual-members and rides by annual-members
SELECT 
 MEMBER_CASUAL, COUNT(*) AS number_of_rides
FROM 
 "2022_TRIP_DATA"
GROUP BY 
 MEMBER_CASUAL;

 -- Counting number of rideable types
SELECT 
 rideable_type_id, COUNT(1)
FROM 
 "2022_TRIP_DATA"
GROUP BY 
 rideable_type_id;

 -- Counting rides ending at each docking station
SELECT 
 END_STATION_ID, END_STATION_NAME, COUNT(1) AS rides
FROM 
 "2022_TRIP_DATA"
GROUP BY 
 END_STATION_ID, END_STATION_NAME
ORDER BY 
 rides DESC;

 -- Counting rides starting at each docking station
SELECT 
 START_STATION_ID, START_STATION_NAME, COUNT(1) AS rides
FROM 
 "2022_TRIP_DATA"
GROUP BY 
 START_STATION_ID, START_STATION_NAME
ORDER BY 
 rides DESC;

-- Count number of round trips
SELECT 
 START_STATION_ID, END_STATION_ID,RIDEABLE_TYPE_ID,MEMBER_CASUAL
FROM 
 "2022_TRIP_DATA"
WHERE 
 START_STATION_ID = END_STATION_ID;

 SELECT COUNT(*)
FROM  
 "2022_TRIP_DATA"
WHERE 
 START_STATION_ID = END_STATION_ID;

 -- Counting total number of trips
SELECT 
 COUNT(*)
FROM 
 "2022_TRIP_DATA"

 --we notice 892,742 round trips  have no END_STATION_ID or END_STATION_NAME, data quality checks w8ill be needed, because of the null values  some of the data might not make sense according to the relationships between them or their definitions.
