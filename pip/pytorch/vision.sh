#!/bin/bash
set -eu

if [ ! -e vision ]; then
    git clone https://github.com/colesbury/vision.git -b v0.10.0-nogil vision
fi

docker run --rm \
    -v `pwd`/vision:/vision \
    -v `pwd`/../wheelhouse:/wheelhouse \
    -w /vision \
    nogil/pytorch packaging/build_wheel_nogil.sh
