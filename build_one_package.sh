#!/bin/bash
set -e
hostname
tmpdir=$(mktemp -d /scratch/installer.XXXXXX)
pushd $tmpdir
/fsx/sgross/Miniconda3-py37_4.8.3-Linux-x86_64.sh -b -p $tmpdir/miniconda
_CONDA_ROOT="$tmpdir/miniconda"
\. "$_CONDA_ROOT/etc/profile.d/conda.sh"
conda activate
conda install conda-build anaconda-client -y
conda config --set anaconda_upload yes

git clone /fsx/sgross/nogil-install.git nogil-install
pushd nogil-install

export CONDA_ADD_PIP_AS_PYTHON_DEPENDENCY=0
conda build $@

popd
popd
rm -rf $tmpdir
