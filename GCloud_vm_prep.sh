#!/bin/bash




bash ./tmp/install_cuda_and_conda.sh
conda create --name torch python=3
source activate torch

### TOOLS
sudo apt-get install -y unzip
sudo apt-get install -y tree
pip install kaggle-cli
conda install libgcc
pip install bcolz

#   3.  PyTorch
conda install pytorch torchvision cuda91 -c pytorch
#   4.  dominate  (just for running https://github.com/NVIDIA/pix2pixHD)
pip install dominate

































