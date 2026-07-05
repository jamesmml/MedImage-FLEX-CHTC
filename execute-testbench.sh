#!/bin/bash
# --- Prepare the datasets ---
echo "Unzipping the datasets..."
unzip -q ./datasets.zip && rm ./datasets.zip
echo "Unzipping complete!"

# --- Run the testbench ---
echo "Running the testbench..."
python -X faulthandler ./testbench/main.py --config ./config.json