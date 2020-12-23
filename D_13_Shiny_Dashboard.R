library(shiny)
library(tidyverse)
#load the dataset
diamons_carat <- select(diamonds , carat) %>% filter( carat >= 1 )
hist(diamons_carat$carat)
 
ui <- fluidPage(
  # Application title
  headerPanel("Diamanod Carat Frequncy Histogram!"),
  
  # Sidebar with a slider input for carat's values
  sidebarPanel(
    helpText("This Dashboard show the carats and ot's total Observations") , 
    sliderInput("obs", 
                "Carats:", 
                min = min(diamons_carat$carat),
                max = max(diamons_carat$carat), 
                value = 2)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot")
  )
)

# Define server logic required to generate and plot a random distribution
server <- function(input, output) {

  output$distPlot <- renderPlot({
    
    # generate an rnorm distribution and plot it
    dist <- rnorm(input$obs)
    hist(dist , xlab = "Carat" , ylab = "Number Of Observations" , main = "Diamonds's Carat Histogram")
  })
}

shinyApp(ui, server)
