#!/bin/bash

# Usage: bash do_mageck_test.sh config.env

# Load project config
if [[ ! -f "$1" ]]; then
    echo "ERROR: Config file not found. Usage: $0 config.env"
    exit 1
fi

source "$1"

# Activate conda environment
source "$CONDA_PATH"
conda activate "$CONDA_ENV_MAGECK"

# Run MAGeCK test
mageck test -k "$MAGECK_OUTPUT/"$PROJECT_NAME" -t "$TREATMENTS" -c "$CONTROLS" -n $PROJECT_NAME --paired --pdf-report