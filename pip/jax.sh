#!/bin/bash
set -e
mkdir -p builds

if [ ! -e builds/jax ]; then
  git clone https://github.com/colesbury/jax -b jaxlib-v0.1.70-nogil builds/jax
fi

docker run -v `pwd`:/io nogil/manylinux2014_x86_64 /io/build-jaxlib-wheel.sh

docker run
  -v `pwd`:/io \
  -w /io/builds/jax \
  nogil/manylinux2014_x86_64 /opt/python/nogil39-nogil_39_x86_64_linux_gnu/bin/python build/build.py

sudo mv builds/jax/dist/jaxlib-0.1.70-nogil39-none-manylinux2010_x86_64.whl wheelhouse/
