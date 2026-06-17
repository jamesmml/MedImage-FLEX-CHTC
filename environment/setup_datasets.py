"""
setup_datasets.py

Downloads the datasets.
"""

import os
import sys

# FIXME: Force kagglehub to download to a desired path (edit as needed)
# Remove if using kagglehub>=0.3.6 and instead add output_dir as a parameter to kagglehub.dataset_download
# Run in terminal: export KAGGLEHUB_CACHE=desired/path/here

# Make the current directory (for the subprocess) relative to the testbench program
script_dir = os.path.dirname(os.path.abspath(__file__))
os.chdir(script_dir)

python = sys.executable

# Download kagglehub
os.system(f"{python} -m pip install kagglehub")

import kagglehub

# Download the datasets
# PAD-UFES-20
kagglehub.dataset_download("mahdavi1202/skin-cancer")

# CheXpert
kagglehub.dataset_download("ashery/chexpert")

# CBIS-DDSM
kagglehub.dataset_download("awsaf49/cbis-ddsm-breast-cancer-image-dataset")

# ODIR-5K
kagglehub.dataset_download("andrewmvd/ocular-disease-recognition-odir5k")

# HAM10000
kagglehub.dataset_download("kmader/skin-cancer-mnist-ham10000")

print("\nDatasets downloaded.")