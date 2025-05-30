#!/bin/bash

# Usage: bash run_fastqc.sh config.env

if [[ ! -f "$1" ]]; then
    echo "Usage: $0 <config.env>"
    exit 1
fi

source "$1"

source ~/miniconda3/etc/profile.d/conda.sh
conda activate "$CONDA_ENV_FASTQC"   # <-- change here

mkdir -p "$FASTQC_DIR"                # <-- change here

echo "Running FastQC on files in $TRIMMED_DIR"
fastqc "$TRIMMED_DIR"/*.fastq.gz -o "$FASTQC_DIR"

echo "FastQC completed. Output saved to $FASTQC_DIR"

