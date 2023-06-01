# Create table for trip data from May 2022 to April 2023.
# Each data will be contained in its respective table and have matching columns.
create table bike_trips_202304 (
  ride_id text,
  rideable_type text,
  started_at datetime,
  ended_at datetime,
  start_station_name text,
  start_station_id text,
  end_station_name text,
  end_station_id text,
  start_lat text,
  start_lng text,
  end_lat text,
  end_lng text,
  member_casual text);

# To load data into a table, repeat this code chunk until all 12 CSV files are imported successfully. 
Load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\bike_trips_202304.csv'
into table bike_trips_202304
fields terminated by ','
lines terminated by '\n'
ignore 1 lines;
