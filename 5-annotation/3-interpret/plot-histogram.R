## plot-histogram.R
## from Baby_BP_pilot.html

summary_mean_median <- ddply(df2, "Type", summarise,
                             Mean=mean(Measurement),
                             Median=median(Measurement))
# summary_mean_median

##        Type     Mean Median
## 1  Systolic 73.18391     71
## 2 Diastolic 42.73563     41

normalized_dist_check <- ggplot(df2, aes(x = Measurement, color=Type, fill = Type))

hist_all <- normalized_dist_check +
  geom_histogram(position="identity", alpha=0.5)  + #bins=100, binwidth = 0.02 ,
  geom_vline(data=summary_mean_median, aes(xintercept=Mean, color=Type), size=1,  linetype="dashed") +
  geom_vline(data=summary_mean_median, aes(xintercept=Median, color=Type), size=1, linetype="solid") +
  theme_bw() +
  scale_fill_manual(values=bp_colors) +
  scale_color_manual(values=bp_colors) +
  scale_y_continuous(expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0)) +
  ylab("Count") +
  xlab("Measurement (mmHg)") +
  ggtitle("Distribution of systolic and diastolic measurements (n=87)") +
  theme(legend.position="right",
        plot.title = element_text(hjust=0.5),
        axis.title.x = element_text(size=14, color="black",
                                    margin=margin(t=15, b=5)),
        axis.title.y = element_text(size=14, color="black", margin=margin(t=0, r=15, b=0)),
        axis.text=element_text(size=13,vjust=0.5, color="black", margin=margin(t=20, b=20)))
hist_all
