# nogil-install

Conda build scripts for nogil Python and packages

**Important**: use `CONDA_ADD_PIP_AS_PYTHON_DEPENDENCY=0` to build Python. 
Otherwise, conda adds `pip` as a default Python dependency, creating a circular
dependency chain.

## Build and Install steps

The following three are essential packages that depend on the Python version.

### Python (nogil)

Note that the build always has an error during test due to unsatisifiable packages. Not sure how to fix that yet.

```
CONDA_ADD_PIP_AS_PYTHON_DEPENDENCY=0 conda build python-feedstock
anaconda upload [filename]
# debug build
PY_INTERP_DEBUG=1 conda build python-feedstock --label debug
```

### certifi

```
cd certifi-feedstock
conda build . --python=3.10
anaconda upload [filename]
```

### setuptools

```
cd setuptools-feedstock
conda build . --python=3.10
anaconda upload [filename]
```

The `wheel` and `pip` packages are also essential packages, but they are `noarch`, so they only need to be built once.
