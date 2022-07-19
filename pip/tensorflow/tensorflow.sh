#/bin/bash
set -e

source ../build-common.sh

TENSORFLOW_VERSION=2.6.5

if [[ ! -e tensorflow ]]; then
    git clone https://github.com/colesbury/tensorflow.git -j 20 --recurse-submodules -b v${PYTORCH_VERSION}-nogil
fi
mkdir -p final_pkgs

function build_pytorch {
    DOCKER_IMAGE="$1"
    docker run \
        --gpus all \
        -w /tensorflow \
        -v /raid/.cache:/root/.cache \
        -v `pwd`/tensorflow:/tensorflow \
        -v `pwd`:/mnt \
        -e HOST_PERMS="$(id -u):$(id -g)" \
        -it nogil/$DOCKER_IMAGE /bin/bash "tensorflow/tools/ci_build/rel/ubuntu/gpu_nogil39_pip.sh"

    #wheel="torch-${PYTORCH_VERSION}-${SOABI}-manylinux1_x86_64.whl"
    #cp final_pkgs/torch-${PYTORCH_VERSION}-${SOABI}-linux_x86_64.whl ../wheelhouse/$wheel
    #upload_wheel ../wheelhouse/$wheel
}

build_tensorflow tensorflow-manylinux
