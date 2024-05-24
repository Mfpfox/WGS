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


echo "chr11 SNPs CAD12"
bcftools view analysis_ready_snps_CAD12_filtered_DP_GQ.vcf.gz --regions chr11 > analysis_ready_snps_CAD12_filtered_DP_GQ_chr11.vcf

echo "chr11 SNPs CAD63"
bcftools view analysis_ready_snps_CAD63_filtered_DP_GQ.vcf.gz --regions chr11 > analysis_ready_snps_CAD63_filtered_DP_GQ_chr11.vcf

echo "chr11 INDELs CAD12"
bcftools view analysis_ready_indels_CAD12_filtered_DP_GQ.vcf.gz --regions chr11 > analysis_ready_indels_CAD12_filtered_DP_GQ_chr11.vcf

echo "chr11 INDELs CAD63"
bcftools view analysis_ready_indels_CAD63_filtered_DP_GQ.vcf.gz --regions chr11 > analysis_ready_indels_CAD63_filtered_DP_GQ_chr11.vcf