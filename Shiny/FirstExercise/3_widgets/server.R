#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
  output$distPlot <- renderPlot({
    input$plot
    isolate({
    # Plot the graph
    # First we need to figure out the distribution the user wants
    # Then we need to generate the numbers for the distribution
    if(input$rb == "Normal")
      x <- rnorm(input$Sample)
    else if(input$rb == "Poisson")
      x <- rpois(input$Sample, 5)
    else if(input$rb == "Exponential")
      x <- rexp(input$Sample)
    else if(input$rb == "Uniform")
      x <- runif(input$Sample)
      
    # Finally, we need to plot that distribution
    library(ggplot2)
    ggplot () +
      aes(x) +
      geom_histogram(bins=input$bins)
    
  })

  })  
  output$rbtext <- renderText({ input$rb })
}
)
