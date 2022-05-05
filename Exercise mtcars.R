data(mtcars)
df <- mtcars

df$cyl <- factor(df$cyl, levels = c(6, 4, 8), labels = c("4-cyclinder", "6-cyclinder", "8-cyclinder"))
df$vs <- factor(df$vs, levels = c(0,1), labels = c("V-shaped", "straight"))
df$am <- factor(df$am, levels = c(0,1), labels = c("Automatic", "Manual"))
df$gear <- factor(df$gear, levels = c(3, 4, 5), labels = c("Three", "Four", "Five"))
df$carb <- factor(df$gear, levels = c(1, 2, 3,4,6,8), labels = c("One", "Two", "Three", "Four", "Six", "Eight"))

library(ggplot2)

#Ex 2
g <- ggplot(df)
g <- g + aes(x=mpg)
g <- g + geom_histogram(bins=30)
g <- g + ggtitle("Histogram") + xlab("Miles per gallon (Mpg)") + ylab("count")

#Ex 3
g <- g + geom_histogram(color = "blue", fill = "yellow")
g

#Ex 4
g <- ggplot(df)
g <- g + aes(x=vs)
g <- g + geom_bar(color = "blue", fill = "yellow")
g <- g + ggtitle("Bar plot/Frequency Chart") + xlab("Engine Shape") + ylab("count")
g

#Ex 5
g <- ggplot(df)
g <- g + aes(x=vs)
g <- g + geom_bar(color = "blue", fill = "yellow", width = 0.5)
g <- g + ggtitle("Bar plot/Frequency Chart") + xlab("Engine Shape") + ylab("count")
g

#Ex 6
library(tidyverse)
df %>% count(cyl) -> bycyl

g <- ggplot(bycyl)
g <- g + aes(x="", y=n, fill=cyl)
g <- g + geom_bar(stat="identity")

g2 <- g + coord_polar("y", start=pi/2)
g2

#Ex 7
g <- ggplot(df)
g <- g + aes(x=wt, y=mpg)
g <- g + geom_point(size=1.5)
g <- g + xlab("wt") + ylab("mpg") + ggtitle("XY plot")
g

#Ex 8

g <- ggplot(df)
g <- g + aes(x=wt, y=mpg, color=vs)
g <- g + geom_point(size=1.5)
g <- g + xlab("wt(1000 lbs)") + ylab("Miles per gallon(mpg)") + ggtitle("XY plot")
g

#Ex 9
