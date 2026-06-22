# --- BUILD ---
# Use a Miniconda image (version 26.3.2) as the base
FROM anaconda/miniconda:26.3.2

# Set a working directory
WORKDIR /app

# Load testbench (manual build, use git pull to obtain most recent version)
COPY . .

# FIXME: Add your model's environment config file
COPY ./conda_envs/medflamingo.yml .

# Download the testbench dependencies
RUN python ./testbench/environment/setup.py

# Download the model dependencies
RUN conda env update --name base --file ./medflamingo.yml && \
    conda clean --all -y && rm ./medflamingo.yml

# --- EXECUTE ---
ENTRYPOINT ["bash", "./execute-testbench.sh"]