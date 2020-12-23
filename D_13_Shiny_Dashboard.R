#install.packages("shiny")
library(shiny)
library (tidyverse)

#diamonds dataset
df <- diamonds
# group by cuts and count each value and the mean of the carats
by_cut <- group_by(diamonds, cut)
by_cut_s <- summarise(by_cut, count = n(), avg = mean(carat))

ui <- fluidPage(
  titlePanel("diamonds"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("View The Diamonds.")
      , selectInput("var", 
                    label = "Choose Type of Cut To Display",
                    choices = by_cut_s$cut))
      , mainPanel(
        # Output: Histogram ----
        plotOutput(outputId = "distPlot") )
    )
  )

server <- function(input, output) {
  output$distPlot <- renderPlot({
    x    <- c(by_cut_s$cut)
    bins <- seq(min(x), max(x))
    
    hist(x, breaks = bins, freq = by_cut_s$count , col = "#75AADB", border = "white",
         xlab = "Diamond Cut",
         ylab = "Count" ,
         main = "Diamond Cut Histogram")
    
  })
  
}
# Run the application
shinyApp(ui = ui, server = server)