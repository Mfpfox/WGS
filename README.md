# WGS variant calling - CAD12 demo - based on GATK4 best practices for germline short variant discovery

@mfpfox

May 24, 2024

[GATK workflow](https://gatk.broadinstitute.org/hc/en-us/articles/360035535932-Germline-short-variant-discovery-SNPs-Indels-)

[GATK standard resource bundle](https://gatk.broadinstitute.org/hc/en-us/articles/360035890811-Resource-bundle)

[wget hg38 ref source](https://console.cloud.google.com/storage/browser/gcp-public-data--broad-references/hg38/v0;tab=objects?pageState=(%22StorageObjectListTable%22:(%22f%22:%22%255B%255D%22))&prefix=&forceOnObjectsSortingFiltering=false)

#################### PATHS and MODULES ###############################################

```bash
reads="/sc/arion/projects/vascbrain/WGS_iPSC/raw_data/P732912"
ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"
known_sites="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.dbsnp138.vcf"
aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"
results="/sc/arion/projects/vascbrain/WGS_iPSC/results"
data="/sc/arion/projects/vascbrain/WGS_iPSC/data"

module load samtools/1.17
module load fastqc
module load bwa
module load picard/3.1.1
module load gatk/4.3.0.0
```

########### only run once (done for hg38) ########################################
```bash
# reference genome
wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.fasta

#index ref - .fai file before running haplotype caller
samtools faidx Homo_sapiens_assembly38.fasta

#create ref dict file before running haplotype caller
gatk CreateSequenceDictionary R=Homo_sapiens_assembly38.fasta O=Homo_sapiens_assembly38.dict

# index reference - can be created from the fasta using samtools faidx
wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.fai

# reference dict created by running gatk haplotype caller and providing reference genome fasta (gatk CreateSequenceDictionary R= O=)
wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.dict

# known sites vcf and index matching reference genome
wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf
wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf.idx
```


# --------------------------------------
# STEP 1: QC raw reads
# --------------------------------------


```bash
"""man fastqc--non-interactive session keep noextract flagst-outputs a fastqc.zip 
    file-this step has same input as following step when no trimming is needed"""

echo "STEP 1: QC - Run fastqc - skip trimming if quality checks out"

fastqc ${reads}/P732912_FDSW220142847_1r_HYMM2DSX2_L1_1.fq.gz -o ${reads}/

fastqc ${reads}/P732912_FDSW220142847_1r_HYMM2DSX2_L1_2.fq.gz -o ${reads}/

echo "done STEP 1"
```



# --------------------------------------
# STEP 2: Map to reference using BWA-MEM
# --------------------------------------

```bash
echo "STEP 2: Map to reference using BWA-MEM"

# BWA index reference use -64 option to specific 64 bit (alt index)
bwa index ${ref}

# BWA alignment with grouping tag step
    # SM is sample
    # ID from illumina
    # PL is platform
    # -R grouping ID added to each read in output sam file
    # -t multi-threading mode

bwa mem -t 4 -R "@RG\tID:P732912\tPL:ILLUMINA\tSM:P732912" \
    ${ref} ${reads}/P732912_FDSW220142847_1r_HYMM2DSX2_L1_1.fq.gz \
    ${reads}/P732912_FDSW220142847_1r_HYMM2DSX2_L1_2.fq.gz \
    > ${aligned_reads}/P732912.paired.sam

echo "done STEP 2: read alignment to hg38"
```


# --------------------------------------
# STEP 2: QC output of alignment and summary of duplicates (flagstat)
# --------------------------------------

```bash
samtools view P732912.paired.sam | less        # check sam file

samtools flagstat P732912.paired.sam        # check flagstat file
```




# -----------------------------------------
# STEP 3: use picard sort to solve time issue with markduplicatesSpark (sort & dedup)
# -----------------------------------------

* markduplicates attempt ran over lsf time and had a ton of I/O messages from SPARK, 
    * spark is super I/O hungry so best to use SSD thats fast 
    * also recommended to try allocating mem to spark, and add temp directory 
    * so the writing from spark doesnt eat up the memory for processing

* gatk community board recommendation for large files :
    * try first using queryname sort before running the mark duplicates function
    * this could speed up time to mark duplicates, reduce by 1/2 total time needed
  
```bash
module load picard/3.1.1            # loaded picard in interactive

echo $PICARD                        # /hpc/packages/minerva-centos7/picard/3.1.1/bin/picard.jar

PICARD SortSam                      #/hpc/packages/minerva-centos7/picard/3.1.1/bin/picard.jar: Permission denied

java -jar $PICARD SortSam           # USAGE: SortSam [arguments]
```

# -----------------------------------------
# STEP 3: sorting pre- Mark Duplicates
# -----------------------------------------

```bash

module load picard/3.1.1

java -jar $PICARD SortSam \
     INPUT=P732912.paired.sam \
     OUTPUT=P732912.paired.sorted.sam \
     SORT_ORDER=queryname

echo 'done sorting CAD12'
```

```bash
# QC sort output

samtools flagstat P732912.paired.sorted.sam
```

# -----------------------------------------
# STEP 3: Mark Duplicates
# -----------------------------------------

```bash
echo "STEP 3: Mark Duplicates and Sort - GATK4"

gatk MarkDuplicatesSpark -I ${aligned_reads}/P732912.paired.sorted.sam -O \
    ${aligned_reads}/P732912_sorted_dedup_reads.bam

echo "done"
```

# -----------------------------------------
# STEP 3: QC MarkDuplicatesSpark output
# -----------------------------------------

```bash
samtools flagstat P732912_sorted_dedup_reads.bam
```


# ----------------------------------
# STEP 4: Base quality recalibration
# ----------------------------------
```
module load gatk

ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"
known_sites="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.dbsnp138.vcf"
aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"
results="/sc/arion/projects/vascbrain/WGS_iPSC/results"
data="/sc/arion/projects/vascbrain/WGS_iPSC/data"

echo "STEP 4: Base quality recalibration"

# 1. build the model

gatk BaseRecalibrator -I ${aligned_reads}/P732912_sorted_dedup_reads.bam -R \
    ${ref} --known-sites ${known_sites} -O ${data}/recal_12data.table

# 2. Apply the model to adjust the base quality scores

gatk ApplyBQSR -I ${aligned_reads}/P732912_sorted_dedup_reads.bam -R ${ref} --bqsr-recal-file {$data}/recal_12data.table \
    -O ${aligned_reads}/P732912_sorted_dedup_bqsr_reads.bam

echo 'done'

```

# ----------------------------------
# STEP 4: QC bqsr
# ----------------------------------

```bash
samtools flagstat P732912_sorted_dedup_bqsr_reads.bam
```

# -----------------------------------------------
# STEP 5: Collect Alignment & Insert Size Metrics
# -----------------------------------------------
```bash
module load gatk
module load R

ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"
aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"

echo "STEP 5: Collect Alignment & Insert Size Metrics --CAD12"

gatk CollectAlignmentSummaryMetrics R=${ref} I=${aligned_reads}/P732912_sorted_dedup_bqsr_reads.bam \
    O=${aligned_reads}/alignment_12metrics.txt

gatk CollectInsertSizeMetrics INPUT=${aligned_reads}/P732912_sorted_dedup_bqsr_reads.bam \
    OUTPUT=${aligned_reads}/insert_size_12metrics.txt HISTOGRAM_FILE=${aligned_reads}/insert_size_12histogram.pdf

echo "Done with step 5 alignment and insert size metrics CAD12"
```


# ----------------------------------------------
# STEP 6: Call Variants - gatk haplotype caller
# ----------------------------------------------

```bash
module load gatk

ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"
aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"
results="/sc/arion/projects/vascbrain/WGS_iPSC/results"

echo "STEP 6: Call Variants - gatk haplotype caller --CAD12"

gatk HaplotypeCaller -R ${ref} -I ${aligned_reads}/P732912_sorted_dedup_bqsr_reads.bam -O \
    ${results}/raw_variants_CAD12.vcf

# extract SNPs & INDELS
gatk SelectVariants -R ${ref} -V ${results}/raw_variants_CAD12.vcf --select-type SNP -O \
    ${results}/raw_snps_CAD12.vcf

gatk SelectVariants -R ${ref} -V ${results}/raw_variants_CAD12.vcf --select-type INDEL -O \
    ${results}/raw_indels_CAD12.vcf

echo "done"
```


# -------------------
# STEP 7 Filter Variants - GATK4 CAD12
# -------------------

```bash
module load gatk

ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"
results="/sc/arion/projects/vascbrain/WGS_iPSC/results"

echo "Filter SNPs"

gatk VariantFiltration \
    -R ${ref} \
    -V ${results}/raw_snps_CAD12.vcf \
    -O ${results}/filtered_snps_CAD12.vcf \
    -filter-name "QD_filter" -filter "QD < 2.0" \
    -filter-name "FS_filter" -filter "FS > 60.0" \
    -filter-name "MQ_filter" -filter "MQ < 40.0" \
    -filter-name "SOR_filter" -filter "SOR > 4.0" \
    -filter-name "MQRankSum_filter" -filter "MQRankSum < -12.5" \
    -filter-name "ReadPosRankSum_filter" -filter "ReadPosRankSum < -8.0" \
    -genotype-filter-expression "DP < 10" \
    -genotype-filter-name "DP_filter" \
    -genotype-filter-expression "GQ < 10" \
    -genotype-filter-name "GQ_filter"

echo "Filter INDELS"

gatk VariantFiltration \
    -R ${ref} \
    -V ${results}/raw_indels_CAD12.vcf \
    -O ${results}/filtered_indels_CAD12.vcf \
    -filter-name "QD_filter" -filter "QD < 2.0" \
    -filter-name "FS_filter" -filter "FS > 200.0" \
    -filter-name "SOR_filter" -filter "SOR > 10.0" \
    -genotype-filter-expression "DP < 10" \
    -genotype-filter-name "DP_filter" \
    -genotype-filter-expression "GQ < 10" \
    -genotype-filter-name "GQ_filter"

echo "Select SNPs that PASS filters"

gatk SelectVariants \
    --exclude-filtered \
    -V ${results}/filtered_snps_CAD12.vcf \
    -O ${results}/analysis_ready_snps_CAD12.vcf

echo "Select INDELs that PASS filters"

gatk SelectVariants \
    --exclude-filtered \
    -V ${results}/filtered_indels_CAD12.vcf \
    -O ${results}/analysis_ready_indels_CAD12.vcf

echo "done"
```


# -------------------
# STEP 8 QC grep : filter by pattern match inversion
# -------------------

```bash
"""
-e PATTERN, --regexp=PATTERN Use  PATTERN as the pattern.
-E, --extended-regexp Interpret PATTERN as an extended regular expression
-v is inversion
-m 1 # number of pattern match instances to show before quit
"""

# qc grep args : success
grep -m 4 -E "DP_filter|GQ_filter" analysis_ready_snps_CAD12.vcf

    ##FILTER=<ID=DP_filter,Description="DP < 10">
    ##FILTER=<ID=GQ_filter,Description="GQ < 10">
    chr1    54586   .   T   C   64.32   PASS    AC=2;AF=1.00;AN=2;DP=2;ExcessHet=0.0000;FS=0.000;MLEAC=1;MLEAF=0.500;MQ=40.00;QD=32.16;SOR=2.303    GT:AD:DP:FT:GQ:PL   1/1:0,2:2:DP_filter;GQ_filter:6:76,6,0
    chr1    54844   .   G   A   174.97  PASS    AC=2;AF=1.00;AN=2;DP=6;ExcessHet=0.0000;FS=0.000;MLEAC=2;MLEAF=1.00;MQ=45.96;QD=29.16;SOR=1.329 GT:AD:DP:FT:GQ:PL   1/1:0,6:6:DP_filter:18:189,18,0

# note - these lines have been dropped from vcf header :
    FILTER=<ID=DP_filter,Description="DP < 10">
    FILTER=<ID=GQ_filter,Description="GQ < 10">

```

# -------------------
# STEP 8 Filter Variants - grep CAD12
# -------------------
```bash
results="/sc/arion/projects/vascbrain/WGS_iPSC/results"

# to exclude variants that failed genotype filters
cat ${results}/analysis_ready_snps_CAD12.vcf | grep -v -E "DP_filter|GQ_filter" > ${results}/analysis_ready_snps_CAD12_filtered_DP_GQ.vcf

cat ${results}/analysis_ready_indels_CAD12.vcf | grep -v -E "DP_filter|GQ_filter" > ${results}/analysis_ready_indels_CAD12_filtered_DP_GQ.vcf

echo "done"
```


# -------------------
# downloaded the following files for vep annotation
# -------------------

```
# VEP hg38 > funcotator imo ##

analysis_ready_snps_CAD12_filtered_DP_GQ.vcf
analysis_ready_indels_CAD12_filtered_DP_GQ.vcf
analysis_ready_snps_CAD63_filtered_DP_GQ.vcf
analysis_ready_indels_CAD63_filtered_DP_GQ.vcf

```


# -------------------
# Funcotator (alternative to vep)
# -------------------

```bash
# gatk Funcotator \
#     --variant ${results}/analysis_ready_snps_CAD12_filtered_DP_GQ.vcf \
#     --reference ${ref} \
#     --ref-version hg38 \
#     --data-sources-path /PATH_TO_functotator_prepackaged_sources/hg38/funcotator_dataSources.v1.7.20200521g \
#     --output ${results}/analysis_ready_snps_CAD12_filtered_DP_GQ_functotated.vcf \
#     --output-file-format VCF

# # indel not shown, same args as SNP annotation

# # extract fields from VCF to make tab-delimited table
# gatk VariantsToTable \
#     -V ${results}/analysis_ready_snps_CAD12_filtered_DP_GQ_functotated.vcf -F AC -F AN -F DP -F AF -F FUNCOTATION \
#     -O ${results}/output_snps.table
```


