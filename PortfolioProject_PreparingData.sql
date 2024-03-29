--This query is preparing data by combining 12 data tables into a single data table for the year 2022. The query first checks if all the tables have the same number of columns, then checks if all tables have the same column names, and then checks if the data types of the columns are the same across all tables.

--The query corrects data type mismatches found in specific tables by altering their columns, and then creates a new table called "2022_TRIP_DATA" with columns for ride information.

--Finally, the code inserts the data from the 12 joined tables into the new "2022_TRIP_DATA" table using the UNION operator.


--1. Preparing Data
--combining all the 12 data tables into a single data table 


--checked if all the tables have the same number of columns
SELECT
 COUNT(*) AS num_columns
FROM
INFORMATION_SCHEMA.COLUMNS
WHERE
TABLE_NAME IN ('TRIP_202201', 'TRIP_202202', 'TRIP_202203', 'TRIP_202204', 'TRIP_202205', 'TRIP_202206', 'TRIP_202207', 'TRIP_202208', 'TRIP_202209', 'TRIP_202210', 'TRIP_202211', 'TRIP_202212' )
GROUP BY
TABLE_NAME;

--checked if all the tables have the same columns names
SELECT
    COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'TRIP_202201'
    OR TABLE_NAME = 'TRIP_202202'
    OR TABLE_NAME = 'TRIP_202203'
    OR TABLE_NAME = 'TRIP_202204'
    OR TABLE_NAME = 'TRIP_202205'
    OR TABLE_NAME = 'TRIP_202206'
    OR TABLE_NAME = 'TRIP_202207'
    OR TABLE_NAME = 'TRIP_202208'
    OR TABLE_NAME = 'TRIP_202209'
    OR TABLE_NAME = 'TRIP_202210'
    OR TABLE_NAME = 'TRIP_202211'
    OR TABLE_NAME = 'TRIP_202212'
GROUP BY COLUMN_NAME
HAVING COUNT(*) = 12;

-- Checked table columns data types
SELECT 
 c.TABLE_SCHEMA, c.TABLE_NAME, c.COLUMN_NAME, c.DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS c
ORDER BY 
 c.TABLE_SCHEMA, c.TABLE_NAME, c.ORDINAL_POSITION;

 --Check if column data types is the same
 SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME IN ('TRIP_202201', 'TRIP_202202', 'TRIP_202203', 'TRIP_202204', 'TRIP_202205', 'TRIP_202206', 'TRIP_202207', 'TRIP_202208', 'TRIP_202209', 'TRIP_202210', 'TRIP_202211', 'TRIP_202212')
GROUP BY 
    TABLE_NAME, 
    COLUMN_NAME, 
    DATA_TYPE
HAVING 
    COUNT(*) <> 1;

-- The above query returns columns that have different data types for the same column name
 --Noticed data type mismatch in 202204, 202207, 202209,202210 and 202211 tables

--corrected datatype mismatch in above tables
ALTER TABLE TRIP_202204 
ALTER COLUMN start_station_id NVARCHAR(50);

ALTER TABLE TRIP_202207 
ALTER COLUMN start_station_id NVARCHAR(50);

ALTER TABLE TRIP_202209 
ALTER COLUMN end_station_id NVARCHAR(50);

ALTER TABLE TRIP_202210 
ALTER COLUMN start_station_id NVARCHAR(50);

ALTER TABLE TRIP_202211 
ALTER COLUMN start_station_id NVARCHAR(50);
ALTER TABLE TRIP_202211 
ALTER COLUMN end_station_id NVARCHAR(50);

ALTER TABLE TRIP_202212 
ALTER COLUMN end_station_id NVARCHAR(50);



--Created a new table 
CREATE TABLE "2022_TRIP_DATA" (
    ride_id NVARCHAR(50),
    rideable_type_id NVARCHAR(50),
    started_at datetime,
    ended_at datetime,
    start_station_name NVARCHAR(100),
    start_station_id NVARCHAR(50),
    end_station_name NVARCHAR(100),
	end_station_id NVARCHAR(50),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual NVARCHAR(50)
	);



-- Inserted data from joined tables into the new created table   
   INSERT INTO 
   "2022_TRIP_DATA"

   SELECT *
    FROM TRIP_202201
    
    UNION 

    SELECT *
    FROM TRIP_202202

    UNION

    SELECT *
    FROM TRIP_202203

	UNION

    SELECT *
    FROM TRIP_202204
    
    UNION

    SELECT *
    FROM TRIP_202205

    UNION

    SELECT *
    FROM TRIP_202206

    UNION

    SELECT *
    FROM TRIP_202207
    
    UNION

    SELECT *
    FROM TRIP_202208

    UNION

    SELECT *
    FROM TRIP_202209

    UNION

    SELECT *
    FROM TRIP_202210
    
    UNION

    SELECT *
    FROM TRIP_202211

    UNION

    SELECT *
    FROM TRIP_202212
	;
