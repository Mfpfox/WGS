

from all_funx import *


# input: individual WGS results for indels
# output: vep html equivalent plots for report

path = "/Users/mariapalafox/Desktop/ensembl-vep/vep-wgs/annotated-XX-cell-lines/annotated_indels_CAD12_autoX.txt"

df = pd.read_csv(path, sep="\t",low_memory=False)
df.head()
df.describe()


# crosstabit(df,"Consequence", "ZYG", True)
# crosstabit(df,"Consequence", "ZYG", True)
# crosstabit(snp12,"Consequence", "IMPACT", True)
# crosstabit(snp63,"Consequence", "IMPACT", True)
