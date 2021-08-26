#!/bin/bash
set -e
mkdir -p builds

if [ ! -e builds/scipy ]; then
  git clone --recurse-submodules https://github.com/colesbury/scipy -b v1.7.1-nogil builds/scipy
fi

docker run -v `pwd`:/io nogil/numpy /io/build-scipy-wheel.sh
./upload_wheel.sh wheelhouse/scipy-1.7.1-nogil_39_x86_64_linux_gnu-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
