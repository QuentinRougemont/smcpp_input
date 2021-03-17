#!/bin/bash

#USAGE:
if [ $# -ne 3 ]; then
    echo "USAGE: $0  <vcf_basename> <chr_list> <pop_Name>"
    echo "<vcf_basename> name of the vcf without the extension chr.vcf.gz
    (all vcf should be compressed+indexed and end with the extension chrID.vcf.gz
    with chrID being the ID of the chromosome"
    echo "<chr_list> a file containing the list of chromosome"
    echo "<pop_Name> name of the population"
    exit 1
else
    vcf_basename=$1
    chr_list=$2
    pop_Name=$3 
fi

#load external variables and verifiy their presence
ind=$(cat "$pop_Name" |perl -pe 's/\n/,/g' |sed 's/\,$//g')
vcf=$(basename "$vcf_basename" )

#PREPARE FOLDERS:
outfolder=02_input/
mkdir -p "$outfolder"/$pop_Name 

#Prepare jSFS now
for i in $(cat "$chr_list") ;
do
        smc++ vcf2smc --cores 5 \
        $vcf_basename.$i.vcf.gz \
        02_input/"$pop_Name"/"$basename"."$i".smc.gz \
        "$i" \
        "$pop":"$ind"
done 

