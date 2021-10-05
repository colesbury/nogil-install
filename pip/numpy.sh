#!/bin/bash
set -e
mkdir -p builds

if [ ! -e builds/numpy-1.19.3 ]; then
  git clone https://github.com/colesbury/numpy -b v1.19.3-nogil builds/numpy-1.19.3
fi

if [ ! -e builds/numpy-1.19.4 ]; then
  git clone https://github.com/colesbury/numpy -b v1.19.4-nogil builds/numpy-1.19.4
fi

docker run -v `pwd`:/io nogil/manylinux2014_x86_64 /io/build-numpy-wheel.sh
./upload_wheel.sh wheelhouse/numpy-1.19.3-nogil39-nogil_39_x86_64_linux_gnu-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
./upload_wheel.sh wheelhouse/numpy-1.19.4-nogil39-nogil_39_x86_64_linux_gnu-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
