
#Create a R shiny widget of a bar plot with the X axis as sift score and Y axis as raw counts
library(shiny)

# Define UI
ui <- fluidPage(
    titlePanel("Bar Plot Widget"),
    sidebarLayout(
        sidebarPanel(
            # Add any input controls here if needed
        ),
        mainPanel(
            plotOutput("barPlot")
        )
    )
)

# Define server
server <- function(input, output) {
    output$barPlot <- renderPlot({
        # Generate data for the bar plot
        predictions <- c(1, 2, 3, 4, 5)  # Replace with your predictions
        raw_counts <- c(10, 20, 15, 30, 25)  # Replace with your raw counts

        # Create the bar plot
        barplot(raw_counts, names.arg = predictions, xlab = "Sift Score", ylab = "Raw Counts")
    })
}

# Run the application
shinyApp(ui = ui, server = server)

