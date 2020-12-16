#install the library
#install.packages('tidyverse')

#load the library
library('tidyverse')

# geom_point --> add a layer to the ggplot by creating a scatter plot
# mapping --> set the aesthetics (variables(columns from the data frame) to map to the x and y axes)
# inside the aes ( color: by column or name of color , alpha: transparency of the points , shape: shape of the points , size: point size)

#template
# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# -------------------------------------------  3.2.4

# 1 - Run ggplot(data = mpg). What do you see?
ggplot(data = mpg) # --> Nothing only a gray background

# 2 - How many rows are in mpg? How many columns?
dim(mpg) # --> 234(rows)  11 (columns)

# 3 - What does the drv variable describe? Read the help for ?mpg to find out.
?mpg # --> the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd

# 4 - Make a scatter plot of hwy vs cyl.
ggplot(data = mpg) +
geom_point(mapping = aes(x = hwy , y = cyl))

# 4 - What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv)) 
# --> class: "type" of car , dvr:the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd
# --> beacuse ther r multiple cars in the dataset and it will only map the the card to its drive train type (no relationship can be determined)

# -------------------------------------------   3.3.1

# 1 - What's gone wrong with this code? Why are the points not blue?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue")) # --> the color should be specified outside the aes
#solution
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy) ,  color = "blue")

# 2 - Which variables in mpg are categorical? Which variables are continuous? (Hint: type ?mpg to read the documentation 
#     for the dataset). How can you see this information when you run mpg?
str(mpg) # --> 6 categorical , 5 continuous

# 3 - Map a continuous variable to color, size, and shape. How do these aesthetics 
#     behave differently for categorical vs. continuous variables?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy ,   color = displ))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy,  size = displ))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy,  shape = displ))
# --> it focuses more on the range of values in the specifed column  + the shape does not work on continuous values 

# 4 - What happens if you map the same variable to multiple aesthetics?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy,  size = displ , color = displ)) # --> it will merge them both  

# 5 - What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)
?geom_point # it modifys the width of the border and it works with shapes from 21-24

# 6 - What happens if you map an aesthetic to something other than a variable name, 
#     like aes(colour = displ < 5)? Note, you'll also need to specify x and y.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy ,   color = displ < 5))
# --> it will split the result with color (points that matches with one color and points that dont matches with another color)

# -------------------------------------------  3.5.1

# 1 - What happens if you facet on a continuous variable?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy ,   color = displ)) + 
  facet_grid(~displ) # --> it will split to alot of plots based on the range of values in that variables

# 2 - What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl)) +
  facet_grid(drv ~ cyl) #--> it shows that some values in drv has no value from cyl mapped to it

# 3 - What plots does the following code make? What does . do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .) #-- > this show the plots splitted by the drv values in rows 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl) #-- > this show the plots splitted by the cyl values in columns 
# --> the . is used when we dont want to specify 2 variables in  the rows or columns dimension (only by 1 varibale repeated by the values of it)

# 4 - What are the advantages to using faceting instead of the colour aesthetic? 
#     What are the disadvantages? How might the balance change if you had a larger dataset?

# --> we can have a splitted view of the plot that will help understand the plot more rather than having all the data in one plot
# the dissadvantages is that the data size and type may leave the data unclear when splitted to multiple plots

# 5 - Read ?facet_wrap. What does nrow do? What does ncol do? What other options control the layout of the individual panels? 
#     Why doesn't facet_grid() have nrow and ncol arguments?
?facet_wrap
# --> nrow, ncol specifies the number of rows and columns the plots should be placed in 
# --> scales = "fixed", shrink = TRUE, labeller = "label_value", as.table = TRUE, switch = NULL, drop = TRUE, dir = "h", strip.position = "top"
?facet_grid
# --> beacuse it focus more on the variable values 

# 6 - When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(trans ~ drv)
# -->  because when we put more levels on the rows the columns might get narrower and it would be hard to see the points clearly

# -------------------------------------------   3.6.1

# 1 - What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
#--> line: geom_line() , boxplot: geom_boxplot() , histogram: geom_histogram() , area: geom_area()

# 2 - 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = TRUE) # se = Display confidence interval around smooth?

# 3 - What does show.legend = FALSE do? What happens if you remove it? Why do you think I used it earlier in the chapter?
#--> its shows the legend from geom_smooth() , nothing will happen becuase it NA by default

# 4 - What does the se argument to geom_smooth() do?
#  --> Display confidence interval around smooth? by TRUE or FALSE

# 5 - Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# --> no it will be the same because it will treat the mapping inside the ggplot as glopal mapping 

# 6 - Recreate the R code necessary to generate the following graphs.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth(mapping = aes(group = drv), se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color=drv)) + 
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color=drv)) +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color=drv)) +
  geom_smooth(se = FALSE, mapping = aes(linetype = drv))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color=drv)) + 
  geom_point(shape = 21, color = "white", stroke = 1)


# -------------------------------------------   3.7.1

# 1 - What is the default geom associated with stat_summary()? How could you 
#     rewrite the previous plot to use that geom function instead of the stat function?
# --> mapping = NULL,
# data = NULL,
# geom = "pointrange",
# position = "identity",
# fun.data = NULL,
# fun = NULL,
# fun.max = NULL,
# fun.min = NULL,
# fun.args = list(),
# bins = 30,
# binwidth = NULL,
# breaks = NULL,
# na.rm = FALSE,
# orientation = NA,
# show.legend = NA,
# inherit.aes = TRUE,
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary",
    fun.min = min,
    fun.max = max,
    fun = median
  )

# 2 - What does geom_col() do? How is it different to geom_bar()?
# --> geom_col deals with  stat_identity which need  and y to be specified 
# --> geom_bar deals with stat_count which only need and x value and it will calulate the y from the data

# 3 - Most geoms and stats come in pairs that are almost always used in concert. Read through 
#     the documentation and make a list of all the pairs. What do they have in common?


# 4 - What variables does stat_smooth() compute? What parameters control its behaviour?
#--> y: predicted value , ymin: lower value of the confidence interval , ymax: upper value of the confidence interval
#    se: standard error

# 5 - In our proportion bar chart, we need to set group = 1. Why? In other words what 
#     is the problem with these two graphs?
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = after_stat(prop)))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = after_stat(prop)))
#--> the two graphs are equal in height, because the geom_bar assume that all bars are equal to x (cut)  
#    beacuse the stat count within the group


