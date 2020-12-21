#Write a function that takes marginals and conditionals as inputs and
#calculates all the conditionals, marginals, and joints

prob <- function(marginals , conditionals) {
  #marginals
  calculate_joints <- rep(0 , (length(conditionals) * 2))
  j = length(marginals) - 1
  # loop to calculate the joints values
  for (i in 1:length(calculate_joints)) {
    if (i %% 2 == 1) {
      # if the index is odd multiply the first marginal with the conditionals
      calculate_joints[i] =  marginals[j]  * conditionals[j]
    } else {
      # if the index is even subtract  the first marginal from the joints we just calculated 
      calculate_joints[i] = marginals[j] - calculate_joints[i-1]
      if(j == 1 ){
        j = j +1
      }else{
        j == 1
      }
    }
  }
  print(paste0("Marginals: P{A|&} = " , marginals[1] , "  P{A'|&} = " , marginals[2]))
  print(paste0(
    "conditionals: P{B|A,&} = " , conditionals[1] ,
               " ,  P{B'|A,&} = " , conditionals[2] ))
  print(paste0(
    "conditionals: P{B|A',&} = " , conditionals[1] ,
              " ,  P{B'|A',&} = " , conditionals[2] ))
  print(paste0(
    "Joints: A and B = " , calculate_joints[1] ,
        " ,  A and B' = " , calculate_joints[2]))
  print(paste0(
    "Joints: A' and B = " , calculate_joints[3] ,
    " ,  A' and B' = " , calculate_joints[4] ))
}
marginals <- c(0.6 , 0.4)
conditionals <- c(0.8 , 0.2)
prob(marginals , conditionals)

#Write a function that solves the Kim's problem decision tree.

#location, weather, prob and costs:
#outdoors: sunny --> 100 (0.4), rainy --> 0 (0.6)
#Indoors: sunny --> 90 (0.4), rainy --> 20 (0.6)
#Porch: sunny --> 40 (0.4), rainy --> 50 (0.6)

party_df = data.frame(
  location = c("Outdoors" , "Outdoors" , "Indoors" , "Indoors" , "Proch" , "Porch") ,
  weather = c("Sunny" , "Rainy" , "Sunny" , "Rainy" , "Sunny" , "Rainy") ,
  prob = c(0.4 , 0.6 , 0.4 , 0.6 , 0.4 , 0.6) ,
  costs = c(100 , 0 , 90 , 20 , 40 , 50)
)

#How much Kim values each one of these decisions
decisions_node <- function(df) {
  # get each location and calculate its cost and prob
  for (loc_p in 1:length(df$location)) {
    uncertainty <- 0
    if (loc_p %%  2 == 0) {
      # now loop to calculate the uncertainty
      for (i in (loc_p - 1):loc_p) {
        # (sunny prob) * cost + (rainy prob *costs)
        uncertainty = uncertainty + (df$prob[i] * df$costs[i])
      }
      print(paste0(df$location[loc_p] , " Will cost: " , uncertainty))
    }
  }
}

decisions_node(party_df)
