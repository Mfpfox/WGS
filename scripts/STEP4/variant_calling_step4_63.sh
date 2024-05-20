#!/bin/bash
#BSUB -J step4_63
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

echo "STEP 4: Base quality recalibration --CAD63"

# 1. build the model

gatk BaseRecalibrator -I ${aligned_reads}/P931263_sorted_dedup_reads.bam -R ${ref} --known-sites ${known_sites} -O ${data}/recal_63data.table
echo "recal_63data.table created"

# 2. Apply the model to adjust the base quality scores

gatk ApplyBQSR -I ${aligned_reads}/P931263_sorted_dedup_reads.bam -R ${ref} --bqsr-recal-file ${data}/recal_63data.table -O ${aligned_reads}/P931263_sorted_dedup_bqsr_reads.bam

echo "done with base quality recalibration for CAD63"

