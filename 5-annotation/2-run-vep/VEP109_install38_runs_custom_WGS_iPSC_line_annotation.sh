vep 109 hg38 annotation of CAD12 and CAD63 vcf files
@mfpfox
May 23, 2024

NOTE sources:
- VEP109_script_documentation.pdf
- VEP109_install_custom_flag_troubeshooting.sh

curl issue:
    from perl INSTALL.pl, error finding curl, not an issue for running below but here is answer to mac osx and curl issue : 
        https://stackoverflow.com/questions/44290925/curl-gives-an-error-on-mac-os



## downloaded input files from minerva: #######################################
analysis_ready_snps_CAD12_filtered_DP_GQ.vcf
analysis_ready_indels_CAD12_filtered_DP_GQ.vcf
analysis_ready_snps_CAD63_filtered_DP_GQ.vcf
analysis_ready_indels_CAD63_filtered_DP_GQ.vcf

scp -r palafm01@minerva.hpc.mssm.edu:/sc/arion/projects/vascbrain/WGS_iPSC/results/analysis_ready_filtered_vcf .


## made following changed to .zprofile: #######################################
export DYLD_LIBRARY_PATH="/Users/mariapalafox/Desktop/ensembl-vep/htslib"
# export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:${DYLD_LIBRARY_PATH}


## confirmed size of merged cache for hg38 matched guide pdf (29GB) ###########
$HOME/.vep/homo_sapiens_merged/109_GRCh38


## environment ################################################################
conda activate perly



######################## test 1 ###############################################

./vep -i examples/homo_sapiens_GRCh38.vcf --dir_cache /Users/mariapalafox/.vep/homo_sapiens_merged/109_GRCh38

"""dont need dir cache arg
    By default, VEP searches for caches in $HOME/. vep; to use a different directory when running VEP, use --dir_cache."""


######################## test 2 ###############################################

./vep -i examples/homo_sapiens_GRCh38.vcf --cache --force_overwrite

"""output missing transcript data
    position and allele info for row 1 == example shown in pdf
    but pdf has ENSEMBL transcript ID

    row position and allele dont match for other rows, is this due to v109.0 
    difference from v109.3 (currently installed) or have to do with 
    --use_transcript_ref
"""


######################## test 3 ###############################################

./vep -i examples/homo_sapiens_GRCh38.vcf --cache --merged -o variant_effect_output_merged.txt

"""INFO: BAM-edited cache detected, enabling --use_transcript_ref;
        use --use_given_ref to override this
        INFO: Database will be accessed when using --use_transcript_ref"""


######################## test 4 ###############################################

./vep -i examples/homo_sapiens_GRCh38.vcf \
    -o homo_sapiens_GRCh38_full_args_useTranscriptREF.txt \
    --cache --merged --assembly GRCh38 \
    --tab \
    --force_overwrite \
    --canonical \
    --pick \
    --exclude_predicted \
    --uniprot \
    --symbol \
    --sift b --polyphen b \
    --regulatory \
    --gene_phenotype \
    --domains \
    --use_transcript_ref \
    --fork 6

"""By default VEP uses the reference allele provided in the input file to calculate consequences for the provided alternate allele(s). Use this flag to force VEP to replace the provided reference allele with sequence derived from the overlapped transcript. This is especially relevant when using the RefSeq cache, see documentation for more details. Not used by default"""


"""--transcript_filter :
    You may filter on any key defined in the root of the transcript object; most commonly this will be stable id:
    --transcript_filter 'stable_id match N[MR]_'
"""


./filter_vep -i homo_sapiens_GRCh38_full_args_useTranscriptREF.txt \
    -o homo_sapiens_GRCh38_full_args_useTranscriptREF_filtered.txt \
    -filter "SYMBOL in SDF2L1,MTFP1"



######################## iPSC lines #########################################

--everything        # Shortcut flag to switch on all of the following:
        --sift b \
        --polyphen b \
        --ccds \
        --hgvs \
        --symbol # cant use with most_severe
        --numbers \
        --domains \
        --regulatory \
        --canonical \
        --protein # cant use with most_severe
        --biotype # cant use with most_severe
        --af \
        --af_1kg
        --af_esp
        --af_gnomade
        --af_gnomadg \
        --max_af \
        --pubmed \
        --uniprot \
        --mane \
        --tsl \
        --appris \
        --variant_class \
        --gene_phenotype \
        --mirna \

## dropped :
--most_severe

./vep -i /Users/mariapalafox/Desktop/BOLDcaution/WGS/results_from_minerva/analysis_ready_filtered_vcf/analysis_ready_snps_CAD12_filtered_DP_GQ.vcf \
    -o annotated_analysis_ready_snps_CAD12_filtered_DP_GQ.txt \
    --cache \
    --merged \
    --assembly GRCh38 \
    --tab \
    --force_overwrite \
    --pick \
    --exclude_predicted \
    --sift b \
    --polyphen b \
    --ccds \
    --hgvs \
    --symbol \
    --numbers \
    --domains \
    --regulatory \
    --canonical \
    --protein \
    --biotype \
    --af_gnomadg \
    --max_af \
    --pubmed \
    --uniprot \
    --mane \
    --tsl \
    --appris \
    --variant_class \
    --gene_phenotype \
    --mirna \
    --use_transcript_ref \
    --check_existing \
    --cell_type \
    --show_ref_allele \
    --total_length \
    --fork 6

"""
-------------------- EXCEPTION --------------------
MSG: ERROR: Cell type "--show_ref_allele" unavailable; available cell types are:
A549,A673,B,B_(PB),CD14+_monocyte_(PB),CD14+_monocyte_1,CD4+_CD25+_ab_Treg_(PB),
CD4+_ab_T,CD4+_ab_T_(PB)_1,CD4+_ab_T_(PB)_2,CD4+_ab_T_(Th),CD4+_ab_T_(VB),
CD8+_ab_T_(CB),CD8+_ab_T_(PB),CMP_CD4+_1,CMP_CD4+_2,CMP_CD4+_3,CM_CD4+_ab_T_(VB),
DND-41,EB_(CB),EM_CD4+_ab_T_(PB),EM_CD8+_ab_T_(VB),EPC_(VB),GM12878,H1-hESC_2,
H1-hESC_3,H9_1,HCT116,HSMM,HUES48,HUES6,HUES64,HUVEC,HUVEC-prol_(CB),HeLa-S3,
HepG2,K562,M0_(CB),M0_(VB),M1_(CB),M1_(VB),M2_(CB),M2_(VB),MCF-7,MM.1S,MSC,MSC_(VB),
NHLF,NK_(PB),NPC_1,NPC_2,NPC_3,PC-3,PC-9,SK-N.,T_(PB),Th17,UCSF-4,adrenal_gland,
aorta,astrocyte,bipolar_neuron,brain_1,cardiac_muscle,dermal_fibroblast,
endodermal,eosinophil_(VB),esophagus,foreskin_fibroblast_2,foreskin_keratinocyte_1,
foreskin_keratinocyte_2,foreskin_melanocyte_1,foreskin_melanocyte_2,germinal_matrix,
heart,hepatocyte,iPS-15b,iPS-20b,iPS_DF_19.11,iPS_DF_6.9,keratinocyte,kidney,
large_intestine,left_ventricle,leg_muscle,lung_1,lung_2,mammary_epithelial_1,
mammary_epithelial_2,mammary_myoepithelial,monocyte_(CB),monocyte_(VB),
mononuclear_(PB),myotube,naive_B_(VB),neuron,neurosphere_(C),neurosphere_(GE),
neutro_myelocyte,neutrophil_(CB),neutrophil_(VB),osteoblast,ovary,pancreas,
placenta,psoas_muscle,right_atrium,right_ventricle,sigmoid_colon,small_intestine_1,
small_intestine_2,spleen,stomach_1,stomach_2,thymus_1,thymus_2,trophoblast,trunk_muscle
"""


## dropped :
--cell_type       # discuss this later w stephen and fanny
--force_overwrite

# run entire snp and indel vcf
/Users/mariapalafox/Desktop/BOLDcaution/WGS/results_from_minerva/analysis_ready_filtered_vcf/

analysis_ready_snps_CAD12_filtered_DP_GQ.vcf

analysis_ready_snps_CAD63_filtered_DP_GQ.vcf


"""2024-05-23 21:51:35 - INFO: BAM-edited cache detected, enabling --use_transcript_ref; use --use_given_ref to override this
2024-05-23 21:51:35 - INFO: Database will be accessed when using --hgvs
2024-05-23 21:51:35 - INFO: Database will be accessed when using --hgvsc
2024-05-23 21:51:35 - INFO: Database will be accessed when using --hgvsp
2024-05-23 21:51:35 - INFO: Database will be accessed when using --use_transcript_ref"""

# idea for speeding up : 
--offline

# time solution = annotate individual chrom :

-rw-r--r--@  1 mariapalafox  staff    28M May 24 16:28 analysis_ready_snps_CAD63_filtered_DP_GQ_chr11.vcf
-rw-r--r--   1 mariapalafox  staff    26M May 24 16:28 analysis_ready_snps_CAD12_filtered_DP_GQ_chr11.vcf
-rw-r--r--   1 mariapalafox  staff    14M May 24 16:28 analysis_ready_snps_CAD12_filtered_DP_GQ_chr19.vcf
-rw-r--r--   1 mariapalafox  staff    13M May 24 16:28 analysis_ready_snps_CAD63_filtered_DP_GQ_chr19.vcf

analysis_ready_snps_CAD63_filtered_DP_GQ_chr19.vcf
analysis_ready_snps_CAD12_filtered_DP_GQ_chr19.vcf
analysis_ready_snps_CAD63_filtered_DP_GQ_chr11.vcf
analysis_ready_snps_CAD12_filtered_DP_GQ_chr11.vcf

-rw-r--r--   1 mariapalafox  staff   5.1M May 24 16:28 analysis_ready_indels_CAD63_filtered_DP_GQ_chr11.vcf
-rw-r--r--   1 mariapalafox  staff   5.0M May 24 16:28 analysis_ready_indels_CAD12_filtered_DP_GQ_chr11.vcf
-rw-r--r--   1 mariapalafox  staff   4.1M May 24 16:28 analysis_ready_indels_CAD12_filtered_DP_GQ_chr19.vcf
-rw-r--r--   1 mariapalafox  staff   3.5M May 24 16:28 analysis_ready_indels_CAD63_filtered_DP_GQ_chr19.vcf




#analysis_ready_snps_CAD63_filtered_DP_GQ_chr19.vcf (done)
out : annotated_analysis_ready_snps_CAD63_filtered_DP_GQ_chr19.txt
# rename : 
    annotated_analysis_ready_snps_CAD63_filtered_DP_GQ_chr19.txt_summary.html
# time:
    28M input
    2M ~10 min
    14x10 = 140 min for annotated snps CAD63 chr19
    # holy cow offline + fasta makes huge difference in time

#analysis_ready_snps_CAD12_filtered_DP_GQ_chr19.vcf (done)
out : annotated_analysis_ready_snps_CAD12_filtered_DP_GQ_chr19.txt

#analysis_ready_snps_CAD63_filtered_DP_GQ_chr11.vcf (done)
out : annotated_analysis_ready_snps_CAD63_filtered_DP_GQ_chr11.txt

#analysis_ready_snps_CAD12_filtered_DP_GQ_chr11.vcf (done)
out : annotated_analysis_ready_snps_CAD12_filtered_DP_GQ_chr11.txt


#analysis_ready_indels_CAD63_filtered_DP_GQ_chr19.vcf (done)
out : annotated_analysis_ready_indels_CAD63_filtered_DP_GQ_chr19.txt

#analysis_ready_indels_CAD63_filtered_DP_GQ_chr11.vcf (done)
out : annotated_analysis_ready_indels_CAD63_filtered_DP_GQ_chr11

#analysis_ready_indels_CAD12_filtered_DP_GQ_chr19.vcf (done)
out : annotated_analysis_ready_indels_CAD12_filtered_DP_GQ_chr19

#analysis_ready_indels_CAD12_filtered_DP_GQ_chr11.vcf (done)
out : annotated_analysis_ready_indels_CAD12_filtered_DP_GQ_chr11


./vep -i /Users/mariapalafox/Desktop/BOLDcaution/WGS/results_from_minerva/analysis_ready_filtered_vcf/\
analysis_ready_indels_CAD12_filtered_DP_GQ_chr11.vcf \
    -o \
zygosity_annotated_analysis_ready_indels_CAD12_filtered_DP_GQ_chr11.txt \
    --cache \
    --merged \
    --offline \
    --hgvs \
    --fasta /Users/mariapalafox/Desktop/BOLDcaution/WGS/hg38_bundle_wget/Homo_sapiens_assembly38.fasta \
    --assembly GRCh38 \
    --tab \
    --pick \
    --exclude_predicted \
    --sift b \
    --polyphen b \
    --ccds \
    --symbol \
    --numbers \
    --domains \
    --regulatory \
    --canonical \
    --protein \
    --biotype \
    --af_gnomadg \
    --max_af \
    --pubmed \
    --uniprot \
    --mane \
    --tsl \
    --appris \
    --variant_class \
    --gene_phenotype \
    --mirna \
    --use_transcript_ref \
    --check_existing \
    --show_ref_allele \
    --total_length \
    --individual all \
    --fork 6

    --total_length \ # problematic with excel - becomes date






# filter 2 genes ---------------------------------------------------

# qc confirm geene name is in file 
grep -m 2 -E "NOTCH3|TAGLN" annotated_analysis_ready_snps_CAD12_filtered_DP_GQ_chr19.txt
grep -m 2 -E "NOTCH3|TAGLN" annotated_analysis_ready_snps_CAD12_filtered_DP_GQ_chr11.txt



# cad12 snps NOTCH3
./filter_vep -i annotated_analysis_ready_snps_CAD12_filtered_DP_GQ_chr19.txt \
    -o NOTCH3_annotated_analysis_ready_snps_CAD12_filtered_DP_GQ_chr19.txt \
    -filter "SYMBOL in NOTCH3,TAGLN"

# cad63 snps NOTCH3
./filter_vep -i annotated_analysis_ready_snps_CAD63_filtered_DP_GQ_chr19.txt \
    -o NOTCH3_annotated_analysis_ready_snps_CAD63_filtered_DP_GQ_chr19.txt \
    -filter "SYMBOL in NOTCH3,TAGLN"


# cad12 snps TAGLN
./filter_vep -i annotated_analysis_ready_snps_CAD12_filtered_DP_GQ_chr11.txt \
    -o TAGLN_annotated_analysis_ready_snps_CAD12_filtered_DP_GQ_chr11.txt \
    -filter "SYMBOL in NOTCH3,TAGLN"

# cad63 snps TAGLN
./filter_vep -i annotated_analysis_ready_snps_CAD63_filtered_DP_GQ_chr11.txt \
    -o TAGLN_annotated_analysis_ready_snps_CAD63_filtered_DP_GQ_chr11.txt \
    -filter "SYMBOL in NOTCH3,TAGLN"


# cad12 indels NOTCH3
./filter_vep -i annotated_analysis_ready_indels_CAD12_filtered_DP_GQ_chr19.txt \
    -o NOTCH3_annotated_analysis_ready_indels_CAD12_filtered_DP_GQ_chr19.txt \
    -filter "SYMBOL in NOTCH3,TAGLN"

# cad63 indels NOTCH3
./filter_vep -i annotated_analysis_ready_indels_CAD63_filtered_DP_GQ_chr19.txt \
    -o NOTCH3_annotated_analysis_ready_indels_CAD63_filtered_DP_GQ_chr19.txt \
    -filter "SYMBOL in NOTCH3,TAGLN"


# cad12 indels TAGLN
./filter_vep -i annotated_analysis_ready_indels_CAD12_filtered_DP_GQ_chr11.txt \
    -o TAGLN_annotated_analysis_ready_indels_CAD12_filtered_DP_GQ_chr11.txt \
    -filter "SYMBOL in NOTCH3,TAGLN"

# cad63 indels TAGLN
./filter_vep -i annotated_analysis_ready_indels_CAD63_filtered_DP_GQ_chr11.txt \
    -o TAGLN_annotated_analysis_ready_indels_CAD63_filtered_DP_GQ_chr11.txt \
    -filter "SYMBOL in NOTCH3,TAGLN"
