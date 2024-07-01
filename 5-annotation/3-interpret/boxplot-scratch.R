
# make this function into an interactive plot function
boxplot_3_comparison <- function(df, xname, yname, fillname, ylabel, yrange, titlename, subname, capname, colorname, stat_table, stat_label) {
  bxplot <- ggboxplot(df, x = xname, y = yname, fill = fillname, alpha=0.8, notch=FALSE) + 
  stat_pvalue_manual(stat_table, label = stat_label) +
  scale_fill_manual(values=colorname) + 
  scale_y_continuous(n.breaks = 9, limits=yrange) +
  theme_bw() + 
  labs(x=xname,
       y= ylabel,
        title = titlename,
       subtitle = subname,
       caption = capname) +  
  theme(panel.grid.minor = element_blank()) +
  theme(legend.position='right') + 
  theme(
        axis.title.x = element_text(size=14, color="black", margin=margin(t=15, b=5)),
        axis.title.y = element_text(size=14, color="black", margin=margin(t=0, r=15, b=0)), 
        axis.text=element_text(size=12, color="black", margin=margin(t=20, b=20)))  
  return(bxplot)
}

# make this function into an interactive plot function
boxplot_2_comparison <- function(df, xname, yname, fillname, ylabel, yrange, titlename, subname, capname, colorname, stat_table, stat_label) {
    bxplot <- ggboxplot(df, x = xname, y = yname, fill = fillname, alpha=0.8, notch=FALSE) + 
    stat_pvalue_manual(stat_table, label = stat_label) +
    scale_fill_manual(values=colorname) + 
    scale_y_continuous(n.breaks = 9, limits=yrange) +
    theme_bw() + 
    labs(x=xname,
         y= ylabel,
            title = titlename,
         subtitle = subname,
         caption = capname) +  
    theme(panel.grid.minor = element_blank()) +
    theme(legend.position='right') + 
    theme(
            axis.title.x = element_text(size=14, color="black", margin=margin(t=15, b=5)),
            axis.title.y = element_text(size=14, color="black", margin=margin(t=0, r=15, b=0)), 
            axis.text=element_text(size=12, color="black", margin=margin(t=20, b=20)))  
    return(bxplot)
    }