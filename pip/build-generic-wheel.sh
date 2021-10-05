#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

export NPY_NUM_BUILD_JOBS=20

yum_packages=${yum_packages:-}

# Install a system package required by our library
if [[ ! -z "${yum_packages}" ]]; then
    yum install -y $yum_packages
fi

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    "${PYBIN}/pip" download "$package==$version"
    "${PYBIN}/pip" wheel "$package-$version.tar.gz"
done
repair_wheel /io/wheelhouse/$package-$version-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
