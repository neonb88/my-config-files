#!/bin/bash

#!/bin/bash
cd ~/

### CUDA
echo "\n\nChecking for CUDA and installing."
if ! dpkg-query -W cuda; then
  curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
  sudo dpkg -i ./cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
  sudo apt-get update
  sudo apt-get install cuda -y
fi

### Anaconda
echo "\n\nAnaconda Install: Interactive"
wget https://repo.continuum.io/archive/Anaconda3-4.3.0-Linux-x86_64.sh
bash Anaconda3-4.3.0-Linux-x86_64.sh

### bashrc
mv ~/.bashrc ~/.bashrc.bak
echo "
#
# ADDITIONAL BASH
#
alias vibash='vi ~/.bashrc'
alias sourcebash='. ~/.bashrc'
lsports(){ sudo lsof -n -i | grep $1 | grep LISTEN ; }


#### EXPORTS/DIRS
cdusf(){ cd $HOME/usf/$1; }

# config
export DATA=$HOME/data
export WEIGHTS=$HOME/weights
cddata(){ cd $DATA/$1; }
cdweights(){ cd $WEIGHTS/$1; }

# cuda
export CUDA_HOME=/usr/local/cuda-8.0 
export LD_LIBRARY_PATH=$CUDA_HOME/lib64
PATH=$CUDA_HOME/bin:$PATH 
export PATH

#### HELPERS

# gcloud
alias gconfig='gcloud config configurations activate' 
alias gssh='gcloud compute ssh' 


# files
alias sampletree='mkdir -p sample/{train,test,valid}'
lsn(){ matchdir=`pwd`/$2; find $matchdir -type f | grep -v sample | shuf -n $1 | awk -F`pwd` '{print "."$NF}' ; }
cpn(){ matchdir=`pwd`/$2; find $matchdir -type f | grep -v sample | shuf -n $1 | awk -F`pwd` '{print "."$NF" sample"$NF}' | xargs -t -n2 cp ; }
mvn(){ matchdir=`pwd`/$2; todir=`pwd`/$3; find $matchdir -type f | grep -v sample | shuf -n $1 | awk -F`pwd` -v todir="$todir" '{print $0" "todir}' | xargs -t -n2 mv ; }
cpnh(){ matchdir=`pwd`/$2; find $matchdir -type f | grep -v sample | head -n $1 | awk -F`pwd` '{print "."$NF" sample"$NF}' | xargs -t -n2 cp ; }
mvnh(){ matchdir=`pwd`/$2; todir=`pwd`/$3; find $matchdir -type f | grep -v sample | head -n $1 | awk -F`pwd` -v todir="$todir" '{print $0" "todir}' | xargs -t -n2 mv ; }
cpnt(){ matchdir=`pwd`/$2; find $matchdir -type f | grep -v sample | tail -n $1 | awk -F`pwd` '{print "."$NF" sample"$NF}' | xargs -t -n2 cp ; }
mvnt(){ matchdir=`pwd`/$2; todir=`pwd`/$3; find $matchdir -type f | grep -v sample | tail -n $1 | awk -F`pwd` -v todir="$todir" '{print $0" "todir}' | xargs -t -n2 mv ; }


# anaconda
alias sd='source deactivate'
sa(){ source activate $1; }
alias jnb='jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser &'

# keras
kerastf() {
    rm -rf ~/.keras/keras.json
    cp ~/.keras/keras.json.tensor ~/.keras/keras.json
    cat ~/.keras/keras.json
}
kerasth() {
    rm -rf ~/.keras/keras.json
    cp ~/.keras/keras.json.theano ~/.keras/keras.json
    cat ~/.keras/keras.json
}
kerastfth() {
    rm -rf ~/.keras/keras.json
    cp ~/.keras/keras.json.tensorth ~/.keras/keras.json
    cat ~/.keras/keras.json
}



#
# INITIAL BASH
#

" > ~/.bashrc  
cat ~/.bashrc.bak >> ~/.bashrc 
source ~/.bashrc

### DIRECTORIES
mkdir $DATA
mkdir $WEIGHTS

### ML
conda install -y pytorch torchvision cuda80 -c soumith

### THEANO
conda install -y theano
echo '
[cuda] 
root = /usr/local/cuda-8.0
'>>~/.theanorc

### Tensorflow
echo "\n\nTensorFlow Install:"
TF=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.0.0-cp36-cp36m-linux_x86_64.whl
pip install --ignore-installed --upgrade $TF

### KERAS
pip install keras
# keras tensorflow setup
echo '{
    "image_dim_ordering": "tf",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "tensorflow"
}' > ~/.keras/keras.json.tensor
# keras theano setup
echo '{
    "image_dim_ordering": "th",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "theano"
}' > ~/.keras/keras.json.theano
# keras tensorflow-th setup
echo '{
    "image_dim_ordering": "th",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "tensorflow"
}' > ~/.keras/keras.json.tensorth































































