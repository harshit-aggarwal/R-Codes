#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
    # Application title
    titlePanel(title="Hello Shiny"),
    sidebarLayout(
        sidebarPanel(),
        mainPanel()
    )
))

# Define server logic required to draw a histogram
# Template for a server
library(shiny)
shinyServer(
    function(input, output) {
    }
)

