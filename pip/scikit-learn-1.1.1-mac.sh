set -e

brew install openblas lapack
pip install delocate numpy scipy

git clone --recurse-submodules -j8 https://github.com/scikit-learn/scikit-learn.git -b 1.1.1
cd scikit-learn

python setup.py bdist_wheel
delocate-wheel dist/*.whl
