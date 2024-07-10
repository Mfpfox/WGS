



```{r}
bp_colors = c("#FF0000", "#08519c")
normalized_dist_check <- ggplot(df, aes(x = MAX.AF, color=IND, fill = IND))

hist_all <- normalized_dist_check +
  geom_histogram(position="identity", alpha=0.5)  + #bins=100, binwidth = 0.02 ,
  #geom_vline(data=summary_mean_median, aes(xintercept=Mean, color=Type), size=1,  linetype="dashed") +
  #geom_vline(data=summary_mean_median, aes(xintercept=Median, color=Type), size=1, linetype="solid") +
  theme_bw() +
  scale_fill_manual(values=bp_colors) +
  scale_color_manual(values=bp_colors) +
  scale_y_continuous(expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0)) +
  #ylab("Count") +
  # xlab("Measurement (mmHg)") +
  # ggtitle("Distribution of systolic and diastolic measurements (n=87)") +
  theme(legend.position="right",
        plot.title = element_text(hjust=0.5),
        axis.title.x = element_text(size=14, color="black",
                                    margin=margin(t=15, b=5)),
        axis.title.y = element_text(size=14, color="black", margin=margin(t=0, r=15, b=0)),
        axis.text=element_text(size=13,vjust=0.5, color="black", margin=margin(t=20, b=20))) +  facet_grid(IND ~ .)
hist_all
```







```{r}
bxplot <- ggboxplot(df, x = factor("VARIANT.CLASS"), y = "SIFTscore",
                    # fill = ZYG,
                    alpha=0.8,
                    notch=FALSE) +
  #stat_pvalue_manual(stat_table, label = stat_label) +
  #scale_fill_manual(values=colorname) +
  #scale_y_continuous(n.breaks = 9, limits=yrange) +
  theme_bw() +
  # labs(x=xname,
  #      y= ylabel,
  #         title = titlename,
  #      subtitle = subname,
  #      caption = capname) +
  theme(panel.grid.minor = element_blank()) +
  theme(legend.position='right') +
  theme(
    axis.title.x = element_text(size=14, color="black", margin=margin(t=15, b=5)),
    axis.title.y = element_text(size=14, color="black", margin=margin(t=0, r=15, b=0)),
    axis.text=element_text(size=12, color="black", margin=margin(t=20, b=20)))
bxplot
```




```{r echo=TRUE}
wgs_db <- wgs %>%
  dplyr::group_by(Database) %>%
  dplyr::tally() %>%
  dplyr::mutate(Percent = round(n/sum(n) * 100, 1))
wgs_db

wgs2_db <- wgs2 %>%
  dplyr::group_by(Database) %>%
  dplyr::tally() %>%
  dplyr::mutate(Percent = round(n/sum(n) * 100, 1))
wgs2_db
```








# Specify the file path
file_path1 <- "1_clean_vep_output-snp-cad12.csv"
file_path2 <- "1_clean_vep_output-snp-cad63.csv"
file_path3 <- "1_clean_vep_output-indel-cad12.csv"
file_path4 <- "1_clean_vep_output-indel-cad63.csv"

# Specify the columns you want to import
columnSnp <- c('Uploaded_variation', 'Location', 'Allele', 'Gene', 'Feature', 'Feature_type', 'Consequence', 'cDNA_position', 'CDS_position', 'Protein_position', 'Amino_acids', 'Existing_variation', 'IND', 'ZYG', 'REF_ALLELE', 'IMPACT', 'DISTANCE',  'SYMBOL', 'SYMBOL_SOURCE', 'BIOTYPE',  'GIVEN_REF', 'USED_REF', 'GENE_PHENO', 'SIFT', 'PolyPhen', 'EXON', 'INTRON', 'DOMAINS', 'miRNA', 'HGVSc', 'HGVSp',  'gnomADg_AF', 'gnomADg_AFR_AF', 'gnomADg_AMI_AF', 'gnomADg_AMR_AF', 'gnomADg_ASJ_AF', 'gnomADg_EAS_AF', 'gnomADg_FIN_AF', 'gnomADg_MID_AF', 'gnomADg_NFE_AF', 'gnomADg_OTH_AF', 'gnomADg_SAS_AF', 'MAX_AF', 'MAX_AF_POPS', 'CLIN_SIG', 'SOMATIC', 'PHENO', 'PUBMED', 'MOTIF_NAME', 'MOTIF_POS', 'HIGH_INF_POS', 'MOTIF_SCORE_CHANGE', 'TRANSCRIPTION_FACTORS', 'SIFTprediction', 'SIFTscore', 'PolyPhenprediction', 'PolyPhenscore','EXONnumber', 'INTRONnumber', 'chr', 'keyID38', 'GIVEN_REF_MATCH')

columnIndel <- c('Uploaded_variation', 'Location', 'Allele', 'Gene', 'Feature', 'Feature_type', 'Consequence', 'cDNA_position', 'CDS_position', 'Protein_position', 'Amino_acids', 'Existing_variation', 'IND', 'ZYG', 'REF_ALLELE', 'IMPACT', 'DISTANCE',  'SYMBOL', 'SYMBOL_SOURCE', 'BIOTYPE',  'GIVEN_REF', 'USED_REF', 'GENE_PHENO', 'SIFT', 'PolyPhen', 'EXON', 'INTRON', 'DOMAINS', 'miRNA', 'HGVSc', 'HGVSp',  'gnomADg_AF', 'gnomADg_AFR_AF', 'gnomADg_AMI_AF', 'gnomADg_AMR_AF', 'gnomADg_ASJ_AF', 'gnomADg_EAS_AF', 'gnomADg_FIN_AF', 'gnomADg_MID_AF', 'gnomADg_NFE_AF', 'gnomADg_OTH_AF', 'gnomADg_SAS_AF', 'MAX_AF', 'MAX_AF_POPS', 'CLIN_SIG', 'SOMATIC', 'PHENO', 'PUBMED', 'MOTIF_NAME', 'MOTIF_POS', 'HIGH_INF_POS', 'MOTIF_SCORE_CHANGE', 'TRANSCRIPTION_FACTORS', 'EXONnumber', 'INTRONnumber', 'chr','GIVEN_REF_MATCH')

# Read the file and import only the specified columns
snp12 <- read.csv(file_path1, colClasses = columnSnp)
snp63 <- read.csv(file_path2, colClasses = columnSnp)
indel12 <- read.csv(file_path3, colClasses = columnIndel)
indel63 <- read.csv(file_path4, colClasses = columnIndel)

# Print the imported data
print(snp12)
