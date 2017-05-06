library(shiny)
source("transit-times.R")

# Define server logic
shinyServer(function(input, output) {
    
    # eventReactive means call only when input$do is clicked
    result <- eventReactive(input$do, {
        if (!is.null(input$address) & nchar(input$address) > 5) {
            transit_times(input$address)
        }
    })
    
    # Print the result
    output$summary <- renderPrint({
        result()
    })
    
})