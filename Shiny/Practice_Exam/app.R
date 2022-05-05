#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
df <- mtcars
df$transtype <- ifelse(df$am == 1, "Automatic", "Manual")
df$gearfac <- factor(df$gear)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Cars info"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("slider","Miles per gallon", min = min(df$mpg), max = max(df$mpg), value = c(min(df$mpg)+1,max(df$mpg)-1)),
            radioButtons("rb", "Transmission Type", 
                        choices = c("Automatic", "Manual"), selected = "Automatic"),
            selectInput("num", label = ("Cylinders"), choices = c(4,6,8))
                    ),
        mainPanel (
            plotOutput("XYplot"),
            tableOutput("table")
        )
    )
)
            
            


# Define server logic required to draw a histogram
server <- function(input, output) {
    
    get_val <- reactive(
    df %>% filter(mpg >= input$slider[1],
           mpg <= input$slider[2],
           transtype == input$rb,
           cyl == input$num
    )
    )
     output$XYplot <- renderPlot(
         ggplot(get_val()) + aes(x=wt, y=mpg) + geom_point(aes(color=gearfac, size=qsec))
     )
     
     output$table <- renderTable(
         get_val()
     )
}

# Run the application 
shinyApp(ui = ui, server = server)
