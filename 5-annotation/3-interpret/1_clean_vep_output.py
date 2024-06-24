# !/usr/bin/env python3
# -*- coding: utf-8 -*-

# 1_clean_vep_output.py
# Created on 2021-06-30
# By Maria Palafox

# This script cleans the vep output files for CAD12 and CAD63
# The script performs the following operations:
# 1. Load the vep output files for CAD12 and CAD63
# 2. Rename the column '#Uploaded_variation' to 'Uploaded_variation'
# 3. Split the 'Location' column on ':' to create 'chromosome' and 'chrCoordinate' columns
# 4. Change the 'chrCoordinate' column values to type int
# 5. Change the 'cDNA_position', 'CDS_position', 'Protein_position' columns values equal to "-" to nan
# 6. Split the 'SIFT' column on "(" to create 'SIFTprediction' and 'SIFTscore' columns
# 7. Remove ")" from 'SIFTscore' column and change 'SIFTscore' column values to type float
# 8. Split the 'PolyPhen' column on "(" to create 'PolyPhenprediction' and 'PolyPhenscore' columns
# 9. Remove ")" from 'PolyPhenscore' column and change 'PolyPhenscore' column values to type float
# 10. Change the 'DISTANCE', 'EXONnumber', 'INTRONnumber' columns values equal to "-" to nan
# 11. Split the 'EXONnumber' and 'INTRONnumber' columns values on "/" to retain only the value before the "/"
# 12. Change the 'DISTANCE', 'EXONnumber', 'INTRONnumber' columns values to type float
# 13. Change the "-" values in columns 'gnomAD' to nan and change to float
# 14. Change the "-" values in column 'MAX_AF' to nan and change to float
                # removed because no need if not int or float # 15. Change the "-" values in column 'CLIN_SIG' to nan
# 16. Strip the 'chromosome' column to remove "chr" from the values
# 17. Duplicate the 'chrCoordinate' column and change the type to string
# 18. Format the 'chrCoordinate' column values to have 9 characters filled with leading 0s
# 19. Create a 'keyID38' column for snp only
# 20. Check the number of non-coding snps using the 'Amino_acids' column "-"
# 21. Check if 'GIVEN_REF' matches 'USED_REF' column, create a new column 'GIVEN_REF_MATCH' based on the comparison
# 22. Save the cleaned files

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

# split Location  on : to make chromosome(str) and chrCoordinate(int) cols
indel12[['chromosome', 'chrCoordinate']] = indel12['Location'].str.split(':', expand=True)
snp12[['chromosome', 'chrCoordinate']] = snp12['Location'].str.split(':', expand=True)
indel63[['chromosome', 'chrCoordinate']] = indel63['Location'].str.split(':', expand=True)
snp63[['chromosome', 'chrCoordinate']] = snp63['Location'].str.split(':', expand=True)


## note chrCoordinnate is the onnly integer column in the dataframe

# if chrCoordinate column contains "-", 
# split the column on - to get start and end columns, change start and end columns to type int, else change chrCoordinate column values to type int
# NOTE the indel df  start position is being used as chrCoordinate and the start could actually be larger than end position depending on strand 
indel12['chrCoordinate'] = indel12['chrCoordinate'].str.split('-', expand=False).str[0].astype(int)
snp12['chrCoordinate'] = snp12['chrCoordinate'].astype(int)
indel63['chrCoordinate'] = indel63['chrCoordinate'].str.split('-', expand=False).str[0].astype(int)
snp63['chrCoordinate'] = snp63['chrCoordinate'].astype(int)

## note cDNA position for inndels has a - character and is not an integer or float
## note cds position for inndels has a - character and is not an integer or float
## note prot position for inndels has a - character and is not an integer or float


# "-" values to nan ::
def replace_dash_with_nan(df, col_name):
       df[col_name] = df[col_name].replace('-', np.nan)
       return df


# change cDNA_position "-" values to nan 
indel12 = replace_dash_with_nan(indel12, 'cDNA_position')
snp12 = replace_dash_with_nan(snp12, 'cDNA_position')
indel63 = replace_dash_with_nan(indel63, 'cDNA_position')
snp63 = replace_dash_with_nan(snp63, 'cDNA_position')

# change CDS_position column values equal to "-" to nan
indel12 = replace_dash_with_nan(indel12, 'CDS_position')
snp12 = replace_dash_with_nan(snp12, 'CDS_position')
indel63 = replace_dash_with_nan(indel63, 'CDS_position')
snp63 = replace_dash_with_nan(snp63, 'CDS_position')

# change Protein_position column values equal to "-" to nan
indel12 = replace_dash_with_nan(indel12, 'Protein_position')
snp12 = replace_dash_with_nan(snp12, 'Protein_position')
indel63 = replace_dash_with_nan(indel63, 'Protein_position')
snp63 = replace_dash_with_nan(snp63, 'Protein_position')


# if SIFT column contains a value, split the column on "(" to get SIFTprediction and SIFTscore, remove ")" from SIFTscore and change SIFTscore to type float
snp12[['SIFTprediction', 'SIFTscore']] = snp12['SIFT'].str.split('(', expand=True)
snp12['SIFTscore'] = snp12['SIFTscore'].str.replace(')', '')
snp12['SIFTscore'] = snp12['SIFTscore'].astype(float)

snp63[['SIFTprediction', 'SIFTscore']] = snp63['SIFT'].str.split('(', expand=True)
snp63['SIFTscore'] = snp63['SIFTscore'].str.replace(')', '')
snp63['SIFTscore'] = snp63['SIFTscore'].astype(float)

# if PolyPhen column contains a value, split the column on "(" to get PolyPhenprediction and PolyPhenscore, remove ")" from PolyPhenscore and change PolyPhenscore to type float
snp12[['PolyPhenprediction', 'PolyPhenscore']] = snp12['PolyPhen'].str.split('(', 
expand=True)
snp12['PolyPhenscore'] = snp12['PolyPhenscore'].str.replace(')', '')
snp12['PolyPhenscore'] = snp12['PolyPhenscore'].astype(float)

snp63[['PolyPhenprediction', 'PolyPhenscore']] = snp63['PolyPhen'].str.split('(', expand=True)
snp63['PolyPhenscore'] = snp63['PolyPhenscore'].str.replace(')', '')
snp63['PolyPhenscore'] = snp63['PolyPhenscore'].astype(float)


# convert distance, exon numberator and intron nnumerators to float

# change DISTANCE column values equal to "-" to nan
indel12 = replace_dash_with_nan(indel12, 'DISTANCE')
snp12 = replace_dash_with_nan(snp12, 'DISTANCE')
indel63 = replace_dash_with_nan(indel63, 'DISTANCE')
snp63 = replace_dash_with_nan(snp63, 'DISTANCE')

# duplicate EXON and save as new column EXONnumber
indel12['EXONnumber'] = indel12['EXON']
snp12['EXONnumber'] = snp12['EXON']
indel63['EXONnumber'] = indel63['EXON']
snp63['EXONnumber'] = snp63['EXON']

# change EXONnumber and INTRONnumber columns values equal to "-" to nan
indel12 = replace_dash_with_nan(indel12, 'EXONnumber')
snp12 = replace_dash_with_nan(snp12, 'EXONnumber')
indel63 = replace_dash_with_nan(indel63, 'EXONnumber')
snp63 = replace_dash_with_nan(snp63, 'EXONnumber')

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
indel12 = replace_dash_with_nan(indel12, 'INTRONnumber')
snp12 = replace_dash_with_nan(snp12, 'INTRONnumber')
indel63 = replace_dash_with_nan(indel63, 'INTRONnumber')
snp63 = replace_dash_with_nan(snp63, 'INTRONnumber')

# split the INTRONnumber column values on "/", retain only the value before the "/"
indel12['INTRONnumber'] = indel12['INTRONnumber'].str.split('/').str[0]
snp12['INTRONnumber'] = snp12['INTRONnumber'].str.split('/').str[0]
indel63['INTRONnumber'] = indel63['INTRONnumber'].str.split('/').str[0]
snp63['INTRONnumber'] = snp63['INTRONnumber'].str.split('/').str[0]



# FLOAT CONVERRSION for distance, exonnumber, intronnumber
col_list = ['DISTANCE', 'INTRONnumber', 'EXONnumber']


def convert_to_float(df, col_list):
    # a function that takes a list of columns and dataframe and 
    # returns the dataframe with the columns converted to type float
    for i in col_list:
        df[i] = df[i].astype(float)
    return(df)

indel12 = convert_to_float(indel12, col_list)
snp12 = convert_to_float(snp12, col_list)
indel63 = convert_to_float(indel63, col_list)
snp63 = convert_to_float(snp63, col_list)


# if colname contains "gnomAD", change the "-" values to nan and change to float

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
indel12 = replace_dash_with_nan(indel12, 'MAX_AF')
snp12 = replace_dash_with_nan(snp12, 'MAX_AF')
indel63 = replace_dash_with_nan(indel63, 'MAX_AF')
snp63 = replace_dash_with_nan(snp63, 'MAX_AF')

# change MAX_AF to type float
indel12['MAX_AF'] = indel12['MAX_AF'].astype(float)
snp12['MAX_AF'] = snp12['MAX_AF'].astype(float)
indel63['MAX_AF'] = indel63['MAX_AF'].astype(float)
snp63['MAX_AF'] = snp63['MAX_AF'].astype(float)

# # change the "-" values in column CLIN_SIG to nan
# indel12 = replace_dash_with_nan(indel12, 'CLIN_SIG')
# snp12 = replace_dash_with_nan(snp12, 'CLIN_SIG')
# indel63 = replace_dash_with_nan(indel63, 'CLIN_SIG')
# snp63 = replace_dash_with_nan(snp63, 'CLIN_SIG')

print(indel12.dtypes)
print(snp12.dtypes)
print(indel63.dtypes)
print(snp63.dtypes)

#############################################
#################### snp keyID38  ###########
#############################################

## strip the chromosome column to remove "chr" from the values
indel12['chr'] = indel12['chromosome'].str.strip('chr')
snp12['chr'] = snp12['chromosome'].str.strip('chr')
indel63['chr'] = indel63['chromosome'].str.strip('chr')
snp63['chr'] = snp63['chromosome'].str.strip('chr')

## QC
checkColumnValue(indel12, 'chr')
checkColumnValue(snp12, 'chr')

##  note snp ref alt  would have - value for missing if there were any missing but there are no mising values
checkColumnValue(snp63, 'Allele')
checkColumnValue(snp63, 'REF_ALLELE')
checkColumnValue(snp12, 'Allele')
checkColumnValue(snp12, 'REF_ALLELE')

checkColumnValue(indel12, 'Allele')
checkColumnValue(indel12, 'REF_ALLELE') 
checkColumnValue(indel63, 'Allele')
checkColumnValue(indel63, 'REF_ALLELE')

describeMe(snp12)
describeMe(snp63)

# confirmed on missing values for chrCoordinate in snp dfs

# duplicate  chr Corrdinate column and turnn from int  back into string
snp12['chrCoordinate-str'] = snp12['chrCoordinate'].astype(str)
snp63['chrCoordinate-str'] = snp63['chrCoordinate'].astype(str)

# format the chr-str columns to have 9 characters filled with leading 0s
snp12['chrCoordinate-str'] = snp12['chrCoordinate-str'].str.zfill(9)
snp63['chrCoordinate-str'] = snp63['chrCoordinate-str'].str.zfill(9)

# create keyID column for snp only
snp12['keyID38'] = snp12['chr'].astype(str) + "_" +  snp12['chrCoordinate-str'] +\
      "_" + snp12['REF_ALLELE'] + "_" + snp12['Allele']

snp63['keyID38'] = snp63['chr'].astype(str) + "_" +  snp63['chrCoordinate-str'] +\
        "_" + snp63['REF_ALLELE'] + "_" + snp63['Allele']

# QC
print(snp12['keyID38'])
print(snp63['keyID38'])

# drop 'chrCoordinate-str' column from snp12 and snp63
snp12.drop(columns=['chrCoordinate-str'], inplace=True)
snp63.drop(columns=['chrCoordinate-str'], inplace=True)

# drop 'chr-str' column from snp12 and snp63
#snp12.drop(columns=['chr-str'], inplace=True)
#snp63.drop(columns=['chr-str'], inplace=True)

# check # of non-coding snps using  Amino_acids column  "-"
# checkColumnValue(snp12, 'Amino_acids')
# checkColumnValue(snp63, 'Amino_acids')
# checkColumnValue(indel12, 'Amino_acids')
# checkColumnValue(indel63, 'Amino_acids')

# Check if GIVEN_REF matches USED_REF column, create a new column GIVEN_REF_MATCH based on the comparison
indel12['GIVEN_REF_MATCH'] = indel12['GIVEN_REF'] == indel12['USED_REF']
snp12['GIVEN_REF_MATCH'] = snp12['GIVEN_REF'] == snp12['USED_REF']
indel63['GIVEN_REF_MATCH'] = indel63['GIVEN_REF'] == indel63['USED_REF']
snp63['GIVEN_REF_MATCH'] = snp63['GIVEN_REF'] == snp63['USED_REF']


# QC check # of rows where GIVEN_REF matches USED_REF
# checkColumnValue(indel12, 'GIVEN_REF_MATCH')
# checkColumnValue(snp12, 'GIVEN_REF_MATCH')
# checkColumnValue(indel63, 'GIVEN_REF_MATCH')
# checkColumnValue(snp63, 'GIVEN_REF_MATCH')

# save given ref false
# indel12_false = indel12[indel12['GIVEN_REF_MATCH'] == False]
# snp12_false = snp12[snp12['GIVEN_REF_MATCH'] == False]
# indel63_false = indel63[indel63['GIVEN_REF_MATCH'] == False]
# snp63_false = snp63[snp63['GIVEN_REF_MATCH'] == False]

# TODO what genes are these False values associated with?
# checkColumnValue(indel12_false, 'SYMBOL')
# checkColumnValue(snp12_false, 'SYMBOL')
# checkColumnValue(indel63_false, 'SYMBOL')
# checkColumnValue(snp63_false, 'SYMBOL')



# # save cleaned files
indel12.to_csv('1_clean_vep_output-indel-cad12-v2.csv', index=False)
snp12.to_csv('1_clean_vep_output-snp-cad12-v2.csv', index=False)
indel63.to_csv('1_clean_vep_output-indel-cad63-v2.csv', index=False)
snp63.to_csv('1_clean_vep_output-snp-cad63-v2.csv', index=False)

## note columns  'SIFTprediction', 'SIFTscore', 'PolyPhenprediction', 'PolyPhenscore', 'keyID38',  are only  in snps dfs not indels

print(indel12.columns)

print(snp12.columns)

# output savved to 1_clean_vep_output-2.ipynb

