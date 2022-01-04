#!/bin/bash
set -e

package=llvmlite
version=0.37.0
yum_packages=zlib-devel
preinstall_file=preinstall-llvm.sh

source build-generic.sh
