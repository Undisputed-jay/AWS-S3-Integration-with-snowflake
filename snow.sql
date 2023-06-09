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

