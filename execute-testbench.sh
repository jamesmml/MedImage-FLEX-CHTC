# --- Prepare the datasets ---
echo "Unzipping the datasets..."
unzip ./datasets.zip -q -d ./testbench/datasets/ && rm ./datasets.zip
echo "Unzipping complete!"

# --- Run the testbench ---
echo "Running the testbench..."
python ./testbench/main.py --config config.json