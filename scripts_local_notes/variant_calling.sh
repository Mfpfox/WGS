STEP 1
#!/bin/bash
#BSUB -J WGS_CAD63_step1
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -n 1
#BSUB -W 6:00
#BSUB -R rusage[mem=8000]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

STEP 2
#!/bin/bash
#BSUB -J WGS_step2
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -n 8
#BSUB -W 60:00
#BSUB -R rusage[mem=4000]
#BSUB -R span[hosts=1]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

STEP 3
#!/bin/bash
#BSUB -J WGS_step3_12
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -n 1
#BSUB -W 20:00
#BSUB -R rusage[mem=256000]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

STEP 4
#!/bin/bash
#BSUB -J WGS_step3_12
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -n 1
#BSUB -W 20:00
#BSUB -R rusage[mem=256000]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

STEP 5??
#!/bin/bash
#BSUB -J WGS_step3_12
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -n 1
#BSUB -W 20:00
#BSUB -R rusage[mem=256000]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

STEP 6??
#!/bin/bash
#BSUB -J WGS_step3_12
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -n 1
#BSUB -W 20:00
#BSUB -R rusage[mem=256000]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash


module load samtools/1.17
module load gatk
module load fastqc
module load bwa


"""Following GATK4 best practices workflow
    https://gatk.broadinstitute.org/hc/en-us/articles/360035535932-Germline-short-variant-discovery-SNPs-Indels-"""

"""script calls germline variants in human WGS paired end reads 2 X 100bp following GATK best practices workflow.

change log : 
    [1] replaced - character with _ for directories and file names
    [2] downloaded reference and index files from google bucket (skipped samtools faidx). NOTE the reference and index must be from same source
    [3] -R grouping ID added to each read in bwa mem step that outputs sam file
"""


########### Prep (RUN ONLY ONCE) interactive session paste wget #####

"""
# GATK standard resource bundle : 
    https://gatk.broadinstitute.org/hc/en-us/articles/360035890811-Resource-bundle

# wget links source : 
    https://console.cloud.google.com/storage/browser/gcp-public-data--broad-references/hg38/v0;tab=objects?pageState=(%22StorageObjectListTable%22:(%22f%22:%22%255B%255D%22))&prefix=&forceOnObjectsSortingFiltering=false

# decompressing file (gzip -dk fasta_from_bundle) error :
    connected to bundle through finder then scp to minerva-> error unexpected file end

    suspect corrupting the file when copying it to the *nix machine.

    FTP it in binary mode. ascii ftp can cause issue.

    scp from local lead to issue.

# solution : 
    wget public url of google bucket for latest standard grch38 (link copied to wget links source)

# note: fastqc arg noextract-
    utility has different defaults depending on whether its run in interactive sesh or non-interactive sesh
"""

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



#################### SET PATHS ###############################################
reads="/sc/arion/projects/vascbrain/WGS_iPSC/raw_data/P732912"
reads="/sc/arion/projects/vascbrain/WGS_iPSC/raw_data/P931263"

# consistent
ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"
known_sites="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.dbsnp138.vcf"

aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"
results="/sc/arion/projects/vascbrain/WGS_iPSC/results"
data="/sc/arion/projects/vascbrain/WGS_iPSC/data"

################ VARIANT CALLING STEPS ######################################

# -------------------
# STEP 1: QC raw reads
# -------------------

"""man fastqc--non-interactive session keep noextract flagst-outputs a fastqc.zip file-this step has same input as following step when no trimming is needed"""

echo "STEP 1: QC - Run fastqc - skip trimming if quality checks out"

fastqc ${reads}/P732912_FDSW220142847_1r_HYMM2DSX2_L1_1.fq.gz -o ${reads}/
fastqc ${reads}/P732912_FDSW220142847_1r_HYMM2DSX2_L1_2.fq.gz -o ${reads}/

# update comment line for reads variable before running
fastqc ${reads}/P931263_FDSW220142848_1r_HYMM2DSX2_L1_1.fq.gz -o ${reads}/
fastqc ${reads}/P931263_FDSW220142848_1r_HYMM2DSX2_L1_2.fq.gz -o ${reads}/

echo "done STEP 1"

# --------------------------------------
# STEP 2: Map to reference using BWA-MEM
# --------------------------------------

echo "STEP 2: Map to reference using BWA-MEM"

# BWA index reference use -64 option to specific 64 bit (alt index)

bwa index ${ref}

# BWA alignment with grouping tag step
    # SM is sample
    # ID is ???
    # PL is platform
    # -R grouping ID added to each read in output sam file
    # -t multi-threading mode

bwa mem -t 4 -R "@RG\tID:P732912\tPL:ILLUMINA\tSM:P732912" ${ref} ${reads}/P732912_FDSW220142847_1r_HYMM2DSX2_L1_1.fq.gz ${reads}/P732912_FDSW220142847_1r_HYMM2DSX2_L1_2.fq.gz > ${aligned_reads}/P732912.paired.sam

# update comment line for reads variable before running

bwa mem -t 4 -R "@RG\tID:P931263\tPL:ILLUMINA\tSM:P931263" ${ref} ${reads}/P931263_FDSW220142848_1r_HYMM2DSX2_L1_1.fq.gz ${reads}/P931263_FDSW220142848_1r_HYMM2DSX2_L1_2.fq.gz > ${aligned_reads}/P931263.paired.sam


echo "done STEP 2: read alignment to hg38"


"""
note STEP 2 submission: 
    ran CAD12 step 2 without the -t 4 multithread option AND ran CAD63 step 2 with the multithread option.

    CAD12 submitted 10 minutes before CAD63. all other variables were identical between the runs.

    Does multi-thread make big difference in terms of time? YES BIG DIFF

    Does the output have any issues caused by interaction between requested resources in bsub options and in script options?
"""

# --------------------------------------
# STEP 2: QC
# --------------------------------------

#check output of alignment and summary of duplicates aka flagstat
# next step flag duplicates

# 1. check sam file
samtools view P732912.paired.sam | less
samtools view P931263.paired.sam | less

# 2. check flagstat file 
samtools flagstat P732912.paired.sam
"""output:
    697658725 + 0 in total (QC-passed reads + QC-failed reads)
    688534498 + 0 primary
    0 + 0 secondary
    9124227 + 0 supplementary
    0 + 0 duplicates
    0 + 0 primary duplicates
    696588515 + 0 mapped (99.85% : N/A)
    687464288 + 0 primary mapped (99.84% : N/A)
    688534498 + 0 paired in sequencing
    344267249 + 0 read1
    344267249 + 0 read2
    672431504 + 0 properly paired (97.66% : N/A)
    686897210 + 0 with itself and mate mapped
    567078 + 0 singletons (0.08% : N/A)
    11230902 + 0 with mate mapped to a different chr
    7810868 + 0 with mate mapped to a different chr (mapQ>=5)
"""

samtools flagstat P931263.paired.sam
"""output:
    742580564 + 0 in total (QC-passed reads + QC-failed reads)
    734104404 + 0 primary
    0 + 0 secondary
    8476160 + 0 supplementary
    0 + 0 duplicates
    0 + 0 primary duplicates
    741390027 + 0 mapped (99.84% : N/A)
    732913867 + 0 primary mapped (99.84% : N/A)
    734104404 + 0 paired in sequencing
    367052202 + 0 read1
    367052202 + 0 read2
    722323088 + 0 properly paired (98.40% : N/A)
    732270836 + 0 with itself and mate mapped
    643031 + 0 singletons (0.09% : N/A)
    7092204 + 0 with mate mapped to a different chr
    3796644 + 0 with mate mapped to a different chr (mapQ>=5)
"""

# -----------------------------------------
# STEP 3: PREP for Mark Duplicates (and Sort) - GATK4
# -----------------------------------------

# markduplicates attempt ran over lsf time and had a ton of I/O messages from SPARK, spark is super I/O hungry so best to use SSD thats fast 
# also recommended to try allocating mem to spark, and add temp directory so the writing from spark doesnt eat up the memory for processing

# downloaded log and error files have job ID ending in 60 and 73

# since time is issue, the gatk community board recommended for large files to try first using queryname sort before running the mark duplicates function. the community board said that this could speed up time to mark duplicates, reduce by 1/2 total time needed.


loaded in interactive env

module load picard/3.1.1

echo $PICARD
    /hpc/packages/minerva-centos7/picard/3.1.1/bin/picard.jar

[palafm01@li03c04 aligned_reads]$ $PICARD SortSam
bash: /hpc/packages/minerva-centos7/picard/3.1.1/bin/picard.jar: Permission denied

[palafm01@li03c04 aligned_reads]$ java -jar $PICARD SortSam
USAGE: SortSam [arguments]

#!/bin/bash
#BSUB -J sortQnameXXX 63 or 12
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -n 8
#BSUB -W 48:00
#BSUB -R rusage[mem=8000]
#BSUB -R span[hosts=1]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

module load picard/3.1.1

java -jar $PICARD SortSam \
     INPUT=P931263.paired.sam   \
     OUTPUT=P931263.paired.sorted.sam \
     SORT_ORDER=queryname
echo 'done sorting CAD63'

##

module load picard/3.1.1
java -jar $PICARD SortSam \
     INPUT=P732912.paired.sam \
     OUTPUT=P732912.paired.sorted.sam \
     SORT_ORDER=queryname
echo 'done sorting CAD12'


## ERROR memory limit reached with 64 gb, 8 threads 8 mem. so resubmitted sort jobs with 1 thread and 256 mem for time = 2 days.

#!/bin/bash
#BSUB -J sortQnameXXX 63 or 12
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -n 1
#BSUB -W 48:00
#BSUB -R rusage[mem=256000]
#BSUB -R span[hosts=1]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

# latest version, main difference between this version and older version is number of 
# reads in supplementary. latest has 3,475,644 whereas v1 had 9,124,227
samtools flagstat P732912.paired.sorted.sam
[palafm01@lc02a29 aligned_reads]$ samtools flagstat P732912.paired.sorted.sam
692010142 + 0 in total (QC-passed reads + QC-failed reads)
688534498 + 0 primary
0 + 0 secondary
3475644 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
690945913 + 0 mapped (99.85% : N/A)
687470269 + 0 primary mapped (99.85% : N/A)
688534498 + 0 paired in sequencing
344,267,249 + 0 read1
344,267,249 + 0 read2
674259388 + 0 properly paired (97.93% : N/A)
686908692 + 0 with itself and mate mapped
561577 + 0 singletons (0.08% : N/A)
9730322 + 0 with mate mapped to a different chr
7062698 + 0 with mate mapped to a different chr (mapQ>=5)

#older version of results that ended up with no variants called
# [palafm01@li03c03 aligned_reads]$ samtools flagstat P732912.paired.sorted.sam
# 697658725 + 0 in total (QC-passed reads + QC-failed reads)
# 688534498 + 0 primary
# 0 + 0 secondary
# 9124227 + 0 supplementary
# 0 + 0 duplicates
# 0 + 0 primary duplicates
# 696588515 + 0 mapped (99.85% : N/A)
# 687464288 + 0 primary mapped (99.84% : N/A)
# 688534498 + 0 paired in sequencing
# 344267249 + 0 read1
# 344267249 + 0 read2
# 672431504 + 0 properly paired (97.66% : N/A)
# 686897210 + 0 with itself and mate mapped
# 567078 + 0 singletons (0.08% : N/A)
# 11230902 + 0 with mate mapped to a different chr
# 7810868 + 0 with mate mapped to a different chr (mapQ>=5)

# latest version
samtools flagstat P931263.paired.sorted.sam
[palafm01@lc02a29 aligned_reads]$ samtools flagstat P931263.paired.sorted.sam 
736812756 + 0 in total (QC-passed reads + QC-failed reads)
734104404 + 0 primary
0 + 0 secondary
2708352 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
735628131 + 0 mapped (99.84% : N/A)
732919779 + 0 primary mapped (99.84% : N/A)
734104404 + 0 paired in sequencing
367052202 + 0 read1
367052202 + 0 read2
724113444 + 0 properly paired (98.64% : N/A)
732282086 + 0 with itself and mate mapped
637693 + 0 singletons (0.09% : N/A)
5600034 + 0 with mate mapped to a different chr
3204249 + 0 with mate mapped to a different chr (mapQ>=5)





# -----------------------------------------
# STEP 3: Mark Duplicates and Sort - GATK4
# -----------------------------------------
# from very end of this link:
    #https://gatk.broadinstitute.org/hc/en-us/community/posts/360058452072-MarkDuplicatesSpark-consumes-enormous-amount-of-RAM
--conf 'spark.kryo.referenceTracking=false'
    #what it means: https://spark.apache.org/docs/1.4.1/configuration.html

# check temp java dir
java -XshowSettings:properties --version 2&1 >/dev/null | grep tmpdir

# ran for 48 hours with 1 thread and --conf arg, finished in around 24 hours and output was 51gb
# decided not to run with 1 thread because it takes so long


#!/bin/bash
#BSUB -J STEP3 63 or 12
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -n 4
#BSUB -W 48:00
#BSUB -R rusage[mem=64000]
#BSUB -R span[hosts=1]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

echo "STEP 3: Mark Duplicates and Sort - GATK4 --CAD12"
gatk MarkDuplicatesSpark -I ${aligned_reads}/P732912.paired.sorted.sam -O ${aligned_reads}/P732912_sorted_dedup_reads.bam 

##

echo "STEP 3: Mark Duplicates and Sort - GATK4 --CAD63"
gatk MarkDuplicatesSpark -I ${aligned_reads}/P931263.paired.sorted.sam -O ${aligned_reads}/P931263_sorted_dedup_reads.bam 




# QC STEP 3
samtools flagstat P732912_sorted_dedup_reads.bam
[palafm01@lc02a30 aligned_reads]$ samtools flagstat P732912_sorted_dedup_reads.bam 
692010142 + 0 in total (QC-passed reads + QC-failed reads)
688534498 + 0 primary
0 + 0 secondary
3475644 + 0 supplementary
146038285 + 0 duplicates
145508412 + 0 primary duplicates
690945913 + 0 mapped (99.85% : N/A)
687470269 + 0 primary mapped (99.85% : N/A)
688534498 + 0 paired in sequencing
344267249 + 0 read1
344267249 + 0 read2
674259388 + 0 properly paired (97.93% : N/A)
686908692 + 0 with itself and mate mapped
561577 + 0 singletons (0.08% : N/A)
9730322 + 0 with mate mapped to a different chr
7062698 + 0 with mate mapped to a different chr (mapQ>=5)


samtools flagstat P931263_sorted_dedup_reads.bam
[palafm01@lc02a30 aligned_reads]$ samtools flagstat P931263_sorted_dedup_reads.bam
736812756 + 0 in total (QC-passed reads + QC-failed reads)
734104404 + 0 primary
0 + 0 secondary
2708352 + 0 supplementary
305912549 + 0 duplicates
305231664 + 0 primary duplicates
735628131 + 0 mapped (99.84% : N/A)
732919779 + 0 primary mapped (99.84% : N/A)
734104404 + 0 paired in sequencing
367052202 + 0 read1
367052202 + 0 read2
724113444 + 0 properly paired (98.64% : N/A)
732282086 + 0 with itself and mate mapped
637693 + 0 singletons (0.09% : N/A)
5600034 + 0 with mate mapped to a different chr
3204249 + 0 with mate mapped to a different chr (mapQ>=5)




# ----------------------------------
# STEP 4: Base quality recalibration
# ----------------------------------


#!/bin/bash
#BSUB -J step4_ 12 or 63
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -W 20:00
#BSUB -n 4
#BSUB -R rusage[mem=16000]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

module load gatk

ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"
known_sites="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.dbsnp138.vcf"
aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"
results="/sc/arion/projects/vascbrain/WGS_iPSC/results"
data="/sc/arion/projects/vascbrain/WGS_iPSC/data"

echo "STEP 4: Base quality recalibration --CAD 12 or 63"

# 1. build the model
gatk BaseRecalibrator -I ${aligned_reads}/P732912_sorted_dedup_reads.bam -R ${ref} --known-sites ${known_sites} -O ${data}/recal_12data.table
# 2. Apply the model to adjust the base quality scores
gatk ApplyBQSR -I ${aligned_reads}/P732912_sorted_dedup_reads.bam -R ${ref} --bqsr-recal-file {$data}/recal_12data.table -O ${aligned_reads}/P732912_sorted_dedup_bqsr_reads.bam
echo 'done with base quality recalibration of CAD12'

##

# 1. build the model
gatk BaseRecalibrator -I ${aligned_reads}/P931263_sorted_dedup_reads.bam -R ${ref} --known-sites ${known_sites} -O ${data}/recal_63data.table
# 2. Apply the model to adjust the base quality scores
gatk ApplyBQSR -I ${aligned_reads}/P931263_sorted_dedup_reads.bam -R ${ref} --bqsr-recal-file {$data}/recal_63data.table -O ${aligned_reads}/P931263_sorted_dedup_bqsr_reads.bam
echo 'done with base quality recalibration of CAD63'



# QC STEP 4:
samtools flagstat 931263_sorted_dedup_reads.bam


samtools flagstat P931263_sorted_dedup_bqsr_reads.bam



# -----------------------------------------------
# STEP 5: Collect Alignment & Insert Size Metrics
# -----------------------------------------------

#!/bin/bash
#BSUB -J step5_12
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -W 20:00
#BSUB -n 4
#BSUB -R rusage[mem=16000]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash
module load gatk
module load R
ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"
aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"
echo "STEP 5: Collect Alignment & Insert Size Metrics --CAD12"
gatk CollectAlignmentSummaryMetrics R=${ref} I=${aligned_reads}/P732912_sorted_dedup_bqsr_reads.bam O=${aligned_reads}/alignment_12metrics.txt
gatk CollectInsertSizeMetrics INPUT=${aligned_reads}/P732912_sorted_dedup_bqsr_reads.bam OUTPUT=${aligned_reads}/insert_size_12metrics.txt HISTOGRAM_FILE=${aligned_reads}/insert_size_12histogram.pdf
echo "Done with step 5 alignment and insert size metrics CAD12"

#!/bin/bash
#BSUB -J step5_63
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -W 20:00
#BSUB -n 4
#BSUB -R rusage[mem=16000]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash
module load gatk
module load R
ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"
aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"
echo "STEP 5: Collect Alignment & Insert Size Metrics --CAD63"
gatk CollectAlignmentSummaryMetrics R=${ref} I=${aligned_reads}/P931263_sorted_dedup_bqsr_reads.bam O=${aligned_reads}/alignment_63metrics.txt
gatk CollectInsertSizeMetrics INPUT=${aligned_reads}/P931263_sorted_dedup_bqsr_reads.bam OUTPUT=${aligned_reads}/insert_size_63metrics.txt HISTOGRAM_FILE=${aligned_reads}/insert_size_63histogram.pdf



# # ----------------------------------------------
# # STEP 6: Call Variants - gatk haplotype caller
# # ----------------------------------------------
#!/bin/bash
#BSUB -J step6
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -W 20:00
#BSUB -n 4
#BSUB -R rusage[mem=16000]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

module load gatk

ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"
aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"
results="/sc/arion/projects/vascbrain/WGS_iPSC/results"

echo "STEP 6: Call Variants - gatk haplotype caller --CAD12"

gatk HaplotypeCaller -R ${ref} -I ${aligned_reads}/P732912_sorted_dedup_bqsr_reads.bam -O ${results}/raw_variants_CAD12.vcf
# extract SNPs & INDELS
gatk SelectVariants -R ${ref} -V ${results}/raw_variants_CAD12.vcf --select-type SNP -O ${results}/raw_snps_CAD12.vcf
gatk SelectVariants -R ${ref} -V ${results}/raw_variants_CAD12.vcf --select-type INDEL -O ${results}/raw_indels_CAD12.vcf
echo "done with variant calling for CAD12"

echo "STEP 6: Call Variants - gatk haplotype caller --CAD63"
gatk HaplotypeCaller -R ${ref} -I ${aligned_reads}/P931263_sorted_dedup_bqsr_reads.bam -O ${results}/raw_variants_CAD63.vcf
# extract SNPs & INDELS
gatk SelectVariants -R ${ref} -V ${results}/raw_variants_CAD63.vcf --select-type SNP -O ${results}/raw_snps_CAD63.vcf
gatk SelectVariants -R ${ref} -V ${results}/raw_variants_CAD63.vcf --select-type INDEL -O ${results}/raw_indels_CAD63.vcf
echo "Done with variant calling for CAD63"
