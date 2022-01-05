#!/bin/bash
set -e
mkdir -p builds

source build-common.sh

JAX_VERSION=0.1.75

if [ ! -e builds/jax ]; then
  git clone https://github.com/colesbury/jax -b jaxlib-v${JAX_VERSION}-nogil builds/jax
else
  pushd builds/jax
  git fetch
  git checkout jaxlib-v${JAX_VERSION}-nogil
  popd
fi

docker run \
  -v `pwd`:/io \
  -w /io/builds/jax \
  nogil/manylinux2014_x86_64 \
  /bin/bash -c \
  "export PATH=/opt/python/$SOABI/bin:\$PATH && \
  /opt/python/$SOABI/bin/pip install numpy scipy six wheel && \
  /opt/python/$SOABI/bin/python build/build.py"

wheel="jaxlib-${JAX_VERSION}-${SOABI}-manylinux2010_x86_64.whl"
sudo mv builds/jax/dist/jaxlib-${JAX_VERSION}-nogil39-none-manylinux2010_x86_64.whl wheelhouse/$wheel
upload_wheel wheelhouse/$wheel
