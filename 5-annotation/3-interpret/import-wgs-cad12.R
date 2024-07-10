# import-wgs-cad12.R
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


wgs <- read.csv("4-cad12-snv-indel-3496201.csv",
                stringsAsFactors = FALSE,
                strip.white = TRUE)


names(wgs) <- stringr::str_replace_all(names(wgs), c("_" = ".")) # fix colnames
wgs <- mutate_all(wgs, funs(replace(., .=='', NA))) # empty string as na
str(wgs)
names(wgs)

wgs[['SIFTprediction']] <- factor(wgs[['SIFTprediction']], levels = c(
  "tolerated_low_confidence",
  "tolerated",
  "deleterious",
  "deleterious_low_confidence"
))

wgs[['PolyPhenprediction']] <- factor(wgs[['PolyPhenprediction']], levels = c(
  "benign",
  "unknown",
  "possibly_damaging",
  "probably_damaging"
))

wgs[['VARIANT.CLASS']] <- factor(wgs[['VARIANT.CLASS']])

wgs[['ZYG']] <- factor(wgs[['ZYG']])

wgs[['IND']] <- factor(wgs[['IND']])

wgs[['IMPACT']] <- factor(wgs[['IMPACT']], levels = c(
  "LOW",
  "MODIFIER",
  "MODERATE",
  "HIGH"
))

wgs[['ClinVar']] <- factor(wgs[['ClinVar']], levels = c(
  "BENIGN",
  "VUS",
  "PATHO"
))

wgs[['MAF']] <- factor(wgs[['MAF']], levels = c("Rare (<1%)" ,
                                                "Less common (<10%)"  ,
                                                "Common (>=10%)"))

wgs[['MAF2']] <- factor(wgs[['MAF2']], levels = c("Rare (<5%)",
                                                  "Common (>=5%)"))


order_variants <- c("deletion","insertion","sequence_alteration","SNV")
test_cv <- c("PATHO","VUS","BENIGN")

wgs[['chromosome']] <- factor(wgs[['chromosome']], levels = c(
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

wgs[['chr']] <- factor(wgs[['chr']], levels = c(
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

print("----- wgs (cad12) object returned -----")
