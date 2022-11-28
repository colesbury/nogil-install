#!/bin/bash
set -e

package=onnx
version=1.11.0
url="git+https://github.com/colesbury/onnx.git@v${version}-nogil"
preinstall_file="preinstall-protobuf.sh"
preinstall_script="export ONNX_ML=1"

source build-generic.sh
