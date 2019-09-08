#!/bin/bash

#AUTHOR: Q. Rougemont
#DATE: June 2019

#PURPOSE: convert a vcf file into a jSFS for pairwise pop split time

#USAGE:
#00_vcf_to_smcc_jSFS.sh <vcf_file.vcf.gz> <pop1> <pop2> <chr_list>
#4 required arguments: 
#an indexed vcf file 
#a file with the name of the individual in population1, 
#a file with the name of the individal in population 2.
#a file listing all chromosomes

#dependancies:
#vcftools
#bgzip
#tabix

########################################################################
#help 
#to write

#test if all variables are provided
#load external variables and verifiy their presence
input=$1 #vcf file  
input_folder="00_data"
pop_arg1=$2
if [[ -z "$pop_arg1" ]]
then
    echo "error please provide pop_name"
    exit
fi
pop_arg2=$3
if [[ -z "$pop_arg2" ]]
then
    echo "error please provide pop_name"
    exit
fi
list_chr=$4 #list of all chromosomes
if [[ -z "$list_chr" ]]
then
    echo "error please provide pop_name"
    exit
fi

############ Test if software are installed ############################

#To do


####### extract name of pop and ind ####################################
pop1=$(echo "$pop_arg1" |sed 's/pop.//g')
ind1=$(less "$pop_arg1" |perl -pe 's/\n/,/g' |sed 's/\,$//g')

pop2=$(echo "$pop_arg2" |sed 's/pop.//g')
ind2=$(less "$pop_arg2" |perl -pe 's/\n/,/g' |sed 's/\,$//g')

#PREPARE FOLDERs:
outfolder=02_out_jsfs/joint_"$pop1"_"$pop2"
mkdir -p "$outfolder" #02.out/joint"$pop_1"_"$pop2"

#PREPARE JSFS
#split vcf by chromosome:
echo "splitting the whole vcf into chromosomes"
for i in $(cat "list_chr" ) ;
do 
	vcftools --gzvcf "$input" \
	--chr $i \
	--out ${input%.vcf.gz}.$i \ 
	--recode --recode-INFO-all
	bgzip ${input%.vcf.gz}.$i 
	tabix -p vcf ${input%.vcf.gz}.$i
done


#prepare jSFS now
echo "preparing joint frequency spectrum"
for i in $(cat "$list_chr" ) ;
do
    smc++ vcf2smc --cores 5 \
    $input_folder/$input."$i".recode.vcf.gz \
    "$outfolder"/chr."$i".smc.gz \
    "$i" \
    "$pop1":"$ind1" "$pop2":"$ind2"
done 

for i in $(cat "$list_chr" ) ;
do
    smc++ vcf2smc --cores 5 \
    $input_folder/$input."$i".recode.vcf.gz \
    "$outfolder"/chr."$i".smc.gz \
    "$i" \
    "$pop2":"$ind2" "$pop1":"$ind1"
done 

