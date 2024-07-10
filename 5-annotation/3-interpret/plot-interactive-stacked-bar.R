

create_interactive_stacked_bar_plot <- function(data, x_col, fill_col, var_colors, DBname, fillname, xname, plotTitle) {
  # Convert column names to symbols for tidy evaluation
  x_col_sym <- ensym(x_col)
  fill_col_sym <- ensym(fill_col)



  # Compute the total count and percentage
  total_db <- data %>%
    dplyr::group_by(!!x_col_sym, !!fill_col_sym) %>%
    dplyr::tally() %>%
    dplyr::mutate(Percent = round(n / sum(n) * 100, 1))
  print(total_db)



  # Create the stacked bar plot using ggplot2
  ggplot_plot <- ggplot(total_db, aes(x = !!x_col_sym, y = Percent, fill = !!fill_col_sym,
                                      text = paste("n:", scales::comma(n), ""))) +
    geom_bar(stat = "identity", width = 0.5, colour = "black", alpha = 0.6) +
    geom_text(aes(label = paste0(sprintf("%1.1f", Percent), "%")),
              position = position_stack(vjust = 0.5),
              colour = "black",
              size = 3,
              check_overlap = TRUE) +
    scale_fill_manual(values = var_colors) +
    labs(fill = fillname) +
    theme_bw() +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          panel.background = element_blank(),
          axis.line = element_blank()) +
    labs(x = xname,
         y = "Percent",
         title = plotTitle,
         subtitle = DBname) +
    theme(legend.position = 'right') +
    theme(axis.title.x = element_text(size = 13, color = "black", margin = margin(t = 10, b = 5)),
          axis.title.y = element_text(vjust = 3, size = 13, color = "black", margin = margin(t = 5, b = 5, r = 1, l = 1)),
          axis.text.y = element_text(vjust = 1, size = 12, color = "black", margin = margin(t = 5, r = 5, b = 5)),
          axis.text.x = element_text(size = 12, color = "black", margin = margin(t = 1)),
          plot.title = element_text(size = 14),
          plot.subtitle = element_text(size = 9)
    )

  # Convert the ggplot object to a plotly object
  plotly_plot <- ggplotly(ggplot_plot, tooltip = "text")

  return(plotly_plot)
}
