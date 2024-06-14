
# login to minerva
$ssh palafm01@minerva.hpc.mssm.edu
password (add VIP number)

# deciding whether to use scp or cyberduck
"""
Transferring large files is not ideal to do with ssh or scp. the minerva help pages recommends using CyberDuck. 
Help page : https://labs.icahn.mssm.edu/minervalab/documentation/file-transfer-globus/
Note: Ensure the Reuse password feature of CyberDuck is disabled.CyberDuck will try to reuse your one-use six-digit VIP token code repeatedly until you get locked out!
## note: changed cyberduck default to dont add keychain and deleted minerva keychain in mac keychain app, then file transfer worked.
""" 

# CyberDuck best choice for transferring large files
# CyberDuck parameters
"""
SFTP (SSH file transfer protocol)
server: minerva.hpc.mssm.edu
user: palafm01
password] + VIP#
"""

# data
cd /sc/arion/projects/vascbrain/WGS-iPSC/

# downloading bashrc from hoffman
scp mfpalafo@hoffman2.idre.ucla.edu:/u/home/m/mfpalafo/hoffman_bashrc.sh .

# set alias in bashrc : data

# upload estimated time : 100 minutes


################ unzip ####################################
unzip -l raw_data.zip # lists content in zip 
# unzipping using cyberduck action 'expand archive' or trying in terminal caused error :
unzip raw_data.zip
"""
replace raw_data/P931263/MD5.txt? [y]es, [n]o, [A]ll, [N]one, [r]ename:   inflating: raw_data/P931263/MD5.txt  
error: invalid zip file with overlapped components 
(possible zip bomb)
 To unzip the file anyway, rerun the command with UNZIP_DISABLE_ZIPBOMB_DETECTION=TRUE environmnent variable

error only seems to involve MD5 so moving on
"""

################ downloadin CAD12 fastqc output########

scp palafm01@minerva.hpc.mssm.edu:/sc/arion/projects/vascbrain/WGS_iPSC/raw_data/P732912/P732912_FDSW220142847_1r_HYMM2DSX2_L1_2_fastqc.html . 

scp palafm01@minerva.hpc.mssm.edu:/sc/arion/projects/vascbrain/WGS_iPSC/raw_data/P732912/P732912_FDSW220142847_1r_HYMM2DSX2_L1_1_fastqc.html .

password (add VIP number)
################  ####################################

# User specific aliases and functions
alias data='cd /sc/arion/projects/vascbrain/'
alias wgs='cd /sc/arion/projects/vascbrain/WGS_iPSC/'

alias bjj='bjobs'
alias hgg='cd /sc/arion/projects/vascbrain/WGS_iPSC/hg38/'
alias out='cd /sc/arion/projects/vascbrain/WGS_iPSC/scripts/'
alias lst='ls -lsht'
alias lss='ls -lhSa'

alias bsub2='bsub -P acc_vascbrain -q interactive -n 4 -W 2:00 -R rusage[mem=4000] -R span[hosts=1] -Is /bin/bash'
alias bsub4='bsub -P acc_vascbrain -q interactive -n 4 -W 4:00 -R rusage[mem=4000] -R span[hosts=1] -Is /bin/bash'
autoload -U colors && colors
export PROMPT="%F{050}%n@%t %1~ %# %F{reset}"

################  ####################################
https://www.baeldung.com/linux/terminal-shell-colors
LS_COLORS='di=01;34:ex=01;32:fi-01;37:*.jpg=01;32:*.png=01;32:*.zip=01;31:*.gz=00;33'
################  ####################################


export LS_COLORS='di=1;31:fi=1;32'
export LS_COLORS='di=1;34:ex=0;32:fi=0;37:*.zip=0;35:*.gz=0;31'

export LS_COLORS='di=1;34:ex=0;32:fi=0;37:*.zip=0;35:*.gz=0;31'
34 dark blue
32 lighter blue
37 white
35 pink 
31 red


