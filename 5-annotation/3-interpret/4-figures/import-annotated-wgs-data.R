
# import-combined-lines-data.R
library(tidyverse)

df12_infilename = '4-combined-cad12.csv'
df63_infilename = '4-combined-cad63.csv'

#df12 <- read.csv(df12_infilename, stringsAsFactors=FALSE)
#df63 <- read.csv(df63_infilename, stringsAsFactors=FALSE)

# df12_count <- df12 %>%
#   dplyr::group_by(SYMBOL) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percent = round(n/sum(n) * 100, 1))
# df12_count


df_combined_infilename  = '4-combined-usecols-cad12-63.csv'

df_combined <- read.csv(df_combined_infilename, stringsAsFactors=FALSE)

df_combined[['SIFTprediction']] <- factor(df_combined[['SIFTprediction']], levels = c(
  "tolerated_low_confidence",
  "tolerated",
  "deleterious",
  "deleterious_low_confidence"
))

df_combined[['PolyPhenprediction']] <- factor(df_combined[['PolyPhenprediction']], levels = c(
  "benign",
  "unknown",
  "possibly_damaging",
  "probably_damaging"
))

df_combined[['VARIANT.CLASS']] <- factor(df_combined[['VARIANT.CLASS']])

df_combined[['ZYG']] <- factor(df_combined[['ZYG']])

df_combined[['IND']] <- factor(df_combined[['IND']])

df_combined[['IMPACT']] <- factor(df_combined[['IMPACT']])

