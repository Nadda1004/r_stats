library(shiny)
library(tidyverse)
#load the dataset
diamonds_carat <- select(diamonds , carat) %>% filter( carat >= 1 )

ui <- fluidPage(
  # Application title
  headerPanel("Diamanod Carat Frequncy Histogram!"),
  
  # Sidebar with a slider input for carat's values
  sidebarPanel(
    helpText("This Dashboard show the carats and ot's total Observations") , 
    sliderInput("obs", 
                "Carats:", 
                min = min(diamonds_carat$carat),
                max = max(diamonds_carat$carat), 
                value = 1)  , 
    selectInput("color", label = "Pick a colour", 
                choices = c("Red", "darkmagenta", "chocolate", "Green"))
  ) , 
    
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot")
  )
)

# Define server logic required to generate and plot a random distribution
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    hist(diamonds_carat$carat , xlab = "Carat" , ylab = "Number Of Observations" , main = "Diamonds's Carat Histogram"  , col = input$color)
  })
}

shinyApp(ui, server)
