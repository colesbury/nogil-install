#!/bin/bash
set -e

# NOTE: must git tag nogil branch as release!

package=numpy
version=1.22.3
url="git+https://github.com/colesbury/numpy.git@v${version}-nogil"
preinstall_script="export NPY_USE_BLAS_ILP64=1"
preinstall_file="preinstall-openblas.sh"

source build-generic.sh
