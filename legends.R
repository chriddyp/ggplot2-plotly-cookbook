library(plotly)
set_credentials_file("ggplot2-cookbook", "gzcn4660jr")
py <- plotly();

library(ggplot2)
bp <- ggplot(data=PlantGrowth, aes(x=group, y=weight, fill=group)) + geom_boxplot()
bp

# Remove legend for a particular aesthetic (fill)
bp + guides(fill=FALSE)
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/hidden legend - 1'))

# It can also be done when specifying the scale
bp + scale_fill_discrete(guide=FALSE)
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/hidden legend - 2'))

# This removes all legends
bp + theme(legend.position="none")
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/hidden legend - all'))

bp + scale_fill_discrete(breaks=c("trt1","ctrl","trt2"))

# These two methods are equivalent:
bp + guides(fill = guide_legend(reverse=TRUE))
bp + scale_fill_discrete(guide = guide_legend(reverse=TRUE))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/reversed legend'))

# You can also modify the scale directly:
bp + scale_fill_discrete(breaks = rev(levels(PlantGrowth$group)))

# Remove title for fill legend
bp + guides(fill=guide_legend(title=NULL))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/removed legend title'))

# Remove title for all legends
bp + theme(legend.title=element_blank())
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/removed legend titles'))

bp + scale_fill_discrete(name="Experimental\nCondition")
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/multiple line legend title'))

bp + scale_fill_discrete(name="Experimental\nCondition",
                         breaks=c("ctrl", "trt1", "trt2"),
                         labels=c("Control", "Treatment 1", "Treatment 2"))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/legend title with custom labels'))

# Using a manual scale instead of hue
bp + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"),
                       name="Experimental\nCondition",
                       breaks=c("ctrl", "trt1", "trt2"),
                       labels=c("Control", "Treatment 1", "Treatment 2"))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/legend title with custom colors'))

# A different data set
df1 <- data.frame(sex        = factor(c("Female","Female","Male","Male")),
                  time       = factor(c("Lunch","Dinner","Lunch","Dinner"), levels=c("Lunch","Dinner")),
                  total_bill = c(13.53, 16.81, 16.24, 17.42))

# A basic graph
lp <- ggplot(data=df1, aes(x=time, y=total_bill, group=sex, shape=sex)) + geom_line() + geom_point()
lp

# Change the legend
lp + scale_shape_discrete(name  ="Payer",
                          breaks=c("Female", "Male"),
                          labels=c("Woman", "Man"))
py$ggplotly(lp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/line chart with custom legend'))

# Specify colour and shape
lp1 <- ggplot(data=df1, aes(x=time, y=total_bill, group=sex, shape=sex, colour=sex)) + geom_line() + geom_point()
lp1

# Here's what happens if you just specify colour
lp1 + scale_colour_discrete(name  ="Payer",
                            breaks=c("Female", "Male"),
                            labels=c("Woman", "Man"))

# Specify both colour and shape
lp1 + scale_colour_discrete(name  ="Payer",
                            breaks=c("Female", "Male"),
                            labels=c("Woman", "Man")) +
      scale_shape_discrete(name  ="Payer",
                           breaks=c("Female", "Male"),
                           labels=c("Woman", "Man"))

pg <- PlantGrowth    # Copy data into new data frame
# Rename the column and the values in the factor
levels(pg$group)[levels(pg$group)=="ctrl"] <- "Control"
levels(pg$group)[levels(pg$group)=="trt1"] <- "Treatment 1"
levels(pg$group)[levels(pg$group)=="trt2"] <- "Treatment 2"
names(pg)[names(pg)=="group"]  <- "Experimental Condition"

# The end product
pg
# weight Experimental Condition
#   4.17                   ctrl
#   5.58                   ctrl
#    ...
#   5.80                   trt2
#   5.26                   trt2

# Make the plot
ggplot(data=pg, aes(x=`Experimental Condition`, y=weight, fill=`Experimental Condition`)) + geom_boxplot()

# Title appearance
bp + theme(legend.title = element_text(colour="blue", size=16, face="bold"))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/styled legend title'))

# Label appearance
bp + theme(legend.text = element_text(colour="blue", size = 16, face = "bold"))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/styled legend labels'))

bp + theme(legend.background = element_rect())
bp + theme(legend.background = element_rect(fill="gray90", size=.5, linetype="dotted"))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/box around legend'))

bp + theme(legend.position="top")
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/legend on top'))

# Position legend in graph, where x,y is 0,0 (bottom left) to 1,1 (top right)
bp + theme(legend.position=c(.5, .5))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/legend in middle'))

# Set the "anchoring point" of the legend (bottom-left is 0,0; top-right is 1,1)
# Put bottom-left corner of legend box in bottom-left corner of graph
bp + theme(legend.justification=c(0,0), legend.position=c(0,0))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/legend in bottom left'))
# Put bottom-right corner of legend box in bottom-right corner of graph
bp + theme(legend.justification=c(1,0), legend.position=c(1,0))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/legends/legend in bottom right'))

# No outline
ggplot(data=PlantGrowth, aes(x=group, fill=group)) + geom_bar()

# Add outline, but slashes appear in legend
ggplot(data=PlantGrowth, aes(x=group, fill=group)) + geom_bar(colour="black")

# A hack to hide the slashes: first graph the bars with no outline and add the legend,
# then graph the bars again with outline, but with a blank legend.
ggplot(data=PlantGrowth, aes(x=group, fill=group)) + geom_bar() + geom_bar(colour="black", show_guide=FALSE)
