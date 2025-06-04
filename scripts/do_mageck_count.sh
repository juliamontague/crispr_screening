#!/bin/bash

# Usage: bash run_mageck_count.sh config.env

# Load config
if [[ ! -f "$1" ]]; then
    echo "Usage: $0 config.env"
    exit 1
fi

source "$1"

# Activate conda environment
source "$CONDA_PATH"
conda activate "$CONDA_ENV_MAGECK"

# Create output dir if not exists
mkdir -p "$MAGECK_OUTPUT"

# Build fastq and fastq-2 file lists
FASTQ1=""
FASTQ2=""

for SAMPLE in "${SAMPLES[@]}"; do
    FASTQ1+="$MAGECK_INPUT/${SAMPLE}_R1_trimmed.fastq.gz "
    FASTQ2+="$MAGECK_INPUT/${SAMPLE}_R2_trimmed.fastq.gz "
done

# Run MAGeCK count
echo "Running MAGeCK count..."
mageck count \
    -l "$LIBRARY_FILE" \
    -n "$MAGECK_OUTPUT/"$PROJECT_NAME" \
    --sample-label "$SAMPLE_LABELS" \
    --fastq $FASTQ1 \
    --fastq-2 $FASTQ2

echo "MAGeCK count complete. Output in: $MAGECK_OUTPUT"
