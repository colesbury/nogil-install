ARG CUDA_IMAGE

FROM nogil/manylinux2014_x86_64 as nogil

FROM nvidia/cuda:11.6.1-cudnn8-devel-centos7 as base
ARG SOABI
ARG PYTHON_VERSION
RUN rm -rf /opt/_internal/cpython-*
#RUN rm /opt/_internal/certs.pem
#RUN cp /opt/python/cp36-cp36m/lib/python3.6/site-packages/certifi/cacert.pem /opt/_internal/certs.pem
COPY --from=nogil   /usr/local/lib/libcrypt.so.2    /lib64/
COPY --from=nogil   /opt/_internal/nogil-${PYTHON_VERSION}      /opt/_internal/nogil-${PYTHON_VERSION}
#RUN ln -s /opt/_internal/nogil-${PYTHON_VERSION} "/opt/python/${SOABI}"

RUN yum -y update
RUN yum -y install centos-release-scl-rh
RUN yum -y install which devtoolset-10-binutils devtoolset-10-gcc devtoolset-10-gcc-c++ devtoolset-10-gcc-gfortran git

ENV PATH=/opt/_internal/nogil-${PYTHON_VERSION}/bin:/opt/rh/devtoolset-10/root/bin:$PATH

RUN pip install cmake numpy auditwheel patchelf

#Install TensorRT 8.4.1.5
#RUN yum install -y wget
RUN v="8.4.1-1.cuda11.6" &&\
    yum-config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo &&\
    yum -y install libnvinfer8-${v} libnvparsers8-${v} libnvonnxparsers8-${v} libnvinfer-plugin8-${v} \
        libnvinfer-devel-${v} libnvparsers-devel-${v} libnvonnxparsers-devel-${v} libnvinfer-plugin-devel-${v}
