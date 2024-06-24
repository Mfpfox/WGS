
# %%
from all_funx import *

# %%
# infiles
path = "/Users/mariapalafox/Desktop/BOLDcaution/WGS/5-annotation/3-summarize/"

vep = pd.read_csv(path + "1_clean_vep_output-snp-cad12.csv")

# %%
dbnsfp_full_match = pd.read_csv(path + "NOTCH3_Q9UM47_dbNSFP-hoffman.csv")

# %%
dbnsfp_partial = pd.read_csv(path + "NOTCH3_Q9UM47_partial_match.csv")

# %%
print(dbnsfp_partial.columns)

# %%
keepme = ['keyID38', 'keyID38AA', 
    'keyID19', 
     'aapos',
      'missenseType', 'REFALTletters','genename', 
    'AltaiNeandertal', 'Denisova', 'VindijiaNeandertal', 'SIFT_score', 'SIFT_converted_rankscore', 'SIFT_pred', 'SIFT4G_score', 'SIFT4G_converted_rankscore', 'SIFT4G_pred', 'Polyphen2_HDIV_score', 'Polyphen2_HDIV_rankscore', 'Polyphen2_HDIV_pred', 'Polyphen2_HVAR_score', 'Polyphen2_HVAR_rankscore', 'Polyphen2_HVAR_pred', 'LRT_score', 'LRT_converted_rankscore', 'LRT_pred', 'LRT_Omega', 'MutationTaster_score', 'MutationTaster_converted_rankscore', 'MutationTaster_pred', 'MutationTaster_model', 'MutationTaster_AAE',
       'MutationAssessor_score', 'MutationAssessor_rankscore', 'MutationAssessor_pred', 'FATHMM_score', 'FATHMM_converted_rankscore', 'FATHMM_pred', 'PROVEAN_score', 'PROVEAN_converted_rankscore', 'PROVEAN_pred', 'VEST4_score', 'VEST4_rankscore', 'MetaSVM_score', 'MetaSVM_rankscore', 'MetaSVM_pred', 'MetaLR_score', 'MetaLR_rankscore', 'MetaLR_pred', 'Reliability_index', 'MetaRNN_score', 'MetaRNN_rankscore', 'MetaRNN_pred', 'M-CAP_score', 'M-CAP_rankscore', 'M-CAP_pred', 'REVEL_score', 'REVEL_rankscore', 'MutPred_score', 'MutPred_rankscore', 'MutPred_protID', 'MutPred_AAchange', 'MutPred_Top5features', 'MVP_score', 'MVP_rankscore', 'MPC_score', 'MPC_rankscore', 'PrimateAI_score', 'PrimateAI_rankscore', 'PrimateAI_pred', 'DEOGEN2_score', 'DEOGEN2_rankscore', 'DEOGEN2_pred', 'BayesDel_addAF_score', 'BayesDel_addAF_rankscore', 'BayesDel_addAF_pred', 'BayesDel_noAF_score', 'BayesDel_noAF_rankscore', 'BayesDel_noAF_pred', 'ClinPred_score', 'ClinPred_rankscore', 'ClinPred_pred',
       'LIST-S2_score', 'LIST-S2_rankscore', 'LIST-S2_pred', 'Aloft_Fraction_transcripts_affected', 'Aloft_prob_Tolerant', 'Aloft_prob_Recessive', 'Aloft_prob_Dominant', 'Aloft_pred', 'Aloft_Confidence', 'CADD_raw', 'CADD_raw_rankscore', 'CADD_phred', 'CADD_raw_hg19', 'CADD_raw_rankscore_hg19', 'CADD_phred_hg19', 'DANN_score', 'DANN_rankscore', 'fathmm-MKL_coding_score', 'fathmm-MKL_coding_rankscore', 'fathmm-MKL_coding_pred', 'fathmm-MKL_coding_group', 'fathmm-XF_coding_score', 'fathmm-XF_coding_rankscore', 'fathmm-XF_coding_pred', 'Eigen-raw_coding', 'Eigen-raw_coding_rankscore', 'Eigen-phred_coding', 'Eigen-PC-raw_coding', 'Eigen-PC-raw_coding_rankscore', 'Eigen-PC-phred_coding', 'GenoCanyon_score', 'GenoCanyon_rankscore', 'integrated_fitCons_score', 'integrated_fitCons_rankscore', 'integrated_confidence_value', 'GM12878_fitCons_score', 'GM12878_fitCons_rankscore', 'GM12878_confidence_value', 'H1-hESC_fitCons_score', 'H1-hESC_fitCons_rankscore', 'H1-hESC_confidence_value',
       'HUVEC_fitCons_score', 'HUVEC_fitCons_rankscore', 'HUVEC_confidence_value', 'LINSIGHT', 'LINSIGHT_rankscore', 'GERP++_NR', 'GERP++_RS', 'GERP++_RS_rankscore', 'phyloP100way_vertebrate', 'phyloP100way_vertebrate_rankscore', 'phyloP30way_mammalian', 'phyloP30way_mammalian_rankscore', 'phyloP17way_primate', 'phyloP17way_primate_rankscore', 'phastCons100way_vertebrate', 'phastCons100way_vertebrate_rankscore', 'phastCons30way_mammalian', 'phastCons30way_mammalian_rankscore', 'phastCons17way_primate', 'phastCons17way_primate_rankscore', 'SiPhy_29way_pi', 'SiPhy_29way_logOdds', 'SiPhy_29way_logOdds_rankscore', 'bStatistic', 'bStatistic_converted_rankscore', 
       'clinvar_id', 'clinvar_clnsig', 'clinvar_trait', 'clinvar_review', 'clinvar_hgvs', 'clinvar_var_source', 'clinvar_MedGen_id', 'clinvar_OMIM_id', 'clinvar_Orphanet_id',
       'Interpro_domain', 'GTEx_V8_gene', 'GTEx_V8_tissue', 'Geuvadis_eQTL_target_gene', 'Gene_old_names', 'Gene_other_names', 'Uniprot_acc(HGNC/Uniprot)', 'Uniprot_id(HGNC/Uniprot)', 'Entrez_gene_id', 'CCDS_id', 'Refseq_id', 'ucsc_id', 'MIM_id', 'OMIM_id', 'Gene_full_name', 'Pathway(Uniprot)', 'Pathway(BioCarta)_short', 'Pathway(BioCarta)_full', 'Pathway(ConsensusPathDB)', 'Pathway(KEGG)_id', 'Pathway(KEGG)_full', 'Function_description', 'Disease_description', 'MIM_phenotype_id', 'MIM_disease', 'Orphanet_disorder_id', 'Orphanet_disorder', 'Orphanet_association_type', 'Trait_association(GWAS)', 'HPO_id', 'HPO_name', 'GO_biological_process', 'GO_cellular_component', 'GO_molecular_function', 'Tissue_specificity(Uniprot)', 'Expression(egenetics)', 'Expression(GNF/Atlas)', 'Interactions(IntAct)', 'Interactions(BioGRID)', 'Interactions(ConsensusPathDB)']

dbnsfp1 = dbnsfp_full_match[keepme].copy()
dbnsfp2 = dbnsfp_partial[keepme].copy()

# %%
vep_notch = vep[vep['SYMBOL'] == "NOTCH3"].copy()

# %%
merge1 = pd.merge(vep_notch, dbnsfp1, on="keyID38", how="left")
merge2 = pd.merge(vep_notch, dbnsfp2, on="keyID38", how="left")



# %%
merge1.to_csv(path + "NOTCH3_dbnsfp1_full_match_merged_vep_CAD12_SNV.csv", index=False)

merge2.to_csv(path + "NOTCH3_dbnsfp2_partial_match_merged_vep_CAD12_SNV.csv", index=False)
