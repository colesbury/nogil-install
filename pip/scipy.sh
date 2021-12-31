#!/bin/bash
set -e

package=scipy
version=1.7.1
url="git+https://github.com/colesbury/scipy.git@v${version}-nogil"
yum_packages="openblas-devel"

source build-generic.sh
