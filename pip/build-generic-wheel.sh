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

# Delete old wheels (we don't to use them by accident)
rm -f "/io/wheelhouse/$filename-$version-*.whl" || true

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

wheels=($(find /io/wheelhouse/ -name "$filename-$version-*.whl"))
if [ ${#wheels[@]} -eq 0 ]; then
    echo "no wheel matching '$filename-$version-\*.whl'" >&2
    exit 1
elif [ ${#wheels[@]} -eq 1 ]; then
    wheel=${wheels[0]}
fi

if [[ ! -z "${postinstall_script}" ]]; then
    eval "${postinstall_script}"
fi

if [[ $wheel =~ "cp3-cp39-manylinux" ]]; then
    # orjson names the wheel incorrectly; fix it here
    fixed_wheel="/io/wheelhouse/$filename-$version-$SOABI-linux_x86_64.whl"
    mv "$wheel" "$fixed_wheel"
    wheel="$fixed_wheel"
fi

if [[ $wheel =~ "linux_x86_64.whl" ]]; then
    repair_wheel "$wheel"
fi
