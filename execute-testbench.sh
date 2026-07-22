#!/bin/bash
# --- Prepare the datasets ---
echo "Unzipping the datasets..."
unzip -q ./datasets.zip && rm ./datasets.zip
echo "Unzipping complete!"

# --- Run the testbench ---
echo "Running the testbench..."
conda run -s -n base python -X faulthandler ./testbench/main.py --num-workers 4 --config ./config.json