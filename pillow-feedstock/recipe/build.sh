#!/bin/bash

export JPEG_ROOT=$PREFIX
# export JPEG2K_ROOT=None
export ZLIB_ROOT=$PREFIX
# export IMAGEQUANT_ROOT=None
export TIFF_ROOT=$PREFIX
export FREETYPE_ROOT=$PREFIX
# export LCMS_ROOT=None

$PYTHON -m pip install . --no-deps \
    --global-option="build_ext" \
    --global-option="--disable-platform-guessing" \
    --ignore-installed --no-cache-dir -vvv
