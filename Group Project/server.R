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
library(dplyr)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    setwd('C:/Users/prith/Downloads') 
    #please put the csv file to the code file or use setwd to set the path to the csv file
    
    df <- read.csv("CASchools.csv", header = TRUE)
    
    data2 <- df %>% group_by(county) %>% summarise(mean(read),mean(math), 
                                                   mean(expenditure), mean(income), 
                                                   mean(lunch), mean(calworks), 
                                                   mean(students))
    
    output$distPlot <- renderPlot({
        
        minval1 <- input$SLIDER1[1]
        maxval1 <- input$SLIDER1[2]
        
        minval2 <- input$SLIDER2[1]
        maxval2 <- input$SLIDER2[2]
        
        df_subset <- subset(df,
                            ( students >= minval1 ) &
                                ( students <= maxval1 ) &
                                ( computer >= minval2 ) &
                                ( computer <= maxval2 ) 
        )
        # Plot data, subset data, and regression line
        g <- ggplot(NULL) +
            geom_point(data=df, aes(x = students,y = computer)) +
            geom_point(data=df_subset,
                       aes(x = students,y = computer, color="blue", size=7)) +
            xlab("student") + ylab("comp")
        
        if (input$cfbandall) {
            g <- g + geom_smooth(data=df,aes(x = students, y = computer),
                                 method='lm', color="orange")
        }
        
        else {
            g <- g + geom_smooth(data=df,aes(x = students, y = computer),
                                 method='lm', se=FALSE, color="orange")
        }
        
        if (input$cfbandsub) {
            g <- g + geom_smooth(data=df_subset,aes(x = students, y = computer),
                                 method='lm')
        }
        else {
            g <- g + geom_smooth(data=df_subset,aes(x = students,y = computer),
                                 method='lm', se=FALSE)
        }
        print(g)

    })

    output$dataPlot <- renderPlot({
        
        # Get min and max values based on input
        minval1 <- input$slider1[1]
        maxval1 <- input$slider1[2]
        
        minval2 <- input$slider2[1]
        maxval2 <- input$slider2[2]
        
        # Create a subset of data
        
        df <- subset(df, select = c(income, calworks, county))
        
        df_subset <- subset(df,
                            ( income >= minval1 ) &
                                ( income <= maxval1 ) &
                                ( calworks >= minval2 ) &
                                ( calworks <= maxval2 ),select = c(income, calworks) 
        )
        
        
        #poly = lm(calworks ~ income + I(income ^ 2), data = df_subset)
        #pred
        # Plot data, subset data, and regression line
        
        
        g <- ggplot(NULL) +
            geom_point(data=df, aes(x = income,y = calworks, color = county)) +
            geom_point(data=df_subset,
                       aes(x = income,y = calworks, color = 'yellow', size = 3)) +
            xlab("District average income (in USD 1,000)") + ylab("Percent qualifying for CalWorks (income assistance)")
        
        if (input$all_linear) {
            g <- g + geom_smooth(data=df,aes(x = income, y = calworks),
                                 method='glm', color="blue")
        }
        else {
            g <- g + geom_smooth(data=df,aes(x = income, y = calworks),
                                 method='glm', se=FALSE, color="blue")
        }
        
        if (input$sub_linear) {
            g <- g + geom_smooth(data=df_subset,aes(x = income, y = calworks),
                                 method='glm', color = "green")
        }
        else {
            g <- g + geom_smooth(data=df_subset,aes(x = income, y = calworks),
                                 method='glm', se=FALSE, color = "green")
        }
        
        if (input$all_poly) {
            g <- g + geom_smooth(data=df, mapping = aes(x = income, y = calworks),
                                 method='gam', color="orange", formula = y ~ x + I(x^2))
        }
        else {
            g <- g + geom_smooth(data=df, mapping = aes(x = income, y = calworks),
                                 method='gam', color="orange", se = FALSE, formula = y ~ x + I(x^2))
        }
        
        if (input$sub_poly) {
            g <- g + geom_smooth(data=df_subset, mapping = aes(x = income, y = calworks),
                                 method='gam', color="black", formula = y ~ x + I(x^2))
        }
        else {
            g <- g + geom_smooth(data=df_subset,aes(x = income, y = calworks),
                                 method='gam', se = FALSE, color="black", formula = y ~ x + I(x^2))
        }
        print(g)
    })
    
    get_read <- reactive(
        df %>% filter(read >= input$Slider1[1],
                      read <= input$Slider1[2])
    )
    
    get_math <- reactive(
        df %>% filter(math >= input$Slider2[1],
                      math <= input$Slider2[2])
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
})
