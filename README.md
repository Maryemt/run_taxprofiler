# run_nf-core-taxprofiler

![image](https://github.com/KhoujSunshine/run_nf-core-taxprofiler/assets/100375394/c53c2cbe-36bb-4ec6-a37f-d6e145ace858)


## Automation script for running the pipeline nf-core/taxprofiler

**[nf-core/taxprofiler](https://github.com/nf-core/taxprofiler)** is a bioinformatics best-practice analysis pipeline for taxonomic classification and profiling of shotgun metagenomic data. 

It allows for in-parallel taxonomic identification of reads or taxonomic abundance estimation with multiple classification and profiling tools against multiple databases, produces standardised output tables.

Find more information here: https://nf-co.re/taxprofiler/1.1.2

This project is a automation script to create the input files needed to run the pipeline nf-core/taxprofiler. 


## Description
The project contains two files:
- The main script **run_taxprofiler.sh** allows the execution of the python files and the nf-core/taxprofiler pipeline
- The folder **scripts** containing the following python scripts:
  - Samplesheet_generator.py : to generate the samplesheet
  - Database_generator.py : to generate the database samplesheet


The main script run_taxprofiler.sh takes two positionnal arguments:

- The path to the directory containing your fastq files
- The profiling tools you want to use for the analysis. Here are the options:
  - Kraken2,
  - Bracken, KrakenUniq,
  - MetaPhlan3,
  - Malt,
  - DIAMOND,
  - Centrifuge,
  - Kaiju &
  - mOTUs
  depending on what you are analyzing. 

Samplesheet_generator.py takes the list of samples, the sequencing technology (*ILLUMINA* or *NANOPORE*) and returns a samplesheet: *samplesheet.csv* 

Database_generator.py takes a chain of profiling tools as argument and return the database samplesheet: *database.csv*

![image](https://github.com/KhoujSunshine/run_nf-core-taxprofiler/assets/100375394/ff128eff-1eac-4cf8-accb-45666fea6b45)

![image](https://www.google.com/url?sa=i&url=https%3A%2F%2Fgithub.com%2Ftaxprofiler&psig=AOvVaw1lEt2C-K-tU9vNudwQtQen&ust=1702462522602000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCMie-KzViYMDFQAAAAAdAAAAABAc)
 
## Usage

Pull the repository
```
git pull https://github.com/Maryemt/run_taxprofiler.git
```
Once it is done 
```
chmod +x run_taxprofiler.sh scripts/*
```


Execute the pipeline
```
./run_taxprofiler.sh  data_directory/ <TOOL1>,<TOOL2>
```
Where 
* **data_directory** is the path to the file containing your fastq files
* **TOOL1,TOOL2...** is the list of the profilers you want to use during the analysis


*Example* :
```
./run_taxprofiler.sh  data/ centrifuge,kraken2
```
 

## Contact

If you found an issue or would like to submit an improvment to this project , you can contact me via [LinkedIn](https://www.linkedin.com/in/ndeye-khoudia-thiam/) or by email (khoudiathiampro@gmail.com)

