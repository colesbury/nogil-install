#!/bin/bash
set -e

package=lxml
version=4.7.1
url="git+https://github.com/lxml/lxml.git@lxml-${version}"
yum_packages="libxml2-devel libxslt-devel"
pip_packages=cython

source build-generic.sh
