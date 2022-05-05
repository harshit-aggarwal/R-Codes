library(ggplot2)
data(mtcars)
df <- mtcars

df$am <- factor(df$am, levels=c(0,1), labels = c("Automatic", "Manual"))
table(df$am)
g <- ggplot(df)
g <- g + aes(x=hp,y=mpg)
g <- g + geom_point()
g <- g + ggtitle("Comparison between horsepower and Mileage") + xlab("Horsepower") + ylab("Miles per Galon")
g 
# As mpg increases the hp of the car decreases 

g <- ggplot(df)
g <- g + aes(x=hp,y=mpg,color=am)
g <- g + geom_point()
g <- g + ggtitle("Comparison between horsepower and Mileage") + xlab("Horsepower") + ylab("Miles per Galon")
g <- g + facet_grid(am ~ .)
g




#plot(df$mpg~df$hp, xlab = "Horsepower", ylab = "Miles per Galon", main = "Comparison between horsepower and Mileage")

