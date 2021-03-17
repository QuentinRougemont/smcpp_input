#/bin/bash

#load variables
input=$1 #basename of vcf
input_folder="01.data"
input_folder="01.data"

pop_arg1=$1
if [[ -z "$pop_arg1" ]]
then
    echo "error please provide pop_name"
    exit
fi
pop_arg2=$2
if [[ -z "$pop_arg2" ]]
then
    echo "error please provide pop_name"
    exit
fi
pop1=$(echo "$pop_arg1" |sed 's/pop.//g')
ind1=$(less "$pop_arg1" |perl -pe 's/\n/,/g' |sed 's/\,$//g')

pop2=$(echo "$pop_arg2" |sed 's/pop.//g')
ind2=$(less "$pop_arg2" |perl -pe 's/\n/,/g' |sed 's/\,$//g')

#PREPARE FOLDERs:
outfolder=02.jsfs_26_02/joint_"$pop1"_"$pop2"
mkdir -p "$outfolder" #02.out/joint"$pop_1"_"$pop2"

for i in $(cat list_chr) ;
do
    smc++ vcf2smc --cores 5 \
    $input_folder/$input."$i".vcf.gz  \
    "$outfolder"/chr."$i"."$pop1"."$pop2".smc.gz \
    "$i" \
    "$pop1":"$ind1" "$pop2":"$ind2"
done 
