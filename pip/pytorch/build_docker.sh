#/bin/bash
set -e

SOABI="nogil39-nogil_39b_x86_64_linux_gnu"
PYTHON_VERSION=3.9.9

function build_image {
    CUDA_IMAGE="$1"
    docker build --rm \
        -t "nogil/${CUDA_IMAGE}" \
        --build-arg CUDA_IMAGE="${CUDA_IMAGE}" \
        --build-arg PYTHON_VERSION="${PYTHON_VERSION}" \
        --build-arg SOABI="${SOABI}" \
        .
    docker push "nogil/${CUDA_IMAGE}"
}

build_image manylinux-cuda102
build_image manylinux-cuda110
build_image manylinux-cuda113