#!/bin/bash
set -e

# note "pip wheel scipy-version.zip" doesn't work
# but "pip wheel scipy-url" does

pip_packages="numpy pybind11 pythran cython"  # for sdist
package=scipy
version=1.8.0
url="git+https://github.com/colesbury/scipy.git@v${version}-nogil"
yum_packages="openblas-devel gcc-gfortran lapack-devel"

source build-generic.sh
