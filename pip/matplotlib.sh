#!/bin/bash
set -e

docker run -v `pwd`:/io nogil/manylinux2014_x86_64 /io/build-matplotlib-wheel.sh
./upload_wheel.sh wheelhouse/matplotlib-3.4.3-nogil_39_x86_64_linux_gnu-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
