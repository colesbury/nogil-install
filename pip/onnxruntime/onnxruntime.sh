#/bin/bash
set -e

source ../build-common.sh

ORT_VERSION=1.13.1
AUDITWHEEL_PLAT=manylinux2014_x86_64

if [[ ! -e onnxruntime ]]; then
    git clone --recursive https://github.com/colesbury/onnxruntime.git -b "v${ORT_VERSION}-nogil"
fi

function build_onnxruntime {
    docker run \
        -v `pwd`/onnxruntime:/onnxruntime \
        -e AUDITWHEEL_PLAT="$AUDITWHEEL_PLAT" \
        -it nogil/manylinux2014_x86_64 /bin/bash -c 'export PATH="/opt/python/nogil39-nogil_39b_x86_64_linux_gnu/bin:$PATH"; pip install numpy && cd /onnxruntime && ./build.sh --config=Release --parallel --enable_pybind --build_wheel --skip_tests'

    path=$(find onnxruntime/build -name "onnxruntime-${ORT_VERSION}-${SOABI}*.whl")
    wheel=$(basename ${path})
    cp "$path" ../wheelhouse/$wheel
    upload_wheel ../wheelhouse/$wheel
}

build_onnxruntime
