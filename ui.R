library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Commute time"),
    
    # Sidebar with controls to select a dataset and specify the
    # number of observations to view
    sidebarLayout(
        sidebarPanel(
            textInput("address", "Address:", NULL),
            actionButton("do", "Calculate")
        ),
        
        # Show a summary of the dataset and an HTML table with the 
        # requested number of observations
        mainPanel(
            verbatimTextOutput("summary")
        )
    )
))