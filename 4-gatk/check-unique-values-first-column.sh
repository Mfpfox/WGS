awk -F '\t' '{print $1}' raw_variants_CAD12.vcf | sort | uniq > unique_col1_raw_vcf_12.txt

awk -F '\t' '{print $1}' raw_variants_CAD63.vcf | sort | uniq > unique_col1_raw_vcf_63.txt
