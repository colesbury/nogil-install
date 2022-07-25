set -e

# see https://github.com/numpy/numpy/blob/maintenance/1.22.x/.github/workflows/wheels.yml
# and https://github.com/numpy/numpy/blob/maintenance/1.22.x/tools/wheels/cibw_before_build.sh

curl "https://raw.githubusercontent.com/$1/tools/openblas_support.py" -o openblas_support.py
basedir=$(python openblas_support.py)
cp -r $basedir/lib/* /usr/local/lib
cp $basedir/include/* /usr/local/include

cat <<EOF > ~/.numpy-site.cfg
[openblas]
libraries = openblas
library_dirs = /usr/local/lib
include_dirs = /usr/local/include
runtime_library_dirs = /usr/local/lib
EOF

cat ~/.numpy-site.cfg
echo "HOME=$HOME"
