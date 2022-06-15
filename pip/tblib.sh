#!/bin/bash
set -e

package=tblib
version=1.7.0
url="git+https://github.com/ionelmc/python-tblib@dd926c1e5dc5bbe5e1fc494443bbac8970c7d3ee"
postinstall_script="wheel='/io/wheelhouse/$package-$version-py3-none-any.whl'"

source build-generic.sh
