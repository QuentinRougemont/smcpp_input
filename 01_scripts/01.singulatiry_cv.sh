#!/bin/bash

pop=$1
if [[ -z "$pop" ]]
then
    echo "error please provide pop_name"
    exit
fi

inputfolder=02_input_test  #folder created from previous conversion  script
outfolder="03_cv"      #where results will be
mkdir -p "$outfolder"/"$pop"

echo "running smcpp for population $pop "
singularity exec -B /scratch/qrougemont:/scratch/qrougemont \
        -B /groups/supergene:/groups/supergene  \
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


