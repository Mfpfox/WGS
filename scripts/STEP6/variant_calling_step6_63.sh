#!/bin/bash
#BSUB -J step6_63
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -n 4
#BSUB -W 48:00
#BSUB -R rusage[mem=64000]
#BSUB -R span[hosts=1]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash


module load gatk

ref="/sc/arion/projects/vascbrain/WGS_iPSC/hg38_bundle_wget/Homo_sapiens_assembly38.fasta"
aligned_reads="/sc/arion/projects/vascbrain/WGS_iPSC/aligned_reads"
results="/sc/arion/projects/vascbrain/WGS_iPSC/results"

echo "STEP 6: Call Variants - gatk haplotype caller --CAD63"

gatk HaplotypeCaller -R ${ref} -I ${aligned_reads}/P931263_sorted_dedup_bqsr_reads.bam -O ${results}/raw_variants_CAD63.vcf

echo "done calling CAD63 variants"

gatk SelectVariants -R ${ref} -V ${results}/raw_variants_CAD63.vcf --select-type SNP -O ${results}/raw_snps_CAD63.vcf

gatk SelectVariants -R ${ref} -V ${results}/raw_variants_CAD63.vcf --select-type INDEL -O ${results}/raw_indels_CAD63.vcf

echo "done selecting SNPs and INDELs for CAD63"

