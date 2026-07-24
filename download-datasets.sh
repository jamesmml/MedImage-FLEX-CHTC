# NOTE:
# - First argument ($1) is the output file path where the .zip file will be saved
# - The .zip file MUST be named datasets.zip
# - The file should be stored to your staging directory
#
# Example: /staging/b/bucky/datasets.zip
wget -O "$1" "https://huggingface.co/datasets/jamesmml/medimage-flex-public-datasets/resolve/main/medimage-flex-public-datasets.zip"