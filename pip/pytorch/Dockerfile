ARG CUDA_IMAGE

FROM nogil/manylinux2014_x86_64 as nogil

FROM pytorch/$CUDA_IMAGE as pytorch
ARG SOABI
ARG PYTHON_VERSION
RUN rm -rf /opt/_internal/cpython-3.7.5 /opt/_internal/cpython-3.8.1 /opt/_internal/cpython-3.9.0
RUN rm /opt/_internal/certs.pem
RUN cp /opt/python/cp36-cp36m/lib/python3.6/site-packages/certifi/cacert.pem /opt/_internal/certs.pem
COPY --from=nogil   /usr/local/lib/libcrypt.so.2    /lib64/
COPY --from=nogil   /opt/_internal/nogil-${PYTHON_VERSION}      /opt/_internal/nogil-${PYTHON_VERSION}
RUN ln -s /opt/_internal/nogil-${PYTHON_VERSION} "/opt/python/${SOABI}"
