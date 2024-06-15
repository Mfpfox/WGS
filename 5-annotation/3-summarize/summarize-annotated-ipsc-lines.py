# !/usr/bin/env python3
# -*- coding: utf-8 -*-

# input: individual WGS vep annotated output files for CAD12 and CAD63
# output: summary excel file that replicates vep html report summary

from all_funx import *

path = "/Users/mariapalafox/Desktop/BOLDcaution/WGS/5-annotation/3-summarize/1-input/"

indel1 = pd.read_csv(path + "annotated_indels_CAD12_autoX.txt", delimiter="\t", engine='python',\
                 comment='##')

snp1 = pd.read_csv(path + "annotated_snps_CAD12_autoX.txt", delimiter="\t", engine='python',\
                  comment='##')

indel6 = pd.read_csv(path + "annotated_indels_CAD63_autoX.txt", delimiter="\t", engine='python',\
                       comment='##')

snp6 = pd.read_csv(path + "annotated_snps_CAD63_autoX.txt", delimiter="\t", engine='python',\
                         comment='##')


# rename column
indel12 = renameit(indel1, '#Uploaded_variation', 'Uploaded_variation')
snp12 = renameit(snp1, '#Uploaded_variation', 'Uploaded_variation')
indel63 = renameit(indel6, '#Uploaded_variation', 'Uploaded_variation')
snp63 = renameit(snp6, '#Uploaded_variation', 'Uploaded_variation')

# split Location column on : to get chromosome and chrCoordinate new columns
indel12[['chromosome', 'chrCoordinate']] = indel12['Location'].str.split(':', expand=True)

snp12[['chromosome', 'chrCoordinate']] = snp12['Location'].str.split(':', expand=True)

indel63[['chromosome', 'chrCoordinate']] = indel63['Location'].str.split(':', expand=True)

snp63[['chromosome', 'chrCoordinate']] = snp63['Location'].str.split(':', expand=True)


# if chrCoordinate column contains "-", split the column on - to get start and end columns, change start and end columns to type int, else change chrCoordinate column values to type int
# NOTE the indel df  start position is being used as chrCoordinate and the start could actually be larger than end position depending on strand 

indel12['chrCoordinate'] = indel12['chrCoordinate'].str.split('-',expand=False).str[0]

indel12['chrCoordinate'] = indel12['chrCoordinate'].astype(int)

snp12['chrCoordinate'] = snp12['chrCoordinate'].astype(int)

indel63['chrCoordinate'] = indel63['chrCoordinate'].str.split('-',expand=False).str[0]

indel63['chrCoordinate'] = indel63['chrCoordinate'].astype(int)

snp63['chrCoordinate'] = snp63['chrCoordinate'].astype(int)

# strip the chromosome column to remove "chr" from the values
# indel12['chromosome'] = indel12['chromosome'].str.strip('chr')
# snp12['chromosome'] = snp12['chromosome'].str.strip('chr')
# indel63['chromosome'] = indel63['chromosome'].str.strip('chr')
# snp63['chromosome'] = snp63['chromosome'].str.strip('chr')

# change cDNA_position "-" values to nan 
indel12['cDNA_position'] = indel12['cDNA_position'].replace('-', np.nan)
snp12['cDNA_position'] = snp12['cDNA_position'].replace('-', np.nan)
indel63['cDNA_position'] = indel63['cDNA_position'].replace('-', np.nan)
snp63['cDNA_position'] = snp63['cDNA_position'].replace('-', np.nan)


# change CDS_position column values equal to "-" to nan
indel12['CDS_position'] = indel12['CDS_position'].replace('-', np.nan)
snp12['CDS_position'] = snp12['CDS_position'].replace('-', np.nan)
indel63['CDS_position'] = indel63['CDS_position'].replace('-', np.nan)
snp63['CDS_position'] = snp63['CDS_position'].replace('-', np.nan)


# change Protein_position column values equal to "-" to nan
indel12['Protein_position'] = indel12['Protein_position'].replace('-', np.nan)
snp12['Protein_position'] = snp12['Protein_position'].replace('-', np.nan)
indel63['Protein_position'] = indel63['Protein_position'].replace('-', np.nan)
snp63['Protein_position'] = snp63['Protein_position'].replace('-', np.nan)


# change DISTANCE column values equal to "-" to nan
indel12['DISTANCE'] = indel12['DISTANCE'].replace('-', np.nan)
snp12['DISTANCE'] = snp12['DISTANCE'].replace('-', np.nan)
indel63['DISTANCE'] = indel63['DISTANCE'].replace('-', np.nan)
snp63['DISTANCE'] = snp63['DISTANCE'].replace('-', np.nan)


# change "-" values in SIFT and PolyPhen columns to nan
# indel12['SIFT'] = indel12['SIFT'].replace('-', np.nan)
# snp12['SIFT'] = snp12['SIFT'].replace('-', np.nan)
# indel63['SIFT'] = indel63['SIFT'].replace('-', np.nan)
# snp63['SIFT'] = snp63['SIFT'].replace('-', np.nan)


# if SIFT column contains a value, split the column on "(" to get SIFTprediction and SIFTscore, remove ")" from SIFTscore and change SIFTscore to type float
snp12[['SIFTprediction', 'SIFTscore']] = snp12['SIFT'].str.split('(', 
                                                            expand=True)
snp12['SIFTscore'] = snp12['SIFTscore'].str.replace(')', '')
snp12['SIFTscore'] = snp12['SIFTscore'].astype(float)
snp63[['SIFTprediction', 'SIFTscore']] = snp63['SIFT'].str.split('(', 
                                                            expand=True)
snp63['SIFTscore'] = snp63['SIFTscore'].str.replace(')', '')
snp63['SIFTscore'] = snp63['SIFTscore'].astype(float)

# if PolyPhen column contains a value, split the column on "(" to get PolyPhenprediction and PolyPhenscore, remove ")" from PolyPhenscore and change PolyPhenscore to type float
snp12[['PolyPhenprediction', 'PolyPhenscore']] = snp12['PolyPhen'].str.split('(', expand=True)
snp12['PolyPhenscore'] = snp12['PolyPhenscore'].str.replace(')', '')
snp12['PolyPhenscore'] = snp12['PolyPhenscore'].astype(float)

snp63[['PolyPhenprediction', 'PolyPhenscore']] = snp63['PolyPhen'].str.split('(', expand=True)
snp63['PolyPhenscore'] = snp63['PolyPhenscore'].str.replace(')', '')
snp63['PolyPhenscore'] = snp63['PolyPhenscore'].astype(float)

# duplicate EXON and save as new column EXONnumber
indel12['EXONnumber'] = indel12['EXON']
snp12['EXONnumber'] = snp12['EXON']
indel63['EXONnumber'] = indel63['EXON']
snp63['EXONnumber'] = snp63['EXON']

# change EXONnumber and INTRONnumber columns values equal to "-" to nan
indel12['EXONnumber'] = indel12['EXONnumber'].replace('-', np.nan)
snp12['EXONnumber'] = snp12['EXONnumber'].replace('-', np.nan)
indel63['EXONnumber'] = indel63['EXONnumber'].replace('-', np.nan)
snp63['EXONnumber'] = snp63['EXONnumber'].replace('-', np.nan)

# split the EXONnumber and INTRONnumber column values on "/", retain only the value before the "/"
indel12['EXONnumber'] = indel12['EXONnumber'].str.split('/').str[0]
snp12['EXONnumber'] = snp12['EXONnumber'].str.split('/').str[0]
indel63['EXONnumber'] = indel63['EXONnumber'].str.split('/').str[0]
snp63['EXONnumber'] = snp63['EXONnumber'].str.split('/').str[0]

# duplicate INTRON column and save as new column INTRONnumber
indel12['INTRONnumber'] = indel12['INTRON']
snp12['INTRONnumber'] = snp12['INTRON']
indel63['INTRONnumber'] = indel63['INTRON']
snp63['INTRONnumber'] = snp63['INTRON']

# change INTRONnumber column values equal to "-" to nan
indel12['INTRONnumber'] = indel12['INTRONnumber'].replace('-', np.nan)
snp12['INTRONnumber'] = snp12['INTRONnumber'].replace('-', np.nan)
indel63['INTRONnumber'] = indel63['INTRONnumber'].replace('-', np.nan)
snp63['INTRONnumber'] = snp63['INTRONnumber'].replace('-', np.nan)

# split the INTRONnumber column values on "/", retain only the value before the "/"
indel12['INTRONnumber'] = indel12['INTRONnumber'].str.split('/').str[0]
snp12['INTRONnumber'] = snp12['INTRONnumber'].str.split('/').str[0]
indel63['INTRONnumber'] = indel63['INTRONnumber'].str.split('/').str[0]
snp63['INTRONnumber'] = snp63['INTRONnumber'].str.split('/').str[0]

# if column name contains "gnomAD", change the "-" values to nan 
for i in indel12.columns:
    if 'gnomAD' in i:
        indel12[i] = indel12[i].replace('-', np.nan)  
        indel12[i] = indel12[i].astype(float) 

for i in snp12.columns:
    if 'gnomAD' in i:
        snp12[i] = snp12[i].replace('-', np.nan)
        snp12[i] = snp12[i].astype(float)

for i in indel63.columns:
       if 'gnomAD' in i:
              indel63[i] = indel63[i].replace('-', np.nan)
              indel63[i] = indel63[i].astype(float)

for i in snp63.columns:
       if 'gnomAD' in i:
              snp63[i] = snp63[i].replace('-', np.nan)
              snp63[i] = snp63[i].astype(float)

# change the "-" values in column MAX_AF to nan
indel12['MAX_AF'] = indel12['MAX_AF'].replace('-', np.nan)
snp12['MAX_AF'] = snp12['MAX_AF'].replace('-', np.nan)
indel63['MAX_AF'] = indel63['MAX_AF'].replace('-', np.nan)
snp63['MAX_AF'] = snp63['MAX_AF'].replace('-', np.nan)

# change MAX_AF to type float
indel12['MAX_AF'] = indel12['MAX_AF'].astype(float)
snp12['MAX_AF'] = snp12['MAX_AF'].astype(float)
indel63['MAX_AF'] = indel63['MAX_AF'].astype(float)
snp63['MAX_AF'] = snp63['MAX_AF'].astype(float)

# change the "-" values in column CLIN_SIG to nan
indel12['CLIN_SIG'] = indel12['CLIN_SIG'].replace('-', np.nan)
snp12['CLIN_SIG'] = snp12['CLIN_SIG'].replace('-', np.nan)
indel63['CLIN_SIG'] = indel63['CLIN_SIG'].replace('-', np.nan)
snp63['CLIN_SIG'] = snp63['CLIN_SIG'].replace('-', np.nan)

print(indel12.dtypes)
print(snp12.dtypes)
print(indel63.dtypes)
print(snp63.dtypes)

# change to type float
indel12['EXONnumber'] = indel12['EXONnumber'].astype(float)
snp12['EXONnumber'] = snp12['EXONnumber'].astype(float)
indel63['EXONnumber'] = indel63['EXONnumber'].astype(float)
snp63['EXONnumber'] = snp63['EXONnumber'].astype(float)


def convert_to_float(df, col_list):
    # a function that takes a list of columns and dataframe and 
    # returns the dataframe with the columns converted to type float
    for i in col_list:
        df[i] = df[i].astype(float)
    return(df)

col_list = ['DISTANCE', 'INTRONnumber', 'EXONnumber']
indel12 = convert_to_float(indel12, col_list)
snp12 = convert_to_float(snp12, col_list)
indel63 = convert_to_float(indel63, col_list)
snp63 = convert_to_float(snp63, col_list)



def excel_summary_of_vep_dataframe(i, dfname):
    typedf = i.dtypes
    sumdf = i.isna().sum()
    desdf = i.describe(include='all')
    featureType = checkColumnValue(i, "Feature_type")
    conseq = checkColumnValue(i, "Consequence")
    zg = checkColumnValue(i, "ZYG")
    impact = checkColumnValue(i, "IMPACT")
    varclass = checkColumnValue(i, "VARIANT_CLASS")
    sym = checkColumnValue(i, "SYMBOL")
    sour = checkColumnValue(i, "SYMBOL_SOURCE")
    bio = checkColumnValue(i, "BIOTYPE")
    sift = checkColumnValue(i, "SIFT")
    polyphen = checkColumnValue(i, "PolyPhen")
    clin = checkColumnValue(i, "CLIN_SIG")
    pheno = checkColumnValue(i, "PHENO")
    som = checkColumnValue(i, "SOMATIC")
    x1,s1 = save_crosstabit_sheet(i,"CLIN_SIG", "ZYG", True)
    x2,s2 = save_crosstabit_sheet(i,"IMPACT", "ZYG", True)
    x3,s3 = save_crosstabit_sheet(i,"SIFT", "ZYG", True)
    x4,s4 = save_crosstabit_sheet(i,"PolyPhen", "ZYG", True)
    x5,s5 = save_crosstabit_sheet(i,"Consequence", "IMPACT", True)
    x6,s6 = save_crosstabit_sheet(i, "SYMBOL", "IMPACT", True)
    describee = pd.DataFrame(i.describe()).T
    checkna = i.isna().sum()
    # write objects to separate sheets of an excel 
    output = dfname + 'excel_summary_of_vep_dataframe.xlsx'
    with pd.ExcelWriter(output) as writer:
       typedf.to_excel(writer, sheet_name='datatypes')
       desdf.to_excel(writer, sheet_name='descriptive_stats')
       featureType.to_excel(writer, sheet_name='Feature_type')
       conseq.to_excel(writer, sheet_name='Consequence')
       zg.to_excel(writer, sheet_name='ZYG')
       impact.to_excel(writer, sheet_name='IMPACT')
       varclass.to_excel(writer, sheet_name='VARIANT_CLASS')
       sym.to_excel(writer, sheet_name='SYMBOL')
       sour.to_excel(writer, sheet_name='SYMBOL_SOURCE')
       bio.to_excel(writer, sheet_name='BIOTYPE')
       sift.to_excel(writer, sheet_name='SIFT')
       polyphen.to_excel(writer, sheet_name='PolyPhen')
       clin.to_excel(writer, sheet_name='CLIN_SIG')
       pheno.to_excel(writer, sheet_name='PHENO')
       som.to_excel(writer, sheet_name='SOMATIC')
       x1.to_excel(writer, sheet_name=s1)
       x2.to_excel(writer, sheet_name=s2)
       x3.to_excel(writer, sheet_name=s3)
       x4.to_excel(writer, sheet_name=s4)
       x5.to_excel(writer, sheet_name=s5)
       x6.to_excel(writer, sheet_name=s6)
       describee.to_excel(writer, sheet_name='describeFloat')
       checkna.to_excel(writer, sheet_name='checkna')
    print('saved excel_summary_of_vep_dataframe as :', output)

# excel_summary_of_vep_dataframe(indel12, 'indel12')
# excel_summary_of_vep_dataframe(snp12, 'snp12')
# excel_summary_of_vep_dataframe(indel63, 'indel63')
# excel_summary_of_vep_dataframe(snp63, 'snp63')



#############################################
#################### QC #####################
#############################################
# TODO does GIVEN_REF match USED_REF col?

# TODO add keyID 38 aa

# add Uniprot keyID

# add keyID38aa





# save cleaned files

indel12.to_csv('indel12_1_summarize_output.csv', index=False)
snp12.to_csv('snp12_1_summarize_output.csv', index=False)
indel63.to_csv('indel63_1_summarize_output.csv', index=False)
snp63.to_csv('snp63_1_summarize_output.csv', index=False)
