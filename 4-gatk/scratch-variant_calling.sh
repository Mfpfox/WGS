
################ Prep files (RUN ONLY ONCE) USCS ERROR ##############

    echo 'download reference files to folder and unzip'
    wget -P /sc/arion/projects/vascbrain/WGS_iPSC/hg38/ https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz
    # gunzip /sc/arion/projects/vascbrain/WGS_iPSC/hg38/hg38.fa.gz

    echo 'index ref - .fai file before running haplotype caller'
    samtools faidx /sc/arion/projects/vascbrain/WGS_iPSC/hg38/hg38.fa

    echo 'create ref dict file before running haplotype caller'
    gatk CreateSequenceDictionary R=/sc/arion/projects/vascbrain/WGS_iPSC/hg38/hg38.fa O=/sc/arion/projects/vascbrain/WGS_iPSC/hg38/hg38.dict


    echo 'download known sites files for BQSR from GATK resource bundle'
    wget -P /sc/arion/projects/vascbrain/WGS_iPSC/hg38/ https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf
    wget -P /sc/arion/projects/vascbrain/WGS_iPSC/hg38/ https://storage.googleapis.com/genomics-public-data/broad/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf.idx

    # use these files and can skip the bwa index step
    # wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.64.alt
    # wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.64.amb
    # wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.64.ann
    # wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.64.bwt
    # wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.64.pac
    # wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.64.sa


########### Minerva job submission #################

    [?] rename script from .sh to .lsf? 
    [?] express instead of premium queue? or fast turnaround, premium is default

    BSUB -oo %J.stdout
    BSUB -eo %J.stderr
    BSUB -o %J.stdout
    BSUB -e %J.stderr

########### CAD12 files ##################

    P732912_FDSW220142847_1r_HYMM2DSX2_L1_1.fq.gz
    P732912_FDSW220142847_1r_HYMM2DSX2_L1_2.fq.gz

    P732912_FDSW220142847_1r_HYMM2DSX2_L1_1_fastqc.zip
    P732912_FDSW220142847_1r_HYMM2DSX2_L1_2_fastqc.zip

############ CAD63 files ###############

    P931263_FDSW220142848_1r_HYMM2DSX2_L1_1.fq.gz
    P931263_FDSW220142848_1r_HYMM2DSX2_L1_2.fq.gz

    P931263_FDSW220142848_1r_HYMM2DSX2_L1_1_fastqc.zip
    P931263_FDSW220142848_1r_HYMM2DSX2_L1_2_fastqc.zip

######### Trouble Shooting STEP 2-error 1 memory ##################

    TERM_MEMLIMIT: job killed after reaching LSF memory usage limit.
    Exited with exit code 130.
    Resource usage summary:
        CPU time :                                   2312.83 sec.
        Max Memory :                                 4000 MB
        Average Memory :                             1135.49 MB
        Total Requested Memory :                     4000.00 MB
        Delta Memory :                               0.00 MB
        Max Swap :                                   2 MB
        Max Processes :                              6
        Max Threads :                                8
        Run time :                                   2323 sec.
        Turnaround time :                            2327 sec.

    # solution :
    BSUB -n 1
    BSUB -W 6:00
    BSUB -R rusage[mem=16000]

########## Trouble Shooting STEP 2-error 2 CAD12 ######

    cat 124703558.stderr

    [bwa_index] Pack FASTA... 19.38 sec
    [bwa_index] Construct BWT for the packed sequence...
    [BWTIncCreate] textLength=6418572210, availableWord=463634060
    [BWTIncConstructFromPacked] 10 iterations done. 99999986 characters processed.
    [BWTIncConstructFromPacked] 20 iterations done. 199999986 characters processed.
    [BWTIncConstructFromPacked] 30 iterations done. 299999986 characters processed.
    [BWTIncConstructFromPacked] 40 iterations done. 399999986 characters processed.
    [BWTIncConstructFromPacked] 50 iterations done. 499999986 characters processed.
    [BWTIncConstructFromPacked] 60 iterations done. 599999986 characters processed.

    BWTIncConstructFromPacked() : Can't read from /sc/arion/projects/vascbrain/WGS_iPSC/hg38/hg38.fa.pac : Unexpected end of file

    [bwt_restore_sa] fail to open file '/sc/arion/projects/vascbrain/WGS_iPSC/hg38/hg38.fa.sa' : No such file or directory

    BWTIncConstructFromPacked() : Can't read from hg38.fa.pac : Unexpected end of file


    google: 
    BWTIncConstructFromPacked() : Cant read from /sc/arion/projects/vascbrain/WGS_iPSC/hg38/hg38.fa.pac : Unexpected end of file



    google: 
    [bwt_restore_sa] fail to open file '/sc/arion/projects/vascbrain/WGS_iPSC/hg38/hg38.fa.sa' : No such file or directory

    answer:
    Sounds like your genome index file(s) may be corrupt 
    or not properly created. 
    Can you try recreating the indexes?

########## Trouble Shooting STEP 2-error 3 CAD63 ############

    # seems like i cant RUN both sample at the same time for this step-the one that was running errors out as soon as the newer job starts

    cad63 end of job once cad12 restarted .. from stderr..

    [BWTIncConstructFromPacked] 490 iterations done. 4899999986 characters processed.

    [BWTIncConstructFromPacked] 500 iterations done. 4999999986 characters processed.

    BWTIncConstructFromPacked() : Cant read from /sc/arion/projects/vascbrain/WGS_iPSC/hg38/hg38.fa.pac : Unexpected end of file

    [bwt_restore_sa] fail to open file /sc/arion/projects/vascbrain/WGS_iPSC/hg38/hg38.fa.sa : No such file or directory


    # # DELETED sam in aligned folder and now waiting to see if CAD12 step 2 finishes without error

########## Trouble Shooting STEP 2-CAD12 out ###################

    Successfully completed.
    Resource usage summary:
        CPU time :                                   2994.12 sec.
        Max Memory :                                 4597 MB
        Average Memory :                             2041.25 MB
        Total Requested Memory :                     16000.00 MB
        Delta Memory :                               11403.00 MB
        Max Swap :                                   2 MB
        Max Processes :                              4
        Max Threads :                                5
        Run time :                                   3003 sec.
        Turnaround time :                            3009 sec.
    The output (if any) follows:
    STEP 2: Map to reference using BWA-MEM
    [bwt_gen] Finished constructing BWT in 710 iterations.
    STEP 2: read alignment to ref genome hg38 complete!

########## Trouble Shooting STEP 2-CAD12 err ###########

    # [main] Real time: 2997.501 sec; CPU: 2986.970 sec
    [M::bwa_idx_load_from_disk] read 0 ALT contigs
    [W::bseq_read] the 2nd file has fewer sequences.
    [W::bseq_read] the 2nd file has fewer sequences.
    # [M::process] read 4 sequences (707 bp)...
    # [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (0, 0, 0, 0)
    # [M::mem_pestat] skip orientation FF as there are not enough pairs
    # [M::mem_pestat] skip orientation FR as there are not enough pairs
    # [M::mem_pestat] skip orientation RF as there are not enough pairs
    # [M::mem_pestat] skip orientation RR as there are not enough pairs
    # [mem_sam_pe] paired reads have different names: "ANw|Ż?Sloam?<?nX???<??Ï??˫˝M", "?д"




























#### minerva scripts to local dir ##########################
    scp -r palafm01@minerva.hpc.mssm.edu:/sc/arion/projects/vascbrain/WGS_iPSC/scripts .

proof that NOVOGENE used PCR based WGS:
    X202SC22042030-Z01-F001_final_20220514195337/X202SC22042030-Z01-F001_Report.html




