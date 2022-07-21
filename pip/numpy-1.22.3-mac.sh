set -e

brew install openblas lapack
pip install delocate cython

git clone https://github.com/colesbury/numpy.git -b v1.22.3-nogil
cd numpy

cat > site.cfg <<EOF
[openblas]
libraries = openblas
library_dirs = $(brew --prefix openblas)/lib
include_dirs = $(brew --prefix openblas)/include
runtime_library_dirs = $(brew --prefix openblas)/lib
EOF

python setup.py bdist_wheel
delocate-wheel dist/*.whl
