# Install

```
conda build opencv-feedstock -c conda-forge
```

## Copy packages to colesbury channel
```
export dst=colesbury
anaconda copy conda-forge/ffmpeg/4.2.3 --to-owner $dst
anaconda copy conda-forge/gmp/6.2.0 --to-owner $dst
anaconda copy conda-forge/jpeg/9d --to-owner $dst
anaconda copy conda-forge/libblas/3.8.0/linux-64/libblas-3.8.0-14_mkl.tar.bz2 --to-owner $dst
anaconda copy conda-forge/libcblas/3.8.0/linux-64/libcblas-3.8.0-14_mkl.tar.bz2 --to-owner $dst
anaconda copy conda-forge/liblapack/3.8.0/linux-64/liblapack-3.8.0-14_mkl.tar.bz2 --to-owner $dst
anaconda copy conda-forge/liblapacke/3.8.0/linux-64/liblapacke-3.8.0-14_mkl.tar.bz2 --to-owner $dst
anaconda copy conda-forge/openh264/2.1.1 --to-owner $dst
anaconda copy "conda-forge/x264/1!152.20180806" --to-owner $dst
```
