#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    pushd /io/builds
    "${PYBIN}/pip" download "matplotlib==3.4.3"
    "${PYBIN}/pip" wheel matplotlib-3.4.3.tar.gz -w /io/wheelhouse/
done

repair_wheel /io/wheelhouse/matplotlib-3.4.3-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
repair_wheel /io/wheelhouse/kiwisolver-1.3.1-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
