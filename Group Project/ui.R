library(shiny)
library(dplyr)

setwd('C:/Users/prith/Downloads') 
#please put the csv file to the code file or use setwd to set the path to the csv file

df <- read.csv("CASchools.csv", header = TRUE)
data2 <- df %>% group_by(county) %>% summarise(mean(read),mean(math), 
                                               mean(expenditure), mean(income), 
                                               mean(lunch), mean(calworks), 
                                               mean(students))

# Define UI for application
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("California Test Score Data Analysis"),
    
    # Sidebar with a ranged slider input for min and max limit of data set
    sidebarPanel(
        # Specification of range within an interval
        sliderInput("slider1", label = h3("Income Range"), 
                    min = 1,
                    max = 70,
                    value = c(1, 70)),
        sliderInput("slider2", label = h3("CalWorks Range"), 
                    min = 1,
                    max = 30,
                    value = c(1, 30)),
        checkboxInput(inputId = "all_linear",
                      label = strong("Show confidence band for all data"),
                      value = FALSE),
        
        checkboxInput(inputId = "sub_linear",
                      label = strong("Show confidence band for subset"),
                      value = FALSE),
        
        checkboxInput(inputId = "all_poly",
                      label = strong("Show confidence band for all data"),
                      value = FALSE),
        
        checkboxInput(inputId = "sub_poly",
                      label = strong("Show confidence band for all data"),
                      value = FALSE),
        
        br(),br(),
        
        sliderInput("SLIDER1", label = h3("No. of enrolled students (student)"), 
                    min = 80,
                    max = 27180,
                    value = c(80, 27180)),
        
        sliderInput("SLIDER2", label = h3("Number of computers (comp)"), 
                    min = 0,
                    max = 3330,
                    value = c(0, 3330)),
        
        checkboxInput(inputId = "cfbandall",
                      label = strong("Show confidence band for all data"),
                      value = FALSE),
        
        checkboxInput(inputId = "cfbandsub",
                      label = strong("Show confidence band for subset"),
                      value = FALSE),
        
        br(),br(),br(),br(),br(),
        
        sliderInput("Slider1","Reading Scores", 
                    min = floor(min(df$read)), 
                    max = ceiling(max(df$read)), 
                    value = c(685,max(df$read)-1)),
        
        sliderInput("Slider2", "Math Scores", 
                    min = floor(min(df$math)), 
                    max = ceiling(max(df$math)), 
                    value = c(min(df$math)+1,625)),
        
        selectInput("select", label = h3("Select County"), 
                    choices = list("Butte", "Contra Costa", "El Dorado", "Glenn",
                                   "Humboldt", "Laseen", "Monterey", "Nevada",
                                   "Placer", "Sacramento", "San Diego", "San Joaquin",
                                   "Shasta", "Siskiyou", "Sonoma", "Sutter",
                                   "Tehama", "Tulare", "Tuolumne")
        )
    ),
    
    # Show a plot of data and regression line
    mainPanel(
        br(),br(),br(),
        plotOutput("dataPlot"),
        br(),br(),br(),br(),br(),br(),
        plotOutput("distPlot"),
        br(),br(),br(),br(),br(),br(),
        plotOutput("readplot"),
        plotOutput("mathplot"),
        tableOutput("table")
    )
))
