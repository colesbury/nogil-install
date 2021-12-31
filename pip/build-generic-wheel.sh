#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

export NPY_NUM_BUILD_JOBS=20

yum_packages=${yum_packages:-}
preinstall_file=${preinstall_file:-}
filename=$(echo "$package" | tr '-' '_')

# Install a system package required by our library
if [[ ! -z "${yum_packages}" ]]; then
    yum install -y $yum_packages
fi
if [[ ! -z "${preinstall_file}" ]]; then
    source "/io/$preinstall_file"
fi
if [[ ! -z "${preinstall_script}" ]]; then
    eval "${preinstall_script}"
fi

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    if [[ ! -z "${url}" ]]; then
        "${PYBIN}/pip" wheel "${url}" -w /io/wheelhouse/
    else
        "${PYBIN}/pip" download --no-binary="$package" "$package==$version"
        "${PYBIN}/pip" wheel "$package-$version.tar.gz" -w /io/wheelhouse/
    fi
done

wheel="/io/wheelhouse/$filename-$version-nogil39-nogil_39b_x86_64_linux_gnu-linux_x86_64.whl"

if [[ ! -z "${postinstall_script}" ]]; then
    eval "${postinstall_script}"
fi

if [[ ! -f "$wheel" ]]; then
    # orjson names the wheel incorrectly; fix it here
    cpwheel="/io/wheelhouse/$filename-$version-cp39-cp39-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
    if [[ -f "$cpwheel" ]]; then
        mv "$cpwheel" "$wheel"
    fi
fi

repair_wheel "$wheel"
