#!/bin/bash
set -e

docker run -v `pwd`:/io nogil/manylinux2014_x86_64 /io/build-lxml-wheel.sh
./upload_wheel.sh wheelhouse/lxml-4.6.3-nogil39-nogil_39_x86_64_linux_gnu-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
