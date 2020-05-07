Note: need to edit meta.yaml numpy version from 1.11 to 1.14
to match https://github.com/AnacondaRecipes/aggregate/blob/master/conda_build_config.yaml

```
git clone https://github.com/pytorch/builder.git pytorch-builder
cd pytorch-builder

sudo docker run -it --ipc=host --rm -v $(pwd):/remote pytorch/conda-cuda bash

yum install -y yum-utils centos-release-scl
yum-config-manager --enable rhel-server-rhscl-7-rpms
yum install -y devtoolset-3-gcc devtoolset-3-gcc-c++ devtoolset-3-gcc-gfortran devtoolset-3-binutils
export PATH=/opt/rh/devtoolset-3/root/usr/bin:$PATH
export LD_LIBRARY_PATH=/opt/rh/devtoolset-3/root/usr/lib64:/opt/rh/devtoolset-3/root/usr/lib:$LD_LIBRARY_PATH
cd remote/conda

ln -sf pytorch-nightly pytorch-1.4.1

export PYTORCH_FINAL_PACKAGE_DIR="/remote"
export TORCH_CONDA_BUILD_FOLDER=pytorch-1.4.1
export PYTORCH_REPO=colesbury
export PYTORCH_BRANCH=v1.4.1-nogil
export ANACONDA_USER=colesbury
export DESIRED_PYTHON=3.9

./build_pytorch.sh 101 1.4.1 1 # cuda 10.0 pytorch 1.0.1 build_number 1
```
