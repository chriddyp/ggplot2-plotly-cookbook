library(plotly)
set_credentials_file("ggplot2-cookbook", "gzcn4660jr")
py <- plotly();

library(ggplot2)

bp <- ggplot(PlantGrowth, aes(x=group, y=weight)) + geom_boxplot()
bp

bp + coord_flip()

# Manually set the order of a discrete-valued axis
bp + scale_x_discrete(limits=c("trt1","trt2","ctrl"))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/discrete valued axes'))

# Reverse the order of a discrete-valued axis
# Get the levels of the factor
flevels <- levels(PlantGrowth$group)
# "ctrl" "trt1" "trt2"
# Reverse the order
flevels <- rev(flevels)
# "trt2" "trt1" "ctrl"
bp + scale_x_discrete(limits=flevels)
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/reversed ordered axes - 1'))

# Or it can be done in one line:
bp + scale_x_discrete(limits = rev(levels(PlantGrowth$group)) )
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/reversed ordered axes - 2'))

bp + scale_x_discrete(breaks=c("ctrl", "trt1", "trt2"), labels=c("Control", "Treat 1", "Treat 2"))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/setting tick mark labels'))

# Hide x tick marks, labels, and grid lines
bp + scale_x_discrete(breaks=NULL)
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/hidden tick marks, labels, gridline'))

# Hide all tick marks and labels (on X axis), but keep the gridlines
bp + theme(axis.ticks = element_blank(), axis.text.x = element_blank())
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/hidden tick marks and labels'))

# Set the range of a continuous-valued axis
# These are equivalent
bp + ylim(0,8)
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/set range of continuous-valued axis - 1'))
bp + scale_y_continuous(limits=c(0,8))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/set range of continuous-valued axis - 2'))

# These two do the same thing; all data points outside the graphing range are dropped,
# resulting in a misleading box plot
bp + ylim(5, 7.5)
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/misleading range'))
bp + scale_y_continuous(limits=c(5, 7.5))

# Using coord_cartesian "zooms" into the area
bp + coord_cartesian(ylim=c(5, 7.5))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/coord_cartesian'))

# Specify tick marks directly
bp + coord_cartesian(ylim=c(5, 7.5)) +
    scale_y_continuous(breaks=seq(0, 10, 0.25))  # Ticks from 0-10, every .25
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/specify tick marks directly'))

# Reverse order of a continuous-valued axis
bp + scale_y_reverse()
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/reverse y scale'))

# Setting the tick marks on an axis
# This will show tick marks on every 0.25 from 1 to 10
# The scale will show only the ones that are within range (3.50-6.25 in this case)
bp + scale_y_continuous(breaks=seq(1,10,1/4))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/manual tick marks'))

# The breaks can be spaced unevenly
bp + scale_y_continuous(breaks=c(4, 4.25, 4.5, 5, 6,8))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/uneven tick marks'))

# Suppress ticks and gridlines
bp + scale_y_continuous(breaks=NULL)
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/suppress y ticks, labels, and gridlines'))

# Hide tick marks and labels (on Y axis), but keep the gridlines
bp + theme(axis.ticks = element_blank(), axis.text.y = element_blank())
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/suppress y ticks and labels'))

# Create some noisy exponentially-distributed data
set.seed(201)
n <- 100
dat <- data.frame(xval = (1:n+rnorm(n,sd=5))/20, yval = 2*2^((1:n+rnorm(n,sd=5))/20))

# A scatterplot with regular (linear) axis scaling
sp <- ggplot(dat, aes(xval, yval)) + geom_point()
py$ggplotly(sp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/linear axes'))
sp

# log2 scaling of the y axis (with visually-equal spacing)
library(scales)     # Need the scales package
sp + scale_y_continuous(trans=log2_trans())
py$ggplotly(sp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/ln y axes with visual-equal spacing'))

# log2 coordinate transformation (with visually-diminishing spacing)
sp + coord_trans(y="log2")
py$ggplotly(sp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/ln y axes with visually diminishing spacing'))

sp + scale_y_continuous(trans = log2_trans(),
                        breaks = trans_breaks("log2", function(x) 2^x),
                        labels = trans_format("log2", math_format(2^.x)))
py$ggplotly(sp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/ln y axes with exponent tick marks'))

set.seed(205)
n <- 100
dat10 <- data.frame(xval = (1:n+rnorm(n,sd=5))/20, yval = 10*10^((1:n+rnorm(n,sd=5))/20))

sp10 <- ggplot(dat10, aes(xval, yval)) + geom_point()

# log10
sp10 + scale_y_log10()
py$ggplotly(sp10, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/log_10 y axes'))

# log10 with exponents on tick labels
sp10 + scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                     labels = trans_format("log10", math_format(10^.x)))
py$ggplotly(sp10, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/log_10 y axes with exponent tick marks'))

# Data where x ranges from 0-10, y ranges from 0-30
set.seed(202)
dat <- data.frame(xval = runif(40,0,10), yval = runif(40,0,30))
sp <- ggplot(dat, aes(xval, yval)) + geom_point()

# Force equal scaling
sp + coord_fixed()
py$ggplotly(sp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/forced equal spacing'))

# Equal scaling, with each 1 on the x axis the same length as y on x axis
sp + coord_fixed(ratio=1/3)
py$ggplotly(sp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/forced equal scaling'))

bp + theme(axis.title.x = element_blank()) +   # Remove x-axis label
     ylab("Weight (Kg)")                    # Set y-axis label
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/axes labels'))

# Also possible to set the axis label with the scale
# Note that vertical space is still reserved for x's label
bp + scale_x_discrete(name="") +
     scale_y_continuous(name="Weight (Kg)")
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/axes labels set with scale'))

# Change font options:
# X-axis label: bold, red, and 20 points
# X-axis tick marks: rotate 90 degrees CCW, move to the left a bit (using vjust,
#   since the labels are rotated), and 16 points
bp + theme(axis.title.x = element_text(face="bold", colour="#990000", size=20),
           axis.text.x  = element_text(angle=90, vjust=0.5, size=16))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/axes labels with formatting'))

# Label formatters
library(scales)   # Need the scales package
bp + scale_y_continuous(labels=percent) +
     scale_x_discrete(labels=abbreviate)  # In this particular case, it has no effect
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/axes labels with percent labels'))

# Self-defined formatting function for times.
timeHMS_formatter <- function(x) {
    h <- floor(x/60)
    m <- floor(x %% 60)
    s <- round(60*(x %% 1))                   # Round to nearest second
    lab <- sprintf('%02d:%02d:%02d', h, m, s) # Format the strings as HH:MM:SS
    lab <- gsub('^00:', '', lab)              # Remove leading 00: if present
    lab <- gsub('^0', '', lab)                # Remove leading 0 if present
}

bp + scale_y_continuous(label=timeHMS_formatter)
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/axes labels with custom time labels'))

# Hide all the gridlines
bp + theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank())
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/hidden gridlines'))

# Hide just the minor gridlines
bp + theme(panel.grid.minor=element_blank())
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/hidden minor gridlines'))

# Hide all the horizontal gridlines
bp + theme(panel.grid.minor.x=element_blank(), panel.grid.major.x=element_blank())
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/hidden horizontal gridlines'))

# Hide all the vertical gridlines
bp + theme(panel.grid.minor.y=element_blank(), panel.grid.major.y=element_blank())
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/axes/hidden vertical gridlines'))
