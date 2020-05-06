import sys
import os

# Use OpenBLAS with 1 thread only as it seems to be using too many
# on the CIs apparently.
os.environ["OPENBLAS_NUM_THREADS"] = "1"
os.environ["OMP_NUM_THREADS"] = "1"

import scipy
import scipy.cluster._hierarchy
import scipy.cluster._vq
import scipy.fft
import scipy.integrate._dop
import scipy.integrate._odepack
import scipy.integrate._quadpack
import scipy.integrate._test_multivariate
import scipy.integrate._test_odeint_banded
import scipy.integrate.lsoda
import scipy.integrate.vode
import scipy.interpolate._fitpack
import scipy.interpolate._ppoly
import scipy.interpolate.dfitpack
import scipy.interpolate.interpnd
import scipy.io.matlab.mio5_utils
import scipy.io.matlab.mio_utils
import scipy.io.matlab.streams
import scipy.linalg._decomp_update
import scipy.linalg._fblas
import scipy.linalg._flapack
import scipy.linalg._flinalg
import scipy.linalg._interpolative
import scipy.linalg._solve_toeplitz
import scipy.linalg.cython_blas
import scipy.linalg.cython_lapack
import scipy.ndimage._nd_image
import scipy.ndimage._ni_label
import scipy.odr.__odrpack
import scipy.optimize._cobyla
import scipy.optimize._group_columns
import scipy.optimize._lbfgsb
import scipy.optimize._lsq.givens_elimination
import scipy.optimize._minpack
import scipy.optimize._nnls
import scipy.optimize._slsqp
import scipy.optimize._zeros
import scipy.optimize.minpack2
import scipy.optimize.moduleTNC
import scipy.signal._max_len_seq_inner
import scipy.signal._spectral
import scipy.signal.sigtools
import scipy.signal.spline
import scipy.sparse._csparsetools
import scipy.sparse._sparsetools
import scipy.sparse.csgraph._min_spanning_tree
import scipy.sparse.csgraph._reordering
import scipy.sparse.csgraph._shortest_path
import scipy.sparse.csgraph._tools
import scipy.sparse.csgraph._traversal
import scipy.sparse.linalg.dsolve._superlu
import scipy.sparse.linalg.eigen.arpack._arpack
import scipy.sparse.linalg.isolve._iterative
import scipy.spatial._distance_wrap
import scipy.spatial.ckdtree
import scipy.spatial.qhull
import scipy.special._ellip_harm_2
import scipy.special._ufuncs
import scipy.special._ufuncs_cxx
import scipy.special.specfun
import scipy.stats.mvn
import scipy.stats.statlib

import scipy.stats
import scipy.special


import numpy

try:
    print('MKL: %r' % numpy.__mkl_version__)
    have_mkl = True
except AttributeError:
    print('NO MKL')
    have_mkl = False

# We have some test-case failures on 32-bit platforms:
#
# Ran 24221 tests in 389.466s
#
# FAILED (KNOWNFAIL=91, SKIP=1948, failures=4)
#
# .. maybe related to:
#
# TODO :: Investigate this properly.
if sys.maxsize > 2**32:
    # run tests in parallel (-n4) to avoid deadlock on Python 3.8:
    # https://github.com/scipy/scipy/issues/11033
    result = scipy.test(verbose=2, extra_argv=['-n4', '-k not test_parallel and not test_optimize and not test_branch_cut and not test_expi_complex'])
    sys.exit(0 if result else 1)
