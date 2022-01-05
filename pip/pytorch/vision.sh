#!/bin/bash
set -eu

source ../build-common.sh

function build_torchvision {
    VERSION="$1"
    PYTORCH_VERSION="$2"
    CUDA_IMAGE="manylinux-cuda$3"
    PYMAJ_MIN=$(echo $PYTHON_VERSION | sed 's/\.[[:digit:]]\+$//')
    CU_VERSION="cu$3"
    wheel="torchvision-$VERSION+$CU_VERSION-$SOABI-manylinux1_x86_64.whl"
    docker run --rm \
        -v `pwd`/../wheelhouse:/wheelhouse \
        -e CU_VERSION=${CU_VERSION} \
        -e PYTORCH_VERSION=${PYTORCH_VERSION} \
        -e BUILD_VERSION=${VERSION} \
        -e PYTHON_VERSION=${PYMAJ_MIN} \
        nogil/$CUDA_IMAGE \
        /bin/bash -c "\
        git clone https://github.com/pytorch/vision.git -b v${VERSION} vision && \
        cd vision && \
        export PATH=/opt/python/$SOABI/bin:\$PATH && \
        pip install torch==$PYTORCH_VERSION && \
        sed -i -E 's/(setup_pip_pytorch_version\(\) \{)/\1 return;/' packaging/pkg_helpers.bash && \
        packaging/build_wheel.sh && \
        mv dist/torchvision-$VERSION+$CU_VERSION-$SOABI-linux_x86_64.whl /wheelhouse/$wheel"
    upload_wheel ../wheelhouse/$wheel
}

build_torchvision 0.10.0 1.9.0 110
