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
cd "${MAGECK_OUTPUT}" || { echo "Failed to enter ${MAGECK_OUTPUT}"; exit 1; }

mageck test \
  -k "${PROJECT_NAME}.count.txt" \
  -t "${TREATMENTS}" \
  -c "${CONTROLS}" \
  -n "${PROJECT_NAME}" \
  --paired \
  --pdf-report

echo "MAGeCK test complete."
touch "${MAGECK_OUTPUT}/mageck_test.done"