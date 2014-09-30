library(plotly)
set_credentials_file("ggplot2-cookbook", "gzcn4660jr")
py <- plotly();

bp <- ggplot(PlantGrowth, aes(x=group, y=weight)) + geom_boxplot()
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/titles/no title'))

bp + ggtitle("Plant growth")
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/titles/graph with title - 1'))
# Equivalent to
bp + labs(title="Plant growth")
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/titles/graph with title - 2'))

# If the title is long, it can be split into multiple lines with \n
bp + ggtitle("Plant growth with\ndifferent treatments")
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/titles/graph with multi-line title'))

# Reduce line spacing and use bold text
bp + ggtitle("Plant growth with\ndifferent treatments") +
     theme(plot.title = element_text(lineheight=.8, face="bold"))
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/titles/shorter and bold title'))
