"""
note : run_vep109_on_WGS_iPSC_lines.sh
@mfpfox
June 7, 2024
"""

1. variant_calling_SOP.sh
2. bcftools_filter_X_and_autosomes.sh
3. run_vep109_on_WGS_iPSC_lines.sh


# path same ref for alignment step (downloaded from minerva)
vep-hg38-PATH = "/Users/mariapalafox/Desktop/BOLDcaution/WGS/3-hg38_bundle_wget"

# vep in path
vep-input-PATH = "/Users/mariapalafox/Desktop/BOLDcaution/WGS/analysis_ready_filtered_vcf/female-autosomes"

# vep out files
snps_CAD12_autoX.vcf
snps_CAD63_autoX.vcf
indels_CAD12_autoX.vcf
indels_CAD63_autoX.vcf

# vep out path
vep-output-PATH = "/Users/mariapalafox/Desktop/ensembl-vep/vep-wgs/annotated-XX-cell-lines"

# vep out files
annotated_snps_CAD12_autoX.txt
annotated_snps_CAD63_autoX.txt
annotated_indels_CAD12_autoX.txt
annotated_indels_CAD63_autoX.txt



INDEL pseudo code

"""basic summary:"""
    total variants
    total transcripts
    total genes
    total regulatory overlap

"""class breakdown:"""
    sequence_alteration
    insertion
    deletion

consequence breakdown: