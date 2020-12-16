# Potential Questions to Answer:
# 1. Create snacks that the customers can buy and randomize who buys which snack
# 2. Pretend you own multiple theaters and run two simulations to represent each theater and plot the results
# 3. Create conditional statements for movies that may be PG-13 and children are not allowed to watch

# Cost for adults and children
ticket_cost <- 70
ticket_cost_child <- 60
movies <-
  c('Greenland',
    'The Invisble Man',
    'Taxi Driver',
    'Frozen 2',
    'Mulan')  # List 5 of your favorite movies

snacks <-
  data.frame(
    type = c('Popcorn' , 'Nachos' , 'Chocolate' , 'Chips' , 'Ice Cream') ,
    price = c(10 , 15 , 5 , 7 , 10)
  )
total_snacks <- c('Popcorn' , 'Nachos' , 'Chocolate' , 'Chips' , 'Ice Cream')
total_prices <- rep(0 , 5)

screens <- 5 # How many screens does the theater have? (assume 1 per movie)
seats <- 50  # How many seats does each theater hold
week_days <- rep(0, 7)  # Store totals for each day

total_revnues_per_day <- rep(0, 7)

# iterate through the week
for (day in 1:length(week_days)) {
  # Keep track of total revenue for the day
  total_revnues_per_day[day] <- 0
  week_days[day] <- day
  revenue <- 0
  
  # iterate through the amount of screens on a particular day
  for (s in 1:screens) {
    # Calculate  how many adults and children are watching the movie
    visitors_adults <- 0
    visitors_children <- 0
    
    visitors_adults = sample(seats, 1)
    seats_remaining <- seats - visitors_adults
    visitors_children <- sample(seats_remaining, 1)
    
    # Calculate the revenue for adults and children
    adults_revenue <- visitors_adults * ticket_cost
    children_revenue <- visitors_children * ticket_cost_child
    
    # every adult can have 1 type of snack or none 
    for(adults_i in 1:visitors_adults){
      num_of_snacks_bought = sample(c(0,1) , 1)
      # if the customer buys something 
      if(num_of_snacks_bought > 0){
        # choose 1 random snack
        random_type_of_snack = sample (length(snacks[, 1]) , 1)
        selected_snack = snacks[random_type_of_snack , 1]
        snack_price = snacks[random_type_of_snack , 2]
        
        #check the index of the snack add the price to the total price for that index
        for(sn in 1:length(total_snacks)){
          if(selected_snack == total_snacks[sn]){
            total_prices[sn] = total_prices[sn] + snack_price
          }
        }
      }
    }
    
    # every child can have 1 type of snack or none 
    for(adults_i in 1:visitors_children){
      num_of_snacks_bought = sample(c(0,1) , 1)
      # if the customer buys something 
      if(num_of_snacks_bought > 0){
        # choose 1 random snack
        random_type_of_snack = sample (length(snacks[, 1]) , 1)
        selected_snack = snacks[random_type_of_snack , 1]
        snack_price = snacks[random_type_of_snack , 2]
        
        #check the index of the snack add the price to the total price for that index
        for(sn in 1:length(total_snacks)){
          if(selected_snack == total_snacks[sn]){
            total_prices[sn] = total_prices[sn] + snack_price
          }
        }
      }
    }
    
    # Calculate revenue, and add to running total for the day
    revenue = revenue + (adults_revenue  + children_revenue)
  }
  # Save total to the corresponding day
  total_revnues_per_day[day] = revenue
}
week_days
total_revnues_per_day
days_week = c("Sun" , "Mon" , "Tue" , "Wed" , "Thu" , "Fri" , "Sat")

# Make a barchart showing total revenue per day
barplot(
  total_revnues_per_day,
  xlab = "Days of the week",
  ylab = "Revenue",
  names.arg = days_week ,
  main = "Bard Chart of The Revenue of Movies in a week",
  col = cm.colors(length(total_revnues_per_day))
)

# Make any other chart

# Simple Pie Chart
#install.packages('plotrix') <--- this need to be installed
library(plotrix)
pie3D(
  total_revnues_per_day,
  labels = total_revnues_per_day,
  explode = 0.1 ,
  main = "Pie Chart of The Revenue of Movies in a week" ,
  col = cm.colors(length(total_revnues_per_day))
)
legend(
  "top",
  days_week ,
  cex = 0.9,
  ncol = 4,
  fill = cm.colors(length(total_revnues_per_day))
)

# Which day had the highest revenue?
index_of_max = which.max(total_revnues_per_day)
day_max = days_week[index_of_max]
print(
  paste0(
    "The Busiest Day in the theater is : ",
    day_max ,
    ",  With total revenue : " ,
    total_revnues_per_day[index_of_max]
  )
)

# bar charts of snacks 
barplot(
  total_prices,
  xlab = "Type Of Snack",
  ylab = "Revenue",
  names.arg = total_snacks ,
  main = "Bar Chart of Favorite Snacks bought by customers",
  col = cm.colors(length(total_prices))
)
