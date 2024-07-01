


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
