"""
run_vep109_on_WGS_iPSC_lines.sh : adds vep109 hg38 ensembl refseq merge annotations - optimized for individual analysis of zygosity and offline use
@mfpfox
May 25, 2024

--------
1. variant_calling_SOP.sh
2. bcftools_filter_X_and_autosomes.sh
3. run_vep109_on_WGS_iPSC_lines.sh
--------

conda activate perly

## input:
    snps_CAD12_autoX.vcf
    snps_CAD63_autoX.vcf
    indels_CAD12_autoX.vcf
    indels_CAD63_autoX.vcf

## output:
    annotated_snps_CAD12_autoX.txt
    annotated_snps_CAD63_autoX.txt
    annotated_indels_CAD12_autoX.txt
    annotated_indels_CAD63_autoX.txt

## note: dropped --total_length FLAG to prevent excel date conversion

## note: SNPs run in transit (offline flag) Indels run on different day with updated output file names and path names (htmls for snp run do not have latest output names)
"""

# ################################# NOT RUN #################################
# cad12 snps
# ./filter_vep -i .txt \
#     -o .txt \
#     -filter "SYMBOL in NOTCH3,TAGLN"

# # cad63 snps
# ./filter_vep -i .txt \
#     -o .txt \
#     -filter "SYMBOL in NOTCH3,TAGLN"

# # cad12 indels
# ./filter_vep -i .txt \
#     -o .txt \
#     -filter "SYMBOL in NOTCH3,TAGLN"

# # cad63 indels
# ./filter_vep -i .txt \
#     -o .txt \
#     -filter "SYMBOL in NOTCH3,TAGLN"

# ############################ DIDNT WORK #################################
## paths for vep call 
## TODO fix ${INPATH} fail with interative and ./

# INPATH = "/Users/mariapalafox/Desktop/BOLDcaution/WGS/analysis_ready_filtered_vcf/female-autosomes"

# OUTPATH = "/Users/mariapalafox/Desktop/ensembl-vep/vep-wgs/annotated-XX-cell-lines"

# REF38 = "/Users/mariapalafox/Desktop/BOLDcaution/WGS/3-hg38_bundle_wget"


#############################################################################
#############################################################################
################ ANNOTATING CAD12 and CAD63 #################################
#############################################################################
#############################################################################

echo "CAD12 snps"

# ../vep -i /Users/mariapalafox/Desktop/BOLDcaution/WGS/analysis_ready_filtered_vcf/female-autosomes/snps_CAD12_autoX.vcf \
#     -o /Users/mariapalafox/Desktop/ensembl-vep/vep-wgs/annotated-XX-cell-lines/annotated_snps_CAD12_autoX.txt \
#     --force_overwrite \
#     --cache \
#     --merged \
#     --offline \
#     --hgvs \
#     --fasta /Users/mariapalafox/Desktop/BOLDcaution/WGS/3-hg38_bundle_wget/Homo_sapiens_assembly38.fasta \
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


echo "CAD63 snps"

../vep -i /Users/mariapalafox/Desktop/BOLDcaution/WGS/analysis_ready_filtered_vcf/female-autosomes/snps_CAD63_autoX.vcf \
    -o /Users/mariapalafox/Desktop/ensembl-vep/vep-wgs/annotated-XX-cell-lines/annotated_snps_CAD63_autoX.txt \
    --force_overwrite \
    --cache \
    --merged \
    --offline \
    --hgvs \
    --fasta /Users/mariapalafox/Desktop/BOLDcaution/WGS/3-hg38_bundle_wget/Homo_sapiens_assembly38.fasta \
    --assembly GRCh38 \
    --tab \
    --pick \
    --exclude_predicted \
    --sift b \
    --polyphen b \
    --ccds \
    --symbol \
    --numbers \
    --domains \
    --regulatory \
    --canonical \
    --protein \
    --biotype \
    --af_gnomadg \
    --max_af \
    --pubmed \
    --uniprot \
    --mane \
    --tsl \
    --appris \
    --variant_class \
    --gene_phenotype \
    --mirna \
    --use_transcript_ref \
    --check_existing \
    --show_ref_allele \
    --individual all \
    --fork 6


echo "CAD12 indels"

../vep -i /Users/mariapalafox/Desktop/BOLDcaution/WGS/analysis_ready_filtered_vcf/female-autosomes/indels_CAD12_autoX.vcf \
    -o /Users/mariapalafox/Desktop/ensembl-vep/vep-wgs/annotated-XX-cell-lines/annotated_indels_CAD12_autoX.txt \
    --force_overwrite \
    --cache \
    --merged \
    --offline \
    --hgvs \
    --fasta /Users/mariapalafox/Desktop/BOLDcaution/WGS/3-hg38_bundle_wget/Homo_sapiens_assembly38.fasta \
    --assembly GRCh38 \
    --tab \
    --pick \
    --exclude_predicted \
    --sift b \
    --polyphen b \
    --ccds \
    --symbol \
    --numbers \
    --domains \
    --regulatory \
    --canonical \
    --protein \
    --biotype \
    --af_gnomadg \
    --max_af \
    --pubmed \
    --uniprot \
    --mane \
    --tsl \
    --appris \
    --variant_class \
    --gene_phenotype \
    --mirna \
    --use_transcript_ref \
    --check_existing \
    --show_ref_allele \
    --individual all \
    --fork 6


# echo "CAD63 indels"

../vep -i /Users/mariapalafox/Desktop/BOLDcaution/WGS/analysis_ready_filtered_vcf/female-autosomes/indels_CAD63_autoX.vcf \
    -o /Users/mariapalafox/Desktop/ensembl-vep/vep-wgs/annotated-XX-cell-lines/annotated_indels_CAD63_autoX.txt \
    --force_overwrite \
    --cache \
    --merged \
    --offline \
    --hgvs \
    --fasta /Users/mariapalafox/Desktop/BOLDcaution/WGS/3-hg38_bundle_wget/Homo_sapiens_assembly38.fasta \
    --assembly GRCh38 \
    --tab \
    --pick \
    --exclude_predicted \
    --sift b \
    --polyphen b \
    --ccds \
    --symbol \
    --numbers \
    --domains \
    --regulatory \
    --canonical \
    --protein \
    --biotype \
    --af_gnomadg \
    --max_af \
    --pubmed \
    --uniprot \
    --mane \
    --tsl \
    --appris \
    --variant_class \
    --gene_phenotype \
    --mirna \
    --use_transcript_ref \
    --check_existing \
    --show_ref_allele \
    --individual all \
    --fork 6

