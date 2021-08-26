#!/bin/bash
set -e
mkdir -p builds

if [ ! -e builds/numpy ]; then
  git clone https://github.com/colesbury/numpy -b v1.19.3-nogil builds/numpy
fi

docker run -v `pwd`:/io nogil/manylinux2014_x86_64 /io/build-numpy-wheel.sh
