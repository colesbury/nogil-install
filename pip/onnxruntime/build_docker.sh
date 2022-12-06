#/bin/bash
set -e

source ../build-common.sh

function build_image {
    CUDA_IMAGE="$1"
    docker build --rm \
        -t "nogil/${CUDA_IMAGE}" \
        --build-arg CUDA_IMAGE="${CUDA_IMAGE}" \
        --build-arg PYTHON_VERSION="${PYTHON_VERSION}" \
        --build-arg SOABI="${SOABI}" \
        .
    #docker push "nogil/${CUDA_IMAGE}"
}

build_image manylinux-onnxruntime-cuda116
