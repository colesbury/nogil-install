#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    "${PYBIN}/pip" wheel /io/builds/scikit-learn -w /io/wheelhouse/
done

repair_wheel /io/wheelhouse/scikit_learn-0.24.2-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
