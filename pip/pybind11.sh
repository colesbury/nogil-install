#!/bin/bash
set -e

package=pybind11
version=2.6.2
url="git+https://github.com/colesbury/pybind11.git@v${version}-nogil"

source build-generic.sh
