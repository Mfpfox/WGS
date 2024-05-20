#!/bin/bash
#BSUB -J WGS_12
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -n 8
#BSUB -W 60:00
#BSUB -R rusage[mem=4000]
#BSUB -R span[hosts=1]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

module load samtools/1.17
module load gatk
module load fastqc
module load bwa

ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"

known_sites="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.dbsnp138.vcf"

aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"

results="/sc/arion/projects/vascbrain/WGS_iPSC/results"

data="/sc/arion/projects/vascbrain/WGS_iPSC/data"

reads="/sc/arion/projects/vascbrain/WGS_iPSC/raw_data/P732912"

#reads="/sc/arion/projects/vascbrain/WGS_iPSC/raw_data/P931263"

################ VARIANT CALLING STEPS ######################################

# --------------------------------------
# STEP 2: Map to reference using BWA-MEM
# --------------------------------------

echo "STEP 2: Map to reference using BWA-MEM"

"""BWA index reference use -64 option to specific 64 bit (alt index)"""

bwa mem -t 4 -R "@RG\tID:P732912\tPL:ILLUMINA\tSM:P732912" ${ref} ${reads}/P732912_FDSW220142847_1r_HYMM2DSX2_L1_1.fq.gz ${reads}/P732912_FDSW220142847_1r_HYMM2DSX2_L1_2.fq.gz > ${aligned_reads}/P732912.paired.sam

echo "done STEP 2: read alignment to hg38"


