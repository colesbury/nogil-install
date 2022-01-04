#!/bin/bash
set -exuo pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

export PATH="/opt/python/nogil39-nogil_39b_x86_64_linux_gnu/bin:$PATH"

cd /io/builds/jax

pip install numpy scipy six wheel
python build/build.py
