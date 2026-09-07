-- ===============================================
-- CYCLISTIC BIKE-SHARE 2019 CASE STUDY ANALYSIS
-- TOOL USED: GOOGLE BIGQUERY
-- ===============================================

--1. COMBINE ALL QUARTERS INTO A MASTER TABLE
-- (Using UNION ALL and aligning Q2's verbose names to match Q1,Q3 and Q4)

CREATE OR REPLACE TABLE `project-ec56076c-01be-4959-90b.Case_study_1.master_2019_trips` AS 
SELECT 
 trip_id,
 start_time,
 end_time,
 bikeid,
 tripduration,
 from_station_id,
 from_station_name,
 to_station_id,
 to_station_name,
 usertype,
 gender,
 birthyear
FROM `project-ec56076c-01be-4959-90b.Case_study_1.Trips_2019_Q1`

UNION ALL 

SELECT 
 _01___Rental_Details_Rental_ID AS trip_id,
 _01___Rental_Details_Local_Start_Time AS start_time,
 _01___Rental_Details_Local_End_Time AS end_time,
 _01___Rental_Details_Bike_ID AS bikeid,
 _01___Rental_Details_Duration_In_Seconds_Uncapped AS tripduration,
 _03___Rental_Start_Station_ID AS from_station_id,
 _03___Rental_Start_Station_Name AS from_station_name,
 _02___Rental_End_Station_ID AS to_station_id,
 _02___Rental_End_Station_Name AS to_station_name,
  User_Type AS usertype,
  Member_Gender AS gender,
  _05___Member_Details_Member_Birthday_Year AS birthyear
FROM `project-ec56076c-01be-4959-90b.Case_study_1.Trips_2019_Q2` 

UNION ALL

SELECT 
 trip_id,
 start_time,
 end_time,
 bikeid,
 tripduration,
 from_station_id,
 from_station_name,
 to_station_id,
 to_station_name,
 usertype,
 gender,
 birthyear
FROM `project-ec56076c-01be-4959-90b.Case_study_1.Trips_2019_Q3`

UNION ALL

SELECT
 trip_id,
 start_time,
 end_time,
 bikeid,
 tripduration,
 from_station_id,
 from_station_name,
 to_station_id,
 to_station_name,
 usertype,
 gender,
 birthyear
FROM `project-ec56076c-01be-4959-90b.Case_study_1.Trips_2019_Q4`;

-- 2. DATA CLEANING & FEATURE ENGINEERING
-- Calculating ride lengths in minutes, extracting day of week (1=Sun, 7=Sat) and filtering bad data
CREATE OR REPLACE TABLE `project-ec56076c-01be-4959-90b.Case_study_1.cleaned_2019_trips` AS

SELECT
 trip_id,
 start_time,
 end_time,
 bikeid,
 from_station_name,
 to_station_name,
 usertype,
 gender,
 birthyear,
 TIMESTAMP_DIFF(end_time, start_time, MINUTE) AS ride_length_minutes,
 EXTRACT (DAYOFWEEK FROM start_time) AS day_of_week

FROM `project-ec56076c-01be-4959-90b.Case_study_1.master_2019_trips` 

WHERE
 TIMESTAMP_DIFF(end_time, start_time, MINUTE) > 0;

-- 3. DESCRIPTIVE ANALYSIS: OVERALL STATS BY USER TYPE
SELECT 
    usertype,
    COUNT(trip_id) AS total_trips,
    ROUND(AVG(ride_length_minutes), 2) AS avg_ride_length,
    MAX(ride_length_minutes) AS max_ride_length
FROM `project-ec56076c-01be-4959-90b.Case_study_1.cleaned_2019_trips`
GROUP BY usertype;


-- 4. DESCRIPTIVE ANALYSIS: TRENDS BY DAY OF WEEK
SELECT 
    usertype,
    day_of_week,
    COUNT(trip_id) AS number_of_rides,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM `project-ec56076c-01be-4959-90b.Case_study_1.cleaned_2019_trips`
GROUP BY usertype, day_of_week
ORDER BY usertype, day_of_week;
