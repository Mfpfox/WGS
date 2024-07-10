
# objective: deploy WGS ipsc line annotation analysis dashboard

- date: june 14, 2024 friday
- by: @Mfpfox

before starting task, i considered dashboard in python vs R but chose R because of shiny subscription and prior figure code. TODO test R kernel for jupyter
* confirm shiny server can deploy output - you pay $40 per month for service which is only reason to not do this in python using ipynb and panel
 * there are two options for python jupyter dashboard: viola (less customizable) and panel (thu vu youtube tutorial)

Completed for running R in jupyter: 
- installed IRkernel
- install R for vs code

Annotations needed:
- structure - protein level, amino acid level
- interface - amino acid level
- CADD
- CADDsv
- latest gnomad with co-occurence (only v2.1.1 in GRCh37)
- pathways / networks - protein level


# dump

QC'd keyID38 added to vep cleaned output snps by merging first with full match dbnsfp NOTCH3 data from hoffman, then a partial NOTCH3 match from hoffman. the partial match worked. 
TODO need to parse dbnsfp and drop unused columns, gnomad is for missense only
QUESTION are dbnsfp ppi annotations for aa-level? domain is aa level?


#------------------------------------------

## 1. variant concerns output from vep :  HEADER-vep-v109.3-latest.txt.sh

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

## 2. Transcription factor binding info from vep

"""
MOTIF_NAME : The stable identifier of a transcription factor binding profile (TFBP) aligned at this position
MOTIF_POS : The relative position of the variation in the aligned TFBP
HIGH_INF_POS : A flag indicating if the variant falls in a high information position of the TFBP
MOTIF_SCORE_CHANGE : The difference in motif score of the reference and variant sequences for the TFBP
TRANSCRIPTION_FACTORS : List of transcription factors which bind to the transcription factor binding profile
"""

## 3. TAGLN from genecards

Top Transcription factor binding sites by QIAGEN in the TAGLN gene promoter:  Nkx2-5 Sp1 




