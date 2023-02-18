--2: Exploring Data

-- Checking if the new created table for the combined tables exists
SELECT 
 table_name
FROM 
 INFORMATION_SCHEMA.TABLES
WHERE 
 table_name = 
 '2022_TRIP_DATA';

 -- Above query confirms that new table exits

 -- View table
SELECT *
FROM 
 "2022_TRIP_DATA"

-- Find the number of rides by casual and members
SELECT 
 MEMBER_CASUAL, COUNT(*) AS number_of_rides
FROM 
 "2022_TRIP_DATA"
GROUP BY 
 MEMBER_CASUAL;

 -- View number of rideable types
SELECT 
 rideable_type_id, COUNT(1)
FROM 
 "2022_TRIP_DATA"
GROUP BY 
 rideable_type_id;

 -- View rides ending at each docking station
SELECT 
 END_STATION_ID, END_STATION_NAME, COUNT(1) AS rides
FROM 
 "2022_TRIP_DATA"
GROUP BY 
 END_STATION_ID, END_STATION_NAME
ORDER BY 
 rides DESC;

 -- View rides starting at each docking station
SELECT 
 START_STATION_ID, START_STATION_NAME, COUNT(1) AS rides
FROM 
 "2022_TRIP_DATA"
GROUP BY 
 START_STATION_ID, START_STATION_NAME
ORDER BY 
 rides DESC;

-- View number of round trips
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

 -- View total number of trips
SELECT 
 COUNT(*)
FROM 
 "2022_TRIP_DATA"

 --I notice 892,742 round trips  have no END_STATION_ID or END_STATION_NAME, data quality checks will be needed in the next query