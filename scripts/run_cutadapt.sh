#!/bin/bash

# Usage: ./run_cutadapt.sh config.env

# Load project config
if [[ ! -f "$1" ]]; then
    echo "ERROR: Config file not found. Usage: $0 config.env"
    exit 1
fi

source "$1"

# Load conda and activate env
source ~/miniconda3/etc/profile.d/conda.sh
conda activate "$CONDA_ENV"

# Create output dir if needed
mkdir -p "$OUTPUT_DIR"

# Loop through input files
for R1 in "$INPUT_DIR"/*_R1.fq
do
    BASE=$(basename "$R1" _R1.fq)
    R2="${INPUT_DIR}/${BASE}_R2.fq"
    
    OUT_R1="${OUTPUT_DIR}/${BASE}_R1_trimmed.fastq.gz"
    OUT_R2="${OUTPUT_DIR}/${BASE}_R2_trimmed.fastq.gz"
    
    echo "Trimming: $BASE"
    cutadapt --nextseq-trim=20 \
             -a "$ADAPTER_FWD" -A "$ADAPTER_REV" \
             -m 20 \
             -o "$OUT_R1" -p "$OUT_R2" \
             "$R1" "$R2"
done

echo "All done."
