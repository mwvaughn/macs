#!/bin/bash

#$ -cwd
#$ -V
#$ -N MACS
##$ -A TG-MCB11022
#$ -q development
#$ -l h_rt=01:00:00
#$ -pe 16way 16
#$ -m be
#$ -M wangli@cshl.edu

module load irods
module load python

PYTHONPATH=$PYTHONPATH:/share/home/01308/lwang/macs/lib/python2.7/site-packages

#EName=${n}
#INPUT_T=${t}
#INPUT_C=${c}
#Format=${f}
#Genomesize=${g}
#Tagsize=${s}
#Pcut=${p}
#Bandwidth=${bw}

INPUT_C="/iplant/home/lwang/applications/macs/data/input_tags.bed"
INPUT_T="/iplant/home/lwang/applications/macs/data/treatment_tags.bed"

#Copy from iRODS
iget -fT "${INPUT_T}"
INPUT_FT=$(basename ${INPUT_T})

iget -fT "${INPUT_C}"
INPUT_FC=$(basename ${INPUT_C})

Format="BED"
EName="MACS_in_iPlant"
Genomesize=2700000000
Tagsize=25
Pcut=0.00001
Bandwidth=300

bin/macs14 -n "${EName}" -f "${Format}" -t "${INPUT_FT}" -c "${INPUT_FC}" -g ${Genomesize} -p ${Pcut} --bw=${Bandwidth}
