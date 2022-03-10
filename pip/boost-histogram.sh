#!/bin/bash
set -e

package=boost-histogram
version=1.3.1
url="git+https://github.com/colesbury/boost-histogram.git@v${version}-nogil"

source build-generic.sh
