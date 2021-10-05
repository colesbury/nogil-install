#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

filename=$(echo "$package" | tr '-' '_')

source /io/preinstall-rust.sh

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    "${PYBIN}/pip" download --no-binary="$package" "$package==$version"
    "${PYBIN}/pip" wheel "$package-$version.tar.gz" -w /io/wheelhouse/
done

mv /io/wheelhouse/$filename-$version-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl /io/wheelhouse/$filename-$version-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
repair_wheel /io/wheelhouse/$filename-$version-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
