# Potential Questions to Answer:
# 1. Create snacks that the customers can buy and randomize who buys which snack
# 2. Pretend you own multiple theaters and run two simulations to represent each theater and plot the results
# 3. Create conditional statements for movies that may be PG-13 and children are not allowed to watch

snacks_revenue <- function(theater_vistors , snacks){
  total_prices <- rep(0 , 5)
  # every adult can have 1 type of snack or none 
  for(v in 1:theater_vistors){
    num_of_snacks_bought = sample(c(0,1) , 1)
    # if the customer buys something 
    if(num_of_snacks_bought > 0){
      # choose 1 random snack
      random_type_of_snack = sample (length(snacks[, 1]) , 1) # snack index
      # add the price to the total price for that index
      total_prices[random_type_of_snack] = total_prices[random_type_of_snack] + snacks[random_type_of_snack , 2]
    }
  }
  total_prices
}

revenue_visual <- function(theater_num , total_revnues_per_day , days_week){
  # Make a bar chart showing total revenue per day
  barplot(
    total_revnues_per_day,
    xlab = "Days of the week",
    ylab = "Revenue",
    names.arg = days_week ,
    main = paste0("Bar Chart of The Total Revenue in a week, theater ",theater_num),
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
    main = paste0("Pie Chart of The Total Revenue in a week, theater ",theater_num),
    col = cm.colors(length(total_revnues_per_day))
  )
  legend(
    "top",
    days_week ,
    cex = 0.9,
    ncol = 4,
    fill = cm.colors(length(total_revnues_per_day))
  )
}

calculate_revenue <- function(visitors_adults , visitors_children , snacks , ticket_cost , ticket_cost_child){
  # Calculate the revenue for adults and children
  adults_revenue <- visitors_adults * ticket_cost
  children_revenue <- visitors_children * ticket_cost_child
  
  #  adult snack revenue
  adults_snack_revenue = snacks_revenue(visitors_adults , snacks)
  
  # children snacks revenue
  children_snack_revenue = snacks_revenue(visitors_children , snacks)
  
  # total snack revenue
  total_snack_revenue = adults_snack_revenue + children_snack_revenue
  
  # Calculate revenue, and add to running total for the day
  revenue = (adults_revenue  + children_revenue + sum(total_snack_revenue))
  
  revenue
}

theater <- function(theater_num , screens , seats , movies , movie_rating){
  
  week_days <- rep(0, 7)  # Store totals for each day
  total_revnues_per_day <- rep(0, 7)
  total_snack_revenue <- rep(0, 7)
  snacks <-
    data.frame(
      type = c('Popcorn' , 'Nachos' , 'Chocolate' , 'Chips' , 'Ice Cream') ,
      price = c(10 , 15 , 5 , 7 , 10)
    )
  # Cost for adults and children
  ticket_cost <- 70
  ticket_cost_child <- 60
  
  # iterate through the week
  for (day in 1:length(week_days)) {
    # Keep track of total revenue for the day
    total_revnues_per_day[day] <- 0
    week_days[day] <- day
    total_revenue <- 0
    
    # iterate through the amount of screens on a particular day
    for (s in 1:screens) {
      # Calculate  how many adults and children are watching the movie
      visitors_adults <- 0
      visitors_children <- 0
      
      # check the rating for each movie
      if(movie_rating[s] == 'PG-13'){
        # only adults
        visitors_adults = sample(seats, 1)
        revenue = calculate_revenue(visitors_adults , visitors_children = 0 , snacks , ticket_cost , ticket_cost_child)
      }else{
        # both adults and children can watch 
        visitors_adults = sample(seats, 1)
        seats_remaining <- seats - visitors_adults
        visitors_children <- sample(seats_remaining, 1)
        revenue = calculate_revenue(visitors_adults , visitors_children , snacks , ticket_cost , ticket_cost_child)
      }
      # calculate the total revenue for each screen in a day
      total_revenue = total_revenue + revenue
    }
    # Save total to the corresponding day
    total_revnues_per_day[day] = total_revenue
  }
  week_days
  total_snack_revenue
  total_revnues_per_day
  days_week = c("Sun" , "Mon" , "Tue" , "Wed" , "Thu" , "Fri" , "Sat")

  revenue_visual(theater_num , total_revnues_per_day , days_week)
  # Which day had the highest revenue?
  index_of_max = which.max(total_revnues_per_day)
  day_max = days_week[index_of_max]
  print(
    paste0(
      "The Busiest Day in theater number ",theater_num," is : ",
      day_max ,
      ",  With total revenue : " ,
      total_revnues_per_day[index_of_max]
    )
  )
  
}

movies <-
  c('Greenland',
    'The Invisble Man',
    'Taxi Driver',
    'Frozen 2',
    'Mulan' ,
    'Greyhound')  # List 5 of your favorite movies

movie_rating = c('PG-13' , 'R' , 'Not Rated' , 'PG' , 'PG-13' , 'PG-13')

#simulate 2 theaters
theater(theater_num = 1 , screens = 5 , seats = 50  , movies , movie_rating)
theater(theater_num = 2 , screens = 6 , seats = 25  , movies , movie_rating)