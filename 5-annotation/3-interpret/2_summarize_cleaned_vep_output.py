# !/usr/bin/env python3
# -*- coding: utf-8 -*-

# 2_summarize_cleaned_vep_output.py

# note: this script outputs excel files with 4 sheets unless its a sift or polyphen summary which has 2 sheets. note-the rows that had a flag for used ref different from given ref were not dropped from the dataframes, but you should look into this further-its not many rows-see symbol value counts for info.

# input:  output of 1_clean_excel_summary.py
# output: excel multi-sheet files per column

"""
# save_colValueCount('Feature_type', dfs, dfnames, path, True):
# output:  colname-checkValueCount.xlsx
    Feature_type
    Consequence
    ZYG
    IMPACT
    VARIANT_CLASS
    SYMBOL
    SYMBOL_SOURCE
    BIOTYPE
    SIFT
    PolyPhen
    CLIN_SIG
    PHENO
    SOMATIC
    # new in v3 not in v2 #
    chr
    Allele
    REF_ALLELE
    Amino_acids
    Gene
    STRAND
    FLAGS
    SWISSPROT
    GENE_PHENO
    MAX_AF_POPS
    HIGH_INF_POS
    MOTIF_NAME
"""

# %%
from all_funx import *

# %%
# import
indel12 = pd.read_csv('1_clean_vep_output-indel-cad12-v2.csv')
indel63 = pd.read_csv('1_clean_vep_output-indel-cad63-v2.csv')
snp12 = pd.read_csv('1_clean_vep_output-snp-cad12-v2.csv')
snp63 = pd.read_csv('1_clean_vep_output-snp-cad63-v2.csv')

dfs = [indel12, indel63, snp12, snp63]
dfnames = ["indel12", "indel63", "snp12", "snp63"]
snps = [snp12, snp63]
snpnames = ["snp12", "snp63"]
# %%
# QC total genes in dfs made with fillter given_ref_match == False
indel12_false = indel12[indel12['GIVEN_REF_MATCH'] == False]
snp12_false = snp12[snp12['GIVEN_REF_MATCH'] == False]
indel63_false = indel63[indel63['GIVEN_REF_MATCH'] == False]
snp63_false = snp63[snp63['GIVEN_REF_MATCH'] == False]
dfs_false = [indel12_false, indel63_false, snp12_false, snp63_false]
dfnames_false = ["indel12_false", "indel63_false", "snp12_false", "snp63_false"]

# %%
# output file path
path  = "/Users/mariapalafox/Desktop/BOLDcaution/WGS/5-annotation/3-interpret/2-summarize-v4/"

# %%
def save_colValueCount(colname, dfs, dfnames, PATH):
    #  funxtion to save value counts of a column in a multi-sheet excel
    #  dfs: list of dataframes
    #  dfnames: list of names of dataframes
    #  colname: name of column to check value counts
    #  PATH: path to save excel
    output =  PATH + colname + '-checkValueCount' + '.xlsx'
    with pd.ExcelWriter(output) as writer:
        for x, df in enumerate(dfs):
            dfname = dfnames[x]
            print(dfname)
            # function call
            colval = checkColumnValue(df, colname)
            # save excel sheet
            colval.to_excel(writer, sheet_name = dfname)
    print('done saving multi-sheet excel : ',  output)

# %%
def save_dtypes(dfs, dfnames, PATH):
    #  dfs: list of dataframes
    #  dfnames: list of names of dataframes
    #  colname: name of column to check value counts
    #  PATH: path to save excel
    output =  PATH + 'dtypes' + '.xlsx'
    with pd.ExcelWriter(output) as writer:
        for x, df in enumerate(dfs):
            dfname = dfnames[x]
            print(dfname)
            # function call
            typedf = df.dtypes
            # save excel sheet
            typedf.to_excel(writer, sheet_name = dfname)
    print('done saving multi-sheet excel : ',  output)
    
# %%
def save_describeNumeric(dfs, dfnames, PATH):
    #  dfs: list of dataframes
    #  dfnames: list of names of dataframes
    #  colname: name of column to check value counts
    #  PATH: path to save excel
    output =  PATH + 'describeNumeric' + '.xlsx'
    with pd.ExcelWriter(output) as writer:
        for x, df in enumerate(dfs):
            dfname = dfnames[x]
            print(dfname)
            # function call
            desdf = df.describe(include='number')
            describee = pd.DataFrame(desdf).T
            # save excel sheet
            describee.to_excel(writer, sheet_name = dfname)
    print('done saving multi-sheet excel : ',  output)

# %%
def save_describeNull(dfs, dfnames, PATH):
    #  dfs: list of dataframes
    #  dfnames: list of names of dataframes
    #  colname: name of column to check value counts
    #  PATH: path to save excel
    output =  PATH + 'describeNull' + '.xlsx'
    with pd.ExcelWriter(output) as writer:
        nan_column_from_1 =['cDNA_position', 'CDS_position', 'Protein_position', 'DISTANCE', 'EXONnumber', 'INTRONnumber', 'gnomADg_AF', 'gnomADg_AFR_AF', 'gnomADg_AMI_AF', 'gnomADg_AMR_AF', 'gnomADg_ASJ_AF', 'gnomADg_EAS_AF', 'gnomADg_FIN_AF', 'gnomADg_MID_AF', 'gnomADg_NFE_AF', 'gnomADg_OTH_AF', 'gnomADg_SAS_AF','MAX_AF', 'CLIN_SIG']
        for x, df in enumerate(dfs):
            dfname = dfnames[x]
            print(dfname)
            # function call
            df_with_nan = df[nan_column_from_1].copy()
            sumdf = df_with_nan.isna().sum()
            # save excel sheet
            sumdf.to_excel(writer, sheet_name = dfname)
    print('done saving multi-sheet excel : ',  output)

# %%
def save_uniqueCount(col, dfs, dfnames, PATH):
    #  dfs: list of dataframes
    #  dfnames: list of names of dataframes
    #  colname: name of column to check value counts
    #  PATH: path to save excel
    output =  PATH + 'uniqueCount-' + col + '.xlsx'
    with pd.ExcelWriter(output) as writer:
        for x, df in enumerate(dfs):
            dfname = dfnames[x]
            print(dfname)
            # function call
            allCol =  []
            uniqCol = []
            lengthAll = len(df[col])
            lengthUniq = len(df[col].unique())
            colname1 = 'total_' + col
            colname2 = 'unique_' + col
            allCol.append(colname1)
            uniqCol.append(colname2)
            allCol.append(lengthAll)
            uniqCol.append(lengthUniq)
            uniqueDF = pd.DataFrame([allCol, uniqCol])
            # save excel sheet
            uniqueDF.to_excel(writer, sheet_name=dfname)
    print('done saving multi-sheet excel : ',  output)

# %%
def save_crossTabIt(col1, col2, dfs, dfnames, PATH):
    # funx to save crosstab of columns in a sheet of an excel
    # col1: column name
    # col2: column name
    # dfs: list of dataframes
    # dfnames: list of names of dataframes
    output =  PATH + 'crossTabIt-' + col1 + '-' + col2 + '.xlsx'
    with pd.ExcelWriter(output) as writer:
        for x, df in enumerate(dfs):
            dfname = dfnames[x]
            print(dfname)
            # function call
            x1, s1 = save_crosstabit_sheet(df, col1, col2, True)
            x1.to_excel(writer, sheet_name = dfname)
    print('done saving multi-sheet excel : ',  output)

# %%
# dtypes
save_dtypes(dfs, dfnames, path)

# %%
# describeNumberic
save_describeNumeric(dfs, dfnames, path)

# %%
# describeNull
save_describeNull(dfs, dfnames, path)

# %%
# unique values
count_unique_value_columns = ['Gene','SYMBOL', 'CCDS', 'Feature', 'ENSP','SWISSPROT']
for i in count_unique_value_columns:
    save_uniqueCount(i, dfs, dfnames, path)
save_uniqueCount('keyID38', snps, snpnames, path)  # keyID38 is only in snp dfs

# %%
# cross tab
# be consistent with order of sift and polyphen
# add feature_type
save_crossTabIt("CLIN_SIG", "ZYG", dfs, dfnames, path)
save_crossTabIt("IMPACT", "ZYG", dfs, dfnames, path)
save_crossTabIt("Consequence", "ZYG", dfs, dfnames, path)
save_crossTabIt("Consequence", "IMPACT", dfs, dfnames, path)
save_crossTabIt("SYMBOL", "IMPACT", dfs, dfnames, path)
save_crossTabIt("SYMBOL", "Consequence", dfs, dfnames, path)

# #snp only
save_crossTabIt("SIFTprediction", "ZYG", snps, snpnames, path)
save_crossTabIt("PolyPhenprediction", "ZYG", snps, snpnames, path)
save_crossTabIt("SIFTprediction", "Consequence", snps, snpnames, path)
save_crossTabIt("PolyPhenprediction", "Consequence", snps, snpnames, path)
save_crossTabIt("SIFTprediction", "SYMBOL", snps, snpnames, path)
# %%
save_crossTabIt("PolyPhenprediction", "SYMBOL", snps, snpnames, path)
# this did not run becuase of on error i think i may need to restart and run again to fix but for time i will skip doing this for now
# %%
save_crossTabIt("SIFTprediction", "Feature_type", snps, snpnames, path)
save_crossTabIt("PolyPhenprediction", "Feature_type", snps, snpnames, path)
save_crossTabIt("SIFTprediction", "IMPACT", snps, snpnames, path)
save_crossTabIt("PolyPhenprediction", "IMPACT", snps, snpnames, path)
save_crossTabIt("SIFTprediction", "CLIN_SIG", snps, snpnames, path)
save_crossTabIt("PolyPhenprediction", "CLIN_SIG", snps, snpnames, path)



# %%
# check Column Value calls
save_colValueCount('SYMBOL', dfs_false, dfnames_false, path) # QC
save_colValueCount('Feature_type', dfs, dfnames, path)
save_colValueCount('Consequence', dfs, dfnames, path)
save_colValueCount('ZYG', dfs, dfnames, path)
save_colValueCount('IMPACT', dfs, dfnames, path)
save_colValueCount('VARIANT_CLASS', dfs, dfnames, path)
save_colValueCount('SYMBOL', dfs, dfnames, path)
save_colValueCount('SYMBOL_SOURCE', dfs, dfnames, path)
save_colValueCount('BIOTYPE', dfs, dfnames, path)
save_colValueCount('GIVEN_REF_MATCH', dfs, dfnames, path)
save_colValueCount('CLIN_SIG', dfs, dfnames, path)
save_colValueCount('PHENO', dfs, dfnames, path)
save_colValueCount('SOMATIC', dfs, dfnames, path)
#### new check values #########
save_colValueCount('chr', dfs, dfnames, path)
save_colValueCount('Allele', dfs, dfnames, path)
save_colValueCount('REF_ALLELE', dfs, dfnames, path)
save_colValueCount('Amino_acids', dfs, dfnames, path)
save_colValueCount('Gene', dfs, dfnames, path)
save_colValueCount('STRAND', dfs, dfnames,path)
save_colValueCount('FLAGS', dfs, dfnames, path)
save_colValueCount('SWISSPROT', dfs, dfnames, path)
save_colValueCount('GENE_PHENO', dfs, dfnames, path)
save_colValueCount('MAX_AF_POPS', dfs, dfnames, path)
save_colValueCount('HIGH_INF_POS', dfs, dfnames, path)
save_colValueCount('MOTIF_NAME', dfs, dfnames, path)

# %%
####### snps only ########
save_colValueCount('SIFTprediction', snps, snpnames, path)
save_colValueCount('PolyPhenprediction', snps, snpnames, path)



# %%
#################### crosstabit ##########################################
# save_crossTabIt_snp(snp12, 'snp12', path)
# save_crossTabIt_snp(snp63, 'snp63', path)
# save_crossTabIt_indel(indel12, 'indel12', path)
# save_crossTabIt_indel(indel63, 'indel63', path)

def save_crossTabIt_indel(i, dfname, PATH):
        # indel func does not include SIFTprediction and PolyPhenprediction
    # funx to save crosstab of columns in a sheet of an excel
    # i: dataframe
    # dfname: name of dataframe
    output =  PATH + dfname + '-crossTabIt' + '.xlsx'
    # crosstab of columns
    x1,s1 = save_crosstabit_sheet(i,"CLIN_SIG", "ZYG", True)
    x2,s2 = save_crosstabit_sheet(i,"IMPACT", "ZYG", True)
    x7,s7 = save_crosstabit_sheet(i,"Consequence", "ZYG", True)
    x8,s8 = save_crosstabit_sheet(i,"Consequence", "IMPACT", True)
    x6,s6 = save_crosstabit_sheet(i, "SYMBOL", "IMPACT", True)
    x11,s11 = save_crosstabit_sheet(i,"SYMBOL", "Consequence", True)
    with pd.ExcelWriter(output) as writer:
        x1.to_excel(writer, sheet_name=s1)
        x2.to_excel(writer, sheet_name=s2)
        x7.to_excel(writer, sheet_name=s7)
        x8.to_excel(writer, sheet_name=s8)
        x6.to_excel(writer, sheet_name=s6)
        x11.to_excel(writer, sheet_name=s11)
    print('saved as :', output)
def save_crossTabIt_snp(i, dfname, PATH):
    # snp func include SIFTprediction and PolyPhenprediction
    # funx to save crosstab of columns in a sheet of an excel
    # i: dataframe
    # dfname: name of dataframe
    # write objects to separate sheets of an excel 
    output =  PATH + dfname + '-crossTabIt' + '.xlsx'
    # crosstab of columns
    x1,s1 = save_crosstabit_sheet(i,"CLIN_SIG", "ZYG", True)
    x2,s2 = save_crosstabit_sheet(i,"IMPACT", "ZYG", True)
    x3,s3 = save_crosstabit_sheet(i,"SIFTprediction", "ZYG", True)
    x4,s4 = save_crosstabit_sheet(i,"PolyPhenprediction", "ZYG", True)
    x7,s7 = save_crosstabit_sheet(i,"Consequence", "ZYG", True)
    x8,s8 = save_crosstabit_sheet(i,"Consequence", "IMPACT", True)
    x9,s9 = save_crosstabit_sheet(i,"Consequence", "SIFTprediction", True)
    x10,s10 = save_crosstabit_sheet(i,"Consequence", "PolyPhenprediction", True)
    x6,s6 = save_crosstabit_sheet(i, "SYMBOL", "IMPACT", True)
    x11,s11 = save_crosstabit_sheet(i,"SYMBOL", "Consequence", True)
    x12,s12 = save_crosstabit_sheet(i,"SYMBOL", "SIFTprediction", True)
    x13,s13 = save_crosstabit_sheet(i,"SYMBOL", "PolyPhenprediction", True)
    with pd.ExcelWriter(output) as writer:
        # get unique values for list of df columns
        x1.to_excel(writer, sheet_name=s1)
        x2.to_excel(writer, sheet_name=s2)
        x3.to_excel(writer, sheet_name=s3)
        x4.to_excel(writer, sheet_name=s4)
        x7.to_excel(writer, sheet_name=s7)
        x8.to_excel(writer, sheet_name=s8)
        x9.to_excel(writer, sheet_name=s9)
        x10.to_excel(writer, sheet_name=s10)
        x6.to_excel(writer, sheet_name=s6)
        x11.to_excel(writer, sheet_name=s11)
        x12.to_excel(writer, sheet_name=s12)
        x13.to_excel(writer, sheet_name=s13)
    print('saved as :', output)


# summarize dataframes v3 
def save_colValueCount_return(colname, dfs, dfnames, PATH, returnListDfs):
    #  funxtion to save value counts of a column in a multi-sheet excel
    #  dfs: list of dataframes
    #  dfnames: list of names of dataframes
    #  colname: name of column to check value counts
    #  PATH: path to save excel
    # return: True or False to return list of dfs
    output_checkvalue =  PATH + colname + '-checkValueCount' + '.xlsx'
    return_results = []
    with pd.ExcelWriter(output_checkvalue) as writer:
        for x, df in enumerate(dfs):
            dfname = dfnames[x]
            # function call
            colval = checkColumnValue(df, colname)
            colval.to_excel(writer, sheet_name = dfname)
            return_results.append(colval)
    print()
    print('saved multi-sheet excel as ',  output_checkvalue)
    print('return list of dfs length: ', len(return_results))
    if returnListDfs:
        print('returning list of dfs..')
        return return_results
    else:
        print('returning None..')
        print()
        return None