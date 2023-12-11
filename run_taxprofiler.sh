#!/bin/bash

Help()
{
   echo "This project is an automation script to run the pipeline nf-core/taxprofiler pipeline "
   echo
   echo "Usage : bash nf-core/taxprofiler.sh " directory/ TOOL1[TOOL1,TOOL2..]
   echo   
}

# Get arguments 
directory=$1
tools=$2

ls -v $directory*.fastq.gz > datas_file

# samplesheet.csv creation
python3 ./scripts/Samplesheet_generator.py -i datas_file -o samplesheet.csv -t 'I'

# database file creation
python3 ./scripts/databases_generator.py -t $tools -d database.csv  
tc=$(cat pip.txt)

# Run the pipeline
#./nextflow run nf-core/taxprofiler --input samplesheet.csv --databases database.csv --outdir ./ -profile docker $tc-resume
nextflow run  nf-core/taxprofiler --input samplesheet.csv --databases database.csv --outdir ./ -profile docker $tc-resume

# Data management
rm -f pip.txt
rm -f datas_file

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
