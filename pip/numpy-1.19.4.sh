#!/bin/bash
set -e

package=numpy
version=1.19.4
url="git+https://github.com/colesbury/numpy.git@v${version}-nogil"
yum_packages="openblas-devel"

source build-generic.sh
