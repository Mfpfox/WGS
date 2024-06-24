## ENSEMBL VARIANT EFFECT PREDICTOR v109.3
## Output produced at 2024-05-24 17:05:04
## Using cache in /Users/mariapalafox/.vep/homo_sapiens_merged/109_GRCh38
## Using API version 109, DB version ?
## ensembl-funcgen version 109
## ensembl-variation version 109
## ensembl version 109
## ensembl-io version 109
## ClinVar version 202209
## assembly version GRCh38.p13
## 1000genomes version phase3
## COSMIC version 96
## refseq version 110 -GCF_000001405.40_GRCh38.p14_genomic.gff
## polyphen version 2.2.3
## HGMD-PUBLIC version 20204
## regbuild version 1.0
## genebuild version 2014-07
## dbSNP version 154
## gnomADg version v3.1.2
## gencode version GENCODE 43
## gnomADe version r2.1.1
## sift version 6.2.1

## Column descriptions:

## Uploaded_variation : Identifier of uploaded variant
## Location : Location of variant in standard coordinate format (chr:start or chr:start-end)
## Allele : The variant allele used to calculate the consequence
## Gene : Stable ID of affected gene
## Feature : Stable ID of feature
## Feature_type : Type of feature -Transcript, RegulatoryFeature or MotifFeature
## Consequence : Consequence type
## cDNA_position : Relative position of base pair in cDNA sequence
## CDS_position : Relative position of base pair in coding sequence
## Protein_position : Relative position of amino acid in protein
## Amino_acids : Reference and variant amino acids
## Codons : Reference and variant codon sequence
## Existing_variation : Identifier(s) of co-located known variants
## REF_ALLELE : Reference allele
## IMPACT : Subjective impact classification of consequence type
## DISTANCE : Shortest distance from variant to transcript
## STRAND : Strand of the feature (1/-1)
## FLAGS : Transcript quality flags
## VARIANT_CLASS : SO variant class
## SYMBOL : Gene symbol (e.g. HGNC)
## SYMBOL_SOURCE : Source of gene symbol
## HGNC_ID : Stable identifer of HGNC gene symbol
## BIOTYPE : Biotype of transcript or regulatory feature
## CANONICAL : Indicates if transcript is canonical for this gene
## MANE_SELECT : MANE Select (Matched Annotation from NCBI and EMBL-EBI) Transcript
## MANE_PLUS_CLINICAL : MANE Plus Clinical (Matched Annotation from NCBI and EMBL-EBI) Transcript
## TSL : Transcript support level
## APPRIS : Annotates alternatively spliced transcripts as primary or alternate based on a range of computational methods
## CCDS : Indicates if transcript is a CCDS transcript
## ENSP : Protein identifer
## SWISSPROT : UniProtKB/Swiss-Prot accession
## TREMBL : UniProtKB/TrEMBL accession
## UNIPARC : UniParc accession
## UNIPROT_ISOFORM : Direct mappings to UniProtKB isoforms
## REFSEQ_MATCH : RefSeq transcript match status
## SOURCE : Source of transcript
## REFSEQ_OFFSET : HGVS adjustment length required due to mismatch between RefSeq transcript and the reference genome
## GIVEN_REF : Reference allele from input
## USED_REF : Reference allele as used to get consequences
## BAM_EDIT : Indicates success or failure of edit using BAM file
## GENE_PHENO : Indicates if gene is associated with a phenotype, disease or trait
## SIFT : SIFT prediction and/or score
## PolyPhen : PolyPhen prediction and/or score
## EXON : Exon number(s) / total
## INTRON : Intron number(s) / total
## DOMAINS : The source and identifer of any overlapping protein domains
## miRNA : SO terms of overlapped miRNA secondary structure feature(s)
## HGVSc : HGVS coding sequence name
## HGVSp : HGVS protein sequence name
## HGVS_OFFSET : Indicates by how many bases the HGVS notations for this variant have been shifted
## gnomADg_AF : Frequency of existing variant in gnomAD genomes combined population
## gnomADg_AFR_AF : Frequency of existing variant in gnomAD genomes African/American population
## gnomADg_AMI_AF : Frequency of existing variant in gnomAD genomes Amish population
## gnomADg_AMR_AF : Frequency of existing variant in gnomAD genomes American population
## gnomADg_ASJ_AF : Frequency of existing variant in gnomAD genomes Ashkenazi Jewish population
## gnomADg_EAS_AF : Frequency of existing variant in gnomAD genomes East Asian population
## gnomADg_FIN_AF : Frequency of existing variant in gnomAD genomes Finnish population
## gnomADg_MID_AF : Frequency of existing variant in gnomAD genomes Mid-eastern population
## gnomADg_NFE_AF : Frequency of existing variant in gnomAD genomes Non-Finnish European population
## gnomADg_OTH_AF : Frequency of existing variant in gnomAD genomes other combined populations
## gnomADg_SAS_AF : Frequency of existing variant in gnomAD genomes South Asian population
## MAX_AF : Maximum observed allele frequency in 1000 Genomes, ESP and ExAC/gnomAD
## MAX_AF_POPS : Populations in which maximum allele frequency was observed
## CLIN_SIG : ClinVar clinical significance of the dbSNP variant
## SOMATIC : Somatic status of existing variant
## PHENO : Indicates if existing variant(s) is associated with a phenotype, disease or trait; multiple values correspond to multiple variants
## PUBMED : Pubmed ID(s) of publications that cite existing variant
## MOTIF_NAME : The stable identifier of a transcription factor binding profile (TFBP) aligned at this position
## MOTIF_POS : The relative position of the variation in the aligned TFBP
## HIGH_INF_POS : A flag indicating if the variant falls in a high information position of the TFBP
## MOTIF_SCORE_CHANGE : The difference in motif score of the reference and variant sequences for the TFBP
## TRANSCRIPTION_FACTORS : List of transcription factors which bind to the transcription factor binding profile
