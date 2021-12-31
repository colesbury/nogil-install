#!/bin/bash
set -e

package=Cython
version=0.29.26
github_branch="${version}-nogil"
yum_packages=

source build-generic.sh
