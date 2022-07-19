#/bin/bash
set -e

source ../build-common.sh

function build_image {
    docker build --rm \
        -t "nogil/tensorflow-$1" \
        --build-arg BASE_IMG="nosla-$1-multipython" \
        --build-arg PYTHON_VERSION="${PYTHON_VERSION}" \
        --build-arg SOABI="${SOABI}" \
        .
    docker push "nogil/tensorflow-$1"
}

build_image cuda11.2-cudnn8.1-ubuntu18.04-manylinux2014
build_image cuda11.2-cudnn8.1-ubuntu20.04-manylinux2014
