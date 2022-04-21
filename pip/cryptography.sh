#!/bin/bash
set -e

package=cryptography
version=36.0.2
url="git+https://github.com/colesbury/cryptography.git@${version}-nogil"
yum_packages="cargo libffi-devel"
preinstall_file="preinstall-openssl.sh"
pip_packages="setuptools-rust"  # setup.py sdist needs setuptools-rust

source build-generic.sh
