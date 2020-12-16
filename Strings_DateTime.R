#load the library
library(tidyverse)

# strings work with double "b" and single 'b'
s1 <- "Hi"
s2 <- 'Hey'

# escape (shown with write line only)
s3 <- "Hey my name is \\ \"Nada\""
print(s3) # not working
writeLines(s3) #working
cat(s3) #not working

# non English char
s4 <- "\u00b5"
print(s4)

# multiple strings
s5 <- c("SDA" , 'DATA' , 'SCIENCE' , 'BOOTCAMP' , 'CODING DOJO' , NA)
print(s5)

#string length
str_length(s5)
str_length("Nada")

#combining strings 
str_c("N" , "a" , 'd' , 'a') #no space between
str_c("N" , "a" , 'd' , 'a' , sep=" ")
str_c("N" , "a" , 'd' , 'a' , sep="*")
str_c('Hello' , c("Nada" ,"Maha") , "!" , sep=" ") #combining a vector with a string before and after 

# replace NA
str_replace_na(s5 , replacement = "2020")


#using if with string 
name <- "Hadley"
time_of_day <- "morning"
birthday <- FALSE
weekend <- TRUE
str_c(
  "Good ", time_of_day, " ", name,
  if (birthday) " and HAPPY BIRTHDAY",
  "."
)

str_c(
  "Good ", time_of_day, " ", name,
  if (weekend) " and HAPPY WEEKEND",
  "."
)

# collapse a vector (no NA should exist in the vector)
s5 = c("SDA" , 'DATA' , 'SCIENCE' , 'BOOTCAMP' , 'CODING DOJO')
str_c(s5 , collapse = ", ")


#sub-string
s6 <- "Welcome to SDA Data Science Bootcamp with Coding Dojo"
str_sub(s6 , 15 , 27)
str_c(str_sub(c("Saudi" , "Digital" , "Academy") , 1 ,1) , collapse = "")

# changing text
# to lower case
s6 <- str_to_lower(s5)
print(s6)

# back to upper case
str_to_upper(s6)

# title
str_to_title(s5)

# sort and order
str_sort(s5) # sorted text
str_order(s5) # index of order


# matching patterns
#install.packages("htmlwidgets") --> I had to install this for the view to work
#basic
str_view(s5 , "A")

s8 <- c("Carrot Cake" , "Chocolate Cake" , "Vanilla Cake" , "Rainbow Cake" , "Cake")
str_view(s8 , "Cake")
str_view(s8, "^Cake$") # ^ --> begin with , $ --> end with

s9 <- c("abc", "a.c", "a*c", "a c" , "a=c")
str_view(s9 , "a[.]c") # --> find the string that has a and the middle must be . and c
str_view(s9 , "a[.* =]c") # --> find the string that has a and the middle must be . or * or space or = and c
str_view(s9 , ".[b].") # --> find the string that has any thing at the start and a b in the middle and anything in the end 
str_view(s9 , "a(b| )c")# --> find the string that has a at the start and a b or a space in the middle and anything in the end 

#-------------------------------------------------------------------------------------------  Date and Time 
#load the lib
library(lubridate)
library(nycflights13)

# basic functions 
today() # date yyyy-mm-dd
now() # date and time yyyy-mm-dd hh:mm:ss time zone

#identify the year month day in different arrangements 
ymd("2020-02-09")
mdy("February 9th, 2020")
dmy("09-Feb-2020")
ymd(20200209)
ymd("20200209" , tz = "GMT")

#with hour minute seconds
ymd_hms("20200209 201159")

#only the day
day(now())
# month
month(now() , label = TRUE , abbr = FALSE) #add the label instead on the number + no abbreviation 
#year
year(now())


# using datasets
df <- flights
head(df)
# get the columns 
flights %>% 
  select(year, month, day, hour, minute)

# create a new column that sum up all date and time values
flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))

# taxi dataset
link <- 'https://github.com/gumdropsteve/datasets/raw/master/nyc_transport/taxi/yellow_tripdata_2019-01.csv'
df <- read.csv(link)
df <- as_tibble(df)

#extract the pick up time 
pickup_times <- df$tpep_pickup_datetime

# get the year, month, day
years <- year(pickup_times)
months <- month(pickup_times)
days <- day(pickup_times)
# hours, minutes, seconds
hours <- hour(pickup_times)
minutes <- minute(pickup_times)
seconds <- second(pickup_times)

str_c(years[1], months[1], paste0(0, days[1]), collapse=TRUE)  

ymd(str_c(years[1], months[1], paste0(0, days[1]), collapse=TRUE))
