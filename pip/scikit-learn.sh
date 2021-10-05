#!/bin/bash
set -e
mkdir -p builds

docker run -v `pwd`:/io nogil/numpy /io/build-scikit-learn-wheel.sh
./upload_wheel.sh wheelhouse/scikit_learn-1.0-nogil39-nogil_39_x86_64_linux_gnu-manylinux_2_17_x86_64.manylinux2014_x86_64.whl