#/bin/bash
set -e

source ../build-common.sh

PYTORCH_VERSION=1.9.0

if [[ ! -e pytorch ]]; then
    git clone https://github.com/colesbury/pytorch.git -j 20 --recurse-submodules -b v${PYTORCH_VERSION}-nogil
fi
if [[ ! -e pytorch-builder ]]; then
    git clone https://github.com/colesbury/builder.git pytorch-builder -b ${PYTORCH_VERSION}-nogil
fi
mkdir -p final_pkgs

function build_pytorch {
    CUDA_IMAGE="$1"
    docker run \
        --gpus all \
        -v `pwd`/pytorch-builder:/pytorch-builder \
        -v `pwd`/pytorch:/pytorch \
        -v `pwd`/final_pkgs:/final_pkgs \
        -e DESIRED_PYTHON="$SOABI" \
        -e PYTORCH_BUILD_VERSION=${PYTORCH_VERSION} \
        -e PYTORCH_BUILD_NUMBER=1 \
        -e PYTORCH_FINAL_PACKAGE_DIR=/final_pkgs \
        -it nogil/$CUDA_IMAGE /bin/bash -c "cd /pytorch-builder/manywheel && ./build.sh"

    wheel="torch-${PYTORCH_VERSION}-${SOABI}-manylinux1_x86_64.whl"
    cp final_pkgs/torch-${PYTORCH_VERSION}-${SOABI}-linux_x86_64.whl ../wheelhouse/$wheel
    upload_wheel ../wheelhouse/$wheel
}

build_pytorch manylinux-cuda110
