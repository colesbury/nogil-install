#!/bin/bash
set -e
mkdir -p builds

if [ ! -e builds/scikit-learn ]; then
  git clone --recurse-submodules https://github.com/colesbury/scikit-learn -b 0.24.2 builds/scikit-learn
fi

docker run -v `pwd`:/io nogil/numpy /io/build-scikit-learn-wheel.sh
# ./upload_wheel.sh wheelhouse/scikit-learn-0.24.2-nogil_39_x86_64_linux_gnu-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
