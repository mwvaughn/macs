# You can transfer directories of binaries, libs, etc over iRODS
# but it tends to bog down (especially if the source tree is included in
# the library). So, what we recommend instead is to ship zipped tarballs of
# your bin, lib, etc, include, share etc required by your application
# 
# Then, in your wrapper script, unpack them
tar -zxvf bin.tgz
# Force apply execute permissions on contents of bin directory
chmod -R a+x bin/*
# Unpack your lib directory
tar -zxvf lib.tgz
# Extend PYTHONPATH so it knows about this local set of packages
export PYTHONPATH=$PYTHONPATH:lib/python2.7/site-packages

#INPUT_C="/iplant/home/lwang/applications/macs/data/input_tags.bed"
#INPUT_T="/iplant/home/lwang/applications/macs/data/treatment_tags.bed"
#Format="BED"
#EName="MACS_in_iPlant"
#Genomesize=2700000000
#Tagsize=25
#Pcut=0.00001
#Bandwidth=300

INPUT_T=${t}
INPUT_C=${c}
# Keep the name static as 'MACS' so that we can identify
# named outputs. This makes MACS usable as an upstream
# component in a workflow
EName="MACS"
Format=${f}
Genomesize=${g}
Tagsize=${s}
Pcut=${p}
Bandwidth=${bw}

#Copy from iRODS
# Added -frPVT to make transfers verbose and recursive
iget -frVT "${INPUT_T}"
INPUT_FT=$(basename ${INPUT_T})
iget -frVT "${INPUT_C}"
INPUT_FC=$(basename ${INPUT_C})

bin/macs14 -n "${EName}" -f "${Format}" -t "${INPUT_FT}" -c "${INPUT_FC}" -g ${Genomesize} -p ${Pcut} --bw=${Bandwidth}

# Remove unpacked dependency directories
rm -rf bin lib 
