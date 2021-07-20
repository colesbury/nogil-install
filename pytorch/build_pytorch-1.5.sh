#!/bin/bash
set -e
set -x
hostname
tmpdir=$(mktemp -d /scratch/pytorch.XXXXXX)
pushd $tmpdir

if ! sudo docker version > /dev/null; then
    sudo apt install -y docker.io
    sudo usermod -aG docker $USER  # add myself to docker group
    newgrp docker  # activate group
fi

docker run hello-world

CHANNEL=${CHANNEL:-colesbury}
echo "CHANNEL=${CHANNEL}"

git clone https://github.com/colesbury/builder.git -b nogil pytorch-builder
git clone https://github.com/colesbury/pytorch.git -b v1.5.1-nogil pytorch

HOME=$tmpdir \
docker run --ipc=host --rm \
    -e PACKAGE_TYPE=conda \
    -e DESIRED_CUDA=cu101 \
    -e DESIRED_PYTHON=3.9 \
    -e PYTORCH_BUILD_VERSION=1.5.1 \
    -e PYTORCH_BUILD_NUMBER=1 \
    -e PYTORCH_FINAL_PACKAGE_DIR="/final_pkgs" \
    -e TORCH_CONDA_BUILD_FOLDER=pytorch-nightly \
    -e PYTORCH_REPO=colesbury \
    -e PYTORCH_BRANCH=v1.5.1-nogil \
    -e ANACONDA_USER="${CHANNEL}" \
    -v "$(pwd)/pytorch":/pytorch \
    -v "$(pwd)/pytorch-builder":/builder \
    -v "$(pwd):/final_pkgs" \
    pytorch/conda-cuda \
    /builder/conda/build_pytorch.sh

/fsx/sgross/Miniconda3-py37_4.8.3-Linux-x86_64.sh -b -p $tmpdir/miniconda
_CONDA_ROOT="$tmpdir/miniconda"
\. "$_CONDA_ROOT/etc/profile.d/conda.sh"
conda activate
conda install conda-build anaconda-client -y

anaconda upload --user $CHANNEL pytorch*.bz2

popd
sudo rm -rf $tmpdir
