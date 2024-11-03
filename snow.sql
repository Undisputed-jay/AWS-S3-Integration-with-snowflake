-- Step 1: Creating an Integration Object for S3 Access
-- This integration configures access between Snowflake and an external Amazon S3 bucket.
-- It uses an AWS IAM role to manage permissions for secure data access and enables Snowflake
-- to read data directly from the specified S3 bucket.

CREATE OR REPLACE STORAGE INTEGRATION citibike
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = s3
    ENABLED = TRUE
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::970884250493:role/snow-s3-work'
    STORAGE_ALLOWED_LOCATIONS = ('s3://snow-s3work/snow-s3work-csv-folder/')
    COMMENT = 'Integration with Citibike S3 bucket for CSV data';

-- Viewing integration details for verification
DESC INTEGRATION citibike;

-- Granting usage permissions on the integration to the account administrator role
GRANT USAGE ON INTEGRATION citibike TO ROLE accountadmin;

-- Step 2: Defining a File Format for CSV Files
-- Specifies the format for CSV files in S3 so that Snowflake can parse the data correctly.
-- The format skips the first header row and treats various null values consistently.

CREATE OR REPLACE FILE FORMAT demo_format
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    NULL_IF = ('NULL', '', 'N/A', 'NA');

-- Step 3: Creating a Stage for External Data
-- Establishes a stage to manage the connection to the S3 bucket and specifies the file format.
-- This stage allows files in the specified S3 bucket to be loaded into Snowflake.

CREATE OR REPLACE STAGE citibike.public.my_stage
    URL = "s3://snow-s3work/snow-s3work-csv-folder/"
    STORAGE_INTEGRATION = citibike
    FILE_FORMAT = demo_format;

-- Listing available files in the stage for verification
LIST @my_stage;

-- Step 4: Creating a Table to Store Data
-- Defines the structure of the `trips` table, where Citibike trip data will be loaded.
-- The table includes columns for trip details such as duration, start and stop times,
-- station details, bike ID, user type, and demographics.

CREATE TABLE IF NOT EXISTS trips (
    tripduration INTEGER,
    starttime STRING,
    stoptime STRING,
    start_station_id INTEGER,
    start_station_name STRING,
    start_station_latitude FLOAT,
    start_station_longitude FLOAT,
    end_station_id FLOAT,
    end_station_name STRING,
    end_station_latitude FLOAT,
    end_station_longitude FLOAT,
    bikeid INTEGER,
    usertype STRING,
    birth_year INTEGER,
    gender INTEGER
);

-- Step 5: Loading Data from Stage to Table
-- Copies the CSV data from the external S3 stage into the `trips` table.
-- The `ON_ERROR` parameter is set to 'CONTINUE' to skip rows with errors during loading.

COPY INTO citibike.public.trips
    FROM @my_stage
    ON_ERROR = 'CONTINUE';

-- Verifying data load by selecting data from the trips table
SELECT * FROM PUBLIC.TRIPS;
-- creating integration object
CREATE OR REPLACE STORAGE INTEGRATION citibike
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = s3
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::970884250493:role/snow-s3-work'
STORAGE_ALLOWED_LOCATIONS = ('s3://snow-s3work/snow-s3work-csv-folder/')
COMMENT = 'Integration with s3 buckets';

DESC INTEGRATION citibike;

-- grant integration usage to accountadmin
GRANT USAGE ON INTEGRATION citibike TO ROLE accountadmin;

-- creating file format
CREATE OR REPLACE FILE FORMAT demo_format
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1
NULL_IF = ('NULL', '', 'N/A', 'NA');

-- creating stage
CREATE OR REPLACE STAGE citibike.public.my_stage
URL = "s3://snow-s3work/snow-s3work-csv-folder/"
STORAGE_INTEGRATION = citibike
FILE_FORMAT = demo_format;

-- list items in stage
LIST @my_stage;

-- creating a table
CREATE TABLE IF NOT EXISTS trips (
tripduration integer,
starttime string,
stoptime string,
start_station_id integer,
start_station_name string,
start_station_latitude float,
start_station_longitude float,
end_station_id float,
end_station_name string,
end_station_latitude float,
end_station_longitude float,
bikeid integer,
usertype string,
birth_year integer,
gender integer
);


-- copy item from stage to table.
COPY INTO citibike.public.trips
FROM @my_stage
ON_ERROR = 'CONTINUE';

SELECT * FROM (PUBLIC.TRIPS);

