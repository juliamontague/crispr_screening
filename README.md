markdown

# crispr_screening

This project contains a pipeline for CRISPR knockout screening analysis.

## Project structure

- `scripts/` — pipeline scripts for processing and analysis  
- `envs/` — conda environment YAML files for reproducible setup  
- `config.env` — environment configuration file with customizable parameters  
- `Human_GeCKOv2_Library_combine.csv` — .csv file containing sgRNA sequences for libraries A and B from Addgene GeCKO v2

## Data

Input data should be paired-end amplicon sequencing FASTQ files with `_R1` and `_R2` suffixes, e.g.: sample1_R1.fq sample1_R2.fq

## Setup

1. Create and activate the desired conda environment by specifying the appropriate YAML file, for example:

```bash
conda env create -f envs/environment1.yml
conda activate environment1
```

Replace environment1.yml and environment1 with the name of the environment you want to use.

2. Edit config.env to set parameters as needed before running the pipeline.

## Order
1 - ./run_cutadapt.sh
2 - ./run_fastqc.sh
3 - ./do_mageck_count.sh
4 - ./do_mageck_test.sh 

## Usage

Run the scripts in the scripts/ directory with the config.env file:

```bash
bash ./script.sh ./config.env
```

replace script.sh with the actual script file 




