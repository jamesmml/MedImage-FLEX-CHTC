# NVIDIA's official CUDA runtime image as the base
FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04

# Install system utilities
RUN apt-get update && apt-get install -y wget unzip libgomp1 && rm -rf /var/lib/apt/lists/*

# Download and install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/miniconda && \
    rm /tmp/miniconda.sh

# Add Conda to the system path
ENV PATH="/opt/miniconda/bin:$PATH"

# Set a working directory
WORKDIR /app

# Create a universally writable cache space inside the container
RUN mkdir -p /tmp/cache && chmod 777 /tmp/cache

# Bypass Python username lookups by forcing frameworks to use a global cache
ENV HOME=/tmp/cache
ENV XDG_CACHE_HOME=/tmp/cache
ENV TORCHINDUCTOR_CACHE_DIR=/tmp/cache

# Download the testbench dependencies
COPY ./environment/dependencies.yml .
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r && \
    conda env update --name base --file ./dependencies.yml && rm ./dependencies.yml

# NOTE: Add your model's environment config file
COPY ./conda_envs/medflamingo.yml .

# Download the model dependencies
# NOTE: Add or remove channels as needed
RUN conda clean --all -y && \
    conda env update --name base --file ./medflamingo.yml && \
    conda clean --all -y && rm ./medflamingo.yml && \
    pip uninstall -y triton