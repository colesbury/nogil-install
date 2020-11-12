#!/bin/bash
#
# Use `conda search --override-channels -c colesbury` to find
# packages.
src=${src:-nogil-staging}
dst=${dst:-nogil}
anaconda copy $src/apipkg/1.5 --to-owner nogil
anaconda copy $src/av/8.0.2 --to-owner nogil
anaconda copy $src/certifi/2020.4.5.1 --to-owner nogil
anaconda copy $src/cffi/1.14.0 --to-owner nogil
anaconda copy $src/cython/0.29.17 --to-owner nogil
anaconda copy $src/h5py/2.10.0 --to-owner nogil
anaconda copy $src/libopencv/4.3.0 --to-owner nogil
anaconda copy $src/magma-cuda101/2.5.2 --to-owner nogil
anaconda copy $src/mkl-service/2.3.0 --to-owner nogil
anaconda copy $src/mkl_fft/1.0.15 --to-owner nogil
anaconda copy $src/mkl_random/1.1.0 --to-owner nogil
anaconda copy $src/mpmath/1.1.0 --to-owner nogil
anaconda copy $src/nose/1.3.7 --to-owner nogil
anaconda copy $src/numpy/1.14.6 --to-owner nogil
anaconda copy $src/numpy/1.18.1 --to-owner nogil
anaconda copy $src/numpy-base/1.14.6 --to-owner nogil
anaconda copy $src/numpy-base/1.18.1 --to-owner nogil
anaconda copy $src/numpy-devel/1.14.6 --to-owner nogil
anaconda copy $src/numpy-devel/1.18.1 --to-owner nogil
anaconda copy $src/opencv/4.3.0 --to-owner nogil
anaconda copy $src/pandas/1.0.5 --to-owner nogil
anaconda copy $src/pillow/7.1.2 --to-owner nogil
anaconda copy $src/pip/20.1 --to-owner nogil
anaconda copy $src/pkgconfig/1.4.0 --to-owner nogil
anaconda copy $src/pluggy/0.13.1 --to-owner nogil
anaconda copy $src/pybind11/2.5.0 --to-owner nogil
anaconda copy $src/py-opencv/4.3.0 --to-owner nogil
anaconda copy $src/pytest/5.4.1 --to-owner nogil
anaconda copy $src/python/3.9.0 --to-owner nogil
anaconda copy $src/python_abi/3.9 --to-owner nogil
anaconda copy $src/pytorch/1.4.1 --to-owner nogil
anaconda copy $src/pytorch/1.5.1 --to-owner nogil
anaconda copy $src/pyyaml/5.3.1 --to-owner nogil
anaconda copy $src/pyzmq/18.1.0 --to-owner nogil
anaconda copy $src/scikit-learn/0.22.1 --to-owner nogil
anaconda copy $src/scipy/1.4.1 --to-owner nogil
anaconda copy $src/sentencepiece/0.1.85 --to-owner nogil
anaconda copy $src/setuptools/46.1.3 --to-owner nogil
anaconda copy $src/six/1.14.0 --to-owner nogil
anaconda copy $src/tbb/2020.0 --to-owner nogil
anaconda copy $src/tbb-devel/2020.0 --to-owner nogil
anaconda copy $src/tbb4py/2020.0 --to-owner nogil
anaconda copy $src/tokenizers/0.4.2 --to-owner nogil
anaconda copy $src/torchvision/0.5.0.dev20200511 --to-owner nogil
anaconda copy $src/torchvision/0.6.0.dev20201022 --to-owner nogil
anaconda copy $src/wheel/0.34.2 --to-owner nogil

# opencv dependencies
anaconda copy conda-forge/ffmpeg/4.2.3 --to-owner $dst
anaconda copy conda-forge/gmp/6.2.0 --to-owner $dst
anaconda copy conda-forge/jpeg/9d --to-owner $dst
anaconda copy conda-forge/libblas/3.8.0/linux-64/libblas-3.8.0-14_mkl.tar.bz2 --to-owner $dst
anaconda copy conda-forge/libcblas/3.8.0/linux-64/libcblas-3.8.0-14_mkl.tar.bz2 --to-owner $dst
anaconda copy conda-forge/liblapack/3.8.0/linux-64/liblapack-3.8.0-14_mkl.tar.bz2 --to-owner $dst
anaconda copy conda-forge/liblapacke/3.8.0/linux-64/liblapacke-3.8.0-14_mkl.tar.bz2 --to-owner $dst
anaconda copy conda-forge/openh264/2.1.1 --to-owner $dst
anaconda copy "conda-forge/x264/1!152.20180806" --to-owner $dst
