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

aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"

################ VARIANT CALLING STEPS ######################################

# -----------------------------------------
# STEP 3: Mark Duplicates and Sort - GATK4
# -----------------------------------------

echo "STEP 3: Mark Duplicates and Sort - GATK4 --CAD12"

gatk MarkDuplicatesSpark -I ${aligned_reads}/P732912.paired.sam -O ${aligned_reads}/P732912_sorted_dedup_reads.bam

echo "Done marking and sorting CAD12 sam into bam"

