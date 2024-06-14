# bcftools is better because grabs headers

# chr1-5
grep -w '^#\|^#CHROM\|^chr[1-5]' my.vcf > my_new.vcf

# all chr no contigs
grep -w '^#\|^#CHROM\|chr[1-9]\|chr[1-2][0-9]\|chr[X]\|chr[Y]'


#analysis_ready_snps_CAD12_filtered_DP_GQ.vcf
#analysis_ready_snps_CAD63_filtered_DP_GQ.vcf
