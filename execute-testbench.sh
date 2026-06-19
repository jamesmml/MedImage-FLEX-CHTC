# --- Prepare the datasets ---
echo "Unzipping the datasets..."

# First argument ($1) is the path to the .zip file containing the datasets
unzip "$1" -q -d ./testbench/datasets/ && rm "$1" && echo "Unzipping complete!"

# --- Run the testbench ---
echo "Running the testbench..."

# Second argument ($2) is the path to the JSON configuration file
python ./testbench/main.py --config $2