#!/bin/bash

# Usage: bash run_fastqc.sh config.env

if [[ ! -f "$1" ]]; then
    echo "Usage: $0 <config.env>"
    exit 1
fi

source "$1"

source "$CONDA_PATH"
conda activate "$CONDA_ENV_FASTQC"   

mkdir -p "$FASTQC_DIR"                

echo "Running FastQC on files in $TRIMMED_DIR"
fastqc "$TRIMMED_DIR"/*.fastq.gz -o "$FASTQC_DIR"

echo "FastQC completed. Output saved to $FASTQC_DIR"
echo "Running multiqc"

conda activate "$CONDA_ENV_MULTIQC"
multiqc "$FASTQC_DIR"

echo "Quality control processing complete."
touch "${FASTQC_DIR}/fastqc.done"
