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

## Dataset Protocol

Dataset downloads are pinned to explicit Kaggle versions. Exact-content duplicate
exclusions are stored in [`testbench/dataset_audits`](testbench/dataset_audits), validated against metadata and image
IDs at load time, and identified by SHA-256 in each result.

PAD-UFES uses patient-grouped folds. HAM10000 uses lesion-grouped folds because
patient identifiers are unavailable. CheXpert retains frontal and lateral views as
separate radiograph samples but keeps every image from one patient in one fold; its
primary uncertainty policy is documented in `CONFIG_JSON.md`. CBIS-DDSM evaluates
the third-party JPEG full-mammogram derivative as an abnormality-enriched dataset,
with source partitions pooled for patient-grouped cross-validation.

ODIR uses the original `data.xlsx` patient annotations, not the derived one-hot
`full_df.csv`. Each evaluation sample is one patient represented by the normalized
mean of the left- and right-eye embeddings and an eight-element multilabel target.

Each dataset result includes lightweight provenance metadata. The data audit records
a traversal-independent SHA-256 over retained sample IDs and another over canonical
sample/group/processed-label records. These fingerprints document dataset semantics;
they do not hash image bytes or establish clinical label correctness. The existing
ordered sample-ID hashes remain separate because they document embedding row order.
Results also record a canonical configuration SHA-256, Git commit and separate
tracked/untracked-worktree state, Python runtime, platform, and relevant package
versions.