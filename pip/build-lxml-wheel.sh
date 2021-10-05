#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

yum install -y libxml2-devel libxslt-devel

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    pushd /io/builds
    "${PYBIN}/pip" download "lxml==4.6.3"
    "${PYBIN}/pip" wheel lxml-4.6.3.tar.gz -w /io/wheelhouse/
done

repair_wheel /io/wheelhouse/lxml-4.6.3-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
