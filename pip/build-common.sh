#!/bin/bash

SOABI="nogil39-nogil_39b_x86_64_linux_gnu"
PYTHON_VERSION=3.9.10

function repair_wheel {
    wheel="$1"
    if ! auditwheel show "$wheel"; then
        echo "Skipping non-platform wheel $wheel"
    else
        pushd /io
        auditwheel repair "$wheel" -w /io/wheelhouse/
        popd
    fi
}

BUCKET=pypi.sam-gross.com

function upload_wheel {
    MY_DIR=$(dirname "${BASH_SOURCE[0]}")
    $MY_DIR/upload_wheel.sh "$1"
}
