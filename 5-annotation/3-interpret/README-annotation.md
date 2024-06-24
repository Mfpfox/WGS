
# objective: deploy WGS ipsc line annotation analysis dashboard
- date: june 14, 2024 friday
- by: @Mfpfox

before starting task, i considered dashboard in python vs R but chose R because of shiny subscription and prior figure code

Completed for running R in jupyter: 
- installed IRkernel
- install R for vs code

Annotations needed:
- structure
- interface
- CADD
- latest gnomad with co-occurence and for 38
- pathways / networks

# dump

QC'd keyID38 added to vep cleaned output snps by merging first with full match dbnsfp NOTCH3 data from hoffman, then a partial NOTCH3 match from hoffman. the partial match worked. 
TODO need to parse dbnsfp and drop unused columns, gnomad is for missense only
QUESTION are dbnsfp ppi annotations for aa-level? domain is aa level?


#------------------------------------------

## 1. version of variant concerns from HEADER-vep-v109.3-latest.txt.sh
"""
Output produced at 2024-05-24 17:05:04
cache:/Users/mariapalafox/.vep/homo_sapiens_merged/109_GRCh38
ClinVar version 202209
gnomADg version v3.1.2
gnomADe version r2.1.1
assembly version GRCh38.p13
1000genomes version phase3
COSMIC version 96
dbSNP version 154
gencode version GENCODE 43
"""

#------------------------------------------

## 2. brain trash of tasks
* test R kernel for jupyter
* confirm shiny server can deploy output - you pay $40 per month for service which is only reason to not do this in python using ipynb and panel
    * there are two options for python jupyter dashboard: viola (less customizable) and panel (thu vu youtube tutorial)
