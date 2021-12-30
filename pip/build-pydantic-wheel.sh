#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    pushd /io/builds
    "${PYBIN}/pip" install cython
    "${PYBIN}/pip" wheel /io/builds/pydantic-1.8.2 -w /io/wheelhouse/
done

repair_wheel /io/wheelhouse/pydantic-1.8.2-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
