#!/bin/bash
set -e

# FIXME: wheel incorrectly named something like numpy-1.22.0+2.gae84e3df4

package=numpy
version=1.22.0
url="git+https://github.com/colesbury/numpy.git@v${version}-nogil"
yum_packages="openblas-devel"
postinstall_script="mv /io/wheelhouse/numpy-${version}+2.gae84e3df4-\$SOABI-linux_x86_64.whl \$wheel"

source build-generic.sh
