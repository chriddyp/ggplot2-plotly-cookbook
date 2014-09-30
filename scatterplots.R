library(plotly)
set_credentials_file("ggplot2-cookbook", "gzcn4660jr")
py <- plotly();

set.seed(955)
# Make some noisily increasing data
dat <- data.frame(cond = rep(c("A", "B"), each=10),
                  xvar = 1:20 + rnorm(20,sd=3),
                  yvar = 1:20 + rnorm(20,sd=3))
# cond         xvar         yvar
#    A -4.252354091  3.473157275
#    A  1.702317971  0.005939612
#   ...
#    B 17.793359218 19.718587761
#    B 19.319909163 19.647899863

library(ggplot2)

g <- ggplot(dat, aes(x=xvar, y=yvar)) +
    geom_point(shape=1)      # Use hollow circles
py$ggplotly(g, kwargs=list(fileopt='overwrite', filename='R-Cookbook/scatterplots/scatterplots with hollow circles'))

g <- ggplot(dat, aes(x=xvar, y=yvar)) +
    geom_point(shape=1) +    # Use hollow circles
    geom_smooth(method=lm)   # Add linear regression line
                             #  (by default includes 95% confidence region)
py$ggplotly(g, kwargs=list(fileopt='overwrite', filename='R-Cookbook/scatterplots/scatterplots with shading and regression line'))

g <- ggplot(dat, aes(x=xvar, y=yvar)) +
    geom_point(shape=1) +    # Use hollow circles
    geom_smooth(method=lm,   # Add linear regression line
                se=FALSE)    # Don't add shaded confidence region
py$ggplotly(g, kwargs=list(fileopt='overwrite', filename='R-Cookbook/scatterplots/scatterplots without shading and regression line'))


g <- ggplot(dat, aes(x=xvar, y=yvar)) +
    geom_point(shape=1) +    # Use hollow circles
    geom_smooth()            # Add a loess smoothed fit curve with confidence region
py$ggplotly(g, kwargs=list(fileopt='overwrite', filename='R-Cookbook/scatterplots/scatterplots shading and smoothed fit curve'))

# Set color by cond
g <- ggplot(dat, aes(x=xvar, y=yvar, color=cond)) + geom_point(shape=1)
py$ggplotly(g, kwargs=list(fileopt='overwrite', filename='R-Cookbook/scatterplots/scatterplots colored by condition'))

# Same, but with different colors and add regression lines
g <- ggplot(dat, aes(x=xvar, y=yvar, color=cond)) + geom_point(shape=1) +
    scale_colour_hue(l=50) + # Use a slightly darker palette than normal
    geom_smooth(method=lm,   # Add linear regression lines
                se=FALSE)    # Don't add shaded confidence region
py$ggplotly(g, kwargs=list(fileopt='overwrite', filename='R-Cookbook/scatterplots/scatterplots colored by condition with regression line'))

# Extend the regression lines beyond the domain of the data
g <- ggplot(dat, aes(x=xvar, y=yvar, color=cond)) + geom_point(shape=1) +
    scale_colour_hue(l=50) + # Use a slightly darker palette than normal
    geom_smooth(method=lm,   # Add linear regression lines
                se=FALSE,    # Don't add shaded confidence region
                fullrange=T) # Extend regression lines
py$ggplotly(g, kwargs=list(fileopt='overwrite', filename='R-Cookbook/scatterplots/scatterplots colored by condition with extended regression line'))

# Set shape by cond
g <- ggplot(dat, aes(x=xvar, y=yvar, shape=cond)) + geom_point()
py$ggplotly(g, kwargs=list(fileopt='overwrite', filename='R-Cookbook/scatterplots/scatterplots shaped by condition'))

# Same, but with different shapes
g <- ggplot(dat, aes(x=xvar, y=yvar, shape=cond)) + geom_point() +
    scale_shape_manual(values=c(1,2))  # Use a hollow circle and triangle
py$ggplotly(g, kwargs=list(fileopt='overwrite', filename='R-Cookbook/scatterplots/scatterplots hollow shapes by condition'))

# Round xvar and yvar to the nearest 5
dat$xrnd <- round(dat$xvar/5)*5
dat$yrnd <- round(dat$yvar/5)*5

# Make each dot partially transparent, with 1/4 opacity
# For heavy overplotting, try using smaller values
g <- ggplot(dat, aes(x=xrnd, y=yrnd)) +
    geom_point(shape=19,      # Use solid circles
               alpha=1/4)     # 1/4 opacity
py$ggplotly(g, kwargs=list(fileopt='overwrite', filename='R-Cookbook/scatterplots/scatterplots with overlapped points'))

# Jitter the points
# Jitter range is 1 on the x-axis, .5 on the y-axis
g <- ggplot(dat, aes(x=xrnd, y=yrnd)) +
    geom_point(shape=1,      # Use hollow circles
               position=position_jitter(width=1,height=.5))
py$ggplotly(g, kwargs=list(fileopt='overwrite', filename='R-Cookbook/scatterplots/scatterplots with jittered points'))
