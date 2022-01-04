#!/bin/bash
set -e

package=pydantic
version=1.8.2
yum_packages=
pip_packages=cython

source build-generic.sh
