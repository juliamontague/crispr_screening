markdown

# crispr_screening

This project contains a pipeline for CRISPR knockout screening analysis.

## Project structure

├── .gitignore <br>
├── Human_GeCKOv2_Library_combine.csv <br>
├── LICENSE <br>
├── README.md <br>
├── Snakefile <br>
├── config.env <br>
├── envs <br>
│   ├── cutadapt_env.yml <br>
│   ├── fastqc_env.yml <br>
│   ├── mageck_env.yml <br>
│   ├── multiqc_env.yml <br>
│   └── snakemake_env.yaml <br>
└── scripts <br>
    ├── do_mageck_count.sh <br>
    ├── do_mageck_test.sh <br>
    ├── run_cutadapt.sh <br>
    └── run_fastqc.sh <br>

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
conda activate snakemake
snakemake --cores 4
```

Call the name of your actual snakemake environment.

Make sure to run the pipeline from the project working directory.

### Pipeline execution order

1 - run_cutadapt.sh <br>
2 - run_fastqc.sh <br>
3 - do_mageck_count.sh <br>
4 - do_mageck_test.sh <br>



