df <- data.frame(time = factor(c("Lunch","Dinner"), levels=c("Lunch","Dinner")),
                 total_bill = c(14.89, 17.23))
#   time total_bill
#  Lunch      14.89
# Dinner      17.23

# Load the ggplot2 library
library(ggplot2)


# Very basic bar graph
ggplot(data=df, aes(x=time, y=total_bill)) + geom_bar(stat="identity")

# Map the time of day to different fill colors. These both have the same result.
ggplot(data=df, aes(x=time, y=total_bill, fill=time)) + geom_bar(stat="identity")
ggplot(data=df, aes(x=time, y=total_bill)) + geom_bar(aes(fill=time), stat="identity")


# Add a black outline
ggplot(data=df, aes(x=time, y=total_bill, fill=time)) + geom_bar(colour="black", stat="identity")


# No legend, since the information is redundant
ggplot(data=df, aes(x=time, y=total_bill, fill=time)) +
    geom_bar(colour="black", stat="identity") +
    guides(fill=FALSE)
