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
data <- read.csv("/Users/harshitaggarwal/Downloads/CASchools.csv")
data2 <- data %>% group_by(county) %>% summarise(mean(read),mean(math), mean(expenditure), mean(income), mean(lunch), mean(calworks), mean(students))

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Read and Math scores compared by County"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("slider1","Reading Scores", min = floor(min(data$read)), max = ceiling(max(data$read)), value = c(685,max(data$read)-1)),
            sliderInput("slider2", "Math Scores", min = floor(min(data$math)), max = ceiling(max(data$math)), value = c(min(data$math)+1,625)),
            selectInput("select", label = h3("Select County"), 
                        choices = list("Butte", "Contra Costa", "El Dorado", "Glenn",
                                       "Humboldt", "Laseen", "Monterey", "Nevada",
                                       "Placer", "Sacramento", "San Diego", "San Joaquin",
                                       "Shasta", "Siskiyou", "Sonoma", "Sutter",
                                       "Tehama", "Tulare", "Tuolumne")
                                       )
        ),
        mainPanel(
           plotOutput("readplot"),
           plotOutput("mathplot"),
           tableOutput("table")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    get_read <- reactive(
        data %>% filter(read >= input$slider1[1],
                      read <= input$slider1[2])
    )
    
    get_math <- reactive(
        data %>% filter(math >= input$slider2[1],
                        math <= input$slider2[2])
    )
    
    output$readplot <- renderPlot(
        ggplot(get_read()) + aes(x=county, y=read) + geom_boxplot(),
    )
    
    output$mathplot <- renderPlot(
        ggplot(get_math()) + aes(x=county, y=math) + geom_boxplot(),
    )
    
    output$table <- renderTable(
        data2 %>% filter(county == input$select)
    )
}

# Run the application 
shinyApp(ui = ui, server = server)


