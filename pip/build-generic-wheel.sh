#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

export NPY_NUM_BUILD_JOBS=20
export SKLEARN_BUILD_PARALLEL=20

yum_packages=${yum_packages:-}
preinstall_file=${preinstall_file:-}
filename=$(echo "$package" | tr '-' '_')

export PATH="/opt/python/$SOABI/bin:$PATH"

# Install a system package required by our library
if [[ ! -z "${yum_packages}" ]]; then
    yum install -y $yum_packages
fi
if [[ ! -z "${preinstall_script}" ]]; then
    eval "${preinstall_script}"
fi
if [[ ! -z "${preinstall_file}" ]]; then
    source "/io/$preinstall_file"
fi

# Compile wheels
if [[ ! -z "${pip_packages}" ]]; then
    pip install $pip_packages
fi
if [[ ! -z "${url}" ]]; then
    pip wheel "${url}" -w /io/wheelhouse/
else
    pip download --no-binary="$package" "$package==$version"
    pip wheel "$package-$version.tar.gz" -w /io/wheelhouse/
fi

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
