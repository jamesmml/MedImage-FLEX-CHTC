# First argument ($1) is the path to the.zip file containing the datasets
unzip "$1" -d ../datasets/ && rm "$1"