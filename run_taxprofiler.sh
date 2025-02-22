#!/bin/bash

Help()
{
   echo "This project is an automation script to run the pipeline nf-core/taxprofiler pipeline "
   echo
   echo "Usage :./run_taxprofiler.sh " directory/ profilers_list[TOOL1,TOOL2..] <path-to-host-reference-genome>
   echo   
   echo "Example: ./run_taxprofiler.sh  data/ kraken2,centrifuge /home/db/human_ref.fna"
}

# Get arguments 
directory=$1
tools=$2
host_ref=$3

echo "===============

STEP I: GENERATION OF NECESSARY FILES FOR TAXPROFILER: samplesheet.csv & database.csv

==============="

# samplesheet.csv creation
echo "--- Generating samplesheet.csv..."
ls -v $directory*.fastq.gz > list_file
python3 ./scripts/Samplesheet_generator.py -i list_file -o samplesheet.csv -t 'I'

### Name Management : get sample names and run accessions
cd $directory
# create run_accession column
ls *R1* | sed 's/_L001_R1_001.fastq.gz//' > run_accession
sed -i '1i run_accession' run_accession # add row name to samples
# create sample names 
ls *R1* | sed 's/_L001_R1_001.fastq.gz//' | awk '{sub(".*_","",$1)}1' > sample_name
sed -i '1i sample' sample_name # add row name to sample_name 
paste -d',' sample_name run_accession > new_cols
mv new_cols ../
rm sample_name run_accession
# insert columns, remove old ones
paste -d',' new_cols samplesheet.csv | cut --complement -d',' -f3-4 > new_samplesheet.csv
rm samplesheet.csv
mv new_samplesheet.csv samplesheet.csv
#####

# database file creation
echo "--- Generating database.csv..."
python3 ./scripts/databases_generator.py -t $tools -d database.csv  
tc=$(cat pip.txt)


echo "===============
Running nf-core/taxprofiler with the following options:
repository containing fastq files: $directory
profilers selected : $tools
host reference: $host_ref
==============="

# NOTES: add host removal option 

nextflow run  nf-core/taxprofiler -profile docker $tc-resume \
--input samplesheet.csv \
--databases database.csv \
--outdir taxprofiler_results \
--run_krona \  # activate krona reporting 
--perform_shortread_hostremoval \
--hostremoval_reference $host_ref \ 
--run_profile_standardisation \ # standardisation of taxon tables across profilers using taxpasta
--save_hostremoval_unmapped # save reads that did not map to the host genome

# Data management
rm -f pip.txt list_file

echo "---------
Command executed :
nextflow run  nf-core/taxprofiler -profile docker $tc-resume \
--input samplesheet.csv \
--databases database.csv \
--outdir taxprofiler_results \
--run_krona \   
--perform_shortread_hostremoval \
--hostremoval_reference $host_ref \ 
--run_profile_standardisation \
--save_hostremoval_unmapped

Output in : taxprofiler_results
BYE ! 
"

while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
     \?) # incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done
