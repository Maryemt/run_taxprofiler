# nf-core-taxprofiler


## Automation script for running the pipeline nf-core/taxprofiler

nf-core/taxprofiler is a bioinformatics best-practice analysis pipeline for taxonomic classification and profiling of shotgun metagenomic data. It allows for in-parallel taxonomic identification of reads or taxonomic abundance estimation with multiple classification and profiling tools against multiple databases, produces standardised output tables.

This project is a automation script for running this pipeline. 

## Description

The script takes two positionnal arguments. The first one is the directory containing the fastq files of the samples and the second argument is the chain of the wanted profilers (TOOL1,TOOL2,...).

It's allow the generation of the main samplesheet(Samplesheet_generator.py) and the database samplesheet from the profilers chain (database_generator.py)


The first python script take as arguments a list of samples (firstly generated by the bash workflow) , the NGS type (ILLUMINA OR NANOPORE) and returns a samplesheet file. The second one takes a profilers's chain as argument , generate the database samplesheet and *pip.txt* which contains the run parameters for the profilers.
The files resulting of those two scripts *samplesheet.csv* & *database.csv* will be used for the execution of our pipeline which is the last step of your bash program.


## Usage

```
./nf-core/taxprofiler.sh  data_directory/ <TOOL1>,<TOOL2>
```

If you want to use the python scripts separately:

```
Samplesheet_generator.py -i data_files/ -o samplesheet.csv -t ['I'/'N']
```
<img width="450" alt="image" src="https://github.com/KhoujSunshine/nf-core-taxprofiler-/assets/100375394/c318b7ec-9753-41f7-9718-4cf22baa6903">

```
databases_generator.py -t TOOL1 -d database.csv  
```


