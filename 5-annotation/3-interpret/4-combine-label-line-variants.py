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
keepme = ["Uploaded_variation",
"Feature_type",
"Consequence",
"Protein_position",
"Amino_acids",
"Existing_variation",
"IND",
"ZYG",
"IMPACT",
"DISTANCE",
"STRAND",
"VARIANT_CLASS",
"SYMBOL",
"BIOTYPE",
"SWISSPROT",
"GENE_PHENO",
"EXON",
"INTRON",
"DOMAINS",
"miRNA",
"gnomADg_AF",
"gnomADg_AFR_AF",
"gnomADg_AMI_AF",
"gnomADg_AMR_AF",
"gnomADg_ASJ_AF",
"gnomADg_EAS_AF",
"gnomADg_FIN_AF",
"gnomADg_MID_AF",
"gnomADg_NFE_AF",
"gnomADg_OTH_AF",
"gnomADg_SAS_AF",
"MAX_AF",
"MAX_AF_POPS",
"CLIN_SIG",
"PUBMED",
"MOTIF_NAME",
"HIGH_INF_POS",
"MOTIF_SCORE_CHANGE",
"TRANSCRIPTION_FACTORS",
"EXONnumber",
"INTRONnumber"]

keepme2 = keepme + ["SIFTprediction","SIFTscore", "PolyPhenprediction", "PolyPhenscore"]

# made note of columns dropped from this step
# indel12 = pd.read_csv('1_clean_vep_output-indel-cad12-v2.csv', usecols = keepme )
# snp12 = pd.read_csv('1_clean_vep_output-snp-cad12-v2.csv', usecols = keepme2)
# indel63 = pd.read_csv('1_clean_vep_output-indel-cad63-v2.csv', usecols = keepme )
# snp63 = pd.read_csv('1_clean_vep_output-snp-cad63-v2.csv', usecols = keepme2)

# %%
indel12 = pd.read_csv('1_clean_vep_output-indel-cad12-v2.csv', low_memory=False)
snp12 = pd.read_csv('1_clean_vep_output-snp-cad12-v2.csv', low_memory=False)
indel63 = pd.read_csv('1_clean_vep_output-indel-cad63-v2.csv', low_memory=False)
snp63 = pd.read_csv('1_clean_vep_output-snp-cad63-v2.csv', low_memory=False)


# %%
cad12 = pd.concat([indel12, snp12], axis=0)
cad63 = pd.concat([indel63, snp63], axis=0)


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
cad12.to_csv('4-cad12-snv-indel-3496201.csv', index=False)
cad63.to_csv('4-cad63-snv-indel-3701014.csv', index=False)



############## simple df for v1 of plots ######################

# %%
useme = ['Uploaded.variation', 'Feature.type','chr', 'SYMBOL', 'HGVSc', 'HGVSp',
         'var.in.both.lines', 'var.exclusive.btw.lines', 
         'gene.in.both.lines', 'gene.exclusive.btw.lines', 
         'IMPACT', 'VARIANT.CLASS',
         'SIFTprediction', 'SIFTscore', 
         'PolyPhenprediction', 'PolyPhenscore', 
         'MAX.AF', 'MAX.AF.POPS',
          'DOMAINS','miRNA',
            'Consequence', 'Amino.acids', 
             'CLIN.SIG', 'Existing.variation', 'SOMATIC', 'PHENO', 'PUBMED',
             'IND', 'ZYG', 'BIOTYPE',
         'EXON','TRANSCRIPTION.FACTORS']


simple12 = cad12[useme].copy()
simple63 = cad63[useme].copy()


final = pd.concat([simple12, simple63], axis=0)
print(final.shape) # (7197215, 32)


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
            newcol.append('NA')
    df['ClinVar'] = newcol
    return df

final1 = label_clin_sig(final)
final2 = label_clin_sig2(final1)

print(final2.tail())

# %%
final2[final2['ClinVar'] == 'PATHO']
crosstabit(final2, 'IND', 'ClinVar', True)


# %%
# RMD dataset
final2.to_csv('4-both-cad12-cad63-useCol-7197215.csv', index=False)


# %%

# most important features at gene level to add are interaction count, expression tissue to see if its relevant to EC vascular, and if its csvd proteins or in any curations ive made involving ROS and antioxidants

# get universe file, select usecols of most important features, 
# label universe using kegg pathway subsets T/F
# label universe using csvd panel genes
# map labels to cad12 cad63 genes


# gene_lists = pd.read_csv('4-figures/Interest_v1_geneLists_72_genes_mapped_to_16k_universe.csv')
# print(gene_lists.columns)

# gene_lists = renameit(gene_lists, 'HGNCsymbol', 'SYMBOL')

# # %%

# gene_list_filter = ['SYMBOL','interaction.count', 'MOEUF', 'LOEUF', 'proteinopathy', 'muino', 'Jonah', 'young', 'other', 'vandam', 'INTEREST']

# gene_lists = gene_lists[gene_list_filter]

# finalgene_list = pd.merge(final, gene_lists, on='SYMBOL', how='left')

# finalgene_list.to_csv('4-combined-usecols-cad12-63.csv', index=False)

# print(finalgene_list.head())

# # %% 

# ipsc = finalgene_list.copy()


# 'UKBID.HGNC', 'UKBID', 'HGNCsymbol', 'HGNC.ID', 'HGNC.approved.genename', 'ENSGv92', 'UKBIDmapsToMultipleGeneSymbols', 'gene.primary.uniprot', 'gene.synonyms.uniprot', 'protein.names.uniprot', 'CpD.protein', 'CpDC.count', 'CpDK.count', 'CpDY.count', 'CpDC.protein', 'CpDK.protein', 'CpDY.protein', 'CpDCKY.protein', 'FDAtarget.HPA2021', 'ClinVar2021.anyPATHO', 'ClinVar2021miss.PATHO', 'ClinVar2021miss.VUS', 'BENIGN', 'PATHO', 'VUS', 'VUS.and.Detected', 'PATHO.and.Detected', 'Mendelian2021', 'Mendelian.and.Detected', 'MIM Number', 'phenotypeCount', 'phenotypesParsed', 'phenoKeysParsed', 'MimNumberParsed', 'inheritanceParsed', 'inheritanceParsedSet', 'Homo.LoF.tolerant.Lek2016', 'Essential.CRISPR.Hart2017', 'NonEssential.CRISPR.Hart2017', 'obs.mis', 'exp.mis', 'oe.mis', 'MOEUF', 'SOEUF', 'obs.lof', 'exp.lof', 'oe.lof', 'LOEUF', 'pLI', 'HaploinsuffLv3.ClinGen2021', 'Essential.mouse.Blake2011', 'GWAS.peak.MacArthur2017', 'Olfactory.Mainland2015', 'Kinase.Uniprot2018',
#        'GPCR.union.Uniprot2018', 'GPI.anchored.Uniprot2017', 'DRG.union.WoodKang', 'chr', 'CCDS.id', 'Refseq.id', 'ucsc.id', 'Function.description', 'Tissue.specificity.Uniprot', 'Expression.egenetics', 'TissueExpression.GNF.Atlas', 'Interactions.IntAct', 'Interactions.BioGRID', 'Interactions.ConsensusPathDB', 'Pathway.ConsensusPathDB', 'GO.biological.process', 'GO.molecular.function', 'GO.cellular.component', 'Orphanet.disorder.id', 'Orphanet.disorder', 'Orphanet.association.type', 'Trait.association.GWAS', 'HPO.id', 'HPO.name', 'Known.rec.info', 'RVIS.EVS', 'RVIS.percentile.EVS', 'gnomAD.pRec', 'gnomAD.pNull', 'LoFtool.score', 'P.HI', 'HIPred.score', 'HIPred', 'GHIS', 'GDI', 'GDIPhred', 'SORVA.LOF.MAF0.005.HomOrCompoundHet', 'SORVA.LOF.MAF0.001.HetOrHom', 'SORVA.LOF.MAF0.001.HomOrCompoundHet', 'SORVA.LOForMissense.MAF0.005.HetOrHom', 'SORVA.LOForMissense.MAF0.005.HomOrCompoundHet', 'SORVA.LOForMissense.MAF0.001.HetOrHom', 'SORVA.LOForMissense.MAF0.001.HomOrCompoundHet',
#        'Essential.gene', 'Essential.gene.CRISPR', 'Essential.gene.CRISPR2', 'Essential.gene.genetrap', 'Gene.indispensability.score', 'Gene.indispensability.pred', 'MGI.mouse.gene', 'MGI.mouse.phenotype', 'No.function.descript', 'interaction.count', 'autism', 'DDD', 'cosmic', 'PathVar', 'disgenet.path', 'virus.interacting', 'metabolic.enzymes', 'ribosomal.protein.mitochondrial', 'ribosomal.protein.cytoplasmic', 'mitochondrial', 'LOEUF.decile.percent', 'MOEUF.decile.percent', 'SOEUF.decile.percent', 'LOEUF.0decile', 'MOEUF.0decile', 'SOEUF.0decile', 'LOEUF.lessthan0.35', 'MOEUF.lessthan0.35', 'SOEUF.lessthan0.35', 'TissueCount.GNF.Atlas', 'TissueCount.level', 'interaction.count.levels', 'Length', 'CodonNumber', 'GCpercent', 'GC1percent', 'GC2percent', 'GC3percent', 'A', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'V', 'W', 'Y', 'F.TTT', 'F.TTC', 'L.TTA', 'L.TTG', 'L.CTT', 'L.CTC', 'L.CTA', 'L.CTG', 'I.ATT', 'I.ATC', 'I.ATA', 'M.ATG', 'V.GTT',
#        'V.GTC', 'V.GTA', 'V.GTG', 'Y.TAT', 'Y.TAC', 'STOP.TAA', 'STOP.TAG', 'H.CAT', 'H.CAC', 'Q.CAA', 'Q.CAG', 'N.AAT', 'N.AAC', 'K.AAA', 'K.AAG', 'D.GAT', 'D.GAC', 'E.GAA', 'E.GAG', 'S.TCT', 'S.TCC', 'S.TCA', 'S.TCG', 'P.CCT', 'P.CCC', 'P.CCA', 'P.CCG', 'T.ACT', 'T.ACC', 'T.ACA', 'T.ACG', 'A.GCT', 'A.GCC', 'A.GCA', 'A.GCG', 'C.TGT', 'C.TGC', 'STOP.TGA', 'W.TGG', 'R.CGT', 'R.CGC', 'R.CGA', 'R.CGG', 'S.AGT', 'S.AGC', 'R.AGA', 'R.AGG', 'G.GGT', 'G.GGC', 'G.GGA', 'G.GGG', 'CRISPR.essential.3studies', ],
#       dtype='object')




