#!/bin/bash
set -e

package=statsmodels
version=0.13.5
url="git+https://github.com/colesbury/statsmodels.git@v${version}-nogil"
yum_packages=

source build-generic.sh
