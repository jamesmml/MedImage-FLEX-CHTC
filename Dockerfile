# Use a Miniconda image (version 26.3.2) as the base
FROM anaconda/miniconda:26.3.2

# Set a working directory
WORKDIR /app

# Load testbench (manual build, use git pull to obtain most recent version)
COPY . .

# NOTE: Add your model's environment config file
COPY ./conda_envs/medflamingo.yml .

# Download the testbench dependencies
RUN python ./testbench/environment/setup.py

# Download the model dependencies
# NOTE: Add or remove channels as needed 
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r && \
    conda env update --name base --file ./medflamingo.yml && \
    conda clean --all -y && rm ./medflamingo.yml