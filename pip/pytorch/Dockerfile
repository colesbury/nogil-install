FROM nogil/manylinux2014_x86_64 as nogil

FROM pytorch/manylinux-cuda110 as pytorch
RUN rm -rf /opt/_internal/cpython-3.7.5 /opt/_internal/cpython-3.8.1 /opt/_internal/cpython-3.9.0
RUN rm /opt/_internal/certs.pem
RUN cp /opt/python/cp36-cp36m/lib/python3.6/site-packages/certifi/cacert.pem /opt/_internal/certs.pem
COPY --from=nogil   /usr/local/lib/libcrypt.so.2    /lib64/
COPY --from=nogil   /opt/_internal/nogil-3.9.0      /opt/_internal/nogil-3.9.0
RUN ln -s /opt/_internal/nogil-3.9.0 /opt/python/nogil39-nogil_39_x86_64_linux_gnu

