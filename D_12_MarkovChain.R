#Helah, [22.12.20 15:22]
# Un-comment if you haven't installed the package yet
# install.packages("expm")

library(expm)

# Create our state matrix with transition probabilities
T <- matrix(c(0.95,0.05,0,0,
              0.8,0.15,0.05,0,
              0.15,0.60,0.2,0.05,
              0.15,0.60,0.2,0.05),
            nrow = 4, byrow = TRUE)

# Column Names
colnames(T) = c(0,1,2,3)
# Row Names
rownames(T) = c(0,1,2,3)

# Initial state matrix
T

# Where will we end up in 2 time periods for a given state
T%^%2

# Where will we end up in 3 time periods for a given state
T%^%5
# Where will we end up in 20 time periods for a given state
# This is also known as your steady state since the values do not change substantially
T%^%20

T%^%40
