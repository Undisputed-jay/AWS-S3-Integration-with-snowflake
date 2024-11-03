<h1>Citibike Data Integration and ETL Pipeline</h1>
    <p>This repository contains SQL scripts and configurations for a data integration and ETL pipeline that loads Citibike trip data from an Amazon S3 bucket into a Snowflake database. This pipeline uses Snowflake's external storage integration and staging capabilities to access, format, and transform Citibike data for analysis.</p>
    <h2>Features</h2>
    <ul>
        <li><strong>AWS S3 and Snowflake Integration</strong>: Securely connects to a designated S3 bucket using Snowflake's <code>STORAGE INTEGRATION</code> and IAM roles, ensuring a reliable and efficient data connection.</li>
        <li><strong>Data Staging and File Formatting</strong>: Defines a reusable file format for consistent parsing of CSV files, including error handling for null values and missing data.</li>
        <li><strong>Automated Data Loading</strong>: Copies raw CSV data from S3 into a Snowflake stage, transforming it for storage in a structured Snowflake table.</li>
        <li><strong>Scalable ETL Process</strong>: Easily scalable for additional Citibike datasets or other data formats, supporting future data ingestion and transformations.</li>
    </ul>
    <h2>Table Structure</h2>
    <p>The pipeline loads data into a <code>trips</code> table, which includes columns for trip duration, start and end times, station details, bike IDs, and user demographic information. This structured format enables quick querying and supports further analytics.</p>
    <h2>Usage</h2>
    <ol>
        <li><strong>Configure Storage Integration</strong>: Ensure Snowflake has permissions to access the S3 bucket by configuring the <code>STORAGE_AWS_ROLE_ARN</code> with appropriate IAM roles.</li>
        <li><strong>Run SQL Scripts</strong>: Execute the SQL scripts in the repository to create the integration, file format, stage, and table, then load the data from S3.</li>
        <li><strong>Query the Data</strong>: Run queries on the <code>trips</code> table to analyze Citibike trip data.</li>
    </ol>
