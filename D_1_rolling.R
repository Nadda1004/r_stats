# 10 face dice 
 die_10 = 1:10

# 20 face dice 
 die_20 = 1:20

# function to roll a dice and calculate the sum
roll_sum <- function(die , num ){
  dice <- sample(die , num , replace= TRUE )
  print(dice)
  sum(dice)
}

# roll 10 sided dice 7 times
roll_sum(die_10 , 7 )

# roll 20 sided dice 7 times
roll_sum(die_20 , 7 )

#-----------------------------------------------------------

# function to calculate how many dice rolled 
# more than 7 (for the 10 sided) 
roll <- function(die , num ){
  dice <- sample(die , num , replace= TRUE )
  print(dice)
  sum(dice > 7)
  }

# roll 10 sided dice 7 times
roll(die_10 , 7 )

#-----------------------------------------------------------

# function to calculate how many dice rolled 17 (for the 20 sided).
roll <- function(die , num ){
  dice <- sample(die , num , replace= TRUE )
  print(dice)
  sum(dice > 17)
}

# roll 20 sided dice 7 times
roll(die_20 , 7 )
