curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -f -p $HOME/miniconda3
source $HOME/miniconda3/bin/activate

conda create -y -n llvmbase
conda activate llvmbase
conda install -y -c numba/label/manylinux2014 llvmdev