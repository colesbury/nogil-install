#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

yum install -y libffi-devel

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    "${PYBIN}/pip" wheel /io/builds/cffi -w /io/wheelhouse/
done

repair_wheel /io/wheelhouse/cffi-1.14.6-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
