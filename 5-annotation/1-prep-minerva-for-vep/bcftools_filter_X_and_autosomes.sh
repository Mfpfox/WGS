"""
bcftools_filter_X_and_autosomes.sh : drops contigs and other non autosome | X chr IDs from analysis ready vcf to optimize time of vep annotation
@mfpfox
May 24, 2024

--------
1. variant_calling_SOP.sh
2. bcftools_filter_X_and_autosomes.sh
3. run_vep109_on_WGS_iPSC_lines.sh
--------


conda activate vcftools


# chr1,chr2,chr3,chr4,chr5,chr6,chr7,chr8,chr9,
# chr10,chr11,chr12,chr13,chr14,chr15,chr16,chr17,chr18,chr19,
# chr20,chr21,chr22,
# chrX


## https://github.com/samtools/bcftools/issues/668
    # bgzip file.vcf       # or:   bcftools view file.vcf -Oz -o file.vcf.gz
    # tabix file.vcf.gz    # or:   bcftools index file.vcf.gz


## replaces .vcf w/ .vcf.gz
bgzip analysis_ready_indels_CAD12_filtered_DP_GQ.vcf
bgzip analysis_ready_indels_CAD63_filtered_DP_GQ.vcf
bgzip analysis_ready_snps_CAD12_filtered_DP_GQ.vcf
bgzip analysis_ready_snps_CAD63_filtered_DP_GQ.vcf


## index 
bcftools index analysis_ready_indels_CAD12_filtered_DP_GQ.vcf.gz
bcftools index analysis_ready_indels_CAD63_filtered_DP_GQ.vcf.gz
bcftools index analysis_ready_snps_CAD12_filtered_DP_GQ.vcf.gz
bcftools index analysis_ready_snps_CAD63_filtered_DP_GQ.vcf.gz



## bcftools view input.vcf.gz --regions all ...


"""

echo "INDELs CAD12"

bcftools view analysis_ready_indels_CAD12_filtered_DP_GQ.vcf.gz \
    --regions chr1,chr2,chr3,chr4,chr5,chr6,chr7,chr8,chr9,chr10,chr11,\
    chr12,chr13,chr14,chr15,chr16,chr17,chr18,chr19,chr20,chr21,chr22,chrX > indels_CAD12_autoX.vcf


echo "INDELs CAD63"

bcftools view analysis_ready_indels_CAD63_filtered_DP_GQ.vcf.gz \
    --regions chr1,chr2,chr3,chr4,chr5,chr6,chr7,chr8,chr9,chr10,chr11,\
    chr12,chr13,chr14,chr15,chr16,chr17,chr18,chr19,chr20,chr21,chr22,chrX > indels_CAD63_autoX.vcf




echo "SNPs CAD12"

bcftools view analysis_ready_snps_CAD12_filtered_DP_GQ.vcf.gz \
    --regions chr1,chr2,chr3,chr4,chr5,chr6,chr7,chr8,chr9,chr10,chr11,\
    chr12,chr13,chr14,chr15,chr16,chr17,chr18,chr19,chr20,chr21,chr22,chrX > snps_CAD12_autoX.vcf


echo "SNPs CAD63"

bcftools view analysis_ready_snps_CAD63_filtered_DP_GQ.vcf.gz \
    --regions chr1,chr2,chr3,chr4,chr5,chr6,chr7,chr8,chr9,chr10,chr11,\
    chr12,chr13,chr14,chr15,chr16,chr17,chr18,chr19,chr20,chr21,chr22,chrX > snps_CAD63_autoX.vcf


