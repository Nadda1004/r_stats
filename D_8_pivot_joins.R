# https://r4ds.had.co.nz/tidy-data.html
library(tidyverse)

# which of these is tidy data

table1

table2

table3

table4a

table4b

# pivot_longer --> add more rows 
# pivot_wider --> add more columns 
# names_from --> take the existing column names from its values 
# names_to --> new column names assigned to the table 
# values_to --> change the name of a specifed column's values
# values_from --> take all the values of a specified column 

# tidying when a column names are values of variables

t4 <- table4a %>% pivot_longer( cols= c(`1999`, `2000`) , names_to = "Year" , values_to = "Population")
t4
t4 <- pivot_longer(table4a , cols= c(`1999`, `2000`) , names_to = 'year' , values_to = 'population')
t4

# tidying when observations are accross multiple rows
t2 <- table2 %>% pivot_wider(names_from = type , values_from = count)
t2
t2 <- pivot_wider(table2 , names_from = type , values_from = count)
t2

# tidying when multiple variables in the same row
t3 <- table3 %>% separate(rate , into = c('Cases' , 'population') , sep = "/")
t3
t3 <- separate(table3 , rate , into = c("cases" , "populaton") , sep = "/")
t3

# joins
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)

#using pipelines

#inner join
j1 <- x %>% inner_join(y)
j1
j1 <- x %>% inner_join(y , by = "key")
j1

j2 <- x %>% left_join(y , by = "key")
j2

j3 <- x %>% right_join(y , by = "key")
j3

j4 <- x %>% full_join(y , by = "key")
j4
