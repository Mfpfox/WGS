"""
note : run_vep109_on_WGS_iPSC_lines.sh
@mfpfox
June 7, 2024
"""

1. variant_calling_SOP.sh
2. bcftools_filter_X_and_autosomes.sh
3. run_vep109_on_WGS_iPSC_lines.sh


#############################################################################
#############################################################################
################ name path file #################################
#############################################################################
#############################################################################

# path same ref for alignment step (downloaded from minerva)
vep-hg38-PATH = "/Users/mariapalafox/Desktop/BOLDcaution/WGS/3-hg38_bundle_wget"


vep-input-PATH = "/Users/mariapalafox/Desktop/BOLDcaution/WGS/analysis_ready_filtered_vcf/female-autosomes"
# vep out path
vep-output-PATH = "/Users/mariapalafox/Desktop/ensembl-vep/vep-wgs/annotated-XX-cell-lines"

# vep out files
snps_CAD12_autoX.vcf
snps_CAD63_autoX.vcf
indels_CAD12_autoX.vcf
indels_CAD63_autoX.vcf
# vep out files
annotated_snps_CAD12_autoX.txt
annotated_snps_CAD63_autoX.txt
annotated_indels_CAD12_autoX.txt
annotated_indels_CAD63_autoX.txt

#############################################################################
#############################################################################
################ GOAL replicate html #################################
#############################################################################
#############################################################################


basic:

    total variants
    total transcripts
    total genes
    total regulatory overlap

class:

    sequence_alteration
    insertion
    deletion

consequence:

#############################################################################
#############################################################################
# columns
#############################################################################
#############################################################################

## name QC
- 74 column names with no spaces
- indel cols ==  snp cols

## python select import of only ones needed for plots






#############################################################################
#############################################################################
# columns
#############################################################################
#############################################################################








