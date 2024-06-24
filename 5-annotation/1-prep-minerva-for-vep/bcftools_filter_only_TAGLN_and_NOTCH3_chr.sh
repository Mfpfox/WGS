## bcftools view input.vcf.gz --regions chr11

# conda activate vcftools

# https://github.com/samtools/bcftools/issues/668
# bgzip file.vcf       # or:   bcftools view file.vcf -Oz -o file.vcf.gz
# tabix file.vcf.gz    # or:   bcftools index file.vcf.gz

# bgzip analysis_ready_indels_CAD12_filtered_DP_GQ.vcf
# bgzip analysis_ready_indels_CAD63_filtered_DP_GQ.vcf

# replaced .vcf w/ .vcf.gz

# bcftools index analysis_ready_indels_CAD12_filtered_DP_GQ.vcf.gz
# bcftools index analysis_ready_indels_CAD63_filtered_DP_GQ.vcf.gz


echo "chr11 and char19 SNPs CAD12"
bcftools view analysis_ready_snps_CAD12_filtered_DP_GQ.vcf.gz --regions chr11,chr19 > snps_CAD12_chr11_chr19.vcf

echo "chr11 and chr19 SNPs CAD63"
bcftools view analysis_ready_snps_CAD63_filtered_DP_GQ.vcf.gz --regions chr11,chr19 > snps_CAD63_chr11_chr19.vcf

echo "chr11 and chr19 INDELs CAD12"
bcftools view analysis_ready_indels_CAD12_filtered_DP_GQ.vcf.gz --regions cchr11,chr19 > indels_CAD12_chr11_chr19.vcf

echo "chr11 and chr19 INDELs CAD63"
bcftools view analysis_ready_indels_CAD63_filtered_DP_GQ.vcf.gz --regions chr11,chr19 > indels_CAD63_chr11_chr19.vcf