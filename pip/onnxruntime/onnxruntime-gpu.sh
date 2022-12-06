#/bin/bash
set -e

source ../build-common.sh

ORT_VERSION=1.13.1
AUDITWHEEL_PLAT=manylinux2014_x86_64
DOCKER_IMAGE=nogil/manylinux-onnxruntime-cuda116


if [[ ! -e onnxruntime ]]; then
    git clone --recursive https://github.com/colesbury/onnxruntime.git -b "v${ORT_VERSION}-nogil"
fi

sudo rm -rf build

function build_onnxruntime {
    docker run \
        -v `pwd`/onnxruntime:/onnxruntime \
        -e AUDITWHEEL_PLAT="$AUDITWHEEL_PLAT" \
        -e CUDA_HOME="/usr/local/cuda-11.6" \
        -e CUDA_BIN_PATH="/usr/local/cuda-11.6" \
        -v `pwd`/onnxruntime:/onnxruntime_src \
        -v `pwd`/build:/build \
        -w /onnxruntime_src \
        -it ${DOCKER_IMAGE} /bin/bash -c './build.sh --build_dir /build --config=Release --parallel --skip_submodule_sync --use_tensorrt --cuda_version=11.6 --tensorrt_home=/usr --cuda_home=/usr/local/cuda-11.6 --cudnn_home=/usr/local/cuda-11.6 --build_wheel --skip_tests --cmake_extra_defines CMAKE_CUDA_HOST_COMPILER=/opt/rh/devtoolset-10/root/usr/bin/cc "CMAKE_CUDA_ARCHITECTURES=37;50;52;60;61;70;75;80"'
    path=$(find build/Release/dist -name "onnxruntime_gpu-${ORT_VERSION}-${SOABI}*.whl")
    wheel=$(basename ${path})
    cp "$path" ../wheelhouse/$wheel
    upload_wheel ../wheelhouse/$wheel
}

build_onnxruntime

#        -e CC=/opt/rh/devtoolset-9/root/usr/bin/cc -e CXX=/opt/rh/devtoolset-9/root/usr/bin/c++ -e CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fstack-protector-strong -fstack-clash-protection -fcf-protection -O3 -Wl,--strip-all" -e CXXFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fstack-protector-strong -fstack-clash-protection -fcf-protection -O3 -Wl,--strip-all" \
#         -it ${DOCKER_IMAGE} /bin/bash -c 'export PATH="/opt/python/nogil39-nogil_39b_x86_64_linux_gnu/bin:/usr/local/cuda-11.6/bin:$PATH"; pip install numpy && cd /onnxruntime && ./build.sh --config=Release --parallel --skip_submodule_sync --use_tensorrt --cuda_version=11.6 --tensorrt_home=/usr --cuda_home=/usr/local/cuda-11.6 --cudnn_home=/usr/local/cuda-11.6 --build_wheel --skip_tests --cmake_extra_defines CMAKE_CUDA_HOST_COMPILER=/opt/rh/devtoolset-9/root/usr/bin/cc "CMAKE_CUDA_ARCHITECTURES=37;50;52;60;61;70;75;80"'
