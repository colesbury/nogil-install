#!/bin/bash
set -e

package=cffi
version=1.14.6
url="git+https://github.com/colesbury/cffi.git@v${version}-nogil"
yum_packages=libffi-devel

source build-generic.sh
