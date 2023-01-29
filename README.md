# nVidia 525 + Cuda 11.8 + Python 3.10 + pyTorch GPU Docker image

It is a base environment for torch with GPU support (including 3090Ti!) that can be used for working with AI models. 
This image requires `nvidia-driver-525` and `nvidia-docker2` installed on host. 
WARNING! It needs ~30GB!

## Download
```bash 
$ git clone https://github.com/ordigital/nvidia-525-cuda-11.8-python-3.10-pytorch.git 
$ cd nvidia-525-cuda-11.8-python-3.10-pytorch
```

## Build
```bash
$ docker build -t nvidia-cuda .
```
## Run
```bash
$ docker run --gpus all -it nvidia-cuda
```
## Test
Run inside container:
```bash
$ conda activate env
$ python
```
```python
>>> include torch
>>> torch.cuda.is_available() 
```
