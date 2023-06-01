# To create a table that contains data from a total of 12 monthly tables, ranging from May 2022 to April 2023.

WITH temp_months_data AS (
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM (
    SELECT * FROM bike_trips_202205
    UNION ALL
    SELECT * FROM bike_trips_202206
    UNION ALL
    SELECT * FROM bike_trips_202207
    UNION ALL
    SELECT * FROM bike_trips_202208
    UNION ALL
    SELECT * FROM bike_trips_202209
    UNION ALL
    SELECT * FROM bike_trips_202210
    UNION ALL
    SELECT * FROM bike_trips_202211
    UNION ALL
    SELECT * FROM bike_trips_202212
    UNION ALL
    SELECT * FROM bike_trips_202301
    UNION ALL
    SELECT * FROM bike_trips_202302
    UNION ALL
    SELECT * FROM bike_trips_202303
    UNION ALL
    SELECT * FROM bike_trips_202304) as temp_all
),

# To create a table that holds computed values for ride duration, day of the week, hour, and month data.

  temp_metrics_data AS ( # to caculate ride duration and week day
  SELECT
    ride_id,
    TIMESTAMPDIFF(SECOND, started_at, ended_at) AS ride_length,
    CASE
    when dayofweek(started_at) = 1 then "Sunday"
	WHEN DAYOFWEEK(started_at) = 2 THEN 'Monday'
	WHEN DAYOFWEEK(started_at) = 3 THEN 'Tuesday'
	WHEN DAYOFWEEK(started_at) = 4 THEN 'Wednesday'
	WHEN DAYOFWEEK(started_at) = 5 THEN 'Thursday'
	WHEN DAYOFWEEK(started_at) = 6 THEN 'Friday'
	WHEN DAYOFWEEK(started_at) = 7 THEN 'Saturday'
    END AS day_of_week,
    date_format(started_at, '%H') AS at_hour,
    date_format(started_at, '%b') AS at_month
  FROM temp_months_data
)

# To select the necessary data for analysis and visualization purposes.

SELECT
  d.ride_id,
  d.rideable_type,
  d.started_at,
  d.ended_at,
  d.member_casual,
  m.ride_length,
  m.day_of_week,
  m.at_hour,
  m.at_month
FROM
  temp_months_data as d
JOIN
  temp_metrics_data as m
ON d.ride_id = m.ride_id
WHERE
  ride_length > 0
  OR start_station_name <> ''
  OR start_station_id <> ''
  OR end_station_name <> ''
  OR end_station_id <> ''
  
  # There were 5,857,272 records that matched the condition, and it took approximately 7 minutes and 47 seconds to complete the query.