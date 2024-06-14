2023_VEP96.sh install of 109 and troubleshooting

gnomad download v2 liftover link-
https://gnomad.broadinstitute.org/downloads#v2-liftover # GRCh38 option


conda activate perly  # env

----backup made ------
//renamed data/ref to data/ref37 (contains dna fastas for 37 asssembly)

//created data/ref and downloaded dna fasta for 38 assembly vep96 (https://ftp.ensembl.org/pub/release-96/fasta/homo_sapiens/dna/)


!Note that VEP requires that the file be either unzipped (Bio::DB::Fasta) or 
    unzipped and then recompressed with bgzip (Bio::DB::HTS::Faidx) to run; 
    when unzipped these files can be very large (25GB for human).
--


## output is all  inntergenic, i think its using 37 cache still for 38 vcf
./vep -i examples/homo_sapiens_GRCh38.vcf --cache --force_overwrite --fasta data/ref/

## perfect output!
 ./vep -i examples/homo_sapiens_GRCh37.vcf --cache --force_overwrite --fasta data/ref37/ --port 3337

 ./vep --show_cache_info



-------------------- EXCEPTION ---------------------------------------
MSG: ERROR: Multiple assemblies found for cache version 96 (GRCh37, GRCh38) - specify one using --assembly [assembly]

STACK Bio::EnsEMBL::VEP::CacheDir::dir /Users/mariapalafox/Desktop/ensembl-vep/modules/Bio/EnsEMBL/VEP/CacheDir.pm:361
STACK Bio::EnsEMBL::VEP::CacheDir::init /Users/mariapalafox/Desktop/ensembl-vep/modules/Bio/EnsEMBL/VEP/CacheDir.pm:227
STACK Bio::EnsEMBL::VEP::CacheDir::new /Users/mariapalafox/Desktop/ensembl-vep/modules/Bio/EnsEMBL/VEP/CacheDir.pm:111
STACK Bio::EnsEMBL::VEP::AnnotationSourceAdaptor::get_all_from_cache /Users/mariapalafox/Desktop/ensembl-vep/modules/Bio/EnsEMBL/VEP/AnnotationSourceAdaptor.pm:115
STACK Bio::EnsEMBL::VEP::AnnotationSourceAdaptor::get_all /Users/mariapalafox/Desktop/ensembl-vep/modules/Bio/EnsEMBL/VEP/AnnotationSourceAdaptor.pm:91
STACK Bio::EnsEMBL::VEP::BaseRunner::get_all_AnnotationSources /Users/mariapalafox/Desktop/ensembl-vep/modules/Bio/EnsEMBL/VEP/BaseRunner.pm:175
STACK Bio::EnsEMBL::VEP::BaseRunner::valid_chromosomes /Users/mariapalafox/Desktop/ensembl-vep/modules/Bio/EnsEMBL/VEP/BaseRunner.pm:384
STACK Bio::EnsEMBL::VEP::Runner::get_Parser /Users/mariapalafox/Desktop/ensembl-vep/modules/Bio/EnsEMBL/VEP/Runner.pm:789
STACK Bio::EnsEMBL::VEP::BaseRunner::get_output_header_info /Users/mariapalafox/Desktop/ensembl-vep/modules/Bio/EnsEMBL/VEP/BaseRunner.pm:341
STACK toplevel ./vep:212
Date (localtime)    = Tue May  9 07:54:30 2023
Ensembl API version = 96


--------------VEP96 run with assembly 38----------------------------

./vep -i examples/homo_sapiens_GRCh38.vcf --cache --force_overwrite --assembly GRCh38  # retrying grch38 run



perl INSTALL.pl

export DYLD_LIBRARY_PATH="/Users/mariapalafox/Desktop/ensembl-vep/htslib"
    # adapted above line from this link  https://apple.stackexchange.com/questions/381177/zsh-cant-set-dyld-library-path-in-zshenv-to-get-imagemagick-working-under-m
    # way deeper info link skimmed https://dakota.sandia.gov/content/set-environment-linux-mac-os-x


./vep -i examples/homo_sapiens_GRCh38.vcf --assembly GRCh38 --cache --offline --fasta data/ref/ --force_overwrite 

./vep --show_cache_info --assembly GRCh38
        # nothing

./vep --show_cache_info --assembly GRCh37
        # ESP 20141103
        # gencode GENCODE 19
        # gnomAD  r2.1
        # regbuild    1.0
        # assembly    GRCh37.p13
        # sift    sift5.2.2
        # HGMD-PUBLIC 20174
        # COSMIC  86
        # polyphen    2.2.2
        # genebuild   2011-04
        # ClinVar 201810
        # dbSNP   151
        # 1000genomes phase3

something is not working for vep 96 grch38 assembly, may be lacking cache data


----------------------------TODO----------------------------------------------
**gnomAD hoffman data is also GRCh37, so instead of updating vep, its perfect for teseting gnomad vcf v2.1.1***


TODO make github of gnomad code (done)
TODO set hoffman and local remote for push
TODO make bed file from clinvar vcf
TODO overlap bed file of clinvar with gnomad filtered vcf (silent, missense, and nonsense)




-----------------updating api to 109 latest-----------------------------

(perly) mariapalafox@ 4:37AM ensembl-vep % perl INSTALL.pl

# Attempting to install Bio::DB::HTS and htslib.

# >>> If this fails, try re-running with --NO_HTSLIB

#  - checking out HTSLib
# fatal: destination path 'htslib' already exists and is not an empty directory.
#  - building HTSLIB in ./htslib
# In /Users/mariapalafox/Desktop/ensembl-vep/htslib
# make: Nothing to be done for `all'.
#  - unpacking ./Bio/tmp/biodbhts.zip to ./Bio/tmp/
# ./Bio/tmp/Bio-DB-HTS-2.9 - moving files to ./biodbhts
#  - making Bio::DB:HTS
# Can't exec "x86_64-apple-darwin13.4.0-clang": No such file or directory at /Users/mariapalafox/anaconda3/envs/perly/lib/5.26.2/ExtUtils/CBuilder/Base.pm line 331.
# Warning: ExtUtils::CBuilder not installed or no compiler detected
# Proceeding with configuration, but compilation may fail during Build

# Checking prerequisites...
#   requires:
#     !  Bio::Root::Version is not installed

# ERRORS/WARNINGS FOUND IN PREREQUISITES.  You may wish to install the versions
# of the modules indicated above before proceeding with this installation

# Run 'Build installdeps' to install missing prerequisites.

# Created MYMETA.yml and MYMETA.json
# Creating new 'Build' script for 'Bio-DB-HTS' version '2.9'
# Building Bio-DB-HTS
# Error: no compiler detected to compile 'lib/Bio/DB/HTS.c'.  Aborting
# ERROR: Shared Bio::DB:HTS library not found

----------------test deactivated env----------------------
mariapalafox@ 4:41AM ensembl-vep % perl INSTALL.pl 
# WARNING: DBD::mysql module not found. VEP can only run in offline (--offline) mode without DBD::mysql installed

# http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html#requirements
# Installation on OSX requires that you set up some paths before running this installer.
# Have you 
# 1. added /Users/mariapalafox/Desktop/ensembl-vep/htslib to your DYLD_LIBRARY_PATH environment variable?
# (y/n): y

Version check reports a newer release of 'ensembl-vep' is available (installed: 96, available: 109)

# We recommend using git to update 'ensembl-vep', by exiting this installer and running:

#     git pull
#     git checkout release/109

# Do you wish to exit so you can get updates (y) or continue (n): 

------------------------------
% git pull

% git checkout release/109

# branch 'release/109' set up to track 'origin/release/109'.
# Switched to a new branch 'release/109'

-----------------1st issue kseq.h----------------------------------------
mariapalafox@ 4:46AM ensembl-vep % perl INSTALL.pl 
# WARNING: DBD::mysql module not found. VEP can only run in offline (--offline) mode without DBD::mysql installed

# http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html#requirements
# Installation on OSX requires that you set up some paths before running this installer.
# Have you 
# 1. added /Users/mariapalafox/Desktop/ensembl-vep/htslib to your DYLD_LIBRARY_PATH environment variable?
# (y/n): y 
# Hello! This installer will help you set up VEP v109, including:
#  - Install v109 of the Ensembl API for use by the VEP. It will not affect any existing installations of the Ensembl API that you may have.
#  - Download and install cache files from Ensembl's FTP server.
#  - Download FASTA files from Ensembl's FTP server.
#  - Download VEP plugins.

# Checking for installed versions of the Ensembl API...done

# Setting up directories
# Destination directory ./Bio already exists.
# Do you want to overwrite it (if updating VEP this is probably OK) (y/n)? y
#  - fetching BioPerl
#  - unpacking ./Bio/tmp/release-1-6-924.zip
#  - moving files
# cannot remove directory for Bio/tmp/bioperl-live-release-1-6-924: Directory not empty at INSTALL.pl line 1045.
# cannot remove directory for ./Bio/tmp: Directory not empty at INSTALL.pl line 1045.
# Attempting to install Bio::DB::HTS and htslib.

# >>> If this fails, try re-running with --NO_HTSLIB

#  - checking out HTSLib
# fatal: destination path 'htslib' already exists and is not an empty directory.
#  - building HTSLIB in ./htslib
# In /Users/mariapalafox/Desktop/ensembl-vep/htslib
# make: Nothing to be done for 'all'
#  - unpacking ./Bio/tmp/biodbhts.zip to ./Bio/tmp/
# ./Bio/tmp/Bio-DB-HTS-2.11 - moving files to ./biodbhts
#  - making Bio::DB:HTS
# ld: warning: -undefined dynamic_lookup may not work with chained fixups
# Checking prerequisites...
#   requires:
#     !  Bio::Root::Version is not installed

# ERRORS/WARNINGS FOUND IN PREREQUISITES.  You may wish to install the versions
# of the modules indicated above before proceeding with this installation

# Run 'Build installdeps' to install missing prerequisites.

# Created MYMETA.yml and MYMETA.json
# Creating new 'Build' script for 'Bio-DB-HTS' version '2.11'
# Building Bio-DB-HTS
cc -iwithsysroot /Users/mariapalafox/Desktop/ensembl-vep/htslib -iwithsysroot /System/Library/Perl/5.30/darwin-thread-multi-2level/CORE -DVERSION="2.11" -DXS_VERSION="2.11" -D_IOLIB=2 -D_FILE_OFFSET_BITS=64 -Wno-error -Wno-unused-result -c -g -pipe -DPERL_USE_SAFE_PUTENV -Os -o lib/Bio/DB/HTS.o lib/Bio/DB/HTS.c
lib/Bio/DB/HTS.xs:52:10: fatal error: 'htslib/kseq.h' file not found
include "htslib/kseq.h"
         ^~~~~~~~~~~~~~~
1 error generated.
error building lib/Bio/DB/HTS.o from 'lib/Bio/DB/HTS.c' at /System/Library/Perl/5.30/ExtUtils/CBuilder/Base.pm line 190.
ERROR: Shared Bio::DB:HTS library not found

------------------tried------------------------------------------

moved kseq.h file that was in nested htslib/htslib dir to outer htslib dir (didnt work)

-------------------export path DYLD_LIBRARY_PATH-----------------------
# TRYING to export path again ..
export DYLD_LIBRARY_PATH="/Users/mariapalafox/Desktop/ensembl-vep/htslib"

export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Users/mariapalafox/Desktop/ensembl-vep/htslib # this made path redundant

------------------------error--------------------------------------------------
mariapalafox@ 4:57AM ensembl-vep % perl INSTALL.pl

Checking prerequisites...
  requires:
    !  Bio::Root::Version is not installed

# ERRORS/WARNINGS FOUND IN PREREQUISITES.  You may wish to install the versions
# of the modules indicated above before proceeding with this installation

# Run 'Build installdeps' to install missing prerequisites.

# Created MYMETA.yml and MYMETA.json
# Creating new 'Build' script for 'Bio-DB-HTS' version '2.11'
# Building Bio-DB-HTS
# cc -iwithsysroot /Users/mariapalafox/Desktop/ensembl-vep/htslib -iwithsysroot /System/Library/Perl/5.30/darwin-thread-multi-2level/CORE -DVERSION="2.11" -DXS_VERSION="2.11" -D_IOLIB=2 -D_FILE_OFFSET_BITS=64 -Wno-error -Wno-unused-result -c -g -pipe -DPERL_USE_SAFE_PUTENV -Os -o lib/Bio/DB/HTS.o lib/Bio/DB/HTS.c
# lib/Bio/DB/HTS.xs:52:10: fatal error: 'htslib/kseq.h' file not found
# #include "htslib/kseq.h"
#          ^~~~~~~~~~~~~~~
# 1 error generated.
# error building lib/Bio/DB/HTS.o from 'lib/Bio/DB/HTS.c' at /System/Library/Perl/5.30/ExtUtils/CBuilder/Base.pm line 190.
# ERROR: Shared Bio::DB:HTS library not found

-------------------tried Bio::Root::Version-------------------------------

Bio::Root::Version

TODO idea: try export PERL5LIB, try while in conda env 'perly'
TODO conda perly has perl 26 and local comupter has perl 30
TODO idea: maybe module is in conda env but i need to export path so it knows



---------------------tried setting PERL5LIB path in conda---------------

# """perl path setting https://github.com/tseemann/prokka/issues/519
#  what helped in the end is setting the environment variable as:
export PERL5LIB=$CONDA_PREFIX/lib/perl5/site_perl/5.22.0/
# To make this permanent in your conda environment, use:
conda env config vars set PERL5LIB=$CONDA_PREFIX/lib/perl5/site_perl/5.22.0/ -n [env_name]
# MAKE SURE PERL 5.22 IS ALREADY INSTALLED (I think it automatically is with prokka but am not 100% sure) (I confirmed this, done)
# """ 
# PATH to perl in my env:
/Users/mariapalafox/anaconda3/envs/perly/lib/perl5/site_perl/5.22.0
echo $DYLD_LIBRARY_PATH
# /Users/mariapalafox/Desktop/ensembl-vep/htslib:/Users/mariapalafox/Desktop/ensembl-vep/htslib

TODO make export of other path std with all new shells

echo $CONDA_PREFIX
# /Users/mariapalafox/anaconda3/envs/perly

# test first before making permanent 
export PERL5LIB=$CONDA_PREFIX/lib/perl5/site_perl/5.22.0

echo $PERL5LIB
# /Users/mariapalafox/anaconda3/envs/perly/lib/perl5/site_perl/5.22.0

# adding your ensembl-vep directory to your PERL5LIB variable should help VEP find Bio::DB::HTS::Tabix. idea from https://github.com/Ensembl/ensembl-vep/issues/446
export PERL5LIB=$CONDA_PREFIX/lib/perl5/site_perl/5.22.0:/Users/mariapalafox/Desktop/ensembl-vep

------------------------setting perlpath in env helped--------------------

(perly) mariapalafox@ 5:40AM ensembl-vep % perl INSTALL.pl 
# >>> If this fails, try re-running with --NO_HTSLIB
#  - checking out HTSLib
# fatal: destination path 'htslib' already exists and is not an empty directory.
#  - building HTSLIB in ./htslib
# In /Users/mariapalafox/Desktop/ensembl-vep/htslib
# make: Nothing to be done for all.
#  - unpacking ./Bio/tmp/biodbhts.zip to ./Bio/tmp/
# ./Bio/tmp/Bio-DB-HTS-2.11 - moving files to ./biodbhts
#  - making Bio::DB:HTS
Cant exec "x86_64-apple-darwin13.4.0-clang": No such file or directory at /Users/mariapalafox/anaconda3/envs/perly/lib/5.26.2/ExtUtils/CBuilder/Base.pm line 331.
Warning: ExtUtils::CBuilder not installed or no compiler detected
Proceeding with configuration, but compilation may fail during Build
# Created MYMETA.yml and MYMETA.json
# Creating new 'Build' script for 'Bio-DB-HTS' version '2.11'
# Building Bio-DB-HTS
# Error: no compiler detected to compile 'lib/Bio/DB/HTS.c'.  Aborting
# ERROR: Shared Bio::DB:HTS library not found

----------------adding compiler to env---------------------------
# from https://www.biostars.org/p/9505731/
# Error: no compiler detected to compile 'lib/Bio/DB/HTS.c'. Aborting. -------- missing a C/C++ compiler, which can be installed, along with other essential programs and libraries:
sudo apt install build-essential
  # After that repeating the installation should work.

% sudo apt install build-essential
#>The operation couldn’t be completed. Unable to locate a Java Runtime that supports apt.
#>Please visit http://www.java.com for information on installing Java.
  # failed

------------------java variable for compiler---------------------------

% echo $JAVA_HOME
/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home

------------------make .zshrc file--------
# from https://superuser.com/questions/1636321/how-to-solve-unable-to-locate-a-java-runtime-that-supports-error
TODO made .zshrc file and add following
# (did and uncommented after echo showed set variables in env)


------------------important paths to check in vep env-----------------
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home"

export PERL5LIB="/Users/mariapalafox/anaconda3/envs/perly/lib/perl5/site_perl/5.22.0:/Users/mariapalafox/Desktop/ensembl-vep"

export DYLD_LIBRARY_PATH="/Users/mariapalafox/Desktop/ensembl-vep/htslib"

echo $JAVA_HOME

echo $PERL5LIB

echo $DYLD_LIBRARY_PATH

--------------------------print env----------------------------------

printenv

-----------------compiler error again------------------------------------------

issue: Cant exec 'x86_64-apple-darwin13.4.0-clang'


-----------------check for clang file in conda env (perly)-----------


% ls /Users/mariapalafox/anaconda3/envs/perly/bin/ | grep clang
  # no output -needs to be installed to compile C and C++

----------------------------check if compiler missing (perly) 

% conda list
% conda install clang_osx-64 clangxx_osx-64 -c anaconda

---------------------------recheck for clang (perly)

% ls /Users/mariapalafox/anaconda3/envs/perly/bin/ | grep clang | grep -i 'apple'
  # x86_64-apple-darwin13.4.0-clang@
  # x86_64-apple-darwin13.4.0-clang++@

-----------export compiler path-----------------

# dont think i need to export because.. echo test shows path
echo $CC
echo $CXX

export CC=x86_64-apple-darwin13.4.0-clang
export CXX=x86_64-apple-darwin13.4.0-clang++




--------------Install ERROR post compiler path--------------------------

perl INSTALL.pl

# Attempting to install Bio::DB::HTS and htslib.

# >>> If this fails, try re-running with --NO_HTSLIB

#  - checking out HTSLib
# fatal: destination path 'htslib' already exists and is not an empty directory.
#  - building HTSLIB in ./htslib
# In /Users/mariapalafox/Desktop/ensembl-vep/htslib
# make: Nothing to be done for all.
#  - unpacking ./Bio/tmp/biodbhts.zip to ./Bio/tmp/
# ./Bio/tmp/Bio-DB-HTS-2.11 - moving files to ./biodbhts
 - making Bio::DB:HTS
ld: warning: directory not found for option '-L/anaconda3/envs/perly/lib'
ld: unknown option: -Wl,-pie
Warning: ExtUtils::CBuilder not installed or no compiler detected
Proceeding with configuration, but compilation may fail during Build
# Created MYMETA.yml and MYMETA.json
# Creating new 'Build' script for 'Bio-DB-HTS' version '2.11'
# Building Bio-DB-HTS
# Error: no compiler detected to compile 'lib/Bio/DB/HTS.c'.  Aborting
# ERROR: Shared Bio::DB:HTS library not found

----------------------------------------------------------------------------
-----------------------------------------------------------------------------

------------------IDEA TRY restart and ExtUtils::CBuilder perl

TODO try restart (done)
TODO check if ExtUtils::CBuilder is installed
??how can i check perl libraries in conda env and locally??


---------------------HTSLIB flag
# The script will also attempt to install a Perl::XS module, Bio::DB::HTS, for rapid access to bgzipped FASTA files. If this fails, you may add the
--NO_HTSLIB # flag when running the installer; 
      # VEP will fall back to using Bio::DB::Fasta for this functionality
 
perldoc

perl INSTALL.pl --NO_HTSLIB

perl INSTALL.pl -a p --PLUGINS list     # list plugin options

cache files:
  (14GB) - downloading https://ftp.ensembl.org/pub/release-109/variation/indexed_vep_cache/homo_sapiens_vep_109_GRCh37.tar.gz

  (29GB) Remember to use --merged when running the VEP with this cache! downloading https://ftp.ensembl.org/pub/release-109/variation/indexed_vep_cache/homo_sapiens_merged_vep_109_GRCh38.tar.gz


---------------------UPDATE_.zprofile--------------------------------------
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home"
echo $JAVA_HOME

# ----------DYLD_LIBRARY_PATH
# export DYLD_LIBRARY_PATH="/Users/mariapalafox/Desktop/ensembl-vep/htslib"
# echo $DYLD_LIBRARY_PATH

----------PERL5LIB_PATH
export PERL5LIB="/Users/mariapalafox/Desktop/ensembl-vep"
echo $PERL5LIB
export PERL5LIB="/Users/mariapalafox/anaconda3/envs/perly/lib/perl5/site_perl/5.22.0"
echo $PERL5LIB

#export PERL5LIB="/Users/mariapalafox/Desktop/ensembl-vep/biodbhts/lib
#/Users/mariapalafox/Desktop/ensembl-vep"

----------------------------------------------------------
# changed zprofile no perl5lib, cc and cxx are gcc and g++, maually installed HTSlib from github https://github.com/samtools/htslib

Building HTSlib

See INSTALL for complete details. Release tarballs contain generated files that have not been committed to this repository, so building the code from a Git repository requires extra steps:

autoreconf -i  # Build the configure script and install files it uses
./configure    # Optional but recommended, for choosing extra functionality
make
make install

--------------


(perly) mariapalafox@10:40AM Bio-DB-HTS % 

set | grep ^PERL ; which cpanm ; head -n 1 "$( which cpanm )"

  PERL5LIB=Users/mariapalafox/anaconda3/envs/perly/lib/5.26.2
  /Users/mariapalafox/anaconda3/envs/perly/bin/cpanm
  #!/anaconda3/envs/perly/bin/perl

---------
# updated perl5lib to 5.26 lib in zprofile
/Users/mariapalafox/anaconda3/envs/perly/lib/site_perl/5.26.2
#/Users/mariapalafox/anaconda3/envs/perly/lib/perl5/site_perl/5.22.0

set | grep ^PERL ; which cpanm ; head -n 1 "$( which cpanm )" 
  PERL5LIB=/Users/mariapalafox/anaconda3/envs/perly/lib/site_perl/5.26.2
  /Users/mariapalafox/anaconda3/envs/perly/bin/cpanm
  #!/anaconda3/envs/perly/bin/perl

cpan Bio::SeqFeature::Lite
#zsh: /Users/mariapalafox/anaconda3/envs/perly/bin/cpan: bad interpreter: /anaconda3/envs/perly/bin/perl: no such file or directory

#vxs.c: loadable library and perl binaries are mismatched (got handshake key 0xdb00080, needed 0xc400080)


export PERL5LIB="/Users/mariapalafox/anaconda3/envs/perly/lib/perl5/site_perl/5.22.0"

cpan Bio::SeqFeature::Lite

What do the following commands print?

    echo $PATH | tr ":" "\n" | nl
    which conda
    which perl
    uname -a

# check my config file for tmp/ path .. CONDA_PREFIX/lib/5.26 perl versionn/system versionn/  file= Config.pm, didnt see any obvious issue, no tmp/ path


conda install -c bioconda perl-bio-db-hts

conda install -c bioconda perl-bioperl

https://useast.ensembl.org/info/docs/api/api_installation.html
# my posts
https://github.com/Ensembl/ensembl-vep/issues/446 
# interesting funx
https://www.perlmonks.org/?node_id=934619

cpanm Bio::Root::Version

------------------------------
#Task: List installed perl module
# To display the list enter the following command:
instmodsh
cmd? l

------------------------------
#This command itself is a perl script that use ExtUtils::Installed module. Try following command to see its source code:
vi $(which instmodsh)

# https://github.com/xie186/ViewBS/issues/37
HTSLIB_DIR environment variable

# Perl variables
# INNFO 
perl -V 

# You can use $PERL_VERSION or $^V too as the revision, version, and subversion of the Perl interpreter, represented as a “version” object. This variable first appeared in perl version 5.6.0; earlier versions of perl will see an undefined value. Before perl v5.10.0 $^V was represented as a v-string. $^V can be used to determine whether the Perl interpreter executing a script is in the right range of versions. For example:
warn "Hashes not randomized!\n" if !$^V or $^V lt v5.8.1

#To convert $^V into its string representation use “sprintf()”‘s “%vd” conversion:
printf "version is v%vd\n", $^V;  # Perl's version https://www.cyberciti.biz/faq/how-can-i-find-out-perl-version/
perl -e 'print "Perl version : $^V\n"'
# Perl version : v5.26.2

----------------------------------------------------------------------
perl -MBio::DB::HTS -e 'print "$Bio::DB::HTS::VERSION\n"'
# 3.01
# wow it worked now!! 
# maybe because of 
# - conda env updates like perl-bio-db-hts package install, 
# - cleared DNS, 
# -set CURL env variable (all notes in VEPP.sh)
# - commented.bash_profile to declutter PATH

"""
 -- https://github.com/Ensembl/ensembl-vep/issues/961 --
source $HOME/perl5/perlbrew/etc/bashrc
export PERL5LIB=${PERL5LIB}:/Users/jh/Resources/ensembl-vep
export PERL5LIB=${PERL5LIB}:/Users/jh/Resources/BioPerl-1.6.924
export PERL5LIB=${PERL5LIB}:/Users/jh/Resources/loftee/
# Previously, BioPerl-1.6.924 was exported first). When I run 
perl -MBio::DB::HTS -e 'print "$Bio::DB::HTS::VERSION\n"' 
# I now get 2.11, but I still get the same error when I attempt to run VEP:
"""

echo $PERL5LIB
export PERL5LIB=${PERL5LIB}:/Users/mariapalafox/Desktop/ensembl-vep
# (perly) mariapalafox@ 1:19PM ensembl-vep % 

perldoc -l Bio::DB::HTS 
#zsh: /Users/mariapalafox/anaconda3/envs/perly/bin/perldoc: bad interpreter: /anaconda3/envs/perly/bin/perl: no such file or directory
# /Users/mariapalafox/Desktop/ensembl-vep/Bio/DB/HTS.pm


perl -e 'use Bio::DB::HTS::Tabix; print "Tabix available\n"';
# Bio::DB::HTS object version 3.01 does not match $Bio::DB::HTS::VERSION 2.11 at /Users/mariapalafox/anaconda3/envs/perly/lib/5.26.2/darwin-thread-multi-2level/DynaLoader.pm line 214.
# Compilation failed in require at /Users/mariapalafox/Desktop/ensembl-vep/Bio/DB/HTS/Tabix.pm line 22.
# BEGIN failed--compilation aborted at /Users/mariapalafox/Desktop/ensembl-vep/Bio/DB/HTS/Tabix.pm line 22.
# Compilation failed in require at -e line 1.
# BEGIN failed--compilation aborted at -e line 1.

export PERL5LIB=${PERL5LIB}:/Users/mariapalafox/Desktop/ensembl-vep/Bio/DB/HTS/Tabix
perl -e 'use Bio::DB::HTS::Tabix; print "Tabix available\n"';


#in htslib directory
perl INSTALL.pl
Error: no compiler detected to compile 'lib/Bio/DB/HTS.c'.  Aborting
ERROR: Shared Bio::DB:HTS library not found

gcc --version
Apple clang version 14.0.0 (clang-1400.0.29.202)
Target: x86_64-apple-darwin22.1.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

export PERL5LIB=${PERL5LIB}:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin


-----------------------
---------------------
perl INSTALL.pl --NO_HTSLIB
perl INSTALL.pl --NO_HTSLIB --NO_TEST

-----------------------
---------------------

./vep -i data/gnomad_wes37_test100.txt \
-o gnomad_wes37_test100_output_pick.txt \
--cache \
--assembly GRCh37 \
--tab \
--force_overwrite \
--offline \
--canonical \
--pick \
--uniprot \
--symbol \
--custom data/clinvar_20230514_GRCh37.vcf.gz,ClinVar,vcf,exact,0,CLNSIG,CLNREVSTAT,CLNDN


-----------------------
---------------------
-----------------------
---------------------








#-------- gnomad - left align space delimited header-less tables---------------
# formatting hoffman downloaded files for merger with clinvar keyid37

# python terminal input-
# vep_input_gnomad211_wgs37_codingSNVs.txt
# vep_input_gnomad211_wes37_codingSNVs.txt
```python
g = pd.read_csv("vep_input_gnomad211_wes37_codingSNVs.txt", sep='\t', low_memory=False)
uniqueCount(g, 'keyID37aa')
split = g.keyID37aa.str.split('_', n=3, expand=True)
split['keyID37'] = split[0].astype(str) + '_' + split[1].astype(str) + '_' + split[2].astype(str)
split.drop([0,1,2,3], axis=1, inplace=True)
df  = pd.concat([g, split], axis=1)
df = df[['CHROM', 'START', 'END', 'REFALT', 'STRAND', 'keyID37']].copy()
df.sort_values(['CHROM',  'START'], inplace=True)
uniqueCount(df, 'keyID37')
df.to_csv("vep_input_gnomad211_wes37_codingSNVs_keyID37.csv", index=False)
```
# python terminal output-
# vep_input_gnomad211_wes37_codingSNVs_keyID37.csv
    # keyID37 length: 6219266
    # keyID37 set length: 6219266
# vep_input_gnomad211_wgs37_codingSNVs_keyID37.csv
    # keyID37aa length: 1775075
    # keyID37aa set length: 1775075


## exome
column -t -s ',' vep_input_gnomad211_wes37_codingSNVs_keyID37.csv > vep_input_aligned_gnomad211_wes37_codingSNVs.txt

sed '1d' vep_input_aligned_gnomad211_wes37_codingSNVs.txt > vep_input_aligned_nohead_gnomad211_wes37_codingSNVs.txt

## genome
column -t -s ',' vep_input_gnomad211_wgs37_codingSNVs_keyID37.csv > vep_input_aligned_gnomad211_wgs37_codingSNVs.txt

sed '1d' vep_input_aligned_gnomad211_wgs37_codingSNVs.txt > vep_input_aligned_nohead_gnomad211_wgs37_codingSNVs.txt


#-------- clinvar - left align space delimited header-less tables----------
# vep_input_clinvar_v20230430_GRCh37_SNVs_VPB.csv
    # keyID37 length: 1550813
    # keyID37 set length: 1550813
# python 
# sorted values in terminal- saved as same name

column -t -s ',' vep_input_clinvar_v20230430_GRCh37_SNVs_VPB.csv > vep_input_aligned_clinvar_v20230430_GRCh37_SNVs_VPB.txt

sed '1d' vep_input_aligned_clinvar_v20230430_GRCh37_SNVs_VPB.txt > vep_input_aligned_nohead_clinvar_v20230430_GRCh37_SNVs_VPB.txt


####################### RUN VEP ######################################

# gnomad EXOME missense & nonsense & silent
./vep -i data/vep_input_aligned_nohead_gnomad211_wes37_codingSNVs.txt \
-o vep_output_aligned_nohead_gnomad211_wes37_codingSNVs.txt --cache --assembly GRCh37 --tab --force_overwrite --offline --canonical --pick --uniprot --symbol --fork 6

# gnomad GENOME missense & nonsense & silent
./vep -i data/vep_input_aligned_nohead_gnomad211_wgs37_codingSNVs.txt \
-o vep_output_aligned_nohead_gnomad211_wgs37_codingSNVs.txt --cache --assembly GRCh37 --tab --force_overwrite --offline --canonical --pick --uniprot --symbol --fork 6

# clinvar HGVSc missense & nonsense & silent
./vep -i data/vep_input_aligned_nohead_clinvar_v20230430_GRCh37_SNVs_VPB.txt \
-o vep_output_aligned_nohead_clinvar_v20230430_GRCh37_SNVs_VPB.txt --cache --assembly GRCh37 --tab --force_overwrite --offline --canonical --pick --uniprot --symbol --fork 6


# --exclude_predicted \
# --sift b \
# --polyphen b \
# --domains \

# --appris --assembly GRCh37 --biotype --cache --canonical --ccds --check_existing --coding_only --domains --force_overwrite --fork 6 --gencode_basic --gene_phenotype --input_file data/allCpDProtiens/bedHGVS_VEPinput_noheader4729.txt --max_af --numbers --offline --output_file allCpDProtiens_VEPoutput_v1.txt --pick --polyphen b --port 3337 --protein --regulatory --sift b --symbol --tab --tsl --xref_refseq












