#!/bin/bash

# Usage: bash run_cutadapt.sh config.env

# Load project config
if [[ ! -f "$1" ]]; then
    echo "ERROR: Config file not found. Usage: $0 config.env"
    exit 1
fi

source "$1"

# Load conda and activate env
source "$CONDA_PATH"
conda activate "$CONDA_ENV_CUTADAPT"

# Create output dir if needed
mkdir -p "$TRIMMED_DIR"

# Loop through input files
for R1 in "$RAW_DIR"/*_R1.*q.gz
do
    FILENAME=$(basename "$R1")
    BASE="${FILENAME%%_R1.*q.gz}"
    EXT="${FILENAME##*_R1.}"  # fq.gz or fastq.gz

    R2="${RAW_DIR}/${BASE}_R2.${EXT}"

    # Intermediate output (after adapter trimming)
    ADAPT_R1="${TRIMMED_DIR}/${BASE}_R1_adptr_trimmed.fastq.gz"
    ADAPT_R2="${TRIMMED_DIR}/${BASE}_R2_adptr_trimmed.fastq.gz"

    # Final output (after primer trimming)
    OUT_R1="${TRIMMED_DIR}/${BASE}_R1_trimmed.fastq.gz"
    OUT_R2="${TRIMMED_DIR}/${BASE}_R2_trimmed.fastq.gz"
	
	# The trimming needs to be done in two passes to adequately remove both adapters and primers

    echo "Adapter trimming: $BASE"
    cutadapt \
        --nextseq-trim=20 \
        -a "$ADAPTER_FWD" \
        -A "$ADAPTER_REV" \
        -m 20 \
        -o "$ADAPT_R1" -p "$ADAPT_R2" \
        "$R1" "$R2" \
        --cores=0

    echo "Primer trimming: $BASE"
    cutadapt \
        -b "$PRIMER_FWD" \
        -b "$PRIMER_REV" \
        -B "$PRIMER_FWD" \
        -B "$PRIMER_REV" \
        -m 20 \
        -o "$OUT_R1" -p "$OUT_R2" \
        "$ADAPT_R1" "$ADAPT_R2" \
        --cores=0

    # Delete intermediate files
    rm -f "$ADAPT_R1" "$ADAPT_R2"
done

echo "All done."
touch "${TRIMMED_DIR}/cutadapt.done"

