#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    "${PYBIN}/pip" wheel /io/builds/pybind11 -w /io/wheelhouse/
done

repair_wheel /io/wheelhouse/pybind11-2.6.2-py2.py3-none-any.whl
