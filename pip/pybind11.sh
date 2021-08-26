#!/bin/bash
set -e
mkdir -p builds

if [ ! -e builds/pybind11 ]; then
  git clone https://github.com/colesbury/pybind11 -b v2.6.2-nogil builds/pybind11
fi

docker run -v `pwd`:/io nogil/manylinux2014_x86_64 /io/build-pybind11-wheel.sh
