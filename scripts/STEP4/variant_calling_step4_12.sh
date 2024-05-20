#!/bin/bash
#BSUB -J step4_12
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

echo "STEP 4: Base quality recalibration --CAD12"

# 1. build the model
gatk BaseRecalibrator -I ${aligned_reads}/P732912_sorted_dedup_reads.bam -R ${ref} --known-sites ${known_sites} -O ${data}/recal_12data.table
echo "recal_12data.table created"

# 2. Apply the model to adjust the base quality scores
gatk ApplyBQSR -I ${aligned_reads}/P732912_sorted_dedup_reads.bam -R ${ref} --bqsr-recal-file ${data}/recal_12data.table -O ${aligned_reads}/P732912_sorted_dedup_bqsr_reads.bam
echo "done with base quality recalibration of CAD12"

