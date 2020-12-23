# Load packages ----
library(shiny)

# Load data ----
stock_data <- read.csv("https://raw.githubusercontent.com/Nadda1004/r_stats/main/5Comapanies_stock.csv")

# User interface ----
ui <- fluidPage(
  titlePanel("5 Technology Comapnies Stocks in 10 Years (2010 - 2020)"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Demonstarte a Line chart that show the stocks of 5 companies in 10 years"),
      
      selectInput("var", 
                  label = "Pick a Company to display",
                  choices = c("Apple", "Google",
                              "Microsoft", "Amazon",
                              "Intel", "VTI"),
                  selected = "Apple"),
    ),
    
    mainPanel(plotOutput("stock"))
  )
)

# Server logic ----
server <- function(input, output) {
  output$stock <- renderPlot({
    data <- switch(input$var, 
                   "Apple" = stock_data$Apple,
                   "Google" = stock_data$Google,
                   "Microsoft" = stock_data$Microsoft,
                   "Amazon" = stock_data$Amazon , 
                   "Intel" = stock_data$Intel , 
                   "VTI" = stock_data$VTI)
    
    plot(x = data , type="l", main= paste0(input$var," Stocks")  , xlab = "Years  From  2010  to  2020" , ylab = "Closing Price" , col=61 , xaxt = "n")
  })
}

# Run app ----
shinyApp(ui, server)
