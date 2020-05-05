# nogil-install

Conda build scripts for nogil Python and packages

**Important**: add the line `add_pip_as_python_dependency: false` to your `~/.condarc` file or you'll have trouble
building a new Python version from scratch. Conda adds `pip` as a default Python dependency, creating a circular
dependency chain.

## Build and Install steps

The following three are essential packages that depend on the Python version.

### Python (nogil)

Note that the build always has an error during test due to unsatisifiable packages. Not sure how to fix that yet.

```
cd python-feedstock
conda build .
anaconda upload [filename]
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
