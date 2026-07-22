# MedImage-FLEX-CHTC: Medical Image Foundation Latent Embedding eXamination (UW-Madison Internal Use)

## Setup
1. Clone the GitHub repo locally
2. Build your environment (see [`Dockerfile`](Dockerfile))
```
# Example
docker build -t medimage-flex-bucky-model:v1 .
docker tag medimage-flex-bucky-model:v1 bucky/medimage-flex-bucky-model:v1
docker push bucky/medimage-flex-bucky-model:v1
```
3. Copy bash scripts to access point
```
scp *.sh bucky@ap2002.chtc.wisc.edu:/home/bucky 
```
4. Download the datasets to your staging directory (see [`download-datasets.sh`](download-datasets.sh))
```
bash download-datasets.sh /staging/b/bucky/datasets.zip
```
## Running the Testbench
1. Choose your model 
2. Add its `model_id` and loading logic to [`testbench/scripts/models.py`](testbench/scripts/models.py)
3. Create a model configuration JSON file with respect to the format in [`CONFIG_JSON.md`](CONFIG_JSON.md)
4. Copy testbench code to access point
```
scp -r testbench/ bucky@ap2002.chtc.wisc.edu:/home/bucky
scp config.json bucky@ap2002.chtc.wisc.edu:/home/bucky
```
5. Create a submit file (see [`sample.sub`](sample.sub), [`execute-testbench.sh`](execute-testbench.sh))
6. Run the testbench
```
# Example
condor_submit sample.sub
```
7. MedImage-FLEX-CHTC offers default model logic as a convenience for three popular frameworks: PyTorch, HuggingFace, and TensorFlow. If a model requires specific logic not handled by default, edit [`testbench/scripts/model_interface.py`](testbench/scripts/model_interface.py), [`testbench/scripts/custom_transforms.py`](testbench/scripts/custom_transforms.py) as needed.

**NOTE: Any personal access tokens or keys for models must be loaded locally**