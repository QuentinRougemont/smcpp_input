#!/bin/bash

#source /path/to/env/envsingularity-3.X.X.sh

if [ $# -ne 1  ]; then
    echo "USAGE: $0 <pop>"
    echo "Expecting a population file with individuals name in one single colomn"
    exit 1
else
    pop=$1
    echo "pop file is : ${pop}"
fi

inputfolder=02_input_test  #folder created from previous conversion  script
outfolder="03_cv"      #where results will be
mkdir -p "$outfolder"/"$pop"

echo "running smcpp for population $pop "
singularity exec -B /path/to/folder/:/path/to/folder/ \
        -B /path/to/data/:/path/to/data/  \
        docker://terhorst/smcpp:latest \
        smc++ cv --cores 2 \
        --out "$outfolder"/$pop \
        --thinning 1609 \
        --timepoints 50 500000 \
        --ftol 0.0001 \
        --spline piecewise \
        --Nmax 9e6 \
        --regularization-penalty 6\
        --polarization-error 0.5 \
        --knots 9 --folds 3\
        2.9e-09 "$inputfolder"/"$pop"/*.smc.gz 


