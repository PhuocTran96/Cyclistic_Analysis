#-------------------------- Cyclistic Project ----------------------------------

##------------------------- Process Phase --------------------------------------

#load libraries
library(tidyverse) #import and process
library(lubridate) #working with date and time
library(data.table) #working with data frame

#load data from 12 seperate monthly .csv files, from May'2022 to April'2023
may22_df <- read_csv("202205-divvy-tripdata.csv")
jun22_df <- read_csv("202206-divvy-tripdata.csv")
jul22_df <- read_csv("202207-divvy-tripdata.csv")
aug22_df <- read_csv("202208-divvy-tripdata.csv")
sep22_df <- read_csv("202209-divvy-tripdata.csv")
oct22_df <- read_csv("202210-divvy-tripdata.csv")
nov22_df <- read_csv("202211-divvy-tripdata.csv")
dec22_df <- read_csv("202212-divvy-tripdata.csv")
jan23_df <- read_csv("202301-divvy-tripdata.csv")
feb23_df <- read_csv("202302-divvy-tripdata.csv")
mar23_df <- read_csv("202303-divvy-tripdata.csv")
apr23_df <- read_csv("202304-divvy-tripdata.csv")

#combine all data frames into 1 year
project_df <- rbind(may22_df,jun22_df,jul22_df,aug22_df,sep22_df,oct22_df,nov22_df,dec22_df,jan23_df,feb23_df,mar23_df,apr23_df)

#clean working enviroment
rm(may22_df,jun22_df,jul22_df,aug22_df,sep22_df,oct22_df,nov22_df,dec22_df,jan23_df,feb23_df,mar23_df,apr23_df)

#create a new data frame to add additional columns
analysis_df <- project_df

analysis_df$ride_length <- difftime(analysis_df$ended_at, analysis_df$started_at, unit ="mins") #ride duration
analysis_df$day_of_week <- format(as.Date(analysis_df$started_at), "%a") #day of week
analysis_df$hour <- as.integer(substr(analysis_df$started_at, 12, 13)) #extract hour
analysis_df$year <- format(as.Date(analysis_df$started_at), "%Y") #extract year
analysis_df$month <- format(as.Date(analysis_df$started_at), "%b") #extract month
analysis_df$date <- format(as.Date(analysis_df$started_at), "%d") #extract day

#create a column for season base on month
analysis_df <- analysis_df %>% mutate(season =
                                        case_when(month %in% c("Jan","Feb","Mar") ~ "Spring",
                                                  month %in% c("Apr","May","Jun") ~ "Summer",
                                                  month %in% c("Jul","Aug","Sep") ~ "Fall",
                                                  TRUE ~ "Winter"))

#create a column for times of day
analysis_df <- analysis_df %>% mutate(dayparting =
                                        case_when(hour %in% c(0:5) ~ "Night",
                                                  hour %in% c(6:12) ~"Morning",
                                                  hour %in% c(13:17) ~ "Afternoon",
                                                  TRUE ~ "Evening"))

#clean data
na_rows <- which(rowSums(is.na(analysis_df)) > 0) #check the rows that contain NA values ~ 1,325,065 records that missing information in station name or id
analysis_df[na_rows, ] #view the rows that contain NA values
analysis_df <- na.omit(analysis_df) #remove rows that contain NA values ~ 4,533,979 remaining valid records
analysis_df <- distinct(analysis_df) #remove duplicate rows ~ no duplicate rows
analysis_df <- analysis_df[analysis_df$ride_length > 0, ] #remove rows that ride duration is <= 0 ~ 4,533,651 remaining valid records
analysis_df <- analysis_df %>% #remove unnecessary columns
  select(-c(start_station_id, end_station_id, start_lat, start_lng, end_lat, end_lng))

##------------------------- Analyze Phase --------------------------------------

#--- Count ---

#total ride
nrow(analysis_df) # 4,533,651 records

#member type
analysis_df %>%
  count(member_casual)

#bike type
analysis_df %>% #total number of rides by bike type
  count(rideable_type)

analysis_df %>% #total number of rides by bike type per member type
  group_by(member_casual, rideable_type) %>%
  count(rideable_type)

#per hour
analysis_df %>%
  count(hour) %>%
  print(n = 24) #view full 24hrs

analysis_df %>%
  group_by(member_casual, hour) %>%
  count(hour) %>%
  print(n = 48) #view full 24hrs per member type

#---times of day---
analysis_df %>% #by times of day
  count(dayparting) %>%
  arrange(match(dayparting, c("Night", "Morning", "Afternoon", "Evening")))

analysis_df %>% #by times of day per member type
  group_by(member_casual, dayparting) %>%
  count(dayparting) %>%
  arrange(match(dayparting, c("Night", "Morning", "Afternoon", "Evening")))

#Morning
analysis_df %>%
  filter(dayparting == "Morning") %>%
  count(dayparting)

analysis_df %>%
  filter(dayparting == "Morning") %>%
  group_by(member_casual, dayparting) %>%
  count(dayparting)

#Afternoon
analysis_df %>%
  filter(dayparting == "Afternoon") %>%
  count(dayparting)

analysis_df %>%
  filter(dayparting == "Afternoon") %>%
  group_by(member_casual, dayparting) %>%
  count(dayparting)

#Evening
analysis_df %>%
  filter(dayparting == "Evening") %>%
  count(dayparting)

analysis_df %>%
  filter(dayparting == "Evening") %>%
  group_by(member_casual, dayparting) %>%
  count(dayparting)

#Night
analysis_df %>%
  filter(dayparting == "Night") %>%
  count(dayparting)

analysis_df %>%
  filter(dayparting == "Night") %>%
  group_by(member_casual, dayparting) %>%
  count(dayparting)

#---day of the week---
analysis_df %>%
  count(day_of_week) %>%
  arrange(match(day_of_week, c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")))

analysis_df %>%
  group_by(member_casual, day_of_week) %>%
  count(day_of_week) %>%
  arrange(match(day_of_week, c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")))

#---day of the month---
analysis_df %>%
  count(date) %>%
  print(n = 31)

analysis_df %>%
  group_by(member_casual, date) %>%
  count(date) %>%
  arrange(as.Date(date, format = "%d")) %>%
  print(n = 62)

#---month---
analysis_df %>%
  count(month) %>%
  arrange(match(month, c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")))

analysis_df %>%
  group_by(member_casual, month) %>%
  count(month) %>%
  arrange(match(month, c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))) %>%
  print(n = 24)

#---season---
analysis_df %>%
  count(season) %>%
  arrange(match(season, c("Spring", "Summer", "Fall", "Winter")))

analysis_df %>%
  group_by(member_casual, season) %>%
  count(season) %>%
  arrange(match(season, c("Spring", "Summer", "Fall", "Winter")))

#Spring
analysis_df %>%
  filter(season == "Spring") %>%
  count(season)

analysis_df %>%
  filter(season == "Sping") %>%
  group_by(member_casual, season) %>%
  count(season)
#Summer
analysis_df %>%
  filter(season == "Summer") %>%
  count(season)

analysis_df %>%
  filter(season == "Summer") %>%
  group_by(member_casual, season) %>%
  count(season)

#Fall
analysis_df %>%
  filter(season == "Fall") %>%
  count(season)

analysis_df %>%
  filter(season == "Fall") %>%
  group_by(member_casual, season) %>%
  count(season)

#Evening
analysis_df %>%
  filter(season == "Evening") %>%
  count(season)

analysis_df %>%
  filter(season == "Evening") %>%
  group_by(member_casual, season) %>%
  count(season)

#---Caculation---

#Avg ride duration
avg_ride_length <- analysis_df %>%
  summarise(avg_ride_length = mean(ride_length)) %>%
  mutate(avg_ride_length = round(avg_ride_length, 2)) %>% #round the average ride length to two decimal places
  pull(avg_ride_length) #extract the average ride length

#Avg ride duration per member type
analysis_df %>%
  group_by(member_casual) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2)))

#Avg ride duration per bike type
analysis_df %>%
  group_by(rideable_type) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2)))

analysis_df %>% #by member type
  group_by(member_casual, rideable_type) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2)))

#Avg ride duration per hour
analysis_df %>%
  group_by(hour) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2))) %>%
  print(n = 24)

analysis_df %>% #by member type
  group_by(member_casual, hour) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2))) %>%
  arrange(match(hour, c(0:23))) %>%
  print(n = 48)

#Avg ride duration per times of day
analysis_df %>%
  group_by(dayparting) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2)))

analysis_df %>% #by member type
  group_by(member_casual, dayparting) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2))) %>%
  arrange(match(dayparting, c("Night", "Morning", "Afternoon", "Evening")))

#Avg ride duration per day of the week
analysis_df %>%
  group_by(day_of_week) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2)))

analysis_df %>% #by member type
  group_by(member_casual, day_of_week) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2))) %>%
  arrange(match(day_of_week, c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")))

#Avg ride duration per day of the month
analysis_df %>%
  group_by(date) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2))) %>%
  print(n = 31)

analysis_df %>% #by member type
  group_by(member_casual, date) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2))) %>%
  arrange(as.Date(date, format = "%d")) %>%
  print(n = 62)

#Avg ride duration per month
analysis_df %>%
  group_by(month) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2))) %>%
  arrange(match(month, c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")))

analysis_df %>% #by member type
  group_by(member_casual, month) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2))) %>%
  arrange(match(month, c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))) %>%
  print(n = 24)

#Avg ride duration per season
analysis_df %>%
  group_by(season) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2))) %>%
  arrange(match(season, c("Spring", "Summer", "Fall", "Winter")))

analysis_df %>%
  group_by(member_casual, season) %>%
  summarise_at(vars(ride_length),
               list(avg_time = ~ round(mean(.),2))) %>%
  arrange(match(season, c("Spring", "Summer", "Fall", "Winter")))

##------------------------- Share Phase ----------------------------------------

#---Total ride by Ride Type---
ggplot(data = analysis_df, mapping = aes(x = rideable_type, fill = member_casual)) +
  geom_bar() +
  scale_y_continuous(labels = scales::comma) +
  labs(x = "Bike Type", y = "Total Ride", fill = "Member Type", title = "Total ride by Ride Type")

#---Total Ride per day of the week---
ggplot(data = analysis_df, mapping = aes(x = day_of_week, fill = rideable_type)) +
  geom_bar() +
  scale_y_continuous(labels = scales::comma) +
  labs(x = "Day of the week", y = "Total Ride", fill = "Bike Type", title = "Total Ride per day of the week")

#---Percentage of Member Type---
#Total ride
ride_counts <- analysis_df %>%
  group_by(member_casual) %>%
  summarise(total_rides = n())

#Percentage
ride_counts <- ride_counts %>%
  mutate(percentage = total_rides / sum(total_rides) * 100)

#Pie Chart
ggplot(ride_counts, aes(x = "", y = total_rides, fill = member_casual)) +
  geom_bar(stat = "identity") +
  coord_polar(theta = "y") +
  labs(fill = "Member Type", title = "Percentage of Member type") +
  geom_text(aes(label = paste0(format(total_rides, big.mark = ","), " (", round(percentage, 1), "%)")), 
            position = position_stack(vjust = 0.5)) +
  theme_void()

#---Compare member type per day of month---
#Total ride
ride_counts_2 <- analysis_df %>%
  group_by(date, member_casual) %>%
  summarise(total_rides = n()) %>%
  ungroup()

#Line Chart
ggplot(ride_counts_2, aes(x = date, y = total_rides, group = member_casual)) +
  geom_line(aes(color = member_casual)) +
  scale_y_continuous(labels = scales::comma) +
  labs(x = "Day of Month", y = "Total Rides", color = "Member Type", title = "Total Rides by Member Type over Days of the Month")
