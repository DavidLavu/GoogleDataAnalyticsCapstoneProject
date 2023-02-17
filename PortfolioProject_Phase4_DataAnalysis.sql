--Phase 5: Data Analysis
--Create new tables for each separate analysis so that they can be exported separately to Tableau

-- Create new column trip duration secs
ALTER TABLE "2022_TRIP_DATA"
ADD TRIP_DURATION_SECS FLOAT;

-- Calculate trip length
UPDATE 
 "2022_TRIP_DATA"
SET TRIP_DURATION_SECS = DATEDIFF(second, ended_at,started_at);

-- Number of rides for casual and members

	CREATE TABLE MEM_CAS_RIDES (
    MEMBER_CASUAL VARCHAR(10),
    NO_OF_RIDES INT
);

INSERT INTO MEM_CAS_RIDES (MEMBER_CASUAL, NO_OF_RIDES)
    SELECT MEMBER_CASUAL, COUNT(*) AS NO_OF_RIDES
    FROM [2022_TRIP_DATA]
    GROUP BY MEMBER_CASUAL
    ORDER BY NO_OF_RIDES DESC;

-- Count of rides for each bike type
CREATE TABLE BIKES_RIDES (
    RIDEABLE_TYPE_ID VARCHAR(50),
    NO_OF_RIDES INT
);

INSERT INTO BIKES_RIDES (RIDEABLE_TYPE_ID, NO_OF_RIDES)
    SELECT RIDEABLE_TYPE_ID, COUNT(*) AS NO_OF_RIDES
    FROM [2022_TRIP_DATA]
    GROUP BY RIDEABLE_TYPE_ID
    ORDER BY NO_OF_RIDES DESC;

	-- Distribution of members and casuals for each bike type
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

	-- Count round trips for each bike type and membership type
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

	-- Distribution of casual and member rides across the year
CREATE TABLE YEAR_RIDES (
    MON_YEAR VARCHAR(10),
    MEMBER_CASUAL VARCHAR(10),
    NO_OF_RIDES INT
);

INSERT INTO YEAR_RIDES (MON_YEAR, MEMBER_CASUAL, NO_OF_RIDES)
    SELECT FORMAT(STARTED_AT,'MMM-yyyy') AS MON_YEAR, MEMBER_CASUAL, COUNT(*) AS NO_OF_RIDES
    FROM [2022_TRIP_DATA]
    GROUP BY FORMAT(STARTED_AT,'MMM-yyyy'), MEMBER_CASUAL;

CREATE TABLE YEAR_RIDES_CASUAL (
    MON_YEAR VARCHAR(10),
    MEMBER_CASUAL VARCHAR(10),
    NO_OF_RIDES INT
);
INSERT INTO YEAR_RIDES_CASUAL (MON_YEAR, MEMBER_CASUAL, NO_OF_RIDES)
    SELECT FORMAT(STARTED_AT,'MMM-yyyy') AS MON_YEAR, MEMBER_CASUAL, COUNT(*) AS NO_OF_RIDES
    FROM [2022_TRIP_DATA]
    WHERE MEMBER_CASUAL = 'casual'
    GROUP BY FORMAT(STARTED_AT,'MMM-yyyy'), MEMBER_CASUAL;

CREATE TABLE YEAR_RIDES_MEMBERS (
    MON_YEAR VARCHAR(10),
    MEMBER_CASUAL VARCHAR(10),
    NO_OF_RIDES INT
);

INSERT INTO YEAR_RIDES_MEMBERS (MON_YEAR, MEMBER_CASUAL, NO_OF_RIDES)
    SELECT FORMAT(STARTED_AT,'MMM-yyyy') AS MON_YEAR, MEMBER_CASUAL, COUNT(*) AS NO_OF_RIDES
    FROM [2022_TRIP_DATA]
    WHERE MEMBER_CASUAL = 'member'
    GROUP BY FORMAT(STARTED_AT,'MMM-yyyy'), MEMBER_CASUAL;


--steps
--calculateD the total trip duration in seconds for each ride and then storeD it in a new column named TRIP_DURATION_SECS.

--created new table MEM_CAS_RIDES that stores the number of casual rides and member rides.

--created new table BIKES_RIDES that stores the distribution of total trips over bike types.

--created new table MEM_CAS_BIKE_RIDES that stores the distribution of member rides and casual rides for each bike type.

--created new table ROUND_RIDES that stores the number of round trips for each bike type and membership type.

--created new table YEAR_RIDES that stores the number of rides per month for each membership type. The tables YEAR_RIDES_CASUAL and YEAR_RIDES_MEMBERS separates this table into rides per month for casuals and members respectively.