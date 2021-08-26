#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

export NPY_NUM_BUILD_JOBS=20

# Install a system package required by our library
yum install -y openblas-devel

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    "${PYBIN}/pip" wheel /io/builds/scipy -w /io/wheelhouse/
done

repair_wheel /io/wheelhouse/scipy-1.7.1-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
