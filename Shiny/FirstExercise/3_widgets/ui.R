#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# Define UI
library(shiny)
# Define UI
shinyUI(fluidPage(
    # Application title
    titlePanel("Distribution Example"),
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("Sample", label = h3("Sample Size"), min = 0,
                        max = 100, value = 50),
            radioButtons("rb", label = h3("Choose a distribution: "),
                         choices = list("Normal", "Poisson", "Exponential", "Uniform"), 
                         selected = "Normal"),
            numericInput("bins", label = h3("Number of bins:"), value = 5),
            actionButton("plot", label = "Plot Now"),
        ),
        mainPanel (
            textOutput("Choice"),
            plotOutput("distPlot")
        )
    )
)
)


