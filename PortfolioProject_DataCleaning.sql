--4: Cleaning Data

-- To delete all rows where any field is null
--This query deletes (2590952 rows)
DELETE
FROM "2022_TRIP_DATA"
WHERE RIDE_ID IS NULL
OR RIDEABLE_TYPE_ID IS NULL
OR STARTED_AT IS NULL
OR ENDED_AT IS NULL
OR START_STATION_NAME IS NULL
OR START_STATION_ID IS NULL
OR END_STATION_NAME IS NULL
OR END_STATION_ID IS NULL
OR START_LAT IS NULL
OR START_LNG IS NULL
OR END_LAT IS NULL
OR END_LNG IS NULL
OR MEMBER_CASUAL IS NULL;


--delete all rows which have STARTED_AT time stamps higher than or equal to ENDED_AT time stamps, 
--because its impossible for that to happen in normal situation so these must be errors 
--below query deletes (206 rows)
DELETE
FROM "2022_TRIP_DATA"
WHERE STARTED_AT >= ENDED_AT;

-- Checking if ride ids still have count >1
SELECT ride_id, COUNT(1)
FROM "2022_TRIP_DATA"
GROUP BY ride_id
HAVING COUNT(1) > 1;

-- Check again for any nulls
SELECT COUNT (*) 
FROM "2022_TRIP_DATA" 
WHERE START_STATION_ID IS NULL OR START_STATION_NAME IS NULL;

--Final table has no null expressions