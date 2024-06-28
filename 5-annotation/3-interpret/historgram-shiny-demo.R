# Load the Shiny package
# https://pyoflife.com/create-a-dashboard-in-r/

library(shiny)

# Load the dataset
data(mtcars)

# Define the UI
ui <- fluidPage(
  titlePanel("MTCars Histogram"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30)
    ),
    mainPanel(
      plotOutput("histogram")
    )
  )
)

# Define the server
server <- function(input, output) {
  output$histogram <- renderPlot({
    bins <- seq(min(mtcars$mpg), max(mtcars$mpg), length.out = input$bins + 1)
    hist(mtcars$mpg, breaks = bins, col = "blue", main = "MTCars Histogram")
  })
}

# Combine the UI and server
shinyApp(ui = ui, server = server)# Load the Shiny package
library(shiny)

# Load the dataset
data(mtcars)

# Define the UI
ui <- fluidPage(
  titlePanel("MTCars Histogram"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30)
    ),
    mainPanel(
      plotOutput("histogram")
    )
  )
)

# Define the server
server <- function(input, output) {
  output$histogram <- renderPlot({
    bins <- seq(min(mtcars$mpg), max(mtcars$mpg), length.out = input$bins + 1)
    hist(mtcars$mpg, breaks = bins, col = "blue", main = "MTCars Histogram")
  })
}

# Combine the UI and server
shinyApp(ui = ui, server = server)