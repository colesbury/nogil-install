#!/bin/bash
set -e

package=Pillow
version=8.4.0
yum_packages="zlib libjpeg-devel libtiff-devel freetype-devel lcms2-devel libwebp-devel harfbuzz-devel ghostscript libffi-devel ImageMagick fribidi-devel"

source build-generic.sh
