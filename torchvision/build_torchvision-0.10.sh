#!/bin/bash
set -e
set -x
hostname
tmpdir=$(mktemp -d /scratch/torchvision.XXXXXX)
pushd $tmpdir

if ! sudo docker version > /dev/null; then
    sudo killall -9 unattended-upgrade unattended-upgrade-shutdown || true
    sleep 1
    sudo killall -9 unattended-upgrade unattended-upgrade-shutdown || true
    sudo apt install -y docker.io
    sudo usermod -aG docker $USER  # add myself to docker group
    newgrp docker  # activate group
fi

CHANNEL=${CHANNEL:-colesbury}
echo "CHANNEL=${CHANNEL}"

git clone https://github.com/colesbury/vision.git -b v0.10.0-nogil torchvision

HOME=$tmpdir \
docker run --ipc=host --rm \
    -e PACKAGE_TYPE=conda \
    -e CU_VERSION=cu110 \
    -e PYTHON_VERSION=3.9 \
    -e PYTORCH_VERSION=1.9.0 \
    -e CONDA_CHANNEL="${CHANNEL}" \
    -e PYTORCH_FINAL_PACKAGE_DIR="/final_pkgs" \
    -w /torchvision \
    -v "$(pwd)/torchvision":/torchvision \
    -v "$(pwd):/final_pkgs" \
    pytorch/conda-cuda \
    /torchvision/packaging/build_conda.sh

/fsx/sgross/Miniconda3-py37_4.8.3-Linux-x86_64.sh -b -p $tmpdir/miniconda
_CONDA_ROOT="$tmpdir/miniconda"
\. "$_CONDA_ROOT/etc/profile.d/conda.sh"
conda activate
conda install conda-build anaconda-client -y

anaconda upload --user $CHANNEL torchvision*.bz2

popd
sudo rm -rf $tmpdir
