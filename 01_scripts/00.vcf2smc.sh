#!/bin/bash

#source /path/to/env/envsingularity-3.X.X.sh

input=$1
input=$(echo $(readlink -f $input ))
output=$(basename ${input%.cleaned.vcf.gz}.smc.gz )
chromosome=$2
pop=$3
ind=$(cat "$pop" |perl -pe 's/\n/,/g' |sed 's/\,$//g')

outfolder=02_input_test/
mkdir -p "$outfolder"/$pop

singularity exec -B /scratch/path/to/user/:/scratch/path/to/user\
        -B /groups/other/path/:/groups/other/path  \
        docker://terhorst/smcpp:latest \
        smc++ vcf2smc "$input" \
        $outfolder/"$output" \
        "$chromosome" \
        "$pop":"$ind"

