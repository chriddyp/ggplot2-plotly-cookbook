library(plotly)
set_credentials_file("ggplot2-cookbook", "gzcn4660jr")
py <- plotly();

bp <- ggplot(PlantGrowth, aes(x=group, y=weight)) + geom_boxplot()
py$ggplotly(bp, kwargs=list(fileopt='overwrite', filename='R-Cookbook/titles/no title'))

bp1 <- bp + ggtitle("Plant growth")
bp1
py$ggplotly(bp1, kwargs=list(fileopt='overwrite', filename='R-Cookbook/titles/graph with title - 1'))
# Equivalent to
bp2 <- bp + labs(title="Plant growth")
bp2
py$ggplotly(bp2, kwargs=list(fileopt='overwrite', filename='R-Cookbook/titles/graph with title - 2'))

# If the title is long, it can be split into multiple lines with \n
# As to be recognized by Plotly: use <br> instead of \n 
bp3 <- bp + ggtitle("Plant growth with\ndifferent treatments")  
bp3
py$ggplotly(bp3, kwargs=list(fileopt='overwrite', filename='R-Cookbook/titles/graph with multi-line title'))

# Reduce line spacing and use bold text
bp4 <- bp + ggtitle("Plant growth with\ndifferent treatments") +
     theme(plot.title = element_text(lineheight=.8, face="bold"))
bp4
py$ggplotly(bp4, kwargs=list(fileopt='overwrite', filename='R-Cookbook/titles/shorter and bold title'))
