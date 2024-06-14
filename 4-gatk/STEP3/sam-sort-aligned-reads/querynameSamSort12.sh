#!/bin/bash
#BSUB -J sortQname12
#BSUB -P acc_vascbrain
#BSUB -q premium
#BSUB -W 48:00
#BSUB -n 1
#BSUB -R rusage[mem=256000]
#BSUB -R span[hosts=1]
#BSUB -oo %J.stdout
#BSUB -eo %J.stderr
#BSUB -L /bin/bash

module load picard/3.1.1

java -jar $PICARD SortSam \
     INPUT=P732912.paired.sam \
     OUTPUT=P732912.paired.sorted.sam \
     SORT_ORDER=queryname

echo 'done sorting CAD12'

