

from all_funx import *


# input: individual WGS results for indels
# output: vep html equivalent plots for report

indel12 = "annotated_indels_CAD12_autoX.txt"
snp12 = "annotated_snps_CAD12_autoX.txt"

indel63 = "annotated_indels_CAD63_autoX.txt"
snp63 = "annotated_snps_CAD63_autoX.txt"

indel12 = pd.read_csv(indel12, delimiter="\t", engine='python',\
                 comment='##')
# snp12 = pd.read_csv(snp12, delimiter="\t", engine='python',\
#                  comment='##')
# indel63 = pd.read_csv(indel63, delimiter="\t", engine='python',\
#                       comment='##')
# snp63 = pd.read_csv(snp63, delimiter="\t", engine='python',\
#                         comment='##')

print(indel12.columns)

indel12 = renameit(indel12, '#Uploaded_variation', 'Uploaded_variation')
"""
['Uploaded_variation', 'Location', 'Allele', 'Gene', 'Feature', 'Feature_type', 'Consequence', 'cDNA_position', 'CDS_position', 'Protein_position', 'Amino_acids', 'Codons', 'Existing_variation', 'IND', 'ZYG', 'REF_ALLELE', 'IMPACT', 'DISTANCE', 'STRAND', 'FLAGS', 'VARIANT_CLASS', 'SYMBOL', 'SYMBOL_SOURCE', 'HGNC_ID', 'BIOTYPE', 'CANONICAL', 'MANE_SELECT', 'MANE_PLUS_CLINICAL', 'TSL', 'APPRIS', 'CCDS', 'ENSP', 'SWISSPROT', 'TREMBL', 'UNIPARC', 'UNIPROT_ISOFORM', 'REFSEQ_MATCH', 'SOURCE', 'REFSEQ_OFFSET', 'GIVEN_REF', 'USED_REF', 'BAM_EDIT', 'GENE_PHENO', 'SIFT', 'PolyPhen', 'EXON', 'INTRON', 'DOMAINS', 'miRNA', 'HGVSc', 'HGVSp', 'HGVS_OFFSET', 'gnomADg_AF', 'gnomADg_AFR_AF', 'gnomADg_AMI_AF', 'gnomADg_AMR_AF', 'gnomADg_ASJ_AF', 'gnomADg_EAS_AF', 'gnomADg_FIN_AF', 'gnomADg_MID_AF', 'gnomADg_NFE_AF', 'gnomADg_OTH_AF', 'gnomADg_SAS_AF', 'MAX_AF', 'MAX_AF_POPS', 'CLIN_SIG', 'SOMATIC', 'PHENO', 'PUBMED', 'MOTIF_NAME', 'MOTIF_POS', 'HIGH_INF_POS', 'MOTIF_SCORE_CHANGE',
       'TRANSCRIPTION_FACTORS'],
"""


uniqueCount(indel12,'Uploaded_variation')

# checkColumnValues(indel12, "Consequence")
# checkColumnValues(indel12, "IMPACT")
# checkColumnValues(indel12, "ZYG")


# #df = pd.read_csv(path, delimiter="\t", low_memory=False)
# print(df.head())
# df.describe()


#crosstabit(df,"Consequence", "ZYG", True)
# crosstabit(df,"Consequence", "ZYG", True)
# crosstabit(snp12,"Consequence", "IMPACT", True)
# crosstabit(snp63,"Consequence", "IMPACT", True)
