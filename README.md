---
title: "Google Data Analytic Capstone Project"
author: "Tran Hoang Phuoc"
date: "2023-05-28"
output: html_document
---

# Table of Contens

1. Introduction
2. Business Task
3. Data
4. Processing and Cleaning
5. Analysis and Viz
6. Conclusion and Recommendations

# Introduction

The project is a part of Google Data Analytics Certification course capstone. The scenario involves analysis of the trip data of Cyclistic bike share company.

The company has two models for availing service: individual passes which are called "casual" riders and annual subscriptions called "member" riders. The company operates in Chicago with around 6000 bicycles at 700 stations.

Maximizing the number of annual members will be key to future growth as it ensures financial sustainability and customer retention. The insights can help devise effective marketing strategies aimed to convert more casual riders into annual members.

# Business Task

How do annual members and casual riders use Cyclistic bikes differently ?

>Objective : To clean, analyze and visualize the data to observe how casual riders use the bike rentals differently from annual member riders.

# Data

* Data source : Public data from Motivate International Inc. (Divvy Bicycle Sharing Service from Chicago) under this [license](https://ride.divvybikes.com/data-license-agreement).
* [Cyclistic' historical trip data](https://divvy-tripdata.s3.amazonaws.com/index.html) (2013 onwards) available in `.csv` format.
* **My date range**: May 2022 to April 2023 (913 MB)
* The dataset has individual ride records consisting of ride start-end date & time, station information, bike type, rider type (casual/member).

# Processing and Cleaning

## Spreadsheet: Microsoft Excel

I initially wanted to gather and analyze my data in Excel because it was the tool I was most familiar with and I could get a general understanding of the data quicker. I did not combine all of the spreadsheets into one because that would've taken more processing power than my computer had.

1. I began turning the `.csv` files into excel spreadsheets and downloading the most recent year of data from May 2022 to April 2023.

2. Added two columns to all of the months:

* a. ride_length: Calculate the length of each ride by subtracting the column “started_at” from the column “ended_at” and format as HH:MM:SS using Format > Cells > Time.
* b. day_of_week: calculate the day of the week that each ride started using the “WEEKDAY” command and format as DDD Date type.

3. Came up with metrics to look at such as:

* a. Total number of rides per hour, per day of the week, per day of the month, per season and for different bike types
* b. Average ride length between members and casual

4. Created Pivot tables and charts for every month:

* a. Total Rides per Weekday - calculated the total rides for members and casual and separated it by day of the week; used a cluster column chart

<img src="https://drive.google.com/uc?id=12JRLVEKNjHvi9BsPuc79x_Fw9nd4D3Ol"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />

* b. Total Rides per Hour -  calculated the total rides for members and casual separated by the time of the day (24hr); used a line comparison chart

<img src="https://drive.google.com/uc?id=1Rf3ySsSP58Ad5w4S7cEYPJI9I1Xtlk38"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />
     
* c. Total Rides per Day -  calculated the total rides for members and casual separated by the day of the month; used a cluster column chart

<img src="https://drive.google.com/uc?id=12JRLVEKNjHvi9BsPuc79x_Fw9nd4D3Ol"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />

* d. Total Rides per Bike Type - calculated the total rides for members and casual separated by Bike type; used stacked column chart

<img src="https://drive.google.com/uc?id=1IzljMeW4SnMxwKC9Fd_yHqwgW-cxlSLN"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />
     
* e. Average Ride Length - calculated the average ride length for members and casual and separated it by day of the week; used a cluster column chart

<img src="https://drive.google.com/uc?id=13ATos_zpas1Ie5RjPCtoQUbgPmRL-8fa"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />
     
## SQL: Oracle MySQL Workbench

In order to aggregate data from 12 separate monthly CSV files, I decided to use SQL as a data query language to optimize the data cleaning and preparation process for analysis and visualization. Specifically, I chose to use MySQL Workbench because I have invested a significant amount of time familiarizing myself with and using this software.

1. I began importing the 12 data files into MySQL Workbench using the following [query](https://github.com/PhuocTran96/Cyclistic_Analysis/blob/main/docs/import_table_into_mySQL.sql).

2. After completing the data import into MySQL Workbench, I followed these steps to clean and prepare the data:

* a. Created a temporary table to combine data from the 12 separate files.

* b. Created another temporary table for calculating ride duration and adding additional columns such as weekday, month, and hour.

* c. Joined the two temporary tables to display the required information.

* d. Exported the resulting table, which contained `5,857,272` records (this process took a significant amount of time to complete).

  This is the query I used for these steps: [single query](https://github.com/PhuocTran96/Cyclistic_Analysis/blob/main/docs/query_all_data.sql).
  
3. The final table had the following structure:

<img src="https://drive.google.com/uc?id=16F7d-WybaI5Sl3kMktXo45FTr4uxsQ-W"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />

## Programming Language: R

After using MySQL Workbench to clean and process the final data, I decided to replicate that process using the R language to further improve my R skills and compare it with the processing time using SQL. Below is the code for data processing in R:

Of course, you can view my script [here](https://github.com/PhuocTran96/Cyclistic_Analysis/blob/main/docs/Cyclistic_project.R).

### Prepare Phase

Load all of the libraries I used: tidyverse, lubridate, hms, data.table

Uploaded all of the original data from the data source divytrip into R using read_csv function to upload all individual csv files and save them in separate data frames. For august 2020 data I saved it into aug08_df, september 2020 to sep09_df and so on. 

Merged the 12 months of data together using rbind to create a one year view

Created a new data frame called cyclistic_date that would contain all of my new columns

### Process Phase

Created new columns for:

Ride Length - did this by subtracting end_at time from start_at time

Day of the Week - Sun to Sat

Month - Jan to Dec

Day

Year

Hour - as integer 

Season - Spring, Summer, Winter or Fall

Time of Day - Night, Morning, Afternoon or Evening

### Cleaning the data

Removing duplicate rows

Remove rows with NA values (blank rows)

Remove where ride_length is < = 0

Remove unnecessary columns: start_station_id, end_station_id, start_lat, start_long, end_lat, end_lng

### Analyze Phase

#### Calculated Total Rides for:

Total number of rides which was just the row count = 4,533,651

Member type - casual riders vs. annual members

Type of Bike - classic vs docked vs electric; separated by member type and total rides for each bike type

Hour - separated by member type and total rides for each hour in a day

Time of Day - separated by member type and total rides for each time of day (morning, afternoon, evening, night)

Day of the Week - separated by member type and total rides for each day of the week

Day of the Month - separated by member type and total rides for each day of the month

Month - separated by member type and total rides for each month

Season - separated by member type and total rides for each season (spring,  summer, fall, winter)

#### Calculated Average Ride Length for:

Total average ride length

Member type - casual riders vs. annual members 

Type of Bike - separated by member type and average ride length for each bike type

Hour - separated by member type and average ride length for each hour in a day

Time of Day - separated by member type and average ride length for each time of day (morning, afternoon, evening, night)

Day of the Week - separated by member type and average ride length for each day of the week

Day of the Month - separated by member type and average ride length for each day of the month

Month - separated by member type and average ride length for each month

Season - separated by member type and average ride lengths for each season (spring,  summer, fall, winter)

Then using all of this data I created my own summary in my case notes and took note of the: total rides for each variable, average ride lengths for each variable, and the difference between members versus casual riders.

### Share Phase

There is no denying that data visualization and charting capabilities in R are powerful and useful. However, I have decided to use another powerful data visualization tool, Microsoft Power BI, which allows me to maximize the potential of charts and have more interactive control over them. But you can view some of my charts and the code [here]().

1. Percentage of Member Type:

<img src="https://drive.google.com/uc?id=1Lxn8aBj0-XWvZ1Kd5XvGzHVlMN4P98db"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />

2. Total Ride by Ride Type per Member Type

<img src="https://drive.google.com/uc?id=1CKvUr_I1W3SWe7J81ifQzTVT5nmJSA3A"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />

3.Total Rides by Member Type over Days of the Week

<img src="https://drive.google.com/uc?id=1cUOldO_-hIPvwsiNIgi7f-hxnmrx3FTj"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />

4.Total Rides by Member Type over Days of the Month

<img src="https://drive.google.com/uc?id=1ucu5XGatQ7KnwuCVF78nb-9QZjIqCgy1"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />

# Analysis and Viz: Miscrosoft Power BI (PBI)

I choose Power BI instead of Tableau for the visualization phase because I have worked with Power BI extensively. I am already familiar with its interface, table relationships and the DAX language (although only at a basic level) for calculations. While Tableau is a good visualization tool, in my opinion, Power BI will continue to gain popularity as the Microsoft Ecosystem expands significantly. Now let's proceed to the analysis and share phase:

1. Overview of the dashboard: The  dashboard in the PBI looks like this

<img src="https://drive.google.com/uc?id=1dYq-9xaAItgxNQjHZZp0gYuAqNdjvQAH"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />

2. Total Ride by Member Type:

* Annual members account for a significant portion of the total number of rides (approximately 60%). The company should continue to focus on this major user type to maximize future profits.

* Casual riders represent over one-third (39.5%) of the total rides. If they participate in the Annual Member or another Temporary Member program, it can generate good profits for the company.

<img src="https://drive.google.com/uc?id=1C51DSWT1LDvefEfrZlqOQs7Gu8VMWODZ"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />

3. Average ride duration:

* The average usage time of casual customers (non-members) tends to be higher than that of member customers (registered users) on the same days of the week. This suggests that casual customers tend to use the service for a longer duration.

* The average usage time is higher on weekends (Saturday and Sunday) compared to other days of the week. This indicates that users tend to utilize the service more during the weekends, possibly due to having more free time or different objectives for using the service.

* The average usage time of both casual and member customers is lower on Wednesdays. This suggests a decrease in service usage on Wednesdays, possibly influenced by external factors such as busy schedules or other factors affecting service usage.

<img src="https://drive.google.com/uc?id=1zpRX0JmPTqO4KtjItmmLtHBW_Aaw2j9W"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />

4. Total Ride per Bike Type:

* It is important to note that the count of classic bike rides is much higher for members compared to casual users. This indicates that classic bikes are preferred by members over casual users.

* Electric bikes are also popular among users, with a substantial number of rides recorded for both casual and member users. However, it is worth noting that the count of electric bike rides is higher for members compared to casual users.

* Among the rideable types, docked bikes are the least commonly used.

<img src="https://drive.google.com/uc?id=1PNs-wIOcf6e7HYPiwFWc5EJvRQ09kCFI"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />

5. Tota Ride by Day of the Week:

* Mondays and Tuesdays have relatively lower ride counts compared to the rest of the weekdays for both casual and member users.

* Wednesdays, Thursdays, and Fridays have higher ride counts, with Fridays having the highest number of rides for both casual and member users.

* Saturdays and Sundays also have a significant number of rides, with Saturdays having slightly higher ride counts compared to Sundays.

* These patterns suggest that weekdays, particularly towards the end of the week, are more popular for bike rides among both casual and member users. Fridays stand out as the busiest day, potentially indicating increased recreational or commuting activities during weekends. Understanding these usage patterns can help in resource allocation, scheduling maintenance, and optimizing bike availability for different user segments.

<img src="https://drive.google.com/uc?id=1d68dN2oqn0paICYROwuudhwAb_u3_8rJ"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />
     
6. Total Ride by Month and Season:

* May, June, July, and August have the highest number of rides for both casual and member users. These months correspond to the summer season when outdoor activities, including bike rides, are more popular.

* December has the lowest number of rides for both casual and member users, likely due to colder weather and holiday season factors.

* There is a general increasing trend in the number of rides from January to August, indicating higher bike usage during the warmer months.

* September and October have relatively lower ride counts compared to the peak summer months but still show a significant number of rides.

* November has a lower number of rides compared to the previous months, possibly due to the transition into colder weather.

<img src="https://drive.google.com/uc?id=1QbkkHtQGbwkAvt4wOlYMfku2m2dpqTk4"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />

7. Total Ride by House and Times of Day:

* Both casual and member users have similar patterns throughout the day, with peak hours of bike rides occurring during the morning and evening commuting hours.

* For both user types, the highest number of rides occurs during the hours of 7 AM to 10 AM and 4 PM to 7 PM, which align with typical workday commuting times.

* Casual users show a more gradual increase and decrease in ride counts throughout the day, indicating a more flexible and varied usage pattern.

* Member users, on the other hand, exhibit a more pronounced peak during the morning and evening rush hours, suggesting a higher proportion of regular commuting riders.

* During late-night and early-morning hours (from midnight to 6 AM), the number of rides decreases significantly for both casual and member users.

* The data reflects the influence of daily routines, work schedules, and commuting patterns on bike ride usage.

<img src="https://drive.google.com/uc?id=1o9RIUVHdKn2zTFqeHVZz_xmJPYXOf_7b"
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 90%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)" />
     
# Conclusion and Recommendations

1. Enhance the bike rental service for casual users: The company can increase advertising efforts and offer promotional campaigns to attract new customers, such as discounted rates for the first hour or day, providing special packages for tourists or event participants.

2. Implement an attractive membership program for member users: The company can create membership packages with special benefits, such as discounted rental rates, extended usage time, or additional services like bike insurance. Additionally, the company should develop loyalty programs to incentive members to use the service during off-peak hours.

3. Invest in infrastructure and services at docking stations: Based on the usage patterns throughout the day, the company can ensure an adequate supply of bikes to meet the highest demand. Additionally, improving the infrastructure at docking stations, such as increasing the number of bike racks or providing supplementary amenities like information boards and maps, can enhance the user experience.

4. Analyze and optimize bike allocation: Utilizing data analysis techniques, the company can gain deeper insights into bike usage patterns and optimize bike allocation. This ensures that bikes are allocated purposefully and efficiently, meeting the users' needs effectively.