#!/bin/bash
set -e

package=Cython
version=0.29.27
url="git+https://github.com/colesbury/cython.git@${version}-nogil"
yum_packages=

source build-generic.sh
