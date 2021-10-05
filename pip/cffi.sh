#!/bin/bash
set -e
mkdir -p builds

if [ ! -e builds/cffi ]; then
  git clone https://github.com/colesbury/cffi -b v1.14.6-nogil builds/cffi
fi

docker run -v `pwd`:/io nogil/manylinux2014_x86_64 /io/build-cffi-wheel.sh
./upload_wheel.sh wheelhouse/cffi-1.14.6-nogil39-nogil_39_x86_64_linux_gnu-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
