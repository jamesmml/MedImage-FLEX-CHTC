# Ubuntu base image
FROM ubuntu:22.04

# Install system utilities
RUN apt-get update && apt-get install -y wget unzip libgomp1 && rm -rf /var/lib/apt/lists/*

# Download and install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/miniconda && \
    rm /tmp/miniconda.sh

# Add Conda to the system path
ENV PATH="/opt/miniconda/bin:${PATH}"

# Force the dynamic linker to check Conda-packaged binaries first 
ENV LD_LIBRARY_PATH="/opt/miniconda/lib"

# Accept Conda TOS
ENV CONDA_PLUGINS_AUTO_ACCEPT_TOS=true

# Disable pip's local cache to keep container lean
ENV PIP_NO_CACHE_DIR=1

# Force PyTorch to not use triton (triton has caused issues, remove if it is needed)
ENV TORCH_USE_TRITON=0

# Set a working directory
WORKDIR /app

# Create a universally writable cache space inside the container
RUN mkdir -p /tmp/cache && chmod 777 /tmp/cache

# Bypass Python username lookups by forcing frameworks to use a global cache
ENV HOME=/tmp/cache
ENV XDG_CACHE_HOME=/tmp/cache
ENV TORCHINDUCTOR_CACHE_DIR=/tmp/cache

# Download the testbench dependencies
COPY ./environment/* .
RUN bash ./setup.sh && rm ./setup.sh ./dependencies.yml

# NOTE: Add your model's environment config file
COPY ./conda_envs/cxr-foundation.yml .

# Download the model dependencies
RUN conda clean --all -y && \
    conda env update --name base --file ./cxr-foundation.yml && \
    conda clean --all -y && rm ./cxr-foundation.yml