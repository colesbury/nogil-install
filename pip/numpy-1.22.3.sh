#!/bin/bash
set -e

# NOTE: must git tag nogil branch as release!

package=numpy
version=1.22.3
url="git+https://github.com/colesbury/numpy.git@v${version}-nogil"
yum_packages="openblas-devel"

source build-generic.sh
