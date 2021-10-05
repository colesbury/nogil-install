#!/bin/bash
set -e

docker run -v `pwd`:/io nogil/manylinux2014_x86_64 /io/build-pydantic-wheel.sh
./upload_wheel.sh wheelhouse/pydantic-1.8.2-nogil39-nogil_39_x86_64_linux_gnu-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
