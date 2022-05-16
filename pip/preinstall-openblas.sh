set -e

# see https://github.com/numpy/numpy/blob/maintenance/1.22.x/.github/workflows/wheels.yml
# and https://github.com/numpy/numpy/blob/maintenance/1.22.x/tools/wheels/cibw_before_build.sh

curl "https://raw.githubusercontent.com/colesbury/numpy/v1.22.3-nogil/tools/openblas_support.py" -o openblas_support.py
basedir=$(python openblas_support.py)
cp -r $basedir/lib/* /usr/local/lib
cp $basedir/include/* /usr/local/include

export OPENBLAS64_=/usr/local
