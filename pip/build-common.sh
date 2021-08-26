#!/bin/bash



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
    filename="$1"
    aws s3 cp "$filename" "$BUCKET/$filename"
}