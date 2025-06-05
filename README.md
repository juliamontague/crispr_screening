markdown

# crispr_screening

This project contains a pipeline for CRISPR knockout screening analysis.

## Project structure

├── .gitignore
├── Human_GeCKOv2_Library_combine.csv
├── LICENSE
├── README.md
├── Snakefile
├── config.env
├── envs
│   ├── cutadapt_env.yml
│   ├── fastqc_env.yml
│   ├── mageck_env.yml
│   ├── multiqc_env.yml
│   └── snakemake_env.yaml
└── scripts
    ├── do_mageck_count.sh
    ├── do_mageck_test.sh
    ├── run_cutadapt.sh
    └── run_fastqc.sh

- `scripts/` — pipeline scripts for processing and analysis  
- `envs/` — conda environment YAML files for reproducible setup  
- `config.env` — environment configuration file with customizable parameters  
- `Human_GeCKOv2_Library_combine.csv` — CSV file containing sgRNA sequences for libraries A and B from human GeCKO v2 (Addgene)
- `Snakefile` — Snakemake workflow file for executing the pipeline

## Data

Input data should be compressed, paired-end amplicon sequencing FASTQ files with `_R1` and `_R2` suffixes, e.g.: 
`sample1_R1.fastq.gz` and `sample1_R2.fastq.gz` or `sample1_R1.fq.gz` and `sample1_R2.fq.gz`

The pipeline assumes that an initial quality check was already performed on the raw data. 

## Setup

1. Create and activate the conda environments by specifying the appropriate YAML file, for example:

```bash
conda env create -f envs/environment1.yml
conda activate environment1
```

Replace `environment1.yml` and `environment1` with the name of the environment you want to use.

2. Edit config.env to set parameters as needed before running the pipeline.

## Usage

Run the pipeline using snakemake

```bash
snakemake --cores 4
```

Make sure to run the pipeline from the project working directory

### Pipeline execution order

1 - run_cutadapt.sh
2 - run_fastqc.sh
3 - do_mageck_count.sh
4 - do_mageck_test.sh 



