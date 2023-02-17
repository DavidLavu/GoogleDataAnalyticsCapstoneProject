--Phase 3: Data Quality Checks
--All rides should be booked by either members or casuals. So the MEMBER_CASUAL field should have only two distinct values. to confirm this:

SELECT DISTINCT 
 MEMBER_CASUAL
FROM 
 "2022_TRIP_DATA";

--check the ranges of latitude and longitudes
--The latitude and longitude fields should have valid values. Latitudes should be between -90 to 90 and longitudes should be between -180 to 180

SELECT
       MIN(end_lng),MAX(end_lng),
	   MIN(end_lat),MAX(end_lat), 
       MIN(start_lng),MAX(start_lng),
       MIN(start_lat),MAX(start_lat)
FROM "2022_TRIP_DATA";


--Check if ride ids are unique or not (if multiple rides have the same ride ID.) having count >1
SELECT
 ride_id, COUNT(1)
FROM
 "2022_TRIP_DATA"
GROUP BY
 ride_id
HAVING COUNT(1) > 1;

--check for null in rows
SELECT*
FROM
 "2022_TRIP_DATA"
WHERE 
 started_at IS NULL OR ended_at IS NULL;


-- Checking for rows where column value is absent
-- We want to investigate if the blank fields are either due to empty strings, or null , or whitespaces

-- Below query is to counter fileds which only have whitespaces 
SELECT COUNT (*) 
FROM "2022_TRIP_DATA"
WHERE TRIM(START_STATION_ID) IS NULL OR TRIM(START_STATION_NAME) IS NULL;

-- Counting number of nulls
-- Checking on start and end stations
SELECT COUNT (*) 
FROM "2022_TRIP_DATA"
WHERE START_STATION_ID IS NULL OR START_STATION_NAME IS NULL;

SELECT COUNT (*) 
FROM "2022_TRIP_DATA"
WHERE END_STATION_ID IS NULL OR END_STATION_NAME IS NULL;

SELECT COUNT(*)
FROM "2022_TRIP_DATA"
WHERE START_LAT IS NULL OR END_LAT IS NULL;

SELECT COUNT(*)
FROM "2022_TRIP_DATA"
WHERE START_LNG IS NULL OR END_LNG IS NULL;

--From the above queries we get the following conclusions,

--There are only two distinct values in the MEMBER_CASUAL field.

--Latitude and longitude values are in the correct range.

--Non-unique ride IDs exist.

--existence of null values in multiple fields across multiple rows