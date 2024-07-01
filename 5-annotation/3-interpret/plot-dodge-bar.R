dodge_both <- ggplot(total_both, aes(x=Database, y=n, fill=ProteinConsequence)) +
  geom_bar(position="dodge",stat="identity", width=0.8, colour="black", alpha=0.8, na.rm=TRUE) +
  geom_text(aes(label=  scales::comma(n)),
            position=position_dodge2(width=0.9),
            vjust=-1,
            colour="black",
            size = 3,
            check_overlap = TRUE) +
  scale_y_continuous(label=comma, limits = c(0,6000000)) +
  scale_fill_manual(values = var_colors) +
  labs(fill='Variant type') +
  theme_bw() +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        panel.background = element_blank(),
        axis.line = element_blank()) +
  labs(x="Database",
       y= "Unique count",
       title="Database SNV counts",
       subtitle = SUB.total
  ) +
  theme(legend.position='right') +
  theme(axis.title.x = element_text(size=13, color="black", margin=margin(t=10, b=5)),
        axis.title.y = element_text(vjust = 3, size=13, color="black", margin=margin(t=5, b=5, r=1, l=1)),
        axis.text.y = element_text(vjust = 1, size=12, color="black", margin = margin(t = 5, r=5, b = 5)),
        axis.text.x = element_text(size=12, color="black", margin = margin(t = 1)),
        plot.title = element_text(size=14),
        plot.subtitle = element_text(size=9)
  )
dodge_both
