# --- Prepare the datasets ---
echo "Unzipping the datasets..."
unzip -q ./datasets.zip -d ./testbench/ && rm ./datasets.zip
echo "Unzipping complete!"

# --- Run the testbench ---
echo "Running the testbench..."
python ./testbench/main.py --config ./config.json