#!/bin/bash -x

# make sure that compiler has been sourced, if necessary

MKLROOT=$PREFIX $PYTHON setup.py build --force install --old-and-unmanageable
