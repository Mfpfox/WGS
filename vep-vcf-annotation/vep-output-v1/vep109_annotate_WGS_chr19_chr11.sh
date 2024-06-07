

# snps_CAD63_chr11_chr19.vcf
# snps_CAD12_chr11_chr19.vcf
# indels_CAD63_chr11_chr19.vcf
# indels_CAD12_chr11_chr19.vcf


# echo "CAD63 snps"
# ./vep -i /Users/mariapalafox/Desktop/BOLDcaution/WGS/results_from_minerva/analysis_ready_filtered_vcf/\
# snps_CAD63_chr11_chr19.vcf \
#     -o \
# snps_CAD63_chr11_chr19.txt \
#     --force_overwrite \
#     --cache \
#     --merged \
#     --offline \
#     --hgvs \
#     --fasta /Users/mariapalafox/Desktop/BOLDcaution/WGS/hg38_bundle_wget/Homo_sapiens_assembly38.fasta \
#     --assembly GRCh38 \
#     --tab \
#     --pick \
#     --exclude_predicted \
#     --sift b \
#     --polyphen b \
#     --ccds \
#     --symbol \
#     --numbers \
#     --domains \
#     --regulatory \
#     --canonical \
#     --protein \
#     --biotype \
#     --af_gnomadg \
#     --max_af \
#     --pubmed \
#     --uniprot \
#     --mane \
#     --tsl \
#     --appris \
#     --variant_class \
#     --gene_phenotype \
#     --mirna \
#     --use_transcript_ref \
#     --check_existing \
#     --show_ref_allele \
#     --individual all \
#     --fork 6

# echo "CAD12 snps"
# ./vep -i /Users/mariapalafox/Desktop/BOLDcaution/WGS/results_from_minerva/analysis_ready_filtered_vcf/\
# snps_CAD12_chr11_chr19.vcf \
#     -o \
# snps_CAD12_chr11_chr19.txt \
#     --force_overwrite \
#     --cache \
#     --merged \
#     --offline \
#     --hgvs \
#     --fasta /Users/mariapalafox/Desktop/BOLDcaution/WGS/hg38_bundle_wget/Homo_sapiens_assembly38.fasta \
#     --assembly GRCh38 \
#     --tab \
#     --pick \
#     --exclude_predicted \
#     --sift b \
#     --polyphen b \
#     --ccds \
#     --symbol \
#     --numbers \
#     --domains \
#     --regulatory \
#     --canonical \
#     --protein \
#     --biotype \
#     --af_gnomadg \
#     --max_af \
#     --pubmed \
#     --uniprot \
#     --mane \
#     --tsl \
#     --appris \
#     --variant_class \
#     --gene_phenotype \
#     --mirna \
#     --use_transcript_ref \
#     --check_existing \
#     --show_ref_allele \
#     --individual all \
#     --fork 6

# echo "CAD63 indels"
# ./vep -i /Users/mariapalafox/Desktop/BOLDcaution/WGS/results_from_minerva/analysis_ready_filtered_vcf/\
# indels_CAD63_chr11_chr19.vcf \
#     -o \
# indels_CAD63_chr11_chr19.txt \
#     --force_overwrite \
#     --cache \
#     --merged \
#     --offline \
#     --hgvs \
#     --fasta /Users/mariapalafox/Desktop/BOLDcaution/WGS/hg38_bundle_wget/Homo_sapiens_assembly38.fasta \
#     --assembly GRCh38 \
#     --tab \
#     --pick \
#     --exclude_predicted \
#     --sift b \
#     --polyphen b \
#     --ccds \
#     --symbol \
#     --numbers \
#     --domains \
#     --regulatory \
#     --canonical \
#     --protein \
#     --biotype \
#     --af_gnomadg \
#     --max_af \
#     --pubmed \
#     --uniprot \
#     --mane \
#     --tsl \
#     --appris \
#     --variant_class \
#     --gene_phenotype \
#     --mirna \
#     --use_transcript_ref \
#     --check_existing \
#     --show_ref_allele \
#     --individual all \
#     --fork 6

# echo "CAD12 indels"
# ./vep -i /Users/mariapalafox/Desktop/BOLDcaution/WGS/results_from_minerva/analysis_ready_filtered_vcf/\
# indels_CAD12_chr11_chr19.vcf \
#     -o \
# indels_CAD12_chr11_chr19.txt \
#     --force_overwrite \
#     --cache \
#     --merged \
#     --offline \
#     --hgvs \
#     --fasta /Users/mariapalafox/Desktop/BOLDcaution/WGS/hg38_bundle_wget/Homo_sapiens_assembly38.fasta \
#     --assembly GRCh38 \
#     --tab \
#     --pick \
#     --exclude_predicted \
#     --sift b \
#     --polyphen b \
#     --ccds \
#     --symbol \
#     --numbers \
#     --domains \
#     --regulatory \
#     --canonical \
#     --protein \
#     --biotype \
#     --af_gnomadg \
#     --max_af \
#     --pubmed \
#     --uniprot \
#     --mane \
#     --tsl \
#     --appris \
#     --variant_class \
#     --gene_phenotype \
#     --mirna \
#     --use_transcript_ref \
#     --check_existing \
#     --show_ref_allele \
#     --individual all \
#     --fork 6

# snps_CAD63_chr11_chr19
# snps_CAD12_chr11_chr19
# indels_CAD63_chr11_chr19
# indels_CAD12_chr11_chr19

echo "snps"
./filter_vep -i snps_CAD63_chr11_chr19.txt \
    -o snps_CAD63_chr11_chr19_NOTCH3_TAGLN.txt \
    -filter "SYMBOL in NOTCH3,TAGLN"

./filter_vep -i snps_CAD12_chr11_chr19.txt \
    -o snps_CAD12_chr11_chr19_NOTCH3_TAGLN.txt \
    -filter "SYMBOL in NOTCH3,TAGLN"

echo "indels"
./filter_vep -i indels_CAD63_chr11_chr19.txt \
    -o indels_CAD63_chr11_chr19_NOTCH3_TAGLN.txt \
    -filter "SYMBOL in NOTCH3,TAGLN"

./filter_vep -i indels_CAD12_chr11_chr19.txt \
    -o indels_CAD12_chr11_chr19_NOTCH3_TAGLN.txt \
    -filter "SYMBOL in NOTCH3,TAGLN"
echo "done"
