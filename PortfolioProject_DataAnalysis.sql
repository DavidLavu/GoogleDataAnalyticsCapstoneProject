--5: Data Analysis
-- This query creates multiple new tables for various data analysis purposes. The first step is to calculate the trip duration in seconds for each ride and add the value to a new column named TRIP_DURATION_SECS. The following tables are then created to store different analyses:

-- MEM_CAS_RIDES: This table stores the number of casual rides and member rides.
-- BIKES_RIDES: This table stores the distribution of total trips over bike types.
-- MEM_CAS_BIKE_RIDES: This table stores the distribution of member rides and casual rides for each bike type.
-- ROUND_RIDES: This table stores the number of round trips for each bike type and membership type.
-- YEAR_RIDES: This table stores the number of rides per month for each membership type. Additionally, the tables YEAR_RIDES_CASUAL and YEAR_RIDES_MEMBERS are created to separate the rides per month for casuals and members, respectively.


-- Create new column trip duration in secs
ALTER TABLE "2022_TRIP_DATA"
ADD TRIP_DURATION_SECS FLOAT;

-- Calculate trip length and update the TRIP_DURATION_SECS column
UPDATE 
[2022_TRIP_DATA]
SET TRIP_DURATION_SECS = DATEDIFF(second, started_at, ended_at);

-- Calculate No. of rides for casual and members riders and save in a new table MEM_CAS_RIDES

	CREATE TABLE MEM_CAS_RIDES (
    MEMBER_CASUAL VARCHAR(10),
    NO_OF_RIDES INT
);

INSERT INTO MEM_CAS_RIDES (MEMBER_CASUAL, NO_OF_RIDES)
    SELECT MEMBER_CASUAL, COUNT(*) AS NO_OF_RIDES
    FROM [2022_TRIP_DATA]
    GROUP BY MEMBER_CASUAL
    ORDER BY NO_OF_RIDES DESC;

-- Calculate No. of rides for each bike type and save in a new table BIKES_RIDES
CREATE TABLE BIKES_RIDES (
    RIDEABLE_TYPE_ID VARCHAR(50),
    NO_OF_RIDES INT
);

INSERT INTO BIKES_RIDES (RIDEABLE_TYPE_ID, NO_OF_RIDES)
    SELECT RIDEABLE_TYPE_ID, COUNT(*) AS NO_OF_RIDES
    FROM [2022_TRIP_DATA]
    GROUP BY RIDEABLE_TYPE_ID
    ORDER BY NO_OF_RIDES DESC;

	-- Calculate Distribution of members and casuals for each bike type and save in a new table MEM_CAS_BIKES_RIDES
	
CREATE TABLE MEM_CAS_BIKES_RIDES (
    RIDEABLE_TYPE_ID VARCHAR(50),
    MEMBER_CASUAL VARCHAR(10),
    NO_OF_RIDES INT
);

INSERT INTO MEM_CAS_BIKES_RIDES (RIDEABLE_TYPE_ID, MEMBER_CASUAL, NO_OF_RIDES)
    SELECT RIDEABLE_TYPE_ID, MEMBER_CASUAL, COUNT(*) AS NO_OF_RIDES
    FROM [2022_TRIP_DATA]
    GROUP BY RIDEABLE_TYPE_ID, MEMBER_CASUAL
    ORDER BY RIDEABLE_TYPE_ID ASC, NO_OF_RIDES DESC;

	-- Calculate No. of round trips for each bike type and membership type and save in a new table ROUND_RIDES 
CREATE TABLE ROUND_RIDES (
    START_STATION_NAME VARCHAR(100),
    NO_OF_ROUND_TRIPS INT,
    RIDEABLE_TYPE_ID VARCHAR(50),
    MEMBER_CASUAL VARCHAR(10)
);

INSERT INTO ROUND_RIDES (START_STATION_NAME, NO_OF_ROUND_TRIPS, RIDEABLE_TYPE_ID, MEMBER_CASUAL)
    SELECT START_STATION_NAME, COUNT(*) AS NO_OF_ROUND_TRIPS, RIDEABLE_TYPE_ID, MEMBER_CASUAL
    FROM [2022_TRIP_DATA]
    WHERE START_STATION_ID = END_STATION_ID
    GROUP BY START_STATION_NAME, RIDEABLE_TYPE_ID, MEMBER_CASUAL
    ORDER BY START_STATION_NAME, NO_OF_ROUND_TRIPS DESC, RIDEABLE_TYPE_ID;

	-- Calculate Distribution of casual and member rides across the year and save in a new table YEAR_RIDES

CREATE TABLE YEAR_RIDES (
    MON_YEAR DATETIME,
    MEMBER_CASUAL VARCHAR(10),
    NO_OF_RIDES INT
);

INSERT INTO YEAR_RIDES (MON_YEAR, MEMBER_CASUAL, NO_OF_RIDES)
    SELECT DATEFROMPARTS(YEAR(STARTED_AT), MONTH(STARTED_AT), 1) AS MON_YEAR, MEMBER_CASUAL, COUNT(*) AS NO_OF_RIDES
    FROM [2022_TRIP_DATA]
    GROUP BY DATEFROMPARTS(YEAR(STARTED_AT), MONTH(STARTED_AT), 1), MEMBER_CASUAL;

CREATE TABLE YEAR_RIDES_CASUAL (
    MON_YEAR DATETIME,
    MEMBER_CASUAL VARCHAR(10),
    NO_OF_RIDES INT
);

INSERT INTO YEAR_RIDES_CASUAL (MON_YEAR, MEMBER_CASUAL, NO_OF_RIDES)
    SELECT CAST(CONVERT(VARCHAR(7), STARTED_AT, 120)+'-01' AS DATETIME) AS MON_YEAR, MEMBER_CASUAL, COUNT(*) AS NO_OF_RIDES
    FROM [2022_TRIP_DATA]
    WHERE MEMBER_CASUAL = 'casual'
    GROUP BY CAST(CONVERT(VARCHAR(7), STARTED_AT, 120)+'-01' AS DATETIME), MEMBER_CASUAL;

CREATE TABLE YEAR_RIDES_MEMBERS (
    MON_YEAR DATETIME,
    MEMBER_CASUAL VARCHAR(10),
    NO_OF_RIDES INT
);

INSERT INTO YEAR_RIDES_MEMBERS (MON_YEAR, MEMBER_CASUAL, NO_OF_RIDES)
    SELECT CAST(CONVERT(VARCHAR(7), STARTED_AT, 120)+'-01' AS DATETIME) AS MON_YEAR, MEMBER_CASUAL, COUNT(*) AS NO_OF_RIDES
    FROM [2022_TRIP_DATA]
    WHERE MEMBER_CASUAL = 'member'
    GROUP BY CAST(CONVERT(VARCHAR(7), STARTED_AT, 120)+'-01' AS DATETIME), MEMBER_CASUAL;

