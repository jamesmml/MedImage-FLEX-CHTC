# Install testbench dependencies
conda env update --name base --file ./dependencies.yml

# Install deep learning frameworks as needed
conda run -n base pip install --index-url https://download.pytorch.org/whl/cpu torch torchvision
conda run -n base pip install tensorflow-cpu