#!/bin/bash
set -e

package=pglast
version=3.8
url="git+https://github.com/colesbury/pglast.git@v${version}-nogil"
pip_packages=cython
yum_packages=

source build-generic.sh
