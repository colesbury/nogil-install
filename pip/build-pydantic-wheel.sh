#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    pushd /io/builds
    "${PYBIN}/pip" download --no-binary pydantic "pydantic==1.8.2"
    "${PYBIN}/pip" install cython
    "${PYBIN}/pip" wheel pydantic-1.8.2.tar.gz -w /io/wheelhouse/
done

repair_wheel /io/wheelhouse/pydantic-1.8.2-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
