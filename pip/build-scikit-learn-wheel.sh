#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    "${PYBIN}/pip" download "scikit-learn==1.0"
    "${PYBIN}/pip" wheel scikit-learn-1.0.tar.gz -w /io/wheelhouse/
done

repair_wheel /io/wheelhouse/scikit_learn-1.0-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
