#!/bin/bash
set -e

preinstall_script="export GRPC_PYTHON_BUILD_WITH_CYTHON=1"
package=grpcio
version=1.47.0
url="git+https://github.com/grpc/grpc.git@v${version}"
#yum_packages="libxml2-devel libxslt-devel"
pip_packages=cython

source build-generic.sh
