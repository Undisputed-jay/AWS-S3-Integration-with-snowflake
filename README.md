Citibike Data Integration and ETL Pipeline

This repository contains SQL scripts and configurations for a data integration and ETL pipeline that loads Citibike trip data from an Amazon S3 bucket into a Snowflake database. This pipeline uses Snowflake's external storage integration and staging capabilities to access, format, and transform Citibike data for analysis.
Features
    AWS S3 and Snowflake Integration: Securely connects to a designated S3 bucket using Snowflake's STORAGE INTEGRATION and IAM roles, ensuring a reliable and efficient data connection.
    Data Staging and File Formatting: Defines a reusable file format for consistent parsing of CSV files, including error handling for null values and missing data.
    Automated Data Loading: Copies raw CSV data from S3 into a Snowflake stage, transforming it for storage in a structured Snowflake table.
    Scalable ETL Process: Easily scalable for additional Citibike datasets or other data formats, supporting future data ingestion and transformations.

Table Structure

The pipeline loads data into a trips table, which includes columns for trip duration, start and end times, station details, bike IDs, and user demographic information. This structured format enables quick querying and supports further analytics.
Usage
    Configure Storage Integration: Ensure Snowflake has permissions to access the S3 bucket by configuring the STORAGE_AWS_ROLE_ARN and STORAGE_ALLOWED_LOCATIONS.
    Load Data: Execute the SQL script to create the integration, define file format and stage, and load data into the trips table.
    Analyze Data: Once loaded, the data can be queried for insights into Citibike usage patterns, peak times, and demographic information.

Getting Started
    Clone the repository.
    Ensure your Snowflake and S3 configurations match those specified in the SQL script.
    Run the SQL script to create the necessary integrations, stage, and tables in Snowflake.
    Query the trips table for analysis.
