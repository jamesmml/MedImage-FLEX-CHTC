# Use a Miniconda image (version 26.3.2) as the base
FROM anaconda/miniconda:26.3.2

# Obtain the unzip utility
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# Set a working directory
WORKDIR /app

# NOTE: Add your model's environment config file
COPY ./conda_envs/medflamingo.yml .

# Download the testbench dependencies
COPY ./environment ./environment
RUN python ./environment/setup.py && rm -rf /environment

# Download the model dependencies
# NOTE: Add or remove channels as needed
RUN conda clean --all -y && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r && \
    conda env update --name base --file ./medflamingo.yml && \
    conda clean --all -y && rm ./medflamingo.yml