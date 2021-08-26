#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

yum install -y zlib libjpeg-devel libtiff-devel freetype-devel \
    lcms2-devel libwebp-devel harfbuzz-devel ghostscript libffi-devel \
    ImageMagick fribidi-devel

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    pushd /io/builds
    "${PYBIN}/pip" download "Pillow==8.3.1"
    "${PYBIN}/pip" wheel Pillow-8.3.1.tar.gz -w /io/wheelhouse/
done

repair_wheel /io/wheelhouse/Pillow-8.3.1-nogil39-nogil_39_x86_64_linux_gnu-linux_x86_64.whl
