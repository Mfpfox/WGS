# !/usr/bin/env python3
# -*- coding: utf-8 -*-


# this script combines the two lines of variants from the two CAD datasets
# and adds a column to indicate if the variant is in both lines or exclusive to one line
# it also adds a column to indicate if the gene is in both lines or exclusive to one line

# %%
from all_funx import *

# %%
# import dfs from 1_clean_excel_summary.py
path  = "/Users/mariapalafox/Desktop/BOLDcaution/WGS/5-annotation/3-interpret/"

# %%
indel12 = pd.read_csv('1_clean_vep_output-indel-cad12-v2.csv', low_memory=False)
snp12 = pd.read_csv('1_clean_vep_output-snp-cad12-v2.csv', low_memory=False)
print(indel12.shape)
print(snp12.shape)
# %%
indel63 = pd.read_csv('1_clean_vep_output-indel-cad63-v2.csv', low_memory=False)
snp63 = pd.read_csv('1_clean_vep_output-snp-cad63-v2.csv', low_memory=False)
print(indel63.shape)
print(snp63.shape)

# %%
cad12 = pd.concat([indel12, snp12], axis=0)
cad63 = pd.concat([indel63, snp63], axis=0)
print(cad12.shape)
print(cad63.shape)

# %%

# create a list of unique 'Uploaded_variation' in both dataframes
cad12_variations = cad12['Uploaded_variation'].unique()
cad63_variations = cad63['Uploaded_variation'].unique()
# create a separate list for variations that are exclusively in cad12
cad12_exclusive_variations = list(set(cad12_variations) - set(cad63_variations))
# create a separate list for variations that are exclusively in cad63
cad63_exclusive_variations = list(set(cad63_variations) - set(cad12_variations))
# create a separate list for variations that are in both cad12 and cad63
common_variations = list(set(cad12_variations) & set(cad63_variations))
print( len(cad12_exclusive_variations), len(cad63_exclusive_variations), len(common_variations)) # 1525780 1730593 1970421
# %%
# Optimize the code by avoiding unnecessary function calls and repeated operations
cad12['var_in_both_lines'] = cad12['Uploaded_variation'].isin(common_variations)
cad12['var_exclusive_btw_lines'] = cad12['Uploaded_variation'].isin(cad12_exclusive_variations)
cad63['var_in_both_lines'] = cad63['Uploaded_variation'].isin(common_variations)
cad63['var_exclusive_btw_lines'] = cad63['Uploaded_variation'].isin(cad63_exclusive_variations)


# create a list of unique 'SYMBOL' in both dataframes
cad12_genes = cad12['SYMBOL'].unique()
cad63_genes = cad63['SYMBOL'].unique()
# create a separate list for SYMBOL that are exclusively in cad12
cad12_exclusive = list(set(cad12_genes) - set(cad63_genes))
# create a separate list for SYMBOL that are exclusively in cad63
cad63_exclusive = list(set(cad63_genes) - set(cad12_genes))
# create a separate list for SYMBOL that are in both cad12 and cad63
common_genes = list(set(cad12_genes) & set(cad63_genes))
cad12['gene_in_both_lines'] = cad12['SYMBOL'].isin(common_genes)
cad12['gene_exclusive_btw_lines'] = cad12['SYMBOL'].isin(cad12_exclusive)
cad63['gene_in_both_lines'] = cad63['SYMBOL'].isin(common_genes)
cad63['gene_exclusive_btw_lines'] = cad63['SYMBOL'].isin(cad63_exclusive)
print( len(cad12_exclusive), len(cad63_exclusive), len(common_genes)) #809 743 28137

# %%
save_describe(cad12, '4-cad12')
save_describe(cad63, '4-cad63')


# %%
print(cad12.columns)
print(cad12.shape)
"""
['Uploaded_variation', 'Location', 'Allele', 'Gene', 'Feature', 'Feature_type', 'Consequence', 'cDNA_position', 'CDS_position', 'Protein_position', 'Amino_acids', 'Codons', 'Existing_variation', 'IND', 'ZYG', 'REF_ALLELE', 'IMPACT', 'DISTANCE', 'STRAND', 'FLAGS', 'VARIANT_CLASS', 'SYMBOL', 'SYMBOL_SOURCE', 'HGNC_ID', 'BIOTYPE', 'CANONICAL', 'MANE_SELECT', 'MANE_PLUS_CLINICAL', 'TSL', 'APPRIS', 'CCDS', 'ENSP', 'SWISSPROT', 'TREMBL', 'UNIPARC', 'UNIPROT_ISOFORM', 'REFSEQ_MATCH', 'SOURCE', 'REFSEQ_OFFSET', 'GIVEN_REF', 'USED_REF', 'BAM_EDIT', 'GENE_PHENO', 'SIFT', 'PolyPhen', 'EXON', 'INTRON', 'DOMAINS', 'miRNA', 'HGVSc', 'HGVSp', 'HGVS_OFFSET', 'gnomADg_AF', 'gnomADg_AFR_AF', 'gnomADg_AMI_AF', 'gnomADg_AMR_AF', 'gnomADg_ASJ_AF', 'gnomADg_EAS_AF', 'gnomADg_FIN_AF', 'gnomADg_MID_AF', 'gnomADg_NFE_AF', 'gnomADg_OTH_AF', 'gnomADg_SAS_AF', 'MAX_AF', 'MAX_AF_POPS', 'CLIN_SIG', 'SOMATIC', 'PHENO', 'PUBMED', 'MOTIF_NAME', 'MOTIF_POS', 'HIGH_INF_POS', 'MOTIF_SCORE_CHANGE',
       'TRANSCRIPTION_FACTORS', 'chromosome', 'chrCoordinate', 'EXONnumber', 'INTRONnumber', 'chr', 'GIVEN_REF_MATCH', 'SIFTprediction', 'SIFTscore', 'PolyPhenprediction', 'PolyPhenscore', 'keyID38', 'var_in_both_lines', 'var_exclusive_btw_lines', 'gene_in_both_lines', 'gene_exclusive_btw_lines'],
      dtype='object')
(3496201, 89)
"""

# %%
print(cad63.columns)
print(cad63.shape)
"""(3701014, 89)"""

# %%
# fix column names by replacing _ with .
cad12.columns = cad12.columns.str.replace('_', '.')
cad63.columns = cad63.columns.str.replace('_', '.')


print(cad63.columns)
"""'Uploaded.variation', 'Location', 'Allele', 'Gene', 'Feature', 'Feature.type', 'Consequence', 'cDNA.position', 'CDS.position', 'Protein.position', 'Amino.acids', 'Codons', 'Existing.variation', 'IND', 'ZYG', 'REF.ALLELE', 'IMPACT', 'DISTANCE', 'STRAND', 'FLAGS', 'VARIANT.CLASS', 'SYMBOL', 'SYMBOL.SOURCE', 'HGNC.ID', 'BIOTYPE', 'CANONICAL', 'MANE.SELECT', 'MANE.PLUS.CLINICAL', 'TSL', 'APPRIS', 'CCDS', 'ENSP', 'SWISSPROT', 'TREMBL', 'UNIPARC', 'UNIPROT.ISOFORM', 'REFSEQ.MATCH', 'SOURCE', 'REFSEQ.OFFSET', 'GIVEN.REF', 'USED.REF', 'BAM.EDIT', 'GENE.PHENO', 'SIFT', 'PolyPhen', 'EXON', 'INTRON', 'DOMAINS', 'miRNA', 'HGVSc', 'HGVSp', 'HGVS.OFFSET', 'gnomADg.AF', 'gnomADg.AFR.AF', 'gnomADg.AMI.AF', 'gnomADg.AMR.AF', 'gnomADg.ASJ.AF', 'gnomADg.EAS.AF', 'gnomADg.FIN.AF', 'gnomADg.MID.AF', 'gnomADg.NFE.AF', 'gnomADg.OTH.AF', 'gnomADg.SAS.AF', 'MAX.AF', 'MAX.AF.POPS', 'CLIN.SIG', 'SOMATIC', 'PHENO', 'PUBMED', 'MOTIF.NAME', 'MOTIF.POS', 'HIGH.INF.POS', 'MOTIF.SCORE.CHANGE',
       'TRANSCRIPTION.FACTORS', 'chromosome', 'chrCoordinate', 'EXONnumber', 'INTRONnumber', 'chr', 'GIVEN.REF.MATCH', 'SIFTprediction', 'SIFTscore', 'PolyPhenprediction', 'PolyPhenscore', 'keyID38', 'var.in.both.lines', 'var.exclusive.btw.lines', 'gene.in.both.lines', 'gene.exclusive.btw.lines"""


# %%
# add MAF column to  dataframes, if MAX.AF is < 0.01 label Rare, if its less than 0.1 label less common, if its greater than or equal  to 0.1 label common, else label empty string
cad12['MAF'] = np.select([cad12['MAX.AF'] < 0.01, 
                          (cad12['MAX.AF'] >= 0.01) & (cad12['MAX.AF'] < 0.1),
                            cad12['MAX.AF'] >= 0.1], 
                            ['Rare (<1%)', 'Less common (<10%)', 'Common (>=10%)'], 
                            default = np.nan)

cad63['MAF'] = np.select([cad63['MAX.AF'] < 0.01, 
                          (cad63['MAX.AF'] >= 0.01) & (cad63['MAX.AF'] < 0.1), 
                          cad63['MAX.AF'] >= 0.1], 
                          ['Rare (<1%)', 'Less common (<10%)', 'Common (>=10%)'], 
                          default = np.nan)

# %%
# convert the R code into python
cad12['MAF2'] = np.select([cad12['MAX.AF'] < 0.05, 
                           cad12['MAX.AF'] >= 0.05], 
                           ['Rare (<5%)', 'Common (>=5%)'],
                            default=np.nan)

cad63['MAF2'] = np.select([cad63['MAX.AF'] < 0.05, 
                           cad63['MAX.AF'] >= 0.05], 
                           ['Rare (<5%)', 'Common (>=5%)'], 
                           default=np.nan)


# %%
# functionn that checks CLIN.SIG column for rows containing 'pathogenic' or 'likely pathogenic' and creates new column with 'PATHO' label. the new column should also  contain 'VUS' and 'BENIGN' labels if the row contain 'benign' for 'BENIGN' and 'uncertain significance' for 'VUS'.

def label_clin_sig(df):
    df['PATHO'] = df['CLIN.SIG'].str.contains('pathogenic|likely pathogenic', case=False)
    df['VUS'] = df['CLIN.SIG'].str.contains('uncertain_significance', case=False)
    df['BENIGN'] = df['CLIN.SIG'].str.contains('benign|likely_benign', case=False)
    return df


# new function creates one column with new labels based on rule heirarchy; if pathogenic or likely pathogenic then labeled PATHO else if uncertain_significance then VUS else if benign or likely benign then BENIGN
def label_clin_sig2(df):
    newcol = []
    for row in df.itertuples():
        if row.PATHO:
            newcol.append('PATHO')
        elif row.VUS:
            newcol.append('VUS')
        elif row.BENIGN:
            newcol.append('BENIGN')
        else:
            newcol.append(np.nan) # append nan value instead of '' emptry string
    df['ClinVar'] = newcol
    return df


# %%
# label ClinVar using not star reviewed system, over-estimates number of pathogenic variants
cad12 = label_clin_sig(cad12)
cad12 = label_clin_sig2(cad12)
checkColumnValue(cad12, 'ClinVar')

# %%
# label ClinVar using not star reviewed system, over-estimates number of pathogenic variants
cad63 = label_clin_sig(cad63)
cad63 = label_clin_sig2(cad63)
checkColumnValue(cad63, 'ClinVar')

# %%
patho12 = cad12[cad12['ClinVar'] == 'PATHO']
crosstabit(cad12, 'IND', 'ClinVar', True)


# %%
patho63 = cad63[cad63['ClinVar'] == 'PATHO']
crosstabit(cad63, 'IND', 'ClinVar', True)

# %%
patho12.head()

# %%
patho63.head()

# %%
# create a new column 'Database' in both dataframes, if MAX.AF is not NA and ClinVar is NA label 'gnomAD', if ClinVar is not NA and MAX.AF is NA label 'ClinVar', if both are not NA label 'gnomAD & ClinVar', else label 'No DB source'
cad12['Database'] = np.select([cad12['ClinVar'].notna() & cad12['MAX.AF'].isna(), 
                                  cad12['MAX.AF'].notna() & cad12['ClinVar'].isna(), 
                                  cad12['MAX.AF'].notna() & cad12['ClinVar'].notna(), 
                                  cad12['MAX.AF'].isna() & cad12['ClinVar'].isna()], 
                                  ['ClinVar', 'gnomAD', 'gnomAD & ClinVar', 'No DB source'], 
                                  default = np.nan)
checkColumnValue(cad12, 'Database')

# %%
cad63['Database'] = np.select([cad63['ClinVar'].notna() & cad63['MAX.AF'].isna(), 
                                  cad63['MAX.AF'].notna() & cad63['ClinVar'].isna(), 
                                  cad63['MAX.AF'].notna() & cad63['ClinVar'].notna(), 
                                  cad63['MAX.AF'].isna() & cad63['ClinVar'].isna()], 
                                  ['ClinVar', 'gnomAD', 'gnomAD & ClinVar', 'No DB source'], 
                                  default = np.nan)
checkColumnValue(cad63, 'Database')


# %%
print(cad12.shape)
print(cad63.shape)

# %%
cad12.to_csv('4-cad12-snv-indel-3496201.csv', index=False)
cad63.to_csv('4-cad63-snv-indel-3701014.csv', index=False)


# %%
crosstabit(cad12, 'MAF', 'Database', True)

# %%
crosstabit(cad63, 'MAF', 'Database', True)




# note 
# 1. note the clinvar col with labels is not star reviewed, check the clin.sig column to confirm high confidence pathogenicity
# 2. added Database column here instead of in R to keep all label functions together in python
# 3. keyID38 is only for SNVs
# 4. var.in.both.lines has T/F values
# 5. gene.in.both.lines has T/F values
# 6. MAF is based on MAX.AF column
