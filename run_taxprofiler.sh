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
host_ref=$3

ls -v $directory*.fastq.gz > datas_file

# samplesheet.csv creation
echo "Generating samplesheet.csv..."
python3 ./scripts/Samplesheet_generator.py -i datas_file -o samplesheet.csv -t 'I'

# database file creation
echo "Generating database.csv..."
python3 ./scripts/databases_generator.py -t $tools -d database.csv  
tc=$(cat pip.txt)

# Run the pipeline
#./nextflow run nf-core/taxprofiler --input samplesheet.csv --databases database.csv --outdir ./ -profile docker $tc-resume

# add host removal option 
# would need to specify the host: here human
# activate krona reporting 
echo "===============
Running nf-core/taxprofiler with the following options:
repository containing fastq files: $directory
profilers selected : $tools
host reference: $host_ref
==============="

nextflow run  nf-core/taxprofiler --input samplesheet.csv --databases database.csv --outdir ./ -profile docker $tc-resume --run_krona --perform_shortread_hostremoval --hostremoval_reference $host_ref

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
