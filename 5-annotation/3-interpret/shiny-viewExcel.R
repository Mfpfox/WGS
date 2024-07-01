

# Load required libraries
library(shiny)
library(readxl)

# Define UI for the Shiny app
ui <- fluidPage(

  # App title
  titlePanel("Excel Viewer"),

  # Sidebar layout with input and output definitions
  sidebarLayout(
    sidebarPanel(
      # Input: Upload Excel file
      fileInput("file1", "Choose Excel File",
                accept = c(".xlsx")),

      # Input: Select sheet from dropdown menu
      selectInput("sheet", "Choose a sheet:",
                  choices = NULL)
    ),

    # Main panel for displaying outputs
    mainPanel(
      # Output: Table of the selected sheet
      tableOutput("contents")
    )
  )
)

# Define server logic
server <- function(input, output, session) {

  # Reactive function to read uploaded Excel file
  observe({
    req(input$file1)

    # Read Excel file
    df <- read_excel(input$file1$datapath, sheet = NULL)

    # Update dropdown choices with sheet names
    updateSelectInput(session, "sheet", choices = c('snp12', 'snp63', 'indel12', 'indel63'))
  })

  # Render selected sheet as a table
  output$contents <- renderTable({
    req(input$file1)

    # Read Excel file again to get selected sheet
    df <- read_excel(input$file1$datapath, sheet = input$sheet)

    # Return the dataframe as a table
    df
  })
}

# Run the Shiny app
shinyApp(ui, server)
