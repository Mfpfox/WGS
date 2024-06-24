awk -F '\t' '{print $1}' snps_CAD12_autoX.vcf | sort | uniq > unique_column_start_snps_CAD12_autoX.txt

