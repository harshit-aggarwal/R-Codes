data <- read.csv("/Users/harshitaggarwal/Desktop/basketball.txt")
data
library(dplyr)
a <- filter(data, points_scored>1000, salary > 20000000)
b <- filter(data, games_played<50 | points_scored<900) %>% select(salary, active_or_retired)
c <- b %>% group_by(active_or_retired)
c  %>% summarise(mean(salary))
c
