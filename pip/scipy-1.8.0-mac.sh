set -e

brew install openblas lapack
pip install delocate cython numpy pythran pybind11

git clone --recurse-submodules -j8 https://github.com/colesbury/scipy.git -b v1.8.0-nogil
cd scipy

cat > site.cfg <<EOF
[openblas]
libraries = openblas
library_dirs = $(brew --prefix openblas)/lib
include_dirs = $(brew --prefix openblas)/include
runtime_library_dirs = $(brew --prefix openblas)/lib
EOF

python setup.py bdist_wheel
delocate-wheel dist/*.whl
