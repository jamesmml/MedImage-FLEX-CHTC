# Install testbench dependencies
conda env update --name base --file ./dependencies.yml

# Install deep learning frameworks as needed:
# PyTorch with CUDA acceleration
conda run -n base pip install --force-reinstall --index-url https://download.pytorch.org/whl/cu121 torch torchvision
conda run -n base pip install --force-reinstall tensorflow-cpu

# TensorFlow with CUDA acceleration
# conda run -n base pip install --force-reinstall tensorflow[and-cuda]==2.16.1
# conda run -n base pip install --force-reinstall --index-url https://download.pytorch.org/whl/cpu torch torchvision