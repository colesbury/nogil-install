#!/bin/bash
set -e

package=cryptography
version=36.0.2
yum_packages="cargo libffi-devel"
preinstall_file="preinstall-openssl.sh"

source build-generic.sh
