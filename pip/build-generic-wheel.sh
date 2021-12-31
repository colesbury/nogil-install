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
if [[ ! -z "${github_branch}" ]]; then
    curl -L "https://github.com/colesbury/$package/tarball/${github_branch}" -o "$package-$version.tar.gz"
fi

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    if [[ -z "${github_branch}" ]]; then
        "${PYBIN}/pip" download --no-binary="$package" "$package==$version"
    fi
    "${PYBIN}/pip" wheel "$package-$version.tar.gz" -w /io/wheelhouse/
done

repair_wheel /io/wheelhouse/$filename-$version-nogil39-nogil_39*_x86_64_linux_gnu-linux_x86_64.whl
