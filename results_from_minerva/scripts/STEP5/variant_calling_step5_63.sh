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

echo "Done with step 5 alignment and insert size metrics for CAD63"

