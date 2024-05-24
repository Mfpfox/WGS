#!/bin/bash
#BSUB -J WGS_step2_CAD63
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -n 4
#BSUB -W 60:00
#BSUB -R rusage[mem=32000]
#BSUB -R span[hosts=1]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

module load samtools/1.17
module load gatk
module load fastqc
module load bwa

ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"

aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"

reads="/sc/arion/projects/vascbrain/WGS_iPSC/raw_data/P931263"

################ VARIANT CALLING STEPS ######################################

# --------------------------------------
# STEP 2: Map to reference using BWA-MEM
# --------------------------------------

echo "STEP 2: Map to reference using BWA-MEM"

bwa mem -t 4 -R "@RG\tID:P931263\tPL:ILLUMINA\tSM:P931263" ${ref} ${reads}/P931263_FDSW220142848_1r_HYMM2DSX2_L1_1.fq.gz ${reads}/P931263_FDSW220142848_1r_HYMM2DSX2_L1_2.fq.gz > ${aligned_reads}/P931263.paired.sam

echo "done STEP 2: read alignment to hg38"

