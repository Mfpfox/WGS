
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


%%
cad12['Database'] = np.select([cad12['ClinVar'].isin(qc_clinvar) & cad12['MAX.AF'].isna(), 
                                  cad12['MAX.AF'].isin(qc_gnomad) & cad12['ClinVar'].isna(), 
                                  cad12['MAX.AF'].isin(qc_gnomad) & cad12['ClinVar'].isin(qc_clinvar), 
                                  cad12['MAX.AF'].isna() & cad12['ClinVar'].isna()], 
                                  ['ClinVar', 'gnomAD', 'gnomAD & ClinVar', 'No DB source'], 
                                  default = np.nan)

cad63['Database'] = np.select([cad63['ClinVar'].isin(qc_clinvar) & cad63['MAX.AF'].isna(), 
                                  cad63['MAX.AF'].isin(qc_gnomad) & cad63['ClinVar'].isna(), 
                                  cad63['MAX.AF'].isin(qc_gnomad) & cad63['ClinVar'].isin(qc_clinvar), 
                                  cad63['MAX.AF'].isna() & cad63['ClinVar'].isna()], 
                                  ['ClinVar', 'gnomAD', 'gnomAD & ClinVar', 'No DB source'], 
                                  default = np.nan)

############## simple df for v1 of plots ######################

# # %%
# useme = ['Uploaded.variation', 'Feature.type','chr', 'SYMBOL', 'HGVSc', 'HGVSp',
#          'var.in.both.lines', 'var.exclusive.btw.lines', 
#          'gene.in.both.lines', 'gene.exclusive.btw.lines', 
#          'IMPACT', 'VARIANT.CLASS',
#          'SIFTprediction', 'SIFTscore', 
#          'PolyPhenprediction', 'PolyPhenscore', 
#          'MAX.AF', 'MAX.AF.POPS',
#           'DOMAINS','miRNA',
#             'Consequence', 'Amino.acids', 
#              'CLIN.SIG', 'Existing.variation', 'SOMATIC', 'PHENO', 'PUBMED',
#              'IND', 'ZYG', 'BIOTYPE',
#          'EXON','TRANSCRIPTION.FACTORS']


# simple12 = cad12[useme].copy()
# simple63 = cad63[useme].copy()


# final = pd.concat([simple12, simple63], axis=0)
# print(final.shape) # (7197215, 32)


# # %%
# # RMD dataset
# final2.to_csv('4-both-cad12-cad63-useCol-7197215.csv', index=False)


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




