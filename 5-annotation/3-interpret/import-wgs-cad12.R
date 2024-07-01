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

# "4-both-cad12-cad63-useCol-7197215.csv",
# "4-cad12-snv-indel-3496201.csv",
# "4-cad63-snv-indel-3701014.csv"

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
  "MODIFIER",
  "LOW",
  "MODERATE",
  "HIGH"
))

wgs[['ClinVar']] <- factor(wgs[['ClinVar']], levels = c(
  "BENIGN",
  "VUS",
  "PATHO"
)) # not star reviewed

wgs[['MAF']] <- factor(wgs[['MAF']], levels = c("Rare (<1%)" ,
                                                "Less common (<10%)"  ,
                                                "Common (>=10%)"))

wgs[['MAF2']] <- factor(wgs[['MAF2']], levels = c("Rare (<5%)",
                                                  "Common (>=5%)"))


order_variants <- c("deletion","insertion","sequence_alteration","SNV")
test_cv <- c("PATHO","VUS","BENIGN")

#
wgs <- wgs %>% mutate(Database = case_when(
  !is.na(ClinVar) & is.na(MAX.AF)  ~ "ClinVar",
  !is.na(MAX.AF) & !is.na(ClinVar)  ~ "gnomAD & ClinVar",
  !is.na(MAX.AF)  & is.na(ClinVar) ~ "gnomAD",
  is.na(MAX.AF) & is.na(ClinVar) ~ "None"))



total_cad12 <- wgs %>%
  dplyr::group_by(gnomadCONSEQ) %>%
  dplyr::tally() %>%
  drop_na() %>%
  dplyr::mutate(Percent = round(n/sum(n) * 100, 1))
names(total_gnomad) <- c("ProteinConsequence", "n", "Percent")
total_gnomad$Database <- "gnomAD"
sum(total_gnomad$n)
SUM.gnomad =  "8,390,678"

total_cv <- clinvar %>%
  dplyr::group_by(clinvarCONSEQ)%>%
  dplyr::tally()%>%
  dplyr::mutate(Percent = round(n/sum(n) * 100, 1))
names(total_cv) <- c("ProteinConsequence", "n", "Percent")
total_cv$Database <- "ClinVar"
sum(total_cv$n)
SUM.cv =  "1,550,594"

total_both <- bind_rows(total_cv, total_gnomad)
total_both

