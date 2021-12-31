#!/bin/bash
set -e

package=pydantic
version=1.8.2
yum_packages=
preinstall_script="/opt/python/*/bin/pip install cython"

source build-generic.sh
