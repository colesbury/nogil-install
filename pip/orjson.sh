#!/bin/bash
set -e

package=orjson
version=3.6.4

docker run \
    -e package="$package" \
    -e version="$version" \
    -v `pwd`:/io nogil/manylinux2014_x86_64 \
    /io/build-orjson-wheel.sh

./upload_wheel.sh wheelhouse/$package-$version-nogil39-nogil_39_x86_64_linux_gnu-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
