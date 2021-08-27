#/bin/bash
set -e

if [ ! -e pytorch]; then
    git clone https://github.com/colesbury/pytorch.git -j 20 --recurse-submodules -b v1.9.0-nogil
fi
if [ ! -e pytorch-builder]; then
    git clone https://github.com/colesbury/builder.git pytorch-builder -b 1.9-nogil
fi
mkdir -p final_pkgs

docker run \
    -v `pwd`/pytorch-builder:/pytorch-builder \
    -v `pwd`/pytorch:/pytorch \
    -v `pwd`/final_pkgs:/final_pkgs \
    -w /pytorch-builder/manywheel \
    -e DESIRED_PYTHON=nogil39-nogil_39_x86_64_linux_gnu \
    -e PYTORCH_BUILD_VERSION=1.9.0 \
    -e PYTORCH_BUILD_NUMBER=1 \
    -e PYTORCH_FINAL_PACKAGE_DIR=/final_pkgs \
    -it nogil/pytorch ./build.sh
