# import-wgs-cad63.R
# adapted from import-combined-lines-data.R
library(tidyverse)
library(ggplot2)
library(readr)
library(scales)
library(ggpubr)
library(RColorBrewer)
library(tidyr)
library(DT)
library(stringr)
library(plyr)
library(dplyr)
library(wesanderson)
#library(correlationfunnel)
library(tidyquant)
library(plotly)
library(shiny)
library(rlang)
library(scales)


wgs2 <- read.csv("4-cad63-snv-indel-3701014.csv",
                stringsAsFactors = FALSE,
                strip.white = TRUE)


names(wgs2) <- stringr::str_replace_all(names(wgs2), c("_" = ".")) # fix colnames
wgs2 <- mutate_all(wgs2, funs(replace(., .=='', NA))) # empty string as na
str(wgs2)
names(wgs2)

wgs2[['SIFTprediction']] <- factor(wgs2[['SIFTprediction']], levels = c(
  "tolerated_low_confidence",
  "tolerated",
  "deleterious",
  "deleterious_low_confidence"
))

wgs2[['PolyPhenprediction']] <- factor(wgs2[['PolyPhenprediction']], levels = c(
  "benign",
  "unknown",
  "possibly_damaging",
  "probably_damaging"
))

wgs2[['VARIANT.CLASS']] <- factor(wgs2[['VARIANT.CLASS']])

wgs2[['ZYG']] <- factor(wgs2[['ZYG']])

wgs2[['IND']] <- factor(wgs2[['IND']])

wgs2[['IMPACT']] <- factor(wgs2[['IMPACT']], levels = c(
  "LOW",
  "MODIFIER",
  "MODERATE",
  "HIGH"
))

wgs2[['MAF']] <- factor(wgs2[['MAF']], levels = c("Rare (<1%)" ,
                                                "Less common (<10%)"  ,
                                                "Common (>=10%)"))

wgs2[['MAF2']] <- factor(wgs2[['MAF2']], levels = c("Rare (<5%)",
                                                  "Common (>=5%)"))


wgs2[['ClinVar']] <- factor(wgs2[['ClinVar']], levels = c(
  "BENIGN",
  "VUS",
  "PATHO"
))

order_variants <- c("deletion","insertion","sequence_alteration","SNV")
test_cv <- c("PATHO","VUS","BENIGN")


wgs2[['chromosome']] <- factor(wgs2[['chromosome']], levels = c(
  "chr1",
  "chr2",
  "chr3",
  "chr4",
  "chr5",
  "chr6",
  "chr7",
  "chr8",
  "chr9",
  "chr10",
  "chr11",
  "chr12",
  "chr13",
  "chr14",
  "chr15",
  "chr16",
  "chr17",
  "chr18",
  "chr19",
  "chr20",
  "chr21",
  "chr22",
  "chrX"
))

wgs2[['chr']] <- factor(wgs2[['chr']], levels = c(
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "X"
))

print("----- wgs2 (cad63) object returned -----")
